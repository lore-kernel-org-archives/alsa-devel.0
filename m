From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs/wm8978: Only reconfigure
 GPIO1 when used for PLL output
Date: Thu, 15 Nov 2012 14:20:38 +0900
Message-ID: <20121115052036.GE7599@opensource.wolfsonmicro.com>
References: <1352482418-64950-1-git-send-email-emillbrandt@dekaresearch.com>
 <20121113064410.GE18224@opensource.wolfsonmicro.com>
 <0A40042D85E7C84DB443060EC44B3FD3459CEDE0D5@dekaexchange07.deka.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5301492235325369555=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7E892615A7
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 06:27:16 +0100 (CET)
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD3459CEDE0D5@dekaexchange07.deka.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5301492235325369555==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Content-Disposition: inline


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2012 at 09:43:08AM -0500, Eric Millbrandt wrote:

> However, I agree that the handling of the pin is odd.  Does OPCLK really need
> to be reconfigured as input whenever the PLL values are updated?  I didn't
> see anything in the user manual to suggest that that needed to be done.

It should not be a requirement of the device itself.  It might be a
requirement of something using the clock but the system doing that
should take care of remuxing the pin as needed.  What I'd suggest doing
here is removing the management of the pin completely from this
function.

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpHuYAAoJELSic+t+oim9/1cQAJy3KwYXE9YZw1ZETXXnYV2v
3L/M5JRlLc4RLqzuVy2r/VPTx2GMg/VAF5u6ye+SoQh7HTktV491mEssBubS1+pg
AVE/eC4dkg8lhUToPyRqLF/3zCxwAHgzx9Ph4OGnrwYc1I2ascRC7plU1Fu/0PJW
eFNpuCWZQiINK/T2NOKPrrxMvDyp5fYhiC5l9OTFVsyVAByMVOp+qFk+zlPqZakn
+sSYeG87UMmtjenwETV4Pp7bXQNEJnNd+MRHKapaQq9zbkYT3s+5ePv8lnTaeVIU
2QnFX2aEf+6Deuo4oNOPwZLDLr6x6MQlwWxPtwXJyL81PPY7R4CH009WxzwlLauk
SovUyTnKPUrolCnVJ5gXWnfvvlJwhCoulGSGHTvQibj8tuRfhTyJ/8J0tY6wsu7O
vbPeRrV9e/Na4fmbRyXOEZl5o7iKWOa3FdNHGFt2CWylBlbRiUEdGvvENfFRc0x4
p8HkqH0N8zIUi6hoBMK9Jd7PeRyKtZJJV7MOZv8HD1N5pzrix4K0X2hPKVlXIDAq
Bpa4f52r5f6WMiL7xcP6dfyjZZTr6fNa+H+4biydFLaVD5Hpo5A2vOlT5bBPZE4u
2i5nbMifwSk1Ru6Ta+5SgxWOhJSYYZ1LtQR+Sh9gDCDZxgfv/NKkZcOWOLOIjt1j
iyphntDRNdLoBVbApA8j
=bvZ+
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--

--===============5301492235325369555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5301492235325369555==--
