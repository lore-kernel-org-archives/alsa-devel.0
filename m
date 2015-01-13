From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: wm8904: fix runtime warning
Date: Tue, 13 Jan 2015 10:47:02 +0100
Message-ID: <54B4E996.80403@metafoo.de>
References: <1421141643-30105-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1421141643-30105-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>, Mark Brown <broonie@kernel.org>
Cc: ckeepax@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/13/2015 10:34 AM, Bo Shen wrote:
[...]
>
> -	{ "AIFOUTL", "Left",  "ADCL" },
> -	{ "AIFOUTL", "Right", "ADCR" },
> -	{ "AIFOUTR", "Left",  "ADCL" },
> -	{ "AIFOUTR", "Right", "ADCR" },
> +	{ "AIFOUTL Mux", "Left", "ADCL" },
> +	{ "AIFOUTL Mux", "Right", "ADCR" },
> +	{ "AIFOUTR Mux", "Left", "ADCL" },
> +	{ "AIFOUTR Mux", "Right", "ADCR" },
> +
> +	{ "AIFOUTL", NULL, "AIFOUTL Mux" },
> +	{ "AIFOUTR", NULL, "AIFOUTR Mux" },
>

This looks ok.

>   	{ "ADCL", NULL, "CLK_DSP" },
>   	{ "ADCL", NULL, "Left Capture PGA" },
> @@ -1089,14 +1092,20 @@ static const struct snd_soc_dapm_route adc_intercon[] = {
>   };
>
>   static const struct snd_soc_dapm_route dac_intercon[] = {
> -	{ "DACL", "Right", "AIFINR" },
> -	{ "DACL", "Left",  "AIFINL" },
> +	{ "DACL", NULL, "AIFINL" },
> +	{ "DACL", NULL, "AIFINR" },
>   	{ "DACL", NULL, "CLK_DSP" },
>
> -	{ "DACR", "Right", "AIFINR" },
> -	{ "DACR", "Left",  "AIFINL" },
> +	{ "DACR", NULL, "AIFINL" },
> +	{ "DACR", NULL, "AIFINR" },
>   	{ "DACR", NULL, "CLK_DSP" },
>
> +	{ "DACL Mux", "Left", "DACL" },
> +	{ "DACL Mux", "Right", "DACR" },
> +
> +	{ "DACR Mux", "Left", "DACL" },
> +	{ "DACR Mux", "Right", "DACR" },
> +

But this should probably be

 > +	{ "DACL Mux", "Left", "AIFINL" },
 > +	{ "DACL Mux", "Right", "AIFINR" },
 > +
 > +	{ "DACR Mux", "Left", "AIFINL" },
 > +	{ "DACR Mux", "Right", "AIFINR" },
 > +
 > +	{ "DACL", NULL, "DACL Mux" },
 > +	{ "DACR", NULL, "DACR Mux" },


