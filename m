From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 4/9] ASoC: ipq806x: Add LPASS CPU DAI driver
Date: Wed, 19 Nov 2014 16:20:49 -0800
Message-ID: <20141120002049.GC13013@sonymobile.com>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
 <1416423169-21865-5-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416423169-21865-5-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 19, 2014 at 07:52:44PM +0100, Kenneth Westfield wrote:
> From: Kenneth Westfield <kwestfie@codeaurora.org>
> 
> Add the CPU DAI driver for the QCOM LPASS SOC.
> 
> Change-Id: I64ac4407dd32bb9a3066d4b7427292002eaf5d14
> Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
> Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
> ---
[...]
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <sound/soc.h>
> +#include <sound/pcm_params.h>
> +#include "lpass-lpaif.h"
> +#include "lpass-pcm-mi2s.h"

This header and the associated structures are not added until 5/9:
"ASoC: ipq806x: Add I2S PCM platform driver"...

> +
> +#define DRV_NAME	"lpass-cpu-dai"
> +#define DRV_VERSION	"1.0"
> +
> +#define LPASS_INVALID	(-1)
> +
> +struct mi2s_hw_params {
> +	uint8_t channels;
> +	uint32_t freq;
> +	uint8_t bit_width;
> +};

This struct, the static global instance of it below ('mi2s_params'), and
the additional use of it in lpass_cpu_mi2s_hw_params() ('curr_params')
are only ever written, never read.

> +
> +static struct clk *lpaif_mi2s_bit_clk;
> +static struct clk *lpaif_mi2s_osr_clk;

It would seem more logical to me to put these in allocated private driver
data for the DAI, managed from (struct snd_soc_dai_driver).probe/remove.

> +static struct mi2s_hw_params mi2s_params;
[...]
> +static int lpass_cpu_mi2s_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params,
> +					struct snd_soc_dai *dai)
> +{
[...]
> +	ret = clk_set_rate(lpaif_mi2s_osr_clk,
> +		(rate * bit_act * channels * bit_div));
> +	if (ret) {
> +		dev_err(dai->dev, "%s: error in setting mi2s osr clk\n",
> +				__func__);
> +		return ret;
> +	}
> +	ret = clk_prepare_enable(lpaif_mi2s_osr_clk);
> +	if (ret) {
> +		dev_err(dai->dev, "%s: error in enabling mi2s osr clk\n",
> +				__func__);
> +		return ret;
> +	}
> +	prtd->lpaif_clk.is_osr_clk_enabled = 1;
> +
> +	ret = clk_set_rate(lpaif_mi2s_bit_clk, rate * bit_act * channels);
> +	if (ret) {
> +		dev_err(dai->dev, "%s: error in setting mi2s bit clk\n",
> +				__func__);
> +		return ret;

clk_disable_unprepare(lpaif_mi2s_osr_clk)?

> +	}
> +	ret = clk_prepare_enable(lpaif_mi2s_bit_clk);
> +	if (ret) {
> +		dev_err(dai->dev, "%s: error in enabling mi2s bit clk\n",
> +				__func__);
> +		return ret;

clk_disable_unprepare(lpaif_mi2s_bit_clk)?
clk_disable_unprepare(lpaif_mi2s_osr_clk)?

> +	}
> +	prtd->lpaif_clk.is_bit_clk_enabled = 1;
> +
> +	return 0;
> +}
> +
> +static int lpass_cpu_mi2s_prepare(struct snd_pcm_substream *substream,
> +					struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}

Isn't this ((struct snd_soc_dai_ops).prepare) optional?

> +
> +static int lpass_cpu_mi2s_startup(struct snd_pcm_substream *substream,
> +					struct snd_soc_dai *dai)
> +{
> +
> +	lpaif_mi2s_osr_clk = clk_get(dai->dev, "mi2s_osr_clk");
> +	if (IS_ERR(lpaif_mi2s_osr_clk)) {
> +		dev_err(dai->dev, "%s: Error in getting mi2s_osr_clk\n",
> +				__func__);
> +		return PTR_ERR(lpaif_mi2s_osr_clk);
> +	}
> +
> +	lpaif_mi2s_bit_clk = clk_get(dai->dev, "mi2s_bit_clk");
> +	if (IS_ERR(lpaif_mi2s_bit_clk)) {
> +		dev_err(dai->dev, "%s: Error in getting mi2s_bit_clk\n",
> +				__func__);
> +		return PTR_ERR(lpaif_mi2s_bit_clk);

clk_put(lpaif_mi2s_osr_clk)?

> +	}
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		lpaif_cfg_i2s_playback(0, 0, LPAIF_MI2S);
> +	} else {
> +		dev_err(dai->dev, "%s: Invalid stream direction\n", __func__);
> +		return -EINVAL;
clk_put(lpaif_mi2s_bit_clk)?
clk_put(lpaif_mi2s_osr_clk)?
> +	}
> +
> +	return 0;
> +}
> +
> +static void lpass_cpu_mi2s_shutdown(struct snd_pcm_substream *substream,
> +					struct snd_soc_dai *dai)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct lpass_runtime_data_t *prtd = runtime->private_data;
> +
> +	if (prtd->lpaif_clk.is_osr_clk_enabled)
> +		clk_disable_unprepare(lpaif_mi2s_osr_clk);

This behavior is a bit odd.  If you clk_prepare_enable() the clocks in
.hw_params, shouldn't you clk_disable_unprepare() in .hw_free?  Then you
wouldn't need these booleans, or the associated lpaif_clk struct.

> +	clk_put(lpaif_mi2s_osr_clk);
> +
> +	if (prtd->lpaif_clk.is_bit_clk_enabled)
> +		clk_disable_unprepare(lpaif_mi2s_bit_clk);
> +	clk_put(lpaif_mi2s_bit_clk);
> +}

-Courtney
