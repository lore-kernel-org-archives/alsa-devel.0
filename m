From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/11] ASoC: Intel: Skylake: Remove static table index
 when parsing topology
Date: Wed, 26 Jun 2019 13:26:44 +0100
Message-ID: <20190626122644.GD5316@sirena.org.uk>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
 <20190617113644.25621-6-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="on+I5Kkc+zqLv55g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190617113644.25621-6-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--on+I5Kkc+zqLv55g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 01:36:38PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
> Currently when we remove and reload driver we use previous ref_count
> value to start iterating over skl->modules which leads to out of table
> access. To fix this just inline the function and calculate indexes
> everytime we parse UUID token.

This doesn't apply against current code, please check and resend.

--on+I5Kkc+zqLv55g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0TZIQACgkQJNaLcl1U
h9CIkAf/XqlWXek/c2A2wcZGYAvrtlTTQ8sZ/0UuXaQmIjtdEo1DyARVUHh+Qssv
Fl4RPsk4Bs9kkVhKIpoBbIzonFCi37z9HmzixNEUG8ohCZZ4T5KP4zM/nkhXkrjC
dv/CrAIRGAL252YrJEaZHjHs15sKRP3vIKB2gdrgIQbDS/7CbQSo4e8kPc4gFzWp
iL14YeiHxQxadR9Vx3YkF5c0ArkbsCgHeUQB66a51ENNA9d4dA4J/kZHKczYawv6
lYiqS2cjv+e8KT1CgtPHEaTchKTOfsoxxDahf7uwzxg+MieeSyf8Q8e6YQVX5ZL5
qLrUTgT38tJxoRIHV1vLTaGIJ1it3w==
=H7fM
-----END PGP SIGNATURE-----

--on+I5Kkc+zqLv55g--
