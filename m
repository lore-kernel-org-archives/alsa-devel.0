From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add resource managed devm_snd_soc_register_codec()
Date: Fri, 20 Dec 2013 11:52:01 +0000
Message-ID: <20131220115201.GO31886@sirena.org.uk>
References: <1387533407-15623-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oDT6ON1uLKeoILhE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387533407-15623-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--oDT6ON1uLKeoILhE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 05:56:47PM +0800, Xiubo Li wrote:
> Adds a resource managed version of snd_soc_register_codec() which makes
> it possible to simplify the remove function as well as the error path
> for codec drivers.

The reason this has not been added is that the goal is to merge CODEC
and component so rather than churn all the CODEC drivers to add this and
then churn them again to convert to components it'd be better to add the
component registration we could do the conversion and then update all
the drivers only once.  That's not actually happened yet though...

--oDT6ON1uLKeoILhE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStC9eAAoJELSic+t+oim9N28P/0Y+fc1hjKNYyk0ZAtNHVWt+
9gt/HoeP8QNzmvQhfKmmlCv6+HAsgmkKAIQH3xj/7Gt517lKjUV13v5foI7CzvSk
vYYIL7Deob84cj88kDk8RkXkd+qkuB76hD7UOdf/r3mzsaxYwzNNLz+BFlmTpMSV
hpxCqk8Zy4JszaThlYLHa0X5bLHdik9IA+mFwA4xQCzcVHYZ9hfivYuMH6rg/qB6
Pa6PcJUdTLwSQO+XpM+YtAn2fPD9x4I3DWctxPYM8Cw+9c378qctDhpCGWDr2Ihn
EHRPq2eai3IJoobmX9to+R4faqhhlU0vHVjz70PW9TsUnCq5ZU1+pdmFtmIMtzzJ
+myPCAeZghjQ41iCfsGquZfp+QCrM44p/YvYg41O9wc2L+U0eZcj6uoBW+fBHrEz
1vaMFfFdUToEHqzftoiuE6AOzZPV612q7G0O+EuG4zKeFMWDM6C9aWQskzdep9Kp
zQNaPGWAVo+Ih+lXj8BVrdwiFL2vXVGXeje3bwnC011vs0WQRByIND7evLW5KLoC
5FVtNRHLtJvluwwSUvdyEp5Cl9UzDviI41JkIqik9jCJYflw55werBtb/kDny+uN
psyM6d+1FwwIaXfPpHohx/l0xhiUxNyQkEZezKlSVvKA7nS/2ZNr+6hocL1AV/+B
eLHEQEj7YwSTdJ7B+JUn
=wEXn
-----END PGP SIGNATURE-----

--oDT6ON1uLKeoILhE--
