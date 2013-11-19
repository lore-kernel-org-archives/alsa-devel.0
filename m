From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/10] ASoC: Ux500: Match platform by device node when
 booting Device Tree
Date: Tue, 19 Nov 2013 18:49:36 +0000
Message-ID: <20131119184936.GG2674@sirena.org.uk>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2nmUZS6EBFTGcnEV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384859269-19801-6-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--2nmUZS6EBFTGcnEV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2013 at 11:07:44AM +0000, Lee Jones wrote:
> We're getting closer to fully enabling the Ux500 ASoC driver for Device
> Tree. When we switch over from using AUXDATA we'll need to match platform
> by only Device Tree nodes. In this patch we NULL out the platform_name,
> and supply nodes for each platform device.

Applied, thanks.

--2nmUZS6EBFTGcnEV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi7K9AAoJELSic+t+oim9VysP/RmPymL1juYyhpiq6vY5ivvH
cWmIey8Q1HmF+8aFeVSY9d9QkQ/upwHwx61JsfPJGN0dza7kmnvQk87J7AjVvB65
7mUvvxzbNrLpe9riMGNHG2DTZ37NVPx5twmFiDhwmqREGswuSIWVaVFgOZDQmXxH
Yd8wbF/1ZSNmFJnkOtkOa0dbXgqsiOTztp7mA6Q1vu0Dwfpn+Sqrz3KI4dUOY4x1
rzuXUQTi/weIX9Ly/aq0fGqfOxunInLh8Jxj9yFoRLtQImt0SGBy73/Gc59ImF4b
dPDNmxR71RrpciQ6J6Zde7ScPHLldlCpOM5+QrfdCwAL9Zq+xdJ9sJxhpJZjpDrE
f7otuuj+JsWPKs4slw3ADOguQEWISdkxhsITD9/z6oabNEGWCyKGeWL3WovmizXV
caXliKHudKJix/THhfU5Fq33mKh84gUrcruK+9WmEtqo8ISl2OrtGN6oB4ryv/Eb
7ZFfy0q1AQUXXULeuVp4Vg1Zh1iVksi/rn3GHeIzKEQjV1YcuuF5IH62KrHdxsfA
Jve8OipkWCi9z+PQZHdRnR5GiGq92h7YjT/AEDZ4eZjyxNVpltOKMOBJ1IfxAnr2
KCsknWbzxKDfZ466v09xmxdbFlY07sHpXpA78gR7IMixNxpQb03ZnuIOVCoE0q0c
GTlfYFKaFmQGFQAAFPHz
=fiVr
-----END PGP SIGNATURE-----

--2nmUZS6EBFTGcnEV--
