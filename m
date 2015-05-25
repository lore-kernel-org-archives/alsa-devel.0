From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: use SNDRV_PCM_FMTBIT_* for format bitmask
Date: Mon, 25 May 2015 13:00:41 +0100
Message-ID: <20150525120041.GI21391@sirena.org.uk>
References: <5560AB9D.1010807@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ry3qE+viRNtbc3l7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5560AB9D.1010807@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Daniel Mack <daniel@zonque.org>, Wolfram Sang <wsa@the-dreams.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Matt Reimer <mreimer@sdgsystems.com>
List-Id: alsa-devel@alsa-project.org


--Ry3qE+viRNtbc3l7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 23, 2015 at 06:32:29PM +0200, Maciej S. Szmigiero wrote:
> snd_soc_pcm_stream.formats is a bitmask of SNDRV_PCM_FMTBIT_*,
> not of SNDRV_PCM_FORMAT_* (which are sequential integers),
> however some of ASoC CODEC drivers use these values instead.

Applied, htanks.

--Ry3qE+viRNtbc3l7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYw7oAAoJECTWi3JdVIfQZooIAIGZQ0nYr2PhEO12tor8vCX3
vwwxuYZfLWWmQiABWxw5Cbv+UlmkvF2ZoFg+9jZQYR3T6usnxSwc5JB3SlLyUeLF
EI0zx07O+WFP2f9x7ChwHmRNACaPyirBqzEEp8jIS+Gq63Zxcf0sFIfXBuJnNfgj
39PZCt7scGqSjB1lWp2MzMPrV9adOMgaea8uLzUtKmgMJLIpx10e/K5tCwNQBV2+
BpNVkkvA961zpyhOYYflO6bpMneTHQfDTPcA5HEkPcqqFGp10TkjZzAhBJHyelwD
4NiIjsqgkHDK6YrlhAkoQ6ntJVRgqJj+Tz1ALj5JKv2pM0UhfaVxRuy0tDXAOyA=
=zH8Z
-----END PGP SIGNATURE-----

--Ry3qE+viRNtbc3l7--
