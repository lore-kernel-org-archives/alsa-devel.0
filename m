From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/11] ASoC: Add a set_bias_level()
 callback to the DAPM context struct
Date: Sun, 22 Jun 2014 11:12:36 +0100
Message-ID: <20140622101236.GI24291@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-6-git-send-email-lars@metafoo.de>
 <20140621201437.GS5099@sirena.org.uk>
 <20140622052600.GM22053@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0204103295433787108=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F2D36265134
 for <alsa-devel@alsa-project.org>; Sun, 22 Jun 2014 12:12:47 +0200 (CEST)
In-Reply-To: <20140622052600.GM22053@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0204103295433787108==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gTY1JhLGodeuSBqf"
Content-Disposition: inline


--gTY1JhLGodeuSBqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 22, 2014 at 10:56:00AM +0530, Vinod Koul wrote:

> Even on DSPs loading firmware and power sequencing the DSP can get some help
> using these functions

> I think I might find some use of this for my work!

Please be more specific about this - what do they offer that runtime PM
and widgets don't offer?

--gTY1JhLGodeuSBqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpqwRAAoJELSic+t+oim9ov4P/3xUYKxVt2Jw4xJ/1s45Nq4m
5B+lPNu9+PzMcpSXVOPmNRN/U8JiDZTD2dfrYiKfI2vJeZJSS43GpIbuSg70Dahv
6C1s2o0ZeGa5lX0b8g+r2u2Ji9GMSmpFMAwIzgtKIFnhfGxWp5xVDnabiAR0a0K1
IiTwOnLwFnJSuxL5E1koSX4Nr2Mdo9rzMNm1Rz0bdBf6RejfssGEesx6sxDwi0QR
EyYqTJgd5LmqlYCECsAQ8xTxTk5p4bWTy1H8L/wdSL3XwBytfUuh4iN6LX4YT3c/
lF5oXs8UbTdNTRYRqqovGuVjqY2wVJnrGhy+EPVThBrox74sNNQzPDsJPEVf3aLO
oJ5sL669gDQPbq6xsJufOIo9QQM2cp1FW5Ga/XYImqfcTUA0cxAWeP2QEOi11NBL
ujiKzzwljHiNB5hPI4dMHq6JJCHtB3+oVlTk8UkjYa3awzXcGseomRRBDAmm+wIr
uid55iwCLwgIdRGHOM4m5WeW9rp3eKEBnRf82ekM1teJA+51sayaWVitu6AoztfO
APPbm3EzIzH4pOPMa/XDDuoR0HxSmwvahOyBbSGUxn/kG80EcRpuumt7hTLpBP5V
YeHXpk772oXEAqNdZVy1w4UUyaxrQLjNhiiLLybUuGd8Dkaedw8kWHMooIm1yUQ4
VP1CgjLGIFjURIGT6nx3
=a25f
-----END PGP SIGNATURE-----

--gTY1JhLGodeuSBqf--

--===============0204103295433787108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0204103295433787108==--
