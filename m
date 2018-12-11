From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: simple-card-utils: fix build warning without
 CONFIG_OF
Date: Tue, 11 Dec 2018 00:25:14 +0000
Message-ID: <87k1kgc415.wl-kuninori.morimoto.gx@renesas.com>
References: <20181210204640.2407929-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210204640.2407929-1-arnd@arndb.de>
Content-Language: en-US
Content-ID: <80F3DADD8AC5934BA270CB4584F12BFC@jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


Hi

> When CONFIG_OF is disabled, of_graph_parse_endpoint() does not
> initialize 'info', and gcc can see that:
>=20
> sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_card_pars=
e_graph_dai':
> sound/soc/generic/simple-card-utils.c:284:13: error: 'info.port' may be u=
sed uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>=20
> It's probably best to check the return code anyway, and that also
> takes care of the warning.
>=20
> Fixes: b6f3fc005a2c ("ASoC: simple-card-utils: fixup asoc_simple_card_get=
_dai_id() counting")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
