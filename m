From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: mxs-saif: set a base clock rate
 for EXTMASTER mode work
Date: Tue, 24 Jul 2012 20:18:25 +0100
Message-ID: <20120724191825.GD3099@opensource.wolfsonmicro.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-3-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7404736883062665631=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9324D265D53
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 21:18:24 +0200 (CEST)
In-Reply-To: <1342776027-31758-3-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: shawn.guo@freescale.com, alsa-devel@alsa-project.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============7404736883062665631==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2012 at 05:20:25PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
>=20
> Set an initial clock rate for the saif internal logic to work
> properly. This is important when working in EXTMASTER mode that
> uses the other saif's BITCLK&LRCLK but it still needs a basic
> clock which should be fast enough for the internal logic.

Applied, thanks.

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDvT2AAoJEBus8iNuMP3d+FIP/0uUwYOnXZVYrfV3fIzJXm9Z
rzBiB2CWOY3NkN19U1uOCq7axaoyVAOuoRLuDayWf4rdEdW3Q/yNqzirYm4/V99S
YLzgDaqo9SABrNhyJf5fUyhmxHauf13NISzqG0XnFw5vgGpjfnQOQdqELIycq/su
RLwr3mV6C4GwGFaxwb3VDJ8G6ImGUXdQL1uWvmZOIU9LxMzE2vHNi+QRaBM83/iC
i546fwAbI3J0mQUkEbuJHgn4s1xclp/Aa8P6C1p8+WY5ebUAAMENizylTUvSLCWg
UTNWnsxOupxkQHnAJpJihq4g327J6T5EeRP+QacW3tgIDBgSk1gRZLNlv8bty83k
GlazV+x/O6nOe4Thqu22LuJwyvvvuLenfnG5/ktl5DT3eljC4funMLODM91D0qyE
3s2MVWxhdyCZOhesZMJTbqBmOGKWvnjQkwSDEnKhUcWk9yyb8ev6nWhx/S2pVbIc
yI3VJc6QAVxkGu9Mw9EF6Z3sF1Y4hZSPDow96COmsdDqwRKJjvhQIfhnrh0gfHT+
Ssf2XzfLb01bsg7CECdNCNUdZtU/8Xe73dO8O3Z4IiW5pa1CLRB8wUPdYYd1M4+I
qyObhh1RLjy5vWqGvh/Id5fEqie0MW0e7kTFlBHLNJUzAjqRb1H6hfQEdmWA8QDE
cZM3ez6VGJvngCjlD+2u
=qsmY
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

--===============7404736883062665631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7404736883062665631==--
