From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] Applied "ASoC: topology: Fix logical inversion in
 set_link_hw_format()" to the asoc tree
Date: Tue, 27 Feb 2018 10:38:49 +0000
Message-ID: <20180227103848.GA11822@sirena.org.uk>
References: <E1eqGmV-0005Rk-Jt@debutante>
 <20180226183407.22335-1-k.marinushkin@gmail.com>
 <e25d592b-0fab-68f8-d9e0-e5061c54f4e0@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e25d592b-0fab-68f8-d9e0-e5061c54f4e0@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>, alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 26, 2018 at 06:30:15PM -0800, Pierre-Louis Bossart wrote:
> On 2/26/18 10:34 AM, Kirill Marinushkin wrote:

> > According to the comment, the existing functionality works correctly "WRT the
> > interface". The suggested commit doesn't fix the behaviour: instead, it reverts
> > the logic to "WRT the codec". But the existing implementation is also valid.

> Look at all the machine drivers, they always use the mask by looking at the
> codec side. The comment on top means that the SOC side ('the interface') is
> the dual of the codec side.

> This issue was found during the development of SOF (Sound Open Firmware)
> where we get the reverse of the intended behavior when using the same
> conventions in topology files as in machine drivers.

Is this perhaps something that the earlier firmware is handling inside
the firmware?

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqVNTYACgkQJNaLcl1U
h9Aazgf+MUDp30qZ5U+NfobyAYb6Ddqp3RwPl2slmQX8MfWfCHR4+hlkO4qSgDZB
plLkqP2MDYz8f6v4KOIUNal5nsI9w/ycXAZ9jYC7P23zcn/sK4zFd4m77/0BGLuS
a8s5VywPtjtkyn2xdy7ywJsX15YvzgxdoTRm49ojDixFlCSe7KWRuEaeLaYVMzTc
SnCjIgan7oqAZ03gk7undXbBfDlErbJ/ocaz6f+Bohz7jgUI8VGr2XzJ8RWxXDY1
u0TsbcFKDRGJxagtf9b5tYno5d+RsJBmVTUvk32WBlNxrzpDfPO+uacUhQt2sbQH
haQp4qC3ajBHrKxZ5hWhfdcriDtBeg==
=Tnwa
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
