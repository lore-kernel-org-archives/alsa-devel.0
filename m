From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 10/13] dt-bindings: Add qcom slimbus controller
 bindings
Date: Thu, 16 Nov 2017 09:42:28 +0000
Message-ID: <570e58a7-06dd-7e0c-e427-28b5abc08533@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-11-srinivas.kandagatla@linaro.org>
 <20171116051911.tvl6mioxpbo4h72c@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171116051911.tvl6mioxpbo4h72c@rob-hp-laptop>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 16/11/17 05:19, Rob Herring wrote:
>> +	entry should be used.
>> + - reg-name for slew rate: "slew"
> reg-names
> 
> I'd prefer it be explicit as to which compatibles do or don't have this
> register.
Makes sense, I will take this in before sending next version.
> 
>> +
>> +Example:
>> +
>> +	slim@28080000 {
>> +		compatible = "qcom,apq8064-slim", "qcom,slim";
>> +		reg = <0x28080000 0x2000>,
> error                                    ^
> 
thanks for spotting.. will fix this.
>> +		interrupts = <0 33 0>;
>> +		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
>> +		clock-names = "iface", "core";
>> +		#address-cells = <2>;
>> +		#size-cell = <0>;
>> +
>> +		codec: wcd9310@1,0{
> Use generic node names:
> 
> wcd9310: audio-codec@1,0
Yep, will do that.

thanks,
srini
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
