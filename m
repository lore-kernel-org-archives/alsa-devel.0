From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 11/13] ASoC: qcom: add apq8016 sound card support
Date: Fri, 15 May 2015 09:47:06 +0100
Message-ID: <5555B28A.9040608@linaro.org>
References: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org> <1431518594-7752-1-git-send-email-srinivas.kandagatla@linaro.org> <20150515052348.GC31687@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150515052348.GC31687-VfhoOQ2zEbNBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 15/05/15 06:23, Kenneth Westfield wrote:
> On Wed, May 13, 2015 at 05:03:14AM -0700, Srinivas Kandagatla wrote:
>> This patch adds apq8016 machine driver support. This patch was tested on
>> two apq8016-sbc and msm8916-mtp board for both hdmi and analog audio
>> features.
>
>> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
>> index 9cc5ed7..e71b0f2 100644
>> --- a/sound/soc/qcom/Kconfig
>> +++ b/sound/soc/qcom/Kconfig
>> @@ -34,3 +34,12 @@ config SND_SOC_STORM
>>   	help
>>             Say Y or M if you want add support for SoC audio on the
>>             Qualcomm Technologies IPQ806X-based Storm board.
>> +
>> +config SND_SOC_APQ8016_SBC
>> +	tristate "SoC Audio support for APQ8016 SBC platforms"
>> +	depends on SND_SOC_QCOM || ARCH_QCOM || COMPILE_TEST
>
> I believe this should be:
>          depends on (SND_SOC_QCOM && ARCH_QCOM) || COMPILE_TEST
>
Yep , I will fix it.
>> +	select SND_SOC_LPASS_APQ8016
>> +	help
>> +          Support for Qualcomm Technologies LPASS audio block in
>> +          APQ8016 SOC-based systems.
>> +          Say Y if you want to use audio devices on MI2S
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
