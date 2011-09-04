From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: rt5631: first commit
Date: Sun, 4 Sep 2011 09:08:10 -0700
Message-ID: <20110904160809.GE21528@opensource.wolfsonmicro.com>
References: <1314879674-22819-1-git-send-email-johnnyhsu@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 745E410384C
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Sep 2011 18:08:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314879674-22819-1-git-send-email-johnnyhsu@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: johnnyhsu@realtek.com
Cc: alsa-devel@alsa-project.org, flove@realtek.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 01, 2011 at 08:21:14PM +0800, johnnyhsu@realtek.com wrote:

> Subject: [PATCH] ASoC: rt5631: first commit

"Add driver for..." or something.

> +static int rt5631_volatile_register(struct snd_soc_codec *codec,
> +				    unsigned int reg)
> +{
> +	switch (reg) {
> +	case RT5631_VENDOR_ID:
> +	case RT5631_VENDOR_ID1:
> +	case RT5631_VENDOR_ID2:
> +		return 0;
> +	default:
> +		return 1;
> +	}
> +}

This looks to be exactly the wrong way round - the only registers we can
cache are the ID registers.

> +/* MIC Boost Volume */
> +static const char *rt5631_mic_boost[] = {"Bypass", "+20db", "+24db", "+30db",
> +			"+35db", "+40db", "+44db", "+50db", "+52db"};

TLV for volume information.

> +	rt5631->bclk_rate = snd_soc_params_to_bclk(params);
> +	if (rt5631->bclk_rate < 0) {
> +		dev_err(codec->dev, "Unsupported BCLK rate: %d\n",
> +					rt5631->bclk_rate);
> +		return rt5631->bclk_rate;
> +	}

The error message here is inacurate, there was an error obtaining the
BCLK rate rather than a problem supporting it.

> +static int rt5631_codec_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
> +		int source, unsigned int freq_in, unsigned int freq_out)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
> +	int i, ret = -EINVAL;
> +
> +	dev_dbg(codec->dev, "enter %s\n", __func__);
> +
> +	if (!freq_in || !freq_out) {
> +		dev_dbg(codec->dev, "PLL disabled\n");
> +		return -EINVAL;
> +	}

This shouldn't be an error condition, disabling the PLL is a perfectly
normal thing to do.

> +	if (rt5631->master) {
> +		for (i = 0; i < ARRAY_SIZE(codec_master_pll_div); i++)
> +			if (freq_in == codec_master_pll_div[i].pll_in &&

Since the PLL configuration depends on the master/slave configuration
you should either warn or reconfigure if the PLL is set up and the user
changes master/slave configuration.

> +/**
> + * rt5631_index_reg_show - sysfs file for dumping index registers of 2nd layer
> + */
> +static ssize_t rt5631_index_reg_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{

No, use the standard facilities.  Please don't ignore review comments,
it's not helpful.
