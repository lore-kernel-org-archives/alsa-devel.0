From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: sn95031: add capture support
Date: Wed, 19 Jan 2011 12:51:32 +0000
Message-ID: <20110119125131.GB31791@opensource.wolfsonmicro.com>
References: <1295441169-32063-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F162924469
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 13:51:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295441169-32063-1-git-send-email-priya.harsha@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <priya.harsha@intel.com>
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 19, 2011 at 06:16:09PM +0530, Harsha Priya wrote:

> +static int amic1_mic_bias(struct snd_soc_dapm_widget *w,
> +				struct snd_kcontrol *k, int event)
> +{
> +	unsigned int value = 0;
> +
> +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> +		pr_debug("AMIC1 SND_SOC_DAPM_EVENT_ON doing\n");
> +		value = BIT(2);
> +	}
> +	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(2), value);
> +	return 0;
> +}

I'm not clear why this is being done using an event?  It's updating a
single register bit which is what the standard MICBIAS widget does.
There's also another example of debug logging which replicates the
standard feature facilities.

> +static int dmic12_mic_bias(struct snd_soc_dapm_widget *w,
> +				struct snd_kcontrol *k, int event)
> +{
> +	unsigned int ldo = 0, clk = 0, out = 0;
> +
> +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> +		pr_debug("DMIC12 SND_SOC_DAPM_EVENT_ON doing\n");
> +		ldo = BIT(5)|BIT(4);
> +		clk = BIT(0);
> +		out = BIT(3);
> +	}
> +	/* program DMIC LDO */
> +	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(5)|BIT(4), ldo);
> +	msleep(1);
> +	/* enable/disable DMIC clock and o/p */
> +	snd_soc_update_bits(w->codec, SN95031_DMICLK, BIT(0), clk);
> +	snd_soc_update_bits(w->codec, SN95031_DMICMUX, BIT(3), out);

How about using a supply widget for the LDO and the clock?  This would
also ensure that...

> +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> +		pr_debug("DMIC34 SND_SOC_DAPM_EVENT_ON doing\n");
> +		ldo = BIT(5)|BIT(4);
> +		clk = BIT(1);
> +		out = BIT(4);

...we don't end up disabling them when one of the DMICs is shut off but
the other is left on.

> +	SND_SOC_DAPM_MIC("AMIC1", amic1_mic_bias), /* headset mic */
> +	SND_SOC_DAPM_MIC("AMIC2", amic2_mic_bias),
> +	SND_SOC_DAPM_MIC("DMIC1", dmic12_mic_bias),
> +	SND_SOC_DAPM_MIC("DMIC2", dmic12_mic_bias),
> +	SND_SOC_DAPM_MIC("DMIC3", dmic34_mic_bias),
> +	SND_SOC_DAPM_MIC("DMIC4", dmic34_mic_bias),
> +	SND_SOC_DAPM_MIC("DMIC5", dmic56_mic_bias),
> +	SND_SOC_DAPM_MIC("DMIC6", dmic56_mic_bias),

These widgets are for use externally to the device in machine drivers.
The pins on the CODEC should be _INPUT() widgets and the biases should
be MICBIAS widgets.

> +	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "MIC1 Enable", SN95031_MICAMP1,
> +			0, 1, 1, 0),
> +	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "MIC2 Enable", SN95031_MICAMP2,
> +			0, 1, 1, 0),

These look awfully like they should just be normal PGA widgets?
