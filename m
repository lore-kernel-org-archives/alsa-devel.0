From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/11] Fix driver reload issues
Date: Tue, 25 Jun 2019 13:04:50 +0100
Message-ID: <20190625120450.GR5316@sirena.org.uk>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eCam2inYEBLywDwW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--eCam2inYEBLywDwW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 01:36:33PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
> Hi,
>=20
> This series of patches introduces fixes to various issues found while
> trying to unload all snd* modules and then loading them again. This
> allows for modules to be really _modules_ and be unloaded and loaded on
> demand, making it easier to develop and test them without constant
> system reboots.

Pierre?  You did comment on the general concept in one of the patches
but not on any of the patches directly.

--eCam2inYEBLywDwW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0SDeEACgkQJNaLcl1U
h9Aszgf/ZJcrZYUqHzmeb3usoo7uoPZKU3yDTW95/KnXa232hRqc+j9GhPGFxXh5
gZjfJzHgyW/51JU+fGwPfMUP4EF/QgSzBBleqChmxPxmnmuD8MPi81bcSLHAtj0e
O2xQ4PJ0FM/FjaZaCWVjSxq0WQf22K4gfZjcRa6GmbYtourQgMPPQVbz3nXREqQc
PCgSV8UyoLC8xR72b0eUIks0UFuR7NVhKJSirPAmdspgdDdPT9WI3pFRmWUeZjno
gVLToJw2hJ9oNp0HIk2fHH/LuAyF6HRWJHQFCJypSWuz3btq/G9b5zgaQYKNxNaT
2XJRfIR7ang8lYLECK/8CnCxS6ZVgA==
=j2NT
-----END PGP SIGNATURE-----

--eCam2inYEBLywDwW--
