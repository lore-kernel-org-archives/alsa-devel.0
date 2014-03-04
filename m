From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/4] ASoC: davinci-evm: Add
 AM43xx-EPOS-EVM audio support
Date: Tue, 04 Mar 2014 15:12:17 +0100
Message-ID: <5315DF41.1090302@metafoo.de>
References: <cover.1393941102.git.jsarha@ti.com>
 <39776dc2fc736ef92f58eac83bce52a11fbbd6c3.1393941102.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-147.synserver.de
 [212.40.185.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 1638D265765
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 15:12:04 +0100 (CET)
In-Reply-To: <39776dc2fc736ef92f58eac83bce52a11fbbd6c3.1393941102.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org


> +static const struct snd_soc_dapm_widget aic31xx_dapm_widgets[] = {
> +	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> +	SND_SOC_DAPM_SPK("Speaker", NULL),
> +	SND_SOC_DAPM_MIC("Mic Jack", NULL),
> +};
> +
> +/* Logic for EVMs with an aic31xx */
> +static int evm_aic31xx_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_dapm_context *dapm = &codec->dapm;

Machine level DAPM elements should go into the card's DAPM context, not the 
CODEC context. Also use rtd->card to get a pointer to the card instead of 
rtd->codec->card.

> +	struct device_node *np = codec->card->dev->of_node;
> +	int ret;
> +
> +	snd_soc_dapm_new_controls(dapm, aic31xx_dapm_widgets,
> +				  ARRAY_SIZE(aic31xx_dapm_widgets));
> +
> +	if (np) {
> +		ret = snd_soc_of_parse_audio_routing(codec->card,
> +						     "ti,audio-routing");
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
