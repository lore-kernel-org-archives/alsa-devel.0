From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Add monaural audio support for
 non-ac97 interface
Date: Mon, 2 Dec 2013 11:56:17 +0000
Message-ID: <20131202115617.GV27568@sirena.org.uk>
References: <1384532729-6588-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YDTWxoC2E3hrC6hC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384532729-6588-1-git-send-email-b42378@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <b42378@freescale.com>
Cc: timur@tabi.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--YDTWxoC2E3hrC6hC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 16, 2013 at 12:25:29AM +0800, Nicolin Chen wrote:
> The normal mode of SSI allows it to send/receive data to/from the first
> slot of each period. So we can use this normal mode to trick I2S signal
> by puting/getting data to/from the first slot only (the left channel)
> so as to support monaural audio playback and recording.

This looks OK but doesn't apply against current code, can you please
check and resend?

--YDTWxoC2E3hrC6hC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnHVeAAoJELSic+t+oim9gXYP/iyCgeTlIkEq2tvHUKNxZoCT
tHOlo3ymeCohXd6nMUQ2bBO0NrpnLphny24jBHuLPFVps1enGqoNRU6TT8d3Pjfm
VTpi+9eTxgwF0wRsN5Lf0deKo/7iLsTtwffNw8K7ll8QNUl0YRIMwvqXIgpxr93Z
NqOYieIZsJSII5Aulw8cMu1fXeJVo66H0V6c4YUHrNKRqb+XZbIEZZJuWBzIaLXC
yqJKIEC7a5fu+hPicxTsf9LdMp/Z3fL6g7rIZq2bmiadcDAAtm97tAR8oYKDb1yt
dShn0dgTnexuamhCCfVI4iExnY70rBvOiz+Zxk3vM4Ub3YCJ5Pkr+DTQngk2Ynhw
RYX6jHjLBTDE3gBW/XTnzEQTMS4Q+1hQdy7sEsJFT6tTUOTWSRZc5A2O6WUtKUtz
j5Rpbc8yb5qCGExqFmTNUL1VlltOXzgPqGNaZljxcWJl5JwJUzxAisNXGT6rc3kM
xdUM/RtDu1nCNjaYebFBn7bpgvqT6+9BO8cCNoPCdGOIhUJRQURKasMWfyUHiQFQ
eQNAwZdYqjK1yfOQrYd9aEa8czH7BwgiYPGhsnT/GhMZloNi7ot7uPvf4XIf7a4x
LdonCKGVjt2yCrbYQ2ceZHyexBLW3R8HwxNWUHcI/hIQuAfaCpFwVQk+ton91Adw
MiDOSDbYsip7Y/0kQss7
=+D7z
-----END PGP SIGNATURE-----

--YDTWxoC2E3hrC6hC--
