From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: codecs: msm8916-wcd-digital: add
 support to set_sysclk
Date: Mon, 17 Jul 2017 15:44:50 +0100
Message-ID: <20170717144450.lk7xfnwtkvt26qvw@sirena.org.uk>
References: <20170717135410.26812-1-srinivas.kandagatla@linaro.org>
 <20170717135410.26812-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7025185906659546816=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 80B782669F3
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 16:45:02 +0200 (CEST)
In-Reply-To: <20170717135410.26812-2-srinivas.kandagatla@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============7025185906659546816==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="itxorw3ehfov4e6u"
Content-Disposition: inline


--itxorw3ehfov4e6u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 17, 2017 at 03:54:08PM +0200, srinivas.kandagatla@linaro.org wrote:

> +static int msm8916_set_dai_sysclk(struct snd_soc_dai *dai,
> +				 int clk_id, unsigned int freq, int dir)
> +{
> +	struct msm8916_wcd_digital_priv *p = dev_get_drvdata(dai->codec->dev);
> +
> +	clk_set_rate(p->mclk, freq);

This is ignoring the return value.

--itxorw3ehfov4e6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllszWIACgkQJNaLcl1U
h9CH8gf+KKLopZSRYaAbpk4qiFa8pWLXV0FYTdQuO9zblRftKMbMvVtBLKpM5DT+
z38ibIjg+bEguIfb58EazgUYxfNx1hAKrUnNAgPAsFoqMDrbadpAARiLrrzDroMI
v6iXsT8sUr93BvZsPF9mrA3GE3HbRe6c4OLr9S9kgb+VNWPETYmD5swQrYPQgEJu
STom7eHAFccACs8gcxGK8tE8kYIC+CG57s8cZZAUIOUcQvutnnxUXeffKJDJWsJS
73QUplQ6nl/IMhePccBIw3o73DcMlZSMa5akDg+VOVcVwU82hZ+xO0WV4CBtE+Uh
u4eFl2uCQST6Y/IAANlaipymrjJbfQ==
=bFNM
-----END PGP SIGNATURE-----

--itxorw3ehfov4e6u--

--===============7025185906659546816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7025185906659546816==--
