From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: fsl: fix miscompilation of snd-soc-imx-pcm
Date: Fri, 23 Nov 2012 19:08:50 +0900
Message-ID: <20121123100849.GC4529@opensource.wolfsonmicro.com>
References: <20121123081307.GA4529@opensource.wolfsonmicro.com>
 <1353661933-27659-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353661933-27659-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2012 at 10:12:13AM +0100, Lothar Wa=DFmann wrote:
> Due to a broken make rule, sound/soc/fsl/imx-pcm-dma.c or
> sound/soc/fsl/imx-pcm-fiq.c (whatever is selected via Kconfig) will
> not be compiled into imx-pcm.o when building as module, i.e.:

What I've been trying to do is get you to tell me what the problem is
with the Makefile rule, it's really not clear to me what the issue is or
why your change is better.  I can see the practical results but nothing
about how they came to be which makes it very hard to tell if this is a
good fix.

This is a common issue with stuff you send, there's lots of analysis
missing so it's hard to understand the thought process behind the
change.

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQr0slAAoJELSic+t+oim94DMQAIClHuSnoyzOEEIVHJRL5DWm
HiImZo8qkCixLmnSAZl3rlGglqqKTG+tH6jYVqsznhibGuILMe2F99Yo0kHHbmZf
u8tkN33jcZyoaTVbEYeZDoPyQuTHLGYgVE7PLv4+W18rSWS3DDDdL/4hH0UJ/7vR
hYsyAvpMkMEZMOLoOhZGHAzyUYiUf/0ejPrHczGo4DBphfZMA3/x7zuOI0FiCr82
UA4b0j7/++N6sMW7+hFwMdLgqy2ootxMdL7S1EoxNe+hc8Pz8blWeC7733wgzELc
KZl3zoE8JDXNIrnqFVzjBzGwSmIFJl7ejpdykRUhtBuMWZm6XVhcyZPR4/zqObUy
PTJ7bh6BVpWeZgcXubi6O/c3gm8jWxe1HfwIMvvP9QPsh6fipmm3uD0Xi54I15ED
cBdspbGaUyVpM1lOVO62fGDvW83hkliVcjuFbobruUxsgK8TT4s4AOScUvNmMh6G
zKJoWUM1Stj2oFDpxSdsFvj0CRIt27IgoL1fgQvw3mgq1a22FIedERR6wct7odEt
A9LgIxcIlusfmU7/+uEHTPZ3kYEJm1wU2RNHrY6Sgb04Ccg9GixwwKkNE9NcKWaL
qfeqqlNJ7LP9U1eX0eZyWkrhKMOm3FWf6Lu2z5PsJC3KrXZlmxm925fD8OUH9Q/W
CByFLB3JjtKgE8jdnTo5
=2us+
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
