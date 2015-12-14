From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [linux-sunxi] Re: [PATCH v2 2/4] ASoC: sun4i-codec: Add support
 for PA gpio pin
Date: Mon, 14 Dec 2015 17:07:47 +0100
Message-ID: <566EE953.3050702@redhat.com>
References: <1449859439-30875-1-git-send-email-hdegoede@redhat.com>
 <1449859439-30875-2-git-send-email-hdegoede@redhat.com>
 <20151214155616.GL19456@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151214155616.GL19456@lukather>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 14-12-15 16:56, Maxime Ripard wrote:
> Hi,
>
> On Fri, Dec 11, 2015 at 07:43:57PM +0100, Hans de Goede wrote:
>> Add support for PA gpio pin for controlling an external amplifier as used
>> on some Allwinner boards.
>>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>> Changes in v2:
>> -Use a dapm speaker widget (SND_SOC_DAPM_SPK) to control the gpio
>> -Rename gpio in devicetree from pa-gpios to allwinner,pa-gpios
>> ---
>>   .../devicetree/bindings/sound/sun4i-codec.txt      |  3 ++
>>   sound/soc/sunxi/sun4i-codec.c                      | 35 ++++++++++++++++++++++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
>> index c92966b..0dce690 100644
>> --- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
>> +++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
>> @@ -14,6 +14,9 @@ Required properties:
>>      - "apb": the parent APB clock for this controller
>>      - "codec": the parent module clock
>>
>> +Optional properties:
>> +- allwinner,pa-gpios: gpio to enable external amplifier
>> +
>>   Example:
>>   codec: codec@01c22c00 {
>>   	#sound-dai-cells = <0>;
>> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
>> index 519ccb3..e6cc6a1 100644
>> --- a/sound/soc/sunxi/sun4i-codec.c
>> +++ b/sound/soc/sunxi/sun4i-codec.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/of_address.h>
>>   #include <linux/clk.h>
>>   #include <linux/regmap.h>
>> +#include <linux/gpio/consumer.h>
>>
>>   #include <sound/core.h>
>>   #include <sound/pcm.h>
>> @@ -103,6 +104,7 @@ struct sun4i_codec {
>>   	struct regmap	*regmap;
>>   	struct clk	*clk_apb;
>>   	struct clk	*clk_module;
>> +	struct gpio_desc *gpio_pa;
>>
>>   	struct snd_dmaengine_dai_dma_data	capture_dma_data;
>>   	struct snd_dmaengine_dai_dma_data	playback_dma_data;
>> @@ -709,6 +711,26 @@ static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
>>   	return link;
>>   };
>>
>> +static int sun4i_codec_spk_event(struct snd_soc_dapm_widget *w,
>> +				 struct snd_kcontrol *k, int event)
>> +{
>> +	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(w->dapm->card);
>> +
>> +	if (scodec->gpio_pa)
>> +		gpiod_set_value_cansleep(scodec->gpio_pa,
>> +					 !!SND_SOC_DAPM_EVENT_ON(event));
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct snd_soc_dapm_widget sun4i_codec_card_dapm_widgets[] = {
>> +	SND_SOC_DAPM_SPK("Speaker", sun4i_codec_spk_event),
>> +};
>> +
>> +static const struct snd_soc_dapm_route sun4i_codec_card_dapm_routes[] = {
>> +	{ "Speaker", NULL, "Power Amplifier" },
>> +};
>
> Shouldn't it be tied to the HP outputs instead?

You're right, the HP outputs are the final outputs, and since this is
for enabling an external amplifier you're right. Since Mark has already
merged this patch I will do a follow up patch to fix this.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
