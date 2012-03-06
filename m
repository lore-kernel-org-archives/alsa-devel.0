From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 16/17] ASoC: fsl: add dt support for
	imx-audmux
Date: Tue, 6 Mar 2012 12:49:25 +0000
Message-ID: <20120306124925.GR19635@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-17-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5737779115463625636=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E775F103CB7
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 13:49:28 +0100 (CET)
In-Reply-To: <1330957865-19085-17-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Richard Zhao <richard.zhao@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============5737779115463625636==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wc6dtGz1CZgs+5WP"
Content-Disposition: inline


--wc6dtGz1CZgs+5WP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2012 at 10:31:04PM +0800, Shawn Guo wrote:
> From: Richard Zhao <richard.zhao@linaro.org>
>=20
> It adds device tree probe support for imx-audmux driver.

Applied this one as well, thanks.  This really should've been in with
all the other audmux motion stuff, there's no dependency on it having
been moved into the fsl directory so it just makes it harder to apply
(but as it was a straight move git am figured it out).

As a general rule put bugfixes first, then minor cleanups, then things
that are internal to existing files (like this) and finally anything
invasive.  Basically, do the urgent stuff first and then work up in
terms of how big/tricky the changes are.  This makes it easier to get
things applied which is especially important with a large series like
this as it makes review easier and means you have fewer out of tree
patches to keep track of.

--wc6dtGz1CZgs+5WP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVgfOAAoJEBus8iNuMP3ddrIP+wTLG65ZSw8Co0ZEtvO38WYl
6zDafwFKB0DIIuCa8ObP7EBk4AVVfMC+ImT5IocCrCjL/myxIp7itaHnGboZjEpT
jGOZ4GynkzFEDQX96XII3s4PykzHc1ex2p3xjAQoXoL9Z6E9RYZ7KCr3QfhLw1qt
wQYdrwoV4hlx+rtBJeOM+jBE/dBTv8h+iR84g0xQBwyVJc1r5+H/+m5iVX5mnQPl
vLxpk3lb7BSU8yyIqXqOxZ9WcLOuId53FAQXqUJ6bDrODLSaesW3oLpymF+i6Ync
ZZ2UKNIamVOA/F+Zi1nld9QTRt0aOkhGMHVZ5+kaXPfa0X/p5+dPq9z6kpwqxL1r
ZOCZCG26awQIvTmtwPWsBC2vNuH+OH6M21/g8ymtHuBIi9WIld9W3LMw8nYmLwK7
aS++yDwN5ewM8ijxLV1Qyof38PHrwU3tU2w1HstpbPd3u6CULB0ZnduYDy1Dh8Qs
m2yfCDHYI19uLstj/bLvMNyM8dIJqyphKHtqM1IcjBfMalSt1faCc6dbII7G3WMh
uTBJQk4RnBO/i7SMzPTuTazXysskXGGVf/sSjTef+YrWaNz/9W4FfxjA/pVECKfY
liMiHhMYBcj5f8vEYWsrHD+ohiExRKREDGiqY89m1HdrDZpPqbwz0KhsBqt+0za7
zNzXPYP0cyHjjkhNxa3d
=sNBL
-----END PGP SIGNATURE-----

--wc6dtGz1CZgs+5WP--

--===============5737779115463625636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5737779115463625636==--
