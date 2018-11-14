From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs35l36: Add support for Cirrus
 CS35L36 Amplifier
Date: Wed, 14 Nov 2018 11:29:14 +0000
Message-ID: <20181114112914.GY16508@imbe.wolfsonmicro.main>
References: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F1D42677E8
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 12:29:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Schulman <james.schulman@cirrus.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com, robh+dt@kernel.org, charles.keepax@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 13, 2018 at 12:49:16PM -0600, James Schulman wrote:
> Add driver support for Cirrus Logic CS35L36 boosted
> speaker amplifier
> 
> Signed-off-by: James Schulman <james.schulman@cirrus.com>
> ---

Mostly just some small nitpicky comments from me:

> +#include "cs35l36.h"
> +
> +struct reg_default cs35l36_reg[CS35L36_MAX_CACHE_REG] = {

Your allocating an array that is much larger than you need here.
This array will have an entry for all possible register addresses
on the device, whereas only a very small subset of those
addresses have defaults infact most of them arn't even registers.

> +	{CS35L36_TESTKEY_CTRL,			0x00000000},
...
> +struct  cs35l36_private {
> +	struct device *dev;
> +	struct cs35l36_platform_data pdata;
> +	struct regmap *regmap;
> +	struct regulator_bulk_data supplies[2];
> +	int num_supplies;
> +	int clksrc;
> +	int prev_clksrc;
> +	int extclk_freq;
> +	int extclk_cfg;
> +	int fll_igain;
> +	int sclk;
> +	int chip_version;
> +	int rev_id;
> +	struct gpio_desc *reset_gpio;
> +	struct completion global_pup_done;
> +	struct completion global_pdn_done;

These two completions are unused.

> +static int cs35l36_dai_set_sysclk(struct snd_soc_dai *dai,
> +				int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct cs35l36_private *cs35l36 =
> +			snd_soc_component_get_drvdata(component);
> +	int fs1_val = 0;
> +	int fs2_val = 0;
> +
> +	/* Need the SCLK Frequency regardless of sysclk source */
> +	cs35l36->sclk = freq;

Yet it is only used locally in this function.

> +	if (cs35l36->sclk > 6000000) {
> +		fs1_val = 3 * 4 + 4;
> +		fs2_val = 8 * 4 + 4;
> +	}
> +
> +	if (cs35l36->sclk <= 6000000) {
> +		fs1_val = 3 * ((24000000 + cs35l36->sclk - 1) / cs35l36->sclk)
> +				+ 4;
> +		fs2_val = 5 * ((24000000 + cs35l36->sclk - 1) / cs35l36->sclk)
> +				+ 4;
> +	}

Nitpicking: Since both paths add 4 you could initialise fs1_val and
fs2_val to 4, then use += would avoid the line wraps for the + 4's
here.

> +static int cs35l36_pcm_startup(struct snd_pcm_substream *substream,
> +			       struct snd_soc_dai *dai)
> +{
> +	if (!substream->runtime)
> +		return 0;

This null check shouldn't be needed now since:

8053f21675b0 ("ASoC: dapm: Add a dummy snd_pcm_runtime to avoid NULL pointer access")

> +
> +	snd_pcm_hw_constraint_list(substream->runtime, 0,
> +				SNDRV_PCM_HW_PARAM_RATE, &cs35l36_constraints);
> +	return 0;
> +}
...
> +static int cs35l36_component_set_sysclk(struct snd_soc_component *component,
> +				int clk_id, int source, unsigned int freq,
> +				int dir)
> +{
> +	struct cs35l36_private *cs35l36 =
> +			snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	cs35l36->extclk_freq = freq;

extclk_freq doesn't appear to be used at all, is there an
expectation it will be in the future?

> +	cs35l36->prev_clksrc = cs35l36->clksrc;

Should this be stored in cs35l36_private, given it is only used
locally in this function?

> +
> +	switch (clk_id) {
> +	case 0:
> +		cs35l36->clksrc = CS35L36_PLLSRC_SCLK;
> +		break;
> +	case 1:
> +		cs35l36->clksrc = CS35L36_PLLSRC_LRCLK;
> +		break;
> +	case 2:
> +		cs35l36->clksrc = CS35L36_PLLSRC_PDMCLK;
> +		break;
> +	case 3:
> +		cs35l36->clksrc = CS35L36_PLLSRC_SELF;
> +		break;
> +	case 4:
> +		cs35l36->clksrc = CS35L36_PLLSRC_MCLK;

Seems clksrc is also only used locally, is there some future work
expected on the clocking?

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = cs35l36_get_clk_config(cs35l36, freq);
> +

Would it be simpler just to return a pointer to the
cs35l36_pll_sysclk_config structure?

> +	if (cs35l36->rev_id == CS35L36_REV_A0) {
> +		if (cs35l36->pdata.dcm_mode) {

Nitpick:
Could probably use an && here.

> +static int cs35l36_pac(struct cs35l36_private *cs35l36)
> +{
> +	int ret, count;
> +	unsigned int val;
> +
> +	if (cs35l36->rev_id == CS35L36_REV_B0) {

Nitpick:
This is already checked before you call the function, so I would
be inclined to drop it but if doing it here it would probably be
better to invert the logic and do:

if (cs35l36->rev_id != CS35L36_REV_B0)
	return 0;

> +	switch (cs35l36->rev_id) {
> +	case CS35L36_REV_A0:
> +		ret = regmap_register_patch(cs35l36->regmap,
> +				cs35l36_reva0_errata_patch,
> +				ARRAY_SIZE(cs35l36_reva0_errata_patch));
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to apply A0 errata patch %d\n",
> +					ret);
> +			goto err;
> +		}
> +		ret = regmap_register_patch(cs35l36->regmap,
> +					cs35l36_pac_int_patch,
> +					ARRAY_SIZE(cs35l36_pac_int_patch));
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to apply A0PAC errata patch %d\n",
> +					ret);
> +			goto err;
> +		}

Is this really what you want, having two calls to
remap_register_patch will apply the settings from both here, but
only the second of those calls would be reapplied on cache_sync
later. Now I guess you don't have any cache_syncs so it won't
cause a problem now but feels like it has the potential to cause
confusion down the road.

> +	ret = devm_request_threaded_irq(dev, i2c_client->irq, NULL, cs35l36_irq,
> +					IRQF_ONESHOT |
> +					irq_pol,

Nitpick probably fire this up on the same line as the ONESHOT.

> +					"cs35l36", cs35l36);

Thanks,
Charles
