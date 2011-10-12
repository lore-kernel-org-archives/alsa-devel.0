From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 9/9] ASoC: da7210: Add support for DAPM
Date: Wed, 12 Oct 2011 17:08:55 +0100
Message-ID: <20111012160854.GV3647@opensource.wolfsonmicro.com>
References: <1318432251.12107.432.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D4D1E103824
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 18:09:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318432251.12107.432.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg@ti.com, kuninori.morimoto.gx@renesas.com, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2011 at 08:40:51PM +0530, Ashish Chavan wrote:
> This patch adds support for DAPM covering all inputs and outputs
> as well as ADC and DAC.

So, you added a bunch of additional routes using the register sequence
method and then add DAPM support, this seems to be the wrong way round
and isn't great for review.  Converting the existing stuff to DAPM and
then adding new features seems a lot more sensible.

> +	/* MICBIAS */
> +	SND_SOC_DAPM_MICBIAS("Mic Bias", DA7210_MIC_L, 6, 0),

Use supply widgets for biases, new code shouldn't introduce micbiases.

> +	/* Input path */
> +	{"Mic Bias", NULL, "MICR"},
> +	{"Mic Bias", NULL, "MICL"},
> +
> +	{"Mic Left", NULL, "Mic Bias"},
> +	{"Mic Right", NULL, "Mic Bias"},

Microphone bias must be hooked up by the board - for example, the system
may use an external microphone bias.

> +static int da7210_add_widgets(struct snd_soc_codec *codec)
> +{
> +	struct snd_soc_dapm_context *dapm = &codec->dapm;
> +
> +	snd_soc_dapm_new_controls(dapm, da7210_dapm_widgets,
> +				  ARRAY_SIZE(da7210_dapm_widgets));
> +	snd_soc_dapm_add_routes(dapm, da7210_audio_map,
> +				ARRAY_SIZE(da7210_audio_map));

Just assign these in the card struct.

> @@ -748,6 +942,10 @@ static int da7210_probe(struct snd_soc_codec *codec)
>  	snd_soc_write(codec, DA7210_INMIX_L, DA7210_IN_L_EN);
>  	snd_soc_write(codec, DA7210_INMIX_R, DA7210_IN_R_EN);
>  
> +	/* In mixer source selection, only MIC is selected by default */
> +	snd_soc_write(codec, DA7210_INMIX_L, 0x01);
> +	snd_soc_write(codec, DA7210_INMIX_R, 0x01);
> +

As ever just leave the chip defaults alone.

> +	/* Enable standby for all inputs and outputs */
> +	snd_soc_write(codec, DA7210_STARTUP2, DA7210_LOUT1_L_STBY |
> +		DA7210_LOUT1_R_STBY | DA7210_LOUT2_STBY | DA7210_HP_L_STBY |
> +		DA7210_HP_R_STBY | DA7210_DAC_L_STBY | DA7210_DAC_R_STBY);
> +	snd_soc_write(codec, DA7210_STARTUP3, DA7210_MIC_L_STBY |
> +		DA7210_MIC_R_STBY | DA7210_LIN1_L_STBY | DA7210_LIN1_R_STBY |
> +		DA7210_LIN2_STBY | DA7210_ADC_L_STBY | DA7210_ADC_R_STBY);
> +

This looks like it should be in set_bias_level().
