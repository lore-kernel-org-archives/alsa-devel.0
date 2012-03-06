From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Tue, 6 Mar 2012 13:03:58 +0000
Message-ID: <20120306130358.GT19635@opensource.wolfsonmicro.com>
References: <20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
	<20120305000411.GL7363@n2100.arm.linux.org.uk>
	<4F54053F.9070502@freescale.com>
	<20120305002635.GA23798@opensource.wolfsonmicro.com>
	<20120306104015.GF17370@n2100.arm.linux.org.uk>
	<20120306120646.GH19635@opensource.wolfsonmicro.com>
	<20120306122516.GH17370@n2100.arm.linux.org.uk>
	<20120306123322.GP19635@opensource.wolfsonmicro.com>
	<4F560AE9.90502@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8015235353211071096=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 36FB61044FC
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 14:04:01 +0100 (CET)
In-Reply-To: <4F560AE9.90502@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8015235353211071096==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RvrrZ8vH9xW05bsQ"
Content-Disposition: inline


--RvrrZ8vH9xW05bsQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2012 at 01:02:35PM +0000, Tabi Timur-B04825 wrote:

> So are you saying that it's possible for one CPU to call my trigger=20
> callback to start playback on one substream, while another CPU calls it t=
o=20
> start capture on another substream?

Yes, Russell is right here.

> If so, then I need to add locking in my trigger function.

Yes.

--RvrrZ8vH9xW05bsQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVgs3AAoJEBus8iNuMP3dpQYQAI17ENkPSQ8VvwsYAlL3UzrF
M7cw6FHahd+sLgRkKnDq0lSljZ7hqxi6n5+jdZgWQsnDIgdYWC/je3+STYvnb2fj
vB5zwQlfDZEE7EPES4G6LLEBbrpCsAaUDkbi99pNf8spLJt1Ef5WnBGBt+DN+20H
0tLzu/9RTuEt7p+jfbIhcdzfY5C0kuZBPXAEtN6g9Gtdvy0S4YnTZ6mAvAQOT04d
zCRk87Lntu62BKrV6YuVn3bOu0nLQHK3844Iwg7wbbEP/PtpQMt+hSobn7g8iT+Z
+f+MK5pVB8u1YNr2GPtiZY4s/N9SbauiCxhBiE8xM3CuXHEWHpc25RZ+hPZOy8bO
JrSCTNh5lL8xHJwuYsPJcYvZjsB1oDco1jmrTiDTUis03BNgek3Xlfx4gUfTerkc
jWtlLpbcmDnWJbXHhMw87mFsI/u1mFxnpk+t+gAWM1SHQeuTm1RfoRKRex/yohL9
bg9Hy7hAGCJUnr/ZMu20FIgZUU6ofhDgpE404DsxYH7rG70c907rEjyGuoA/64iT
7qV1aGH3MaXeQSn/P0pypY7GFbqX/nasVG5kjjNf7qIdSZz4Dlna0akRImKfWGLL
AxVEsuGeBXJkT1av2obz7zke63qGLo4wac0AfM0/HGF6PV6uT8qurK0nA1XIpgkC
0k/14ZUwHUVZr1H3lPgW
=Hzk0
-----END PGP SIGNATURE-----

--RvrrZ8vH9xW05bsQ--

--===============8015235353211071096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8015235353211071096==--
