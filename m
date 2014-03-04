From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 2/4] ASoC: davinci-evm: Add AM43xx-EPOS-EVM
 audio support
Date: Tue, 4 Mar 2014 17:40:44 +0200
Message-ID: <5315F3FC.5070101@ti.com>
References: <cover.1393941102.git.jsarha@ti.com> <39776dc2fc736ef92f58eac83bce52a11fbbd6c3.1393941102.git.jsarha@ti.com> <5315DF41.1090302@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5315DF41.1090302-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 03/04/2014 04:12 PM, Lars-Peter Clausen wrote:
>
>> +static const struct snd_soc_dapm_widget aic31xx_dapm_widgets[] = {
>> +    SND_SOC_DAPM_HP("Headphone Jack", NULL),
>> +    SND_SOC_DAPM_SPK("Speaker", NULL),
>> +    SND_SOC_DAPM_MIC("Mic Jack", NULL),
>> +};
>> +
>> +/* Logic for EVMs with an aic31xx */
>> +static int evm_aic31xx_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +    struct snd_soc_codec *codec = rtd->codec;
>> +    struct snd_soc_dapm_context *dapm = &codec->dapm;
>
> Machine level DAPM elements should go into the card's DAPM context, not
> the CODEC context. Also use rtd->card to get a pointer to the card
> instead of rtd->codec->card.
>

Thanks, I'll fix those.

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
