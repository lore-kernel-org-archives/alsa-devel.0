From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH baohua] ASoC: sirf: atlas7: atlas7_iacc_dai_ops can be
 static
Date: Thu, 5 Feb 2015 17:11:59 +0000
Message-ID: <20150205171159.GY21293@sirena.org.uk>
References: <201502060130.hszyNa1F%fengguang.wu@intel.com>
 <20150205170352.GA49811@snb>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BbXz1MMUIxJdX0pG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150205170352.GA49811@snb>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Rongjun Ying <rongjun.ying@csr.com>, kbuild-all@01.org, Barry Song <Barry.Song@csr.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--BbXz1MMUIxJdX0pG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 06, 2015 at 01:03:52AM +0800, kbuild test robot wrote:
> sound/soc/sirf/atlas7-iacc.c:168:24: sparse: symbol 'atlas7_iacc_dai_ops' was not declared. Should it be static?

This file isn't in an upstream tree, should this patch have been sent
upstream (I suspect non-upstream trees may need a bit of filtering in
the scripts)?

--BbXz1MMUIxJdX0pG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU06ReAAoJECTWi3JdVIfQf1AH/0NlAARKvrLncypO0f7fwOZu
+7Yjn3J5rc+FV+EP3rtfVuTm0a6mElsHsBS9+0IKDkxXuwT30j4qmn5KvBFGAr71
+1Ykzf6CBlR+S+mR/FOAw1060cvDdfHn8vuV8rSZQ3zwbZf76sTvbz0NP4i/0TxR
9TMdH8UjcL0uj8pQTvyDy2zDmb0Jg4XbmM2xxdOCMj0QLWjrKf30BYMovuhw8fQJ
AxslMruIm+afpoWIkox4wXFKL14tWM5aWo9to1eDjbkU9Qik26zJfhBjHeuPTbBO
h/llvlCDNRW9QAy7pqUk9mZSi9faQEFJFwUE8bKkkGW2KQ7+HxtDEGsFYpHN58E=
=+PeG
-----END PGP SIGNATURE-----

--BbXz1MMUIxJdX0pG--
