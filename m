From: Mark Brown <broonie@kernel.org>
Subject: Re: Choosing the sysclk in simple-card looks broken to
	me.
Date: Mon, 11 Aug 2014 11:48:54 +0100
Message-ID: <20140811104854.GX17528@sirena.org.uk>
References: <CAKON4Oxusv_VuHNgbum1wBBz_N_V-a11N_rPu8m-rLFYAcQ_sQ@mail.gmail.com>
 <20140810105405.GW17528@sirena.org.uk>
 <CAKON4OzhSFJ4-cGkbr10LNorb+ihi6gqm1V4-YhTMHq8kmcWGg@mail.gmail.com>
 <CAKON4OxvoLBiq64t6Oh1i3CgA=Zy5DU7xYEe2kkpVdWkXMmqsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6697759793635662584=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50B03260864
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 12:49:02 +0200 (CEST)
In-Reply-To: <CAKON4OxvoLBiq64t6Oh1i3CgA=Zy5DU7xYEe2kkpVdWkXMmqsg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, zengzm.kernel@gmail.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6697759793635662584==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JwM+kXJnAuf2qao6"
Content-Disposition: inline


--JwM+kXJnAuf2qao6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2014 at 02:42:23PM -0400, jonsmirl@gmail.com wrote:
> This should fix it to use the output clocks, but does it break any of
> the other DTS using simple-audio?
>=20
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-c=
ard.c
> index 03a7fdc..8c4b267 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -116,6 +116,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
>  {
>   struct device_node *node;
>   struct clk *clk;
> + const char *clk_name =3D NULL;
>   int ret;
>=20
>   /*
> @@ -156,11 +157,14 @@ asoc_simple_card_sub_parse_of(struct device_node *n=
p,
>       "system-clock-frequency",
>       &dai->sysclk);
>   } else {
> - clk =3D of_clk_get(node, 0);
> - if (!IS_ERR(clk))
> - dai->sysclk =3D clk_get_rate(clk);
> + of_property_read_string(node, "clock-output-names", &clk_name);
> + if (clk_name) {
> + clk =3D of_clk_get_by_name(node, clk_name);
> + if (!IS_ERR(clk)) {
> + dai->sysclk =3D clk_get_rate(clk);
> + }

Jon, please use indentation when sending code via e-mail - this is far
too hard to read.

--JwM+kXJnAuf2qao6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6J+TAAoJELSic+t+oim9TWEQAICqhCgqk+Xc0bRezUhC9E99
SeQMZRT8ZqqDuCIlcrfc2s4Rh7QIDCVOtqKFXVbjiaSXyUt94wjwGjDfUiSNT9lo
rnvd0b16hXaQX3XTVQZL4t218cXk0OwcZTJl/Ok83WRFUw2R0S29fXPnvE0nIsvJ
7Mf66XEnUKqVNMb+/bhFyStZ/NzHWBiAFlnTy3Rtc3wextgUOTpAKzRdjup8+1mV
phCdTaUJoELQFTT+Tq1xLRmW4QFL6XO6qfp6OWpITl1todjPOjTQmtlzv6LjtAJj
k10TjLTgxoRsLmm9ApEcbBuTkO2DAcPqn0tWb+mtlH6jW0AeJZzbdWNTVhpvHi1i
hHwtRmvMkYRn42ujjXNVow3It9znAVf1SPUT3LWXwsoEg1Xi7kWGPSQQQmpKUDjj
ObNKihtAHwd609cOcyJG3ab34bHqliKEM5EyEg+N4NnA2NodsJTipWGZqHMo+kPG
J3zyDReHgIzEeViH5EJTuotVevqz9vkixZB0RveZ85NG8aPLzJdzgsScmJDOfDGV
ZecmST6kq1g6g7llWY+j1bUVP6EaQ80sGeMEBuaHaRCjy9to4Oz5DNArrJRHjkr+
4MGZu22cE68wgYLmKJv70dWUzN3kumarSDe5nYO25APm2AnmrUFznbKozMFZztos
jXEGL2ssx4SuxPrWYtX6
=YKPd
-----END PGP SIGNATURE-----

--JwM+kXJnAuf2qao6--

--===============6697759793635662584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6697759793635662584==--
