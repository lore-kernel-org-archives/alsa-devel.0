From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: add input clock
	selection
Date: Tue, 26 Jun 2012 11:26:28 +0100
Message-ID: <20120626102627.GN30406@opensource.wolfsonmicro.com>
References: <4FE98D28.8050908@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1693644748094101917=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D10DB24601
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 12:26:30 +0200 (CEST)
In-Reply-To: <4FE98D28.8050908@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prchal =?utf-8?B?SmnFmcOt?= <jiri.prchal@aksignal.cz>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, peter.ujfalusi@ti.com, mr.swami.reddy@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1693644748094101917==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+2GlJm56SCtLHYlr"
Content-Disposition: inline


--+2GlJm56SCtLHYlr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 12:21:28PM +0200, Prchal Ji=C5=99=C3=AD wrote:

> +	/* set clock on MCLK or GPIO2 or BCLK */
> +	snd_soc_update_bits(codec, AIC3X_CLKGEN_CTRL_REG, PLLCLK_IN_MASK, clk_i=
d);
> +	snd_soc_update_bits(codec, AIC3X_CLKGEN_CTRL_REG, CLKDIV_IN_MASK, clk_i=
d);

Normally it's possible to set these separately.  Is there a reason why
they have to be the same (and if so why has the chip got separate
registers)?

> +#define PLLCLK_IN_MASK		0x30
> +#define CLKDIV_IN_MASK		0xc0
> +/* clock in source */
> +#define CLKIN_MCLK		0
> +#define CLKIN_GPIO2		1
> +#define CLKIN_BCLK		2

This doesn't look right - you use the clock source values directly above
but they need shifting to be used as if they're used directly they'll
always come out as zero.  It'd also be better to have some bounds
checking on the values.

--+2GlJm56SCtLHYlr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6Y4lAAoJEBus8iNuMP3dBR0P/A7kCIunU7fNaY2JfyEQo9F4
fqP1IpD9L0mf99JhlRMF1ljW3rz/BLF2v+95EPxFMpP9ixhmflmKUBTJOLOeP2Mb
9yl8wGeHc53qtK1kTMXn6U5KOEqic8LAYuGBL/RjYzOpfL7QrtCM1uJekp8DpYS1
Cp5xrXA25zAD8jlfeEH5FKj9P0U8cR9os3GCi2C79pIbDvARh+ynGvvd8lTdvdap
FvO5MjJHvh5O2fEUEjNQTXTLFwTSLiEJqqAb7pR3Afq0sGdnE1O1ci7efzrJO0+Z
YYjbXhXiHYQg7tsSnWnILEwbJgMmfpYrFF7X2eNDipBs14G3vbRaWnmUrxDwPMHF
OLpXrsSl7ah6fLIQIzgiaPOdJWsG/iSvMOaZ5poTdsmQOrH2SNlp0fvz/D7xR9Oi
6s4ApYwS2m95ObQiGc7qSI7VbbLjNuAlDMJkkCqpisotVRntJUUVDVT/BBU1uyZW
0mc7cIFVFn6HGW4XmRdFuCcsev81DdDTZodeGlutZ+DhriP92Djvpc3X+Z/yb2VV
a+hzrN1Sa9nVMlSe8zzkP2eVY36RA4OscP7Lq64Na96RF4jt0Nxmp7aUyHv4UoK6
n8UlLeas9k3/B3Bq0rZte/q1OzIHtwL+rZGoLdomUGW/XOKI54Oc5wLB3QK1dOCF
Sfuuy9dKhu9t6tUKEWsJ
=uB61
-----END PGP SIGNATURE-----

--+2GlJm56SCtLHYlr--

--===============1693644748094101917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1693644748094101917==--
