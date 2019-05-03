From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] regmap: soundwire: fix Kconfig select/depend issue
Date: Fri, 3 May 2019 13:39:57 +0900
Message-ID: <20190503043957.GA14916@sirena.org.uk>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
 <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pMHZerOf5PT7gmN5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: alsa-devel@alsa-project.org


--pMHZerOf5PT7gmN5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 19, 2019 at 02:46:49PM -0500, Pierre-Louis Bossart wrote:

>  config REGMAP_SOUNDWIRE
>  	tristate
> -	depends on SOUNDWIRE_BUS
> +	select SOUNDWIRE_BUS

This now makes _SOUNDWIRE different to all the other bus types; if this
is a good change then surely the same thing should be done for all the
other bus types.  It's also not clear to me that this actually does
anything, do selects from symbols that are themselves selected actually
do anything?

--pMHZerOf5PT7gmN5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzLxhwACgkQJNaLcl1U
h9BFVAf+Kt8GD1suXskJzvuY/n6wUgMPGxKm9mip+31Y4Nv5D7V6nydDFOwdS/f2
0C6007zZSPyN2VqhgqhyuXlop/FAn9NkAHSsw5MEdOTabr3z07tL6TazA7pH5fG1
9/uTD3fbEcxQXJLvHhgR2KlkmbougPBt+Xbsl+7r/FHx1ZZ4lxhdAFZJmpHVRUo8
NtWcaeWOOpBEfd/0L335nNPOVChuNgpgUxj5mVidltafNB5H+9ygUWlF2ad0YaRK
qmjRWKCopc7DAghRUqIf8UoL+VV+YJnsuvTXky5lsuv56h3SXQiX50+QH/aKhbBu
+CDExuiE/VrK6yKLt8+xXpUHATjxEQ==
=RQMe
-----END PGP SIGNATURE-----

--pMHZerOf5PT7gmN5--
