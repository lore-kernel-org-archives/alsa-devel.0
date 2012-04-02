From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: sh: fsi: add fsi-codec card
	support
Date: Mon, 2 Apr 2012 22:39:28 +0100
Message-ID: <20120402213928.GD3160@opensource.wolfsonmicro.com>
References: <874nt2aphw.wl%kuninori.morimoto.gx@renesas.com>
	<87398mapg7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3673995031663101113=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8282A24365
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 23:39:24 +0200 (CEST)
In-Reply-To: <87398mapg7.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rafael <rjw@sisk.pl>, Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3673995031663101113==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 01, 2012 at 06:32:27PM -0700, Kuninori Morimoto wrote:

> --- /dev/null
> +++ b/sound/soc/sh/fsi-codec.c

A more descriptive name (even if it's just fsi-simple-codec or
something) would be nice.

> +	if (pinfo->codec_fmt) {

> +	if (pinfo->cpu_fmt) {

I'd expect that these should always be the same, it's probably as well
to just have one format and then require anyone who wants anything
unusual to handle it.

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPehyKAAoJEBus8iNuMP3dA5YP/3YdG15LnkxGxodMT4wijYuO
jmrB2qEi5NH2ni+fUkMHSaroJCBRYVcZVwqag+Ov+YJnF3MYwUtHDdKRQ1e3puvg
Egqlx8Juyx4kt+wHTLjz8wjljQv+3zHvDb3bI2uQYH0BBpWzK3SJ/CmPHERus+Ew
4KEWcQof6uajuw1Gn2LLowA72gN+qqKpJ+7FMF/OfFGEtxB6xhlnVPh50xL4UAbc
G3Ne4FxbSq3w+zyteRBd7iTIX2jBQxtP5K/5p1tdjNBpl+3zmQwEVFbW1JsBTM0s
9I0eSuTnD+I1WV9stRwSswe3i0A+joWjKpoD8+MlrK3oCPN3L6RdmeCj2xp0NwE8
/vA8uXxzs/TGB8kl6t+tlplBGaG9NSLytOSo5N8KIj9dUUAmD8zxTlgPi3DqY++a
0ehcmexHX9bNe35wDHxtu2kIfH5kIu8Py/GoMNfazUKcknFkbidmPFUZw8fBt5l3
vve4Xq5PiAl23y4wrF14EyYQ29mpLVFu0VXuaGWSVhxmmAr0446IQTN4tgfgoilr
izTD758puYMhpQ9cZrLGmphc0WZY1F3FE0/GYWpHkF/l3ethr8v6GAsvVAGuHa5M
QhbtEdRQ+oxX+gwKi232t+0Ub4BGHK1O94JYlfRTaG0M5IMxxquyXFyfi1+var/b
l1aWZURj+p0UkrxmiRhq
=zZN5
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--

--===============3673995031663101113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3673995031663101113==--
