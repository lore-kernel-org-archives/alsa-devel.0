From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: allow changing the playback/capture rates for
 symmetric links
Date: Wed, 4 May 2016 17:49:22 +0100
Message-ID: <20160504164922.GB6292@sirena.org.uk>
References: <1461746959-11443-1-git-send-email-peda@axentia.se>
 <20160427161504.GZ3217@sirena.org.uk>
 <122ca84a-230e-654e-425f-3adb0ca00ec7@axentia.se>
 <20160428103822.GJ3217@sirena.org.uk>
 <c7193097-f216-df7d-2f94-bd5f6684c28b@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zKD0QXBepZ0ysD7Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c7193097-f216-df7d-2f94-bd5f6684c28b@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--zKD0QXBepZ0ysD7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 02, 2016 at 09:43:53AM +0200, Peter Rosin wrote:

> The problem is in the drain/close part. If I leave out snd_pcm_drain
> I naturally lose the tail of the output, but if I have it I get what
> I guess is a repeat of the content in some circular buffer. I.e. the
> very last part of the played sound is played twice(ice).

> If I instead write the generated samples to a file and play them
> with aplay, all is fine, so I appear to be misunderstanding the
> alsa api?

> Anything obviously wrong in the above code?

Look at how aplay handles this...  it's a natural consequence of the
hardware being free running.  You need to either make the teardown
non-blocking or play some silence at the end.

--zKD0QXBepZ0ysD7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKigRAAoJECTWi3JdVIfQzhQIAIQvWx3Sop7mLUHDXpuYAI5n
/FKDyGJGI/TegfvF1s/KbIRsnekt2SoLqcm89vAdJZscKpUwSNT7tiUThOiSU2NR
VBVporNq9t4ksemrR27jMsRfJZ3OzwqFcG1Fn24Ynh7AEiHEmBeD0lXW7ovodrnu
jzIHXmEWsno3mt+lq87Komdcboz4q+AGSDoDicyCeEIHSmtRL4rMkc9k57G6COi9
P61tuDVWe43hiSd667nBx7xYMr0WyOBlU2XlCQhvtxFaFGxNdYbtRzpgLnMcVLS7
o3EqrpxewEFmOslLv+eHj3yo6L0soMwZB5+gKzGtKaCsWG1+pZD7vEJ+CSBWTdQ=
=2/ia
-----END PGP SIGNATURE-----

--zKD0QXBepZ0ysD7Q--
