From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Add driver for CLPS711X DAI
	interface
Date: Thu, 27 Feb 2014 12:44:30 +0900
Message-ID: <20140227034430.GB9383@sirena.org.uk>
References: <1393430741-16272-1-git-send-email-shc_work@mail.ru>
 <1393430741-16272-2-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4593852355008538744=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 17BE3261AC7
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 04:45:15 +0100 (CET)
Received: from [223.55.94.147] (helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1WIruC-0002MH-14
 for alsa-devel@alsa-project.org; Thu, 27 Feb 2014 03:45:13 +0000
In-Reply-To: <1393430741-16272-2-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Olof Johansson <olof@lixom.net>
List-Id: alsa-devel@alsa-project.org


--===============4593852355008538744==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2014 at 08:05:41PM +0400, Alexander Shiyan wrote:

> +static int clps711x_dai_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
> +{
> +	struct clps711x_dai *s = dev_get_drvdata(dai->dev);
> +
> +	s->div2 = div;
> +
> +	return 0;
> +}

What is this divider and why does the machine driver need to manually
configure it?

> +static int clps711x_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct clps711x_dai *dai = snd_soc_platform_get_drvdata(rtd->platform);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +		atomic_set(&dai->running, 1);
> +		hrtimer_start(&dai->hrt, ns_to_ktime(dai->reload),
> +			      HRTIMER_MODE_REL);
> +		break;

I'm wondering if the FIQ code can be shared with the i.MX FIQ code?  Not
something that should block merging but it seems like it might be
helpful for other platforms that need to use FIQ support.

> +static int clps711x_pcm_silence(struct snd_pcm_substream *substream,
> +				int channel, snd_pcm_uframes_t pos,
> +				snd_pcm_uframes_t count)
> +{
> +	return 0;
> +}

Omit empty functions.

> +#if defined(CONFIG_SND_CLPS711X_SOC_MODULE)
> +irqreturn_t no_action(int irq, void *dev_id)
> +{
> +	return IRQ_NONE;
> +}
> +#endif

Eh?  Waht's this about?

> +static void clps711x_pcm_free(struct snd_pcm *pcm)
> +{
> +	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
> +	struct clps711x_dai *dai = snd_soc_platform_get_drvdata(rtd->platform);
> +
> +	/* Manually free IRQ */
> +	devm_free_irq(rtd->platform->dev, dai->irq, NULL);

Why is this using devm_?

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDrSWAAoJELSic+t+oim9AHwQAIhfU6luXAL9GwW+EQnXH5Ci
764QR9Q34XrhcPIgSQx1dq+CKJSTzvY401sFnuQamxw8NeXMJM3YrQIJ8LkmTQ/M
XFeS07m06BpqDbLKUzz5z1X47AL6sN5R5O0KTQlJAd8KqydsPkJwfLI6i+iE5O4I
I0yC21b4Si7W+/gtidDbUQChVh8oYWDMHFaIgDGkB7+79dGKKzIZcN6JmBjziynx
0YONSOy9Uy7IdEUeSV9gpk2sd2lBEosWSyWzIEZthYmT5Y0mUyS3VOpOBtibi1wR
bWDHeh5XQpDyTZERrHFMdvUPescbyIRsC67sjB/vR4/dTB0vF3ccggOPRolpa1PX
0PTySfOA/1W17dz6bpdeWWHiy3OG1KgFApx7y68sxEM2ixuPqHbJPa5B4P4YeLcG
hXP6Xi/ANVuXCRHuGDppkflsIXRgnaT2yMNcHRtJNcCViwqsRjoahm7zkKszQ+Pn
eN1pu+5PyvlrzxgP7KbdGZ5D/9Ax0PMHO8OZfHEU7hn3KcLAZsafrQ+Q0Z/33SRQ
8FPrObWNB/MaRKIDW7yErsMhfo8TIAF1mRJeXWp8O7m4arW+ZwuRRrwZRA5Qovt6
2P86mOGMZvA8FFuoh2w5qs3pTO/A50b7JqtikWw8V5YVXeghYJet1yYfxmlBsIzx
hpjrftAtjzlamR/43exS
=aZC6
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--

--===============4593852355008538744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4593852355008538744==--
