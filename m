From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 1/9] ASoC: tlv320aic31xx: Fix typo in DT
 binding documentation
Date: Thu, 9 Nov 2017 10:28:45 -0600
Message-ID: <0a640aec-1c8e-f778-3a72-f7d012e0604e@ti.com>
References: <20171108212505.28320-1-afd@ti.com>
 <20171108212505.28320-2-afd@ti.com> <1510237517.7659.10.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 6995126782C
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 17:28:47 +0100 (CET)
In-Reply-To: <1510237517.7659.10.camel@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/09/2017 08:25 AM, Philipp Zabel wrote:
> Hi Andrew,
> 
> On Wed, 2017-11-08 at 15:24 -0600, Andrew F. Davis wrote:
>> The property used to specify a GPIO intended for reset is "reset-gpio",
>> this binding uses "gpio-reset", as almost all other bindings use the
>> former name this use of the latter is certainly not intended and
>> was a typo. It is not compatible with newer methods used to fetch
>> GPIO pins and to prevent the spread of this error to other bindings
>> lets fix this here.
>>
>> We also standardize the pin as active-low, different device trees have
>> marked the GPIO different ways, luckily the driver currently uses the
>> low-level GPIO set function which does not respect the active-low flag,
>> but future changes may change this. This is an active-low reset, mark
>> it as such.
>>
>> Lastly, add an example of use for this property.
>>
>> Fixes: e00447fafbf7 ("ASoC: tlv320aic31xx: Add basic codec driver implementation")
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>  Documentation/devicetree/bindings/sound/tlv320aic31xx.txt | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
>> index 6fbba562eaa7..4c4e77f97d87 100644
>> --- a/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
>> +++ b/Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
>> @@ -22,7 +22,7 @@ Required properties:
>>  
>>  Optional properties:
>>  
>> -- gpio-reset - gpio pin number used for codec reset
> 
> I would move this into a "Deprecated properties:" section instead of
> just hiding it away.
> 

The hope was to fix this mistake and pretend it never existed :)

I'll add a Deprecated section in case this breaks for someone they can
see that it was changed.

>> +- reset-gpio - GPIO specification for the active low RESET input.
> 
> This should be "reset-gpios". For reference, see
> Documentation/devicetree/bindings/gpio/gpio.txt.
> 

Yup, will fix for v2.

>>  - ai31xx-micbias-vg - MicBias Voltage setting
>>          1 or MICBIAS_2_0V - MICBIAS output is powered to 2.0V
>>          2 or MICBIAS_2_5V - MICBIAS output is powered to 2.5V
>> @@ -48,6 +48,7 @@ CODEC input pins:
>>  The pins can be used in referring sound node's audio-routing property.
>>  
>>  Example:
>> +#include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/sound/tlv320aic31xx-micbias.h>
>>  
>>  tlv320aic31xx: tlv320aic31xx@18 {
>> @@ -56,6 +57,8 @@ tlv320aic31xx: tlv320aic31xx@18 {
>>  
>>  	ai31xx-micbias-vg = <MICBIAS_OFF>;
>>  
>> +	reset-gpio = <&gpio1 17 GPIO_ACTIVE_LOW>;
>> +
>>  	HPVDD-supply = <&regulator>;
>>  	SPRVDD-supply = <&regulator>;
>>  	SPLVDD-supply = <&regulator>;
> 
> regards
> Philipp
> 
