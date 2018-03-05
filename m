From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: dapm: add support to pinctrl dapm
Date: Mon, 5 Mar 2018 15:52:08 +0000
Message-ID: <20180305155208.GK8588@sirena.org.uk>
References: <20180305123213.2045-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2539348093352906645=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A92482671A8
 for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2018 16:52:17 +0100 (CET)
In-Reply-To: <20180305123213.2045-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============2539348093352906645==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2WS97oupGEGbYNpW"
Content-Disposition: inline


--2WS97oupGEGbYNpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2018 at 12:32:13PM +0000, srinivas.kandagatla@linaro.org wrote:

> +int dapm_pinctrl_event(struct snd_soc_dapm_widget *w,
> +		       struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_dapm_pinctrl_priv *priv = w->priv;
> +	struct pinctrl *p = w->pinctrl;
> +	struct pinctrl_state *s;
> +
> +	if (!p || !priv)
> +		return -EIO;
> +
> +	soc_dapm_async_complete(w->dapm);

This doesn't look right - we're trying to synchronize with the DAPM
async queue from something that should be run inside that very queue.
What is this supposed to be doing?

--2WS97oupGEGbYNpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdZ6gACgkQJNaLcl1U
h9Cf2Qf+LEcnkBxz5K9/VMMvmHzkz6BFHGu6MjMGN3KKJAiV/NN5mKOnL0jFqlci
to7GQdx9HMXBCq6osQqHuDOYtY57kYWN0KpBG0i3dddvJLF4kGc+QZnzB7WpBfeu
0Vb1T/nE9h6J7wSqfIdYqxUw/7cAdIqxL/qrV8PQWTgZFKAV/45VuQ/bEYVZsmFM
uXqUuGwJm0OFkU66pkHVg4b1fPBIP3XfX9UohgO3Gejj8N7gBIBI4tPD3J42Eu49
CEGHaf0888RmXYQprZZcUE8NOQH+zsbkU6TNhf0JFVVL1u9QF0ofR1mz6IaIZ/lL
A9B8c0OT+3Z8CRMxSB0VFL5wnqKm6g==
=hY2d
-----END PGP SIGNATURE-----

--2WS97oupGEGbYNpW--

--===============2539348093352906645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2539348093352906645==--
