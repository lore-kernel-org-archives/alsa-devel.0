From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/5] ASoC: codecs: Add msm8916-wcd digital codec
Date: Mon, 19 Sep 2016 12:00:56 +0100
Message-ID: <4c5459e3-2bbf-eb0b-a850-818ca16eb32f@linaro.org>
References: <1473339896-9409-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1473339896-9409-3-git-send-email-srinivas.kandagatla@linaro.org>
 <20160916154501.GB15543@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160916154501.GB15543@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Thanks for review,

On 16/09/16 16:45, Rob Herring wrote:
> On Thu, Sep 08, 2016 at 02:04:53PM +0100, Srinivas Kandagatla wrote:
>> msm8916-wcd codec is found in Qualcomm msm8916 and apq8016 processors.
>> This codec IP is split in to two parts(Digital & Analog).
>> Analog part is integrated in to PMIC PM8916 and the digital part is
>> integrated into Application processor. Data transfer between Analog and
>> Digital Die is done via a internal bus called PDM.
>>
>> This patch adds support to Digital part of the Codec which is integrated
>> into Application Processor.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  .../bindings/sound/qcom,msm8916-wcd-digital.txt    |  20 +
>>  sound/soc/codecs/Kconfig                           |   3 +
>>  sound/soc/codecs/Makefile                          |   2 +
>>  sound/soc/codecs/msm8916-wcd-digital.c             | 920 +++++++++++++++++++++
>>  4 files changed, 945 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt
>>  create mode 100644 sound/soc/codecs/msm8916-wcd-digital.c
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt
>> new file mode 100644
>> index 0000000..6342549
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt
>> @@ -0,0 +1,20 @@
>> +msm8916 digital audio CODEC
>> +
>> +## Bindings for codec core in lpass:
>> +
>> +Required properties
>> + - compatible = "qcom,msm8916-wcd-digital-codec";
>> + - reg: address space for lpass codec.
>> + - clocks: Handle to mclk and ahbclk
>> + - clock-names: should be "mclk", "ahbix-clk".
>> +
>> +Example:
>> +
>> +lpass_codec: codec{
>
> audio-codec@771c000
Yep, Will fix this in next version,

Thanks,
srini
>
>> +	compatible = "qcom,msm8916-wcd-digital-codec";
>> +	reg = <0x0771c000 0x400>;
>> +	clocks = <&gcc GCC_ULTAUDIO_AHBFABRIC_IXFABRIC_CLK>,
>> +		 <&gcc GCC_CODEC_DIGCODEC_CLK>;
>> +	clock-names = "ahbix-clk", "mclk";
>> +	#sound-dai-cells = <1>;
>> +};
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
