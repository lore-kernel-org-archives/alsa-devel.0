From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 15/17 v2] ASoC: pxa: magician: Update locking around use
 of DAPM pin API
Date: Thu, 20 Feb 2014 19:54:01 +0900
Message-ID: <20140220105401.GQ2669@sirena.org.uk>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392736948-26623-16-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RAbP3WyQYKsI2/Hz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392736948-26623-16-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--RAbP3WyQYKsI2/Hz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:22:26PM +0000, Charles Keepax wrote:
> The pin updates in this driver look like they are intended to be done
> atomically, update to do so.

Applied, thanks.

--RAbP3WyQYKsI2/Hz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBd7GAAoJELSic+t+oim91HUP/AsgzjBWQP5f9NgIV0IMc1Io
80bPfDPvo/aFGkdcLFVCFPjzsA1tDoK6xAnutgGCVaY7lbGSDk2QcwXZh9FyVHq0
KIHr8tlb0Dkry1Sb1Ua7Boca5Ev/lwQOsy8FqTfLVtaqhGrcotH+ckR55kbTi3tH
4zdiNIj2krBFjPNOKzdKtqZQl1YhF7/5MKy8PCSZCgRrfGfitUGpdXDWGVrCEFQ4
ILCjedzali7TzlSwn2eOQNQQLN+fSdBPJlsBza0eh2A43OCsqwZQhyHBsdmZ8Saq
UhpUz7VXAVzsPVtXfwXukegqMEkgSsKrgls5bA5YgrlIGYsppWq5gxvSOCn6hSQE
+5y+EqA58LbHN7SrDhm476slIFSpGnqkc1wCX8xfkmQO9qPm3dU3DSC0LbBqwU+I
997HpPnAFU5eqO8tue2KqWxE0ZdWxn/9Vrjk2K8jxULbfX/FYNWu2UPEF4zxciRf
GFlADS1qQaEYL2F6zbQqYWNDFoh5UBnDeifTyXxJdLxn2snqYVx8WQEC4DDnu/wF
tko63hPcj2cDxsOM+7K9UDkIzMuhqHi9G5/A1Zbyti7xZAcQsCsViLNC5DtxJWL+
OBCPLG4awZT1OMnoEy5ishmDhn8PlOdjfKA91DpQZUTYsy4fLOgbXQ7PeVWSRW5E
o0TMkBkIEALtjvgR3fa/
=3afl
-----END PGP SIGNATURE-----

--RAbP3WyQYKsI2/Hz--
