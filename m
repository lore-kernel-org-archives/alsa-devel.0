From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/17 v2] ASoC: adav80x: Update locking around use of
 DAPM pin API
Date: Thu, 20 Feb 2014 19:25:55 +0900
Message-ID: <20140220102555.GG2669@sirena.org.uk>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392736948-26623-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mWXK089GQK8IfVJ1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392736948-26623-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--mWXK089GQK8IfVJ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:22:16PM +0000, Charles Keepax wrote:
> The pin updates in this driver look like they are intended to be done
> atomically, update to do so.

Applied, thanks.

--mWXK089GQK8IfVJ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBdgwAAoJELSic+t+oim9RGwP/3jNBuNY2fujF+0sWoIGdJs1
XygslON5Sxf/P2aTFTADUjpdCOtLKEFz8hUbv32EJSnzuHqipExfmx5xV1r4teo+
5HUU4u6FUg0UckElOSk+YNsneI6GyzAHIIcipGjWAyOkTOIho1hz0VfL11S57fUc
MR1UVfOY2ieBJVViz5VB/UXNowENQLVg9TcOuGK8h9oFgJwUVz3S4Pgo1y9tQ/M1
obkRhBc5xDDvKYsXkMhZl/sn4azslhjo5arxgg1qj9cUEWJG2j07Q8dltevqXlLC
e8LOAIoEJaUjS1SJ50CmcPgT+jAulP9nA1HvNN6OjcFEN9eZbV0z0+plcW+Q6rvR
SW3kDgpfNk1ZJFjOAueIe5fizn21JO1Ov1OM0sFnsgtRIZl7/ynr8WlXDEn1rXWr
GUE5VmjApJSkIesoKwDS5x+ZfcLy7Y3cOeKlyaxOGCsZhUKMT/wn0kPIK1K8UA/P
pk3Zu+tASVX3aFLs3Xf3ei3MSkxm+wZ5ExKYQ7q3Jjk5tsXxzNCyX6sk7AfmfgLn
ff9fJrfbX/vE5y9EqhkWfV22cN/z6bbZR5MQueajMc7fR6UnLV19s+huKT5k2Uou
JrijXKxUMODq/4YEQq9D3s7puGwIPZTXLusS7HfaYuREHniareG4JJlvDf8Tog75
Os7TMund62G7XvrniZQt
=uJVM
-----END PGP SIGNATURE-----

--mWXK089GQK8IfVJ1--
