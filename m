From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 2/4] ASoC: Intel: Add merrifield machine
	driver
Date: Tue, 06 May 2014 17:54:53 +0200
Message-ID: <536905CD.4030007@metafoo.de>
References: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
 <1399312908-20744-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F9312650D7
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 17:54:56 +0200 (CEST)
In-Reply-To: <1399312908-20744-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/05/2014 08:01 PM, Vinod Koul wrote:
[...]
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/async.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/jack.h>
> +#include <linux/input.h>
> +
> +#include <linux/mfd/wm8994/core.h>
> +#include <linux/mfd/wm8994/registers.h>
> +#include <linux/mfd/wm8994/pdata.h>
> +#include "../../codecs/wm8994.h"
> +#include "../platform-libs/controls_v2.h"

I don't think that include exists in upstream.

> +
> +/* Codec PLL output clk rate */
> +#define CODEC_SYSCLK_RATE			24576000
> +/* Input clock to codec at MCLK1 PIN */
> +#define CODEC_IN_MCLK1_RATE			19200000
> +/* Input clock to codec at MCLK2 PIN */
> +#define CODEC_IN_MCLK2_RATE			32768
> +/*  define to select between MCLK1 and MCLK2 input to codec as its clock */
> +#define CODEC_IN_MCLK1				1
> +#define CODEC_IN_MCLK2				2
> +
> +struct mrfld_8958_mc_private {
> +	struct snd_soc_jack jack;
> +	int jack_retry;
> +};
> +
> +
> +static inline struct snd_soc_codec *mrfld_8958_get_codec(struct snd_soc_card *card)
> +{
> +	bool found = false;
> +	struct snd_soc_codec *codec;
> +
> +	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
> +		if (!strstr(codec->name, "wm8994-codec")) {
> +			pr_debug("codec was %s", codec->name);
> +			continue;
> +		} else {
> +			found = true;
> +			break;
> +		}
> +	}
> +	if (found == false) {
> +		pr_warn("%s: cant find codec", __func__);
> +		return NULL;
> +	}
> +	return codec;
> +}
> +
> +/* TODO: find better way of doing this */

Yes!

> +static struct snd_soc_dai *find_codec_dai(struct snd_soc_card *card, const char *dai_name)
> +{
> +	int i;
> +	for (i = 0; i < card->num_rtd; i++) {
> +		if (!strcmp(card->rtd[i].codec_dai->name, dai_name))
> +			return card->rtd[i].codec_dai;
> +	}
> +	pr_err("%s: unable to find codec dai\n", __func__);
> +	/* this should never occur */
> +	WARN_ON(1);
> +	return NULL;
> +}

The proper way to do this is to implement the init callback for the dai 
link. There you get a pointer to the codec and the dai and everything else. 
If you need one for later store them in the private struct of the card driver.


> +
> +/* Function to switch the input clock for codec,  When audio is in
> + * progress input clock to codec will be through MCLK1 which is 19.2MHz
> + * while in off state input clock to codec will be through 32KHz through
> + * MCLK2
> + * card	: Sound card structure
> + * src	: Input clock source to codec

That's not proper kerneldoc

> + */
[...]
> +
> +static int mrfld_wm8958_set_clk_fmt(struct snd_soc_dai *codec_dai)
> +{
> +	unsigned int fmt;
> +	int ret = 0;
> +	struct snd_soc_card *card = codec_dai->card;
> +
> +	pr_err("setting snd_soc_dai_set_tdm_slot\n");
> +	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0, 0, 4, SNDRV_PCM_FORMAT_S24_LE);

the slot width should be in number of bit clock cycles.

> +	if (ret < 0) {
> +		pr_err("can't set codec pcm format %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* WM8958 slave Mode */
> +	fmt =   SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
> +		| SND_SOC_DAIFMT_CBS_CFS;
> +	ret = snd_soc_dai_set_fmt(codec_dai, fmt);

Use the dai_fmt field of the dai_link to set this up.

> +	if (ret < 0) {
> +		pr_err("can't set codec DAI configuration %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* FIXME: move this to SYS_CLOCK event handler when codec driver
> +	 * dependency is clean.
> +	 */
> +	/* Switch to 19.2MHz MCLK1 input clock for codec */
> +	ret = mrfld_8958_set_codec_clk(card, CODEC_IN_MCLK1);
> +
> +	return ret;
> +}
[...]
> +static int mrfld_8958_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +	int ret;
> +	unsigned int fmt;
> +	struct snd_soc_codec *codec;
> +	struct snd_soc_card *card = runtime->card;
> +	struct snd_soc_dai *aif1_dai = find_codec_dai(card, "wm8994-aif1");
> +	struct mrfld_8958_mc_private *ctx = snd_soc_card_get_drvdata(card);
> +
> +	if (!aif1_dai)
> +		return -ENODEV;
> +
> +	pr_debug("Entry %s\n", __func__);
> +
> +	ret = snd_soc_dai_set_tdm_slot(aif1_dai, 0, 0, 4, SNDRV_PCM_FORMAT_S24_LE);
> +	if (ret < 0) {
> +		pr_err("can't set codec pcm format %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* WM8958 slave Mode */
> +	fmt =   SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
> +		| SND_SOC_DAIFMT_CBS_CFS;
> +	ret = snd_soc_dai_set_fmt(aif1_dai, fmt);

Same commens as above.

> +	if (ret < 0) {
> +		pr_err("can't set codec DAI configuration %d\n", ret);
> +		return ret;
> +	}
> +
> +	mrfld_8958_set_bias_level(card, &card->dapm, SND_SOC_BIAS_OFF);
> +	card->dapm.idle_bias_off = true;
> +
> +	/* these pins are not used in SB config so mark as nc
> +	 *
> +	 * LINEOUT1, 2
> +	 * IN1R
> +	 * DMICDAT2
> +	 */
> +	snd_soc_dapm_nc_pin(&card->dapm, "DMIC2DAT");
> +	snd_soc_dapm_nc_pin(&card->dapm, "LINEOUT1P");
> +	snd_soc_dapm_nc_pin(&card->dapm, "LINEOUT1N");
> +	snd_soc_dapm_nc_pin(&card->dapm, "LINEOUT2P");
> +	snd_soc_dapm_nc_pin(&card->dapm, "LINEOUT2N");
> +	snd_soc_dapm_nc_pin(&card->dapm, "IN1RN");
> +	snd_soc_dapm_nc_pin(&card->dapm, "IN1RP");

Set the fully_routed flag on the card and this will happen automatically.

> +
> +	/* Force enable VMID to avoid cold latency constraints */
> +	snd_soc_dapm_force_enable_pin(&card->dapm, "VMID");
> +	snd_soc_dapm_sync(&card->dapm);
> +
> +	codec = mrfld_8958_get_codec(card);
> +	if (!codec) {
> +		pr_err("%s: we didnt find the codec pointer!\n", __func__);
> +		return 0;
> +	}
> +
> +	ctx->jack_retry = 0;
> +	ret = snd_soc_jack_new(codec, "Intel MID Audio Jack",
> +			       SND_JACK_HEADSET | SND_JACK_HEADPHONE |
> +				SND_JACK_BTN_0 | SND_JACK_BTN_1,
> +				&ctx->jack);
> +	if (ret) {
> +		pr_err("jack creation failed\n");
> +		return ret;
> +	}
> +
> +	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_1, KEY_MEDIA);
> +	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_0, KEY_MEDIA);
> +
> +	wm8958_mic_detect(codec, &ctx->jack, NULL, NULL, NULL, NULL);
> +
> +	snd_soc_update_bits(codec, WM8994_AIF1_DAC1_FILTERS_1, WM8994_AIF1DAC1_MUTE, 0);
> +	snd_soc_update_bits(codec, WM8994_AIF1_DAC2_FILTERS_1, WM8994_AIF1DAC2_MUTE, 0);

The card driver should not be poking in the codec registers.

> +
> +	/* Micbias1 is always off, so for pm optimizations make sure the micbias1
> +	 * discharge bit is set to floating to avoid discharge in disable state
> +	 */
> +	snd_soc_update_bits(codec, WM8958_MICBIAS1, WM8958_MICB1_DISCH, 0);
> +
> +	return 0;
> +}
> +
[...]
> +
> +static int snd_mrfld_8958_mc_probe(struct platform_device *pdev)
> +{
> +	int ret_val = 0;
> +	struct mrfld_8958_mc_private *drv;
> +
> +	pr_debug("Entry %s\n", __func__);
> +
> +	drv = kzalloc(sizeof(*drv), GFP_ATOMIC);

GFP_KERNEL and maybe devm_kzalloc

> +	if (!drv) {
> +		pr_err("allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* register the soc card */
> +	snd_soc_card_mrfld.dev = &pdev->dev;
> +	snd_soc_card_set_drvdata(&snd_soc_card_mrfld, drv);
> +	ret_val = snd_soc_register_card(&snd_soc_card_mrfld);
> +	if (ret_val) {
> +		pr_err("snd_soc_register_card failed %d\n", ret_val);
> +		goto unalloc;
> +	}
> +	platform_set_drvdata(pdev, &snd_soc_card_mrfld);
> +	pr_info("%s successful\n", __func__);
> +	return ret_val;
> +
> +unalloc:
> +	kfree(drv);
> +	return ret_val;
> +}
[...]
> +
> +static int snd_mrfld_8958_driver_init(void)
> +{
> +	pr_info("Merrifield Machine Driver mrfld_wm8958 registerd\n");

That's just noise.

> +	return platform_driver_register(&snd_mrfld_8958_mc_driver);
> +}
> +
> +static void snd_mrfld_8958_driver_exit(void)
> +{
> +	pr_debug("In %s\n", __func__);
> +	platform_driver_unregister(&snd_mrfld_8958_mc_driver);
> +}
> +late_initcall(snd_mrfld_8958_driver_init);
> +module_exit(snd_mrfld_8958_driver_exit);

module_platform_driver().
