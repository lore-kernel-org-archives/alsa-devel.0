From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: fix WM8753 initialization.
Date: Sun, 4 Mar 2012 14:33:25 +0000
Message-ID: <20120304143324.GI3083@opensource.wolfsonmicro.com>
References: <1330280514-32232-1-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3543217819747180380=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C352B246E8
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 15:33:28 +0100 (CET)
In-Reply-To: <1330280514-32232-1-git-send-email-GNUtoo@no-log.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3543217819747180380==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 26, 2012 at 07:21:53PM +0100, Denis 'GNUtoo' Carikli wrote:
> Without that fix the wm8753 SPI initialization fails, and then produces

Applied, thanks.

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPU30gAAoJEBus8iNuMP3dE40P/jQ1R8232iKBS46CmxBgEHOS
OHJCM8/Gn/niizJNDTLTvP0SfIBIW+Ix3QRiiv6N+iw6+oZYaYoOuNTL7rQ52Y5z
KX3k0ORzeYcWHABrVfQ+QMyZjaHZSPBlfC94TUqaRvyJIV5jW6r4ajmnE+bvj5AR
UQrm3/C6D/kv9DulMuGCOpj0ttjagl8J/OmYIHkaAfQ4nP/pNKpzXCL5LiV3VnJ3
9w12LgF/NH0rXYYv3WoMKEnEUtTy4ujFF5fgCTT5Cyfw9H+ZcWPCFgUdzY56JEXi
F0VXR9k3mYnSPzFpdHZilCkxbJTwpMymZVdj1EuwpLNvWYrgP8iLu9zZThBILEoA
Ag6lNUt3RdodIHGsmqVpxfd7Q1DwR2/FrCOPJuEZ/Oc6E9NYw+PSQVU+1+boP7dR
G7BOxvx+d4l03TMIH6OdlSQiB1EWfy/PPVbTPJKULowPE6egFRmSULgNCh06rBJC
c5wNQBNNl1amFM0LpbASpUQMYsf1T2a0FfqKh2txJFrVZf3CEG48PhBqeXUyfMX8
cyJ+MHzY8YU4LdnpLb54T14Pqbty3a1AEQ+Si3GYIdfdXYa11v9v6Ar3lx7b52FM
jrIwuxrTOuiE5jNQ4ByIUTvMajdUREL9gHlWTKsVlEXo+KF7bfnbIDLuEwI8dRqe
CEClfijEDuQELz97pwPI
=2mOb
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--

--===============3543217819747180380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3543217819747180380==--
