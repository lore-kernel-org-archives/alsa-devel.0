From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [alsa-devel] [PATCH 6/6] ASoC: Intel: kbl: Enable mclk and ssp
 sclk early
Date: Fri, 8 Sep 2017 08:56:52 +0530
Message-ID: <20170908032644.GA19877@subhransu-desktop>
References: <1504794565-19168-1-git-send-email-subhransu.s.prusty@intel.com>
 <1504794565-19168-7-git-send-email-subhransu.s.prusty@intel.com>
 <f1f70b1f-7b83-876a-f0ce-0db6d3542f18@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f1f70b1f-7b83-876a-f0ce-0db6d3542f18@linux.intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, harshapriya.n@intel.com, tiwai@suse.de, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, patches.audio@intel.com, broonie@kernel.org, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 07, 2017 at 05:19:25PM -0500, Pierre-Louis Bossart wrote:
> 
> >+static int platform_clock_control(struct snd_soc_dapm_widget *w,
> >+			struct snd_kcontrol *k, int  event)
> >+{
> >+	struct snd_soc_dapm_context *dapm = w->dapm;
> >+	struct snd_soc_card *card = dapm->card;
> >+	struct kbl_rt5663_private *priv = snd_soc_card_get_drvdata(card);
> >+
> >+	clk_disable_unprepare(priv->mclk);
> >+	clk_disable_unprepare(priv->sclk);
> >+
> >+	return 0;
> >+}
> >+
> >  static const struct snd_soc_dapm_widget kabylake_widgets[] = {
> >  	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> >  	SND_SOC_DAPM_MIC("Headset Mic", NULL),
> >@@ -77,7 +95,8 @@ enum {
> >  	SND_SOC_DAPM_SPK("HDMI1", NULL),
> >  	SND_SOC_DAPM_SPK("HDMI2", NULL),
> >  	SND_SOC_DAPM_SPK("HDMI3", NULL),
> >-
> >+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
> >+			platform_clock_control, SND_SOC_DAPM_POST_PMD),
> [snip]
> >+static int kabylake_enable_ssp_clks(struct snd_soc_card *card)
> >+{
> >+
> >+	struct kbl_rt5663_private *priv = snd_soc_card_get_drvdata(card);
> >+	int ret;
> >+
> >+	/* Enable MCLK */
> >+	ret = clk_set_rate(priv->mclk, 24000000);
> >+	if (ret < 0) {
> >+		dev_err(card->dev, "Can't set rate for mclk, err: %d\n", ret);
> >+		return ret;
> >+	}
> >+
> >+	ret = clk_prepare_enable(priv->mclk);
> >+	if (ret < 0) {
> >+		dev_err(card->dev, "Can't enable mclk, err: %d\n", ret);
> >+		return ret;
> >+	}
> >+
> >+	/* Enable SCLK */
> >+	ret = clk_set_rate(priv->sclk, 3072000);
> >+	if (ret < 0) {
> >+		dev_err(card->dev, "Can't set rate for sclk, err: %d\n", ret);
> >+		clk_disable_unprepare(priv->mclk);
> >+		return ret;
> >+	}
> >+
> >+	ret = clk_prepare_enable(priv->sclk);
> >+	if (ret < 0) {
> >+		dev_err(card->dev, "Can't enable sclk, err: %d\n", ret);
> >+		clk_disable_unprepare(priv->mclk);
> >+	}
> >+
> >+	return ret;
> >+}
> >+
> >  static int kabylake_rt5663_hw_params(struct snd_pcm_substream *substream,
> >  	struct snd_pcm_hw_params *params)
> >  {
> >  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> >+	struct snd_soc_card *card = rtd->card;
> >  	int ret;
> >+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> >+		ret = kabylake_enable_ssp_clks(card);
> 
> Is there a reason why the clocks need to be enabled in the
> hw_params() instead of platform_clock_control()?

Hi Pierre,

Thanks for the review.

For rt5663 the internal codec clock is configured in set_sysclk callback.
And It is understood from realtek that the mclk/bclk need to turned ON
before the set_sysclk call for a successful clock synchronization by the
codec. So the clocks are enabled in hw_params and disabled in
platform_clk_control.

I will add comments explaining this in the v2 once I receive feedback for
rest of the series.

Regards,
Subhransu

> The code is not symmetrical between enable/disable, is this
> intended? I remember seeing this in a different context (dialog
> codec?).

-- 
