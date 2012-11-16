From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Patch v6 1/4] ARM: at91: atmel-ssc: add pinctrl support
Date: Fri, 16 Nov 2012 13:48:01 +0900
Message-ID: <20121116044758.GO4387@opensource.wolfsonmicro.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
 <1352887751-21848-2-git-send-email-voice.shen@atmel.com>
 <20121116010310.GG4387@opensource.wolfsonmicro.com>
 <50A5A843.2060902@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+wSiqF7c0ySQ2tNi"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50A5A843.2060902@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--+wSiqF7c0ySQ2tNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 16, 2012 at 10:43:15AM +0800, Bo Shen wrote:
> On 11/16/2012 9:03, Mark Brown wrote:

> >This generates lots of conflicts in the pinctrl stuff in the DTS - looks
> >like it was generated against -next.  Can you please regenerate against
> >my atmel branch with just the changes to add the pinmux information on
> >the SSC nodes?  Or possbily this can just be applied direct to the
> >pinctrl branch (we'll get an add/add conflict with the SSC nodes though
> >that should be simple to resolve, a cross merge might be helpful).

> As Mark suggested, would this patch be split into 2 patches? One is
> for atmel ssc add pinmux information go into ASoC tree, and the
> other add ssc node into dts file go into pinctrl tree. Would this be
> ok?

It's more of an either/or thing but the two patches would be OK, then we
can work out which to apply.

--+wSiqF7c0ySQ2tNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpcV3AAoJELSic+t+oim95KcP/1v8kLirgUE75EebQMvd5gMv
mtb3L+Caa6AG7KCMHDwNCbuDlCYEVFGdoxrsjj6AgkSFh1WVgzZQEdc7cr1YDm1W
HBGDF5SK6VSVlPAh96Xs9VIpPe6oe6wyVb7XHTbJNWrHQn5O/mfetBJRdvY457nK
0FS4waF1zGD8VsSPut7cbaT2Rjg5ho4Vz5rjNuxp1S3qZBeX3i8h1igtA4gW5NlD
b8wHNevBtCQyrckwUFkWplYvw3Ixfns2RyODTmRjrkbkgUxmEAOA5xGN3UHliq5T
fg3CW1DC4EfJpQf6wOHg6I5AeDQWLr7rmS6vCecvJZ9rSahVjOCBP/To9nF7bWRw
X/YVr5S+9VuYSUhGcCz65nP70s2Z+VRnnt/9cDnLlZtDmCDeFC07Q9xgX3Q55U4R
OVOXKPvKLYb6og5eB43iXF/f4Hi6D7IF4Lm2zo8LE+9fSifUYIm52CmJrBlUs+JS
uey9isTr8eMm4aagGG5Yny3MrPsqVOHj14vQUOhWPo6cUSsc/PQQzLU3yWEQO14N
T7GTVT1t+Bt68uhesIP54lq20QmpoQRMmn3nsr3Kzkp4BZzKQt/GSKdPi9lLAsxO
X+s8FqZEZxAu6VTBdGAti/Ne2mb0fkFZd2MILIQS/CSbPHkF2bvp87Sqou59Dwik
xnbF2eQQiU+tkJD97nkw
=YsJV
-----END PGP SIGNATURE-----

--+wSiqF7c0ySQ2tNi--
