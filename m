From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/17 v2] ASoC: wm5100: Update locking around use of DAPM
 pin API
Date: Thu, 20 Feb 2014 19:26:31 +0900
Message-ID: <20140220102631.GH2669@sirena.org.uk>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392736948-26623-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKEGotTb16aqLsYQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392736948-26623-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--bKEGotTb16aqLsYQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:22:17PM +0000, Charles Keepax wrote:
> The pin updates in this driver look like they are intended to be done
> atomically, update to do so.

Applied, thanks.

--bKEGotTb16aqLsYQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBdhUAAoJELSic+t+oim9zcAP/j38zRYu1K5Nb7eh0l9bNjeF
+g4Eq8lXwoTrsTyyXQCIAjbEntSB5HXjKXSROLhTZt7rJpUs/StFBbVi23MTCvzp
Ozp6HUrhsYVMf8DOxSu0WM7SKBVTEZEOkVURJO44MTrO/9z2VlEP/MZrPuDR6sXO
49fLFScltsB73TpDiCAfRTCa7ihDTIPvsbfMYuReSjZ8VSbRtnCiQJlxkIkms02y
sG+THdJRcBOnMqEKD0S7qyGIhw7odnND645CexJEMqpGHAH8BYtWgUC1js6BV0ZS
m43tOojNp9G22HMkL0OqtCvpwxSG8kf5eOUH34+1HyM2NLiQxHI1FDhSMXtEcukr
L/YEkYBK1mC41NMl4/oqCxWZ4rAEK/Gmjr369HWv86gmrhmPI8s9cDWLwkv3tPZX
Brls7y9j74ha5YeoIxbPAwl34wGx30/bkCbveRPHacq8OfSOLBB8yfwtag11BICB
R5Soj3mYqFwmtTvBRlISOcn9Y6O1wTIQH+wDbUTcxwSc4cU+/x74sYUwktP68nX0
xxRljp1gEIoz4N1AxaG6ZdE8nT+HUecLAV1Bn7h8o2AQbkiRrRIgZtN5pa3WIhGT
sW94a8knarAiULzfPWkxWKI3aP3axHL1KlYZ1BL7naQC8jjF4eiRfeGxfMEOFi4z
5PnYthbddp70DkGvyu+E
=dOzC
-----END PGP SIGNATURE-----

--bKEGotTb16aqLsYQ--
