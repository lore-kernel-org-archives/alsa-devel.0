From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] ASoC: wm_adsp: Add code_probe and codec_remove
 stubs
Date: Wed, 10 Jun 2015 18:47:40 +0100
Message-ID: <20150610174740.GO14071@sirena.org.uk>
References: <1433949168-25615-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PlWN2or5MzbGPm4Y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433949168-25615-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--PlWN2or5MzbGPm4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2015 at 04:12:46PM +0100, Richard Fitzgerald wrote:
> Currently the only init function in wm_adsp is called by the
> codec driver early in its probe before the codec has been
> registered with SOC.

This doesn't apply against current code, please check and resend (bits
of the series do apply to topic/arizona but not all).

--PlWN2or5MzbGPm4Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVeHg7AAoJECTWi3JdVIfQdqMH/0vDIa3QyHlq8JM/wOW/8Kew
r8Mi6bWkEDlT7SvauIUpdTRCvGgstx5NWKtGYo0SkJUTusH0tlY1FtZyWjUkr1WQ
15u/MgT9yEEbb0PODr/67SrfDztangdWQsaJKPecn9ToiVW9CLhFSmZ1nkOUqgI4
EiPP9NcUB9v3bBpFNTm1zdNPdqMAIeg3j9ecRn64NQ9UGEfzT7UpFI3iV+DWbjHM
KZ5Mvx/veavqWk61W6zMBrS0OJVyLr30VI6bd1FLYJRmVJDnjdtfAoyEbbFm92S5
DnkUq7zZJq07R46ICcrlGok1LUhS0YVi5Ehf52asMslSDGD8PbbOgglGaWIQ4FU=
=aLk5
-----END PGP SIGNATURE-----

--PlWN2or5MzbGPm4Y--
