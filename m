From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 3/3] Binding: atmel-wm8904: add option to choose clock
Date: Thu, 16 Jan 2014 09:38:52 +0800
Message-ID: <52D7382C.4080705@atmel.com>
References: <1389669956-2304-1-git-send-email-voice.shen@atmel.com> <1389669956-2304-4-git-send-email-voice.shen@atmel.com> <52D6C2A1.4080405@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52D6C2A1.4080405@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: broonie@kernel.org, devicetree@vger.kernel.org, plagnioj@jcrosoft.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Mark Brown <broonie@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Nicolas,

On 01/16/2014 01:17 AM, Nicolas Ferre wrote:
> On 14/01/2014 04:25, Bo Shen :
>> Add the option to choose clock output on which pin connect to SSC.
>> Default is on TK pin to SSC, add clk_from_rk_pin option, the clock
>
> Please do not use "_" in DT properties. It is a common pattern to use
> "-" instead.

OK, I will use "-" instead in next version.

>> is on RK pin to SSC.
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> ---
>>
>>   Documentation/devicetree/bindings/sound/atmel-wm8904.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
>> index 8bbe50c..68a5c1a 100644
>> --- a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
>> +++ b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
>> @@ -33,6 +33,8 @@ Required properties:
>>
>>   Optional properties:
>>     - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
>> +  - clk_from_rk_pin: according to hardware design, clk privide on rk pin
>
> typo + more description is needed:
> Please tell that it is a boolean property, that by default it is using
> the TK pin (like in the commit message in fact).

OK, I will add more description for it.

Thanks

> Bye,
>
>> +    to ssc device
>>
>>   Example:
>>   sound {
>>
>
>

Best Regards,
Bo Shen
