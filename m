From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/8] sound: soc: pxa: Suppress SND_MMP_SOC for arm64
Date: Wed, 22 Feb 2017 10:47:34 -0800
Message-ID: <20170222184734.wmkbzfsz4yklofcg@sirena.org.uk>
References: <20170222022929.10540-1-afaerber@suse.de>
 <20170222022929.10540-5-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bhhb7bdri6ffkv2d"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170222022929.10540-5-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, info@andromedabox.org, linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--bhhb7bdri6ffkv2d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 03:29:24AM +0100, Andreas F=E4rber wrote:

This is patch 4 of 8, what's going on with dependencies here?

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

>  config SND_MMP_SOC
> -	bool "Soc Audio for Marvell MMP chips"
> -	depends on ARCH_MMP
> +	bool "SoC Audio for Marvell MMP chips"
> +	depends on ARCH_MMP && ARM

There are no obvious build time architecture dependencies for this
driver, shouldn't we have an || COMPILE_TEST in here?

--bhhb7bdri6ffkv2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlit3MYACgkQJNaLcl1U
h9Ca8Qf8D1dyTYXcClzVbS57p2kGhSfhVxxUqLaLQA0QMRB242SUt5hHi8p4M6+S
pha2MGfdMpsFjKs46wAgrDmIF5XgHi+RLdal8Zgkf2Vr2HFgudd2Tv5cIfy0j4Ze
F0mJtj3gHcfwdeQxNmJpLH0Uojrp475CBtQI7M0Qze6l+GldpBfuU5kGde6BM3v4
iZr2i8ngMQHselJoorEbrukg9AetRr0COiIWn/t37z4YKWWNryeP9CVEZOLJBV6H
AUY69S34Dii80ZbnZcnHu89fMslX1/OvapkZ7WvtkT8/WF7WmfmpKj4JXliVcd3T
1AJk0FLQYqnaw3y8r3GPLH1E2HniAw==
=0NE9
-----END PGP SIGNATURE-----

--bhhb7bdri6ffkv2d--
