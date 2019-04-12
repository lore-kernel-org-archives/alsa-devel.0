From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 1/2] regmap: soundwire: fix Kconfig
 select/depend issue
Date: Fri, 12 Apr 2019 15:18:41 +0100
Message-ID: <20190412141841.GA6235@sirena.org.uk>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <20190411192814.10663-2-pierre-louis.bossart@linux.intel.com>
 <s5ho95bpqis.wl-tiwai@suse.de>
 <bd9a5c75-8519-b6ac-ca16-7fa93c706ead@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd9a5c75-8519-b6ac-ca16-7fa93c706ead@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: alsa-devel@alsa-project.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 09:07:41AM -0500, Pierre-Louis Bossart wrote:

>  config CODEC_XYX_SDW
> 	 tristate "XYZ SDW Codec"
>          depends on SOUNDWIRE
>          select REGMAP_SOUNDWIRE

That looks good.

>  config REGMAP_SOUNDWIRE
>          select SOUNDWIRE_BUS

> it'd follow the typical pattern seen in sound/soc/codecs/Kconfig:

IIRC the select here won't actually do anything.

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywnkAACgkQJNaLcl1U
h9A7BAf/ZQPvLJvY2riHokRX7TsbOrjabKTlSnHcIylInSlPNaDWMb4onD5Mo3Ma
C7OFe1IN/Xrxtd8xj4Z54s286Irimk+KwJGVYNjUuNP4ekEzcLmVe+UN6TzCaelg
dlB8d7i0lGGTc8LVXgto+Rf8CzoejfbmbGPjzynsIbiqZZ/eljacwAkuxMD8IPZn
g32rsw3f/vzhOr3frnTfTe9SvZp3qiKMPRtRYHofXYp8xoOa+hU1jwHmF6bZ2D+O
p6uaBh1SeVt5VtqThNWGvFUHB+QZfqGV86C4T6OkaPWpEK6F58ANWao93izGPlz4
nwO1+67/EJ2bQzGNPAVJOcc0MjOsaw==
=Uu1+
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
