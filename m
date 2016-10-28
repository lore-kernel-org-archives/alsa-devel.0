From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: lpass-platform: Fix broken pcm data usage
Date: Fri, 28 Oct 2016 19:26:44 +0100
Message-ID: <20161028182644.nbsbm6h7fcj3rlcj@sirena.org.uk>
References: <1477668740-30389-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1477668740-30389-3-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="arlu6voxtqu23a2q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477668740-30389-3-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Kenneth Westfield <kwestfie@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--arlu6voxtqu23a2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2016 at 04:32:19PM +0100, Srinivas Kandagatla wrote:
> This patch fixes lpass-platform driver which was broken in v4.9-rc1.
> lpass_pcm_data data structure holds information specific to stream.
> Holding a single private pointer to it in global lpass_data
> will not work, because it would be overwritten by for each pcm instance.

This is a bug fix but you've made it depend on patch 1 which is just a
refactoring and should therefore not be sent to Linus as a fix.  Please
don't do this, fix bugs first then do any cleanups and new
functionality.  That way we can send fixes to Linus without needing to
pull in extra stuff.

--arlu6voxtqu23a2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE5hjAAoJECTWi3JdVIfQU5kH/RLJrRwPZhFziQj9keWu3ha+
anXHl6qqa36Ter1lwT0AhQZkHQuFTyiVdaWOEpTBso3IQbkwvfDndKUKDQQjQrco
pODMlm2S5S6bprJ7DZTpetdqelny3LT43uzoc64elq5YJzUh+ZcvQn3kRC0TV2WV
3MfYzvonGX0tFOrTXxUWca1x0726SIarweOxlGel8CZLenwodxwZ2ZdWfkIVXQ6z
y7/nYU5kNsydHhns23HmI/RSyyZFvHRfLBGBXdaaL6UI6gmiQ1TRq94RJ1llU4tK
0+zjHbGTN3kYyIUnp58YBSIIE6O10F0WLF4B9m3+GRLdg6KyQmbRvqG0s2yUqgU=
=PKXQ
-----END PGP SIGNATURE-----

--arlu6voxtqu23a2q--
