From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel][PATCH] ASoC: wm8960: add two kcontrols to select
 ADC left/right channel source
Date: Mon, 15 Jun 2015 13:17:24 +0200
Message-ID: <557EB444.9070204@metafoo.de>
References: <1434364473-27130-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434364473-27130-1-git-send-email-zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/15/2015 12:34 PM, Zidan Wang wrote:
> Add two kcontrols to select ADC left/right channel source, one to select
> the left channel source and one for the right channel source.
>
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
>   sound/soc/codecs/wm8960.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> index 023e898..8f9aed1 100644
> --- a/sound/soc/codecs/wm8960.c
> +++ b/sound/soc/codecs/wm8960.c
> @@ -141,6 +141,8 @@ static const char *wm8960_3d_upper_cutoff[] = {"High", "Low"};
>   static const char *wm8960_3d_lower_cutoff[] = {"Low", "High"};
>   static const char *wm8960_alcfunc[] = {"Off", "Right", "Left", "Stereo"};
>   static const char *wm8960_alcmode[] = {"ALC", "Limiter"};
> +static const char *wm8960_adc_left_source[] = {"left ADC", "right ADC"};
> +static const char *wm8960_adc_right_source[] = {"right ADC", "left ADC"};

Left and Right with a uppercase first letter.

>
>   static const struct soc_enum wm8960_enum[] = {
>   	SOC_ENUM_SINGLE(WM8960_DACCTL1, 5, 4, wm8960_polarity),
> @@ -149,6 +151,8 @@ static const struct soc_enum wm8960_enum[] = {
>   	SOC_ENUM_SINGLE(WM8960_3D, 5, 2, wm8960_3d_lower_cutoff),
>   	SOC_ENUM_SINGLE(WM8960_ALC1, 7, 4, wm8960_alcfunc),
>   	SOC_ENUM_SINGLE(WM8960_ALC3, 8, 2, wm8960_alcmode),
> +	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 3, 2, wm8960_adc_left_source),
> +	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 2, 2, wm8960_adc_right_source),
>   };

Preferably use a separate variable for each of the enums, keeping track of 
which array index belongs to which enums is quite cumbersome. E.g.

static SOC_ENUM_SINGLE_DECL(wm8960_adc_left_enum, WM8960_ADDCTL1, ...);

>
>   static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
> @@ -279,6 +283,9 @@ SOC_SINGLE_TLV("Right Output Mixer Boost Bypass Volume",
>   	       WM8960_BYPASS2, 4, 7, 1, bypass_tlv),
>   SOC_SINGLE_TLV("Right Output Mixer RINPUT3 Volume",
>   	       WM8960_ROUTMIX, 4, 7, 1, bypass_tlv),
> +
> +SOC_ENUM("ADC Left Channel Source", wm8960_enum[6]),
> +SOC_ENUM("ADC Right Channel Source", wm8960_enum[7]),

Since this affects the routing these should be DAPM controls. Otherwise you 
might run into issues with a path being powered down even if it is used.

>   };
>
>   static const struct snd_kcontrol_new wm8960_lin_boost[] = {
>
