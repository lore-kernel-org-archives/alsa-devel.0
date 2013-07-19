From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: sirf: add I2S CPU DAI driver
Date: Fri, 19 Jul 2013 17:52:46 +0100
Message-ID: <20130719165246.GL9858@sirena.org.uk>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-3-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2196673487156001237=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B21F265740
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 18:52:49 +0200 (CEST)
In-Reply-To: <1374232042-26088-3-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2196673487156001237==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Content-Disposition: inline


--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2013 at 07:07:18PM +0800, Barry Song wrote:

Pretty good overall - there's a few things below but should all be
fairly small.

> +static int sirf_i2s_startup(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +
> +	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
> +
> +	if (si2s->master_mode)
> +		pwm_enable(si2s->mclk_pwm);
> +	clk_prepare_enable(si2s->clk);
> +
> +	device_reset(dai->dev);
> +	snd_soc_dai_set_dma_data(dai, substream,
> +		&sirf_i2s_dai_dma_data[substream->stream]);
> +	return 0;
> +}

device_reset() sounds like it's not going to work for simultaneous
playback and capture.

> +static int sirf_i2s_trigger(struct snd_pcm_substream *substream,
> +		int cmd, struct snd_soc_dai *dai)
> +{
> +	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
> +	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		spin_lock(&si2s->lock);
> +
> +		if (playback) {
> +			/* First start the FIFO, then enable the tx/rx */
> +			writel(AUDIO_FIFO_RESET,
> +				si2s->base + AUDIO_CTRL_EXT_TXFIFO1_OP);
> +			mdelay(1);
> +			writel(AUDIO_FIFO_START,
> +				si2s->base + AUDIO_CTRL_EXT_TXFIFO1_OP);
> +			mdelay(1);

Do we really need these 1ms delays?  They're very long for the
context...

> +static int sirf_i2s_prepare(struct snd_pcm_substream *substream,
> +			struct snd_soc_dai *dai)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
> +	u32 ctrl = readl(si2s->base + AUDIO_CTRL_I2S_CTRL);
> +
> +	if (runtime->channels == 2)
> +		ctrl &= ~I2S_SIX_CHANNELS;
> +	else
> +		ctrl |= I2S_SIX_CHANNELS;

A switch statement for the number of channels would make me happier
here.

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		ctrl = readl(si2s->base + AUDIO_CTRL_I2S_CTRL);
> +		ctrl |= I2S_SLAVE_MODE;
> +		writel(ctrl, si2s->base + AUDIO_CTRL_I2S_CTRL);
> +		si2s->master_mode = 0;
> +		break;

Do we need locking on all these register updates?

> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		si2s->master_mode = 1;
> +		return -EINVAL;

Should this be undoing the work done for _CBM_CFM?

> +#ifdef CONFIG_PM
> +static int sirf_i2s_suspend(struct platform_device *pdev,
> +		pm_message_t state)
> +{
> +	struct sirf_i2s *si2s = platform_get_drvdata(pdev);
> +
> +	si2s->i2s_ctrl = readl(si2s->base+AUDIO_CTRL_I2S_CTRL);
> +
> +	clk_disable_unprepare(si2s->clk);
> +
> +	if (si2s->master_mode)
> +		pwm_disable(si2s->mclk_pwm);
> +	return 0;
> +}

Should these be runtime PM calls as well?  Seems like the bus could be
unclocked whenever audio is not playing.  If you need the clock to write
conifguraiton perhaps regmap-mmio could help?

> +	spin_lock_init(&si2s->lock);

What is this lock actually protecting?

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6W7bAAoJELSic+t+oim9oJkQAJwvrRICRzUKIAj0so45OZDa
2QkV1M1oT7oE4Haljwf1cpOX3a9wyO1A0rw8kAAgzu1rk3Z/2zKFjAcKjk8vJJ9v
NCrI7psAZobXPyIavGPtoz53mo6TBz1/j4gqaScLpEQX1P1CLj7h25Cd3wED1Yzq
m2BD5TIiplN96TTDUMlDHZVYWhCRTUj2AGJfA39aIC2pkPptKwCubh8GiKsI3wl8
4A3hoHEErJRPA/nS6twwNI+iJtGP8Ke2R73j5OBrlk7T5/LGmAXZr2acPJ5Gwl3n
Elwbdn2GmHPfp/3wiriNGJ0TsavgH3wQffrc842PoJdUKvbfbyfZqr+esGsR7VxC
e5qGkmwqSMsFjqMKPTcTkkQKN1Z0AkIJnb2WoY7vzOt5cqmbBi6pX+uGwFIRjpMw
Y5fQh28mplZvafi13m8M3ye/Vu37McH7cJR4NKUHpTZlZpfgM560/injn3SW0628
nts30HZUpM7YwpSodq/6Haz4od8ruWb8X69BAAST45AIJV5W0PpyX73Hsm3N+Gd1
tjOmNKYyizWhk3Cfu9CEYK9V1817EjpGeztCI8oZsEJcNeYqOaes3amfgPaqvFpj
p7r4wL+OKB7l5ikvgaukS4DHNZlnxEb3NeJt2kqmFf5+phtOE0U+uwQoxpYaIKQT
gtyc1EtaKeAcd02ZZ176
=soAT
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--

--===============2196673487156001237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2196673487156001237==--
