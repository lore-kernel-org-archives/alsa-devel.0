From: Yang Kuankuan <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 12/12] dt-bindings: Add documentation for Rockchip
 dw-hdmi-audio
Date: Sat, 31 Jan 2015 08:51:40 -0500
Message-ID: <54CCDDEC.5050706@rock-chips.com>
References: <1422617031-25098-1-git-send-email-ykk@rock-chips.com> <1422618253-27312-1-git-send-email-ykk@rock-chips.com> <20150131113659.GA26493@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150131113659.GA26493-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Ben Zhang <benzh-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dbehr-ph2c+iIn4itg9hUCZPvPmw@public.gmane.org, mmind00-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, march
List-Id: alsa-devel@alsa-project.org


On 01/31/2015 06:36 AM, Russell King - ARM Linux wrote:
> On Fri, Jan 30, 2015 at 06:44:13AM -0500, Yakir Yang wrote:
>> Required properties:
>> - compatible: platform specific
>> - cpu-of-node: the device node of cpu_dai
>>
>> Signed-off-by: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>> Changes in v2:
>> - remove codec-name and codec-dai-name
>> - rename rockchip,rockchip-hdmi-audio.txt to rockchip,rockchip-dw-hdmi-audio.txt
>>
>>   .../bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt       | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt b/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
>> new file mode 100644
>> index 0000000..5b86eed
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
>> @@ -0,0 +1,12 @@
>> +Rockchip hdmi audio bindings
>> +
>> +Required properties:
>> +- compatible: platform specific
>> +- cpu-of-node: the device node of cpu_dai
>> +
>> +Example:
>> +
>> +sound {
>> +	compatible = "rockchip,rk3288-hdmi-audio";
>> +	cpu-of-node = <&i2s>;
>> +};
> In patch 11, it looks like you parse a property called i2s-controller.
> This doesn't appear to be documented.  Maybe it's what you call
> "cpu-of-node" above?
>
Mistaken, i will modify dt-bings in next version v3.

Thanks for your kindness remind.  : )


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
