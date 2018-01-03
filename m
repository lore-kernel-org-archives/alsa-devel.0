From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v2 11/15] ASoC: qcom: qdsp6: Add support to q6afe
 dai driver
Date: Wed, 3 Jan 2018 16:27:12 +0000
Message-ID: <4edcacb6-6567-8f1a-dd71-cbcce0a66e06@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-12-srinivas.kandagatla@linaro.org>
 <20180102232811.GS478@tuxbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180102232811.GS478@tuxbook>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 02/01/18 23:28, Bjorn Andersson wrote:
> On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> 
>> From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> This patch adds support to q6afe backend dais driver.
>>
> 
> Isn't the list of backend DAIs platform-dependent?

dai links and connections between backend and front ends are platform 
dependent.

> 
> [..]
>> +static const struct snd_soc_dapm_widget hdmi_dapm_widgets[] = {
>> +	SND_SOC_DAPM_AIF_OUT("HDMI", "HDMI Playback", 0, 0, 0, 0),
>> +	SND_SOC_DAPM_OUTPUT("HDMI-RX"),
>> +};
>> +
>> +static const struct snd_soc_component_driver msm_dai_hdmi_q6_component = {
> 
> How will this look beyond HDMI? I'm having issues mapping this to
> downstream.

ex:
For slimbus dais, we would have more entries of "struct 
snd_soc_dai_driver" in this file.

Basically these are the dais that are exposed by the dsp firmware.

Depending on the actually platform some of these dais would be setup 
accordingly.


> 
>> +	.name		= "msm-dai-q6-hdmi",
>> +	.dapm_widgets = hdmi_dapm_widgets,
>> +	.num_dapm_widgets = ARRAY_SIZE(hdmi_dapm_widgets),
>> +	.controls = hdmi_config_controls,
>> +	.num_controls = ARRAY_SIZE(hdmi_config_controls),
>> +	.dapm_routes = hdmi_dapm_routes,
>> +	.num_dapm_routes = ARRAY_SIZE(hdmi_dapm_routes),
>> +};
>> +
> 
> Regards,
> Bjorn
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
