-module(sphincs_nif).

%% Private API.
-export([keypair/0,
         sign/2,
         verify/2]).

%% Initializer.
-on_load(init/0).

%% NIF.
-define(nif_stub, nif_stub_error(?LINE)).

-spec init() -> ok | {error, any()}.
init() ->
    Module = "sphincs",
    File = case code:priv_dir(?MODULE) of
        {error, bad_name} ->
            case code:which(?MODULE) of
                DirectoryName when is_list(DirectoryName) ->
                    filename:join([filename:dirname(DirectoryName), "..", "priv", Module]);

                _Otherwise ->
                    filename:join(["..", "priv", Module])
            end;

        DirectoryName when is_list(DirectoryName) ->
            filename:join([DirectoryName, Module])
    end,
    erlang:load_nif(File, 0).

%% @private
-spec keypair() -> {binary(), binary()}.
keypair() ->
    ?nif_stub.

%% @private
-spec sign(binary(), binary()) -> binary().
sign(_, _) ->
    ?nif_stub.

%% @private
-spec verify(binary(), binary()) -> binary() | {error, term()}.
verify(_, _) ->
    ?nif_stub.

%% @private
-spec nif_stub_error(Line :: non_neg_integer()) -> no_return().
nif_stub_error(Line) ->
    erlang:nif_error({nif_not_loaded, module, ?MODULE, line, Line}).
