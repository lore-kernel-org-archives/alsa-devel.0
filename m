From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: Add I2C dependency for snow
Date: Wed, 4 Jun 2014 16:45:49 +0100
Message-ID: <20140604154549.GO2520@sirena.org.uk>
References: <7290614.Z7JFMYFomx@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7544830479534934457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D2C2F265071
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 17:46:09 +0200 (CEST)
In-Reply-To: <7290614.Z7JFMYFomx@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7544830479534934457==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3snK74p7ddXn3Qrx"
Content-Disposition: inline


--3snK74p7ddXn3Qrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 04, 2014 at 11:40:40AM +0200, Arnd Bergmann wrote:
> Both codecs used by snow, max98090 and max98095 require the use
> of I2C, so we can only select this driver if I2C is there, otherwise
> we get a build error like:

Applied, thanks.

--3snK74p7ddXn3Qrx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjz8qAAoJELSic+t+oim9aWgP/1upHpdrZTKAqNP6HUpnX5uz
hABJyJEBwd2gz8/Dks4HnL89Z1Ndm58qo/nNnG4Ko6LLwyORC0puskVBe+ZO9DW0
O4J1FG5WH5N1GW84Vmr+51U8+/Vb1V6rjVT+jdIOJH63qsQw7w6s9517EiW8wEoU
EBLGGC+FSR1WelYsD2LNCnEIRAaTQwdGJQlp91jelJQam3rHmZTpjDL3gcR+Fsnl
hPoOzvhSbZOrxF4NfbThv1zmvYZA2sIgXHa5JMIfVW3oZzi//MH7vhnt7FwUKXIs
yeoNmpEowh3bCPfr6CvcGk4DhxN1YJhVR/Ah5fY5rVLrvUpyvvYoQYRMon9qQW7g
bExqgm6cI/WahnJ7CQsr/esnj7NnDfD/2lgLBDWLdNuZ9TXvXbCyqoFIUc4xA39E
xtCxZU+m90zzuGf9miJkrsW3POo7iM7KkmrbmlXGWZ4CvYN9kPGz6hN4qyANfXlg
x4Lv/RQI1+hQTlacxRkuMvV7VFsA51UJKcoEd7nYZmD79L5sp2Br7FWi8ziFkT5r
+wH4uyPbox77fLs59E+GPQaw/lDy7VeiwPv1iMx9j7FBOT+izjG1iSGgG4b5R5jt
auGEc+n+q0G7zoUl95IUvsM0JuKVxxMIX8UzZsYzfU8EYkcxYyEu0p1PY/v7D/Mp
IQKL7mOtmtqaJSGuLDiM
=zx18
-----END PGP SIGNATURE-----

--3snK74p7ddXn3Qrx--

--===============7544830479534934457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7544830479534934457==--
