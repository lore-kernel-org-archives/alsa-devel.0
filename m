From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 16/19] ASoC: tlv320aic31xx: Add short
 circuit detection support
Date: Wed, 6 Dec 2017 14:22:39 -0600
Message-ID: <fd362117-ae71-a6a2-eb43-70c2457c0a5d@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-17-afd@ti.com>
 <20171201133930.xzfjjj6wzkbtk6c4@sirena.org.uk>
 <4d956cbc-829c-0d81-2980-aa2a79f36660@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F0E8267044
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 21:22:41 +0100 (CET)
In-Reply-To: <4d956cbc-829c-0d81-2980-aa2a79f36660@ti.com>
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
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 12/01/2017 09:32 AM, Andrew F. Davis wrote:
> On 12/01/2017 07:39 AM, Mark Brown wrote:
>> On Wed, Nov 29, 2017 at 03:32:57PM -0600, Andrew F. Davis wrote:
>>
>>> +static irqreturn_t aic31xx_irq(int irq, void *data)
>>> +{
>>> +	struct aic31xx_priv *aic31xx = (struct aic31xx_priv *)data;
>>
>> There is no need to cast away from void, doing so can only mask bugs.
>>
>>> +	ret = regmap_read(aic31xx->regmap, AIC31XX_INTRDACFLAG, &value);
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to read interrupt mask: %d\n", ret);
>>> +		return IRQ_NONE;
>>> +	}
>>> +
>>> +	if (value & AIC31XX_HPLSCDETECT)
>>> +		dev_err(dev, "Short circuit on Left output is detected\n");
>>> +	if (value & AIC31XX_HPRSCDETECT)
>>> +		dev_err(dev, "Short circuit on Right output is detected\n");
>>> +
>>> +	return IRQ_HANDLED;
>>
>> This will report the interrupt as handled even if we didn't see an
>> interrupt we understand which will break shared interrupt lines.  At the
>> very least we should log other interrupt sources numerically.
>>
> 
> Okay, I think I can make that work by checking if no bits are set in the
> interrupt regs and returning early if not, IRQ_NONE.
> 

This turned out to be more difficult than I expected, plus if I do
handle an interrupt it doesn't mean the other device did not right? So
this wouldn't fix shared lines as far as I can tell, but I don't
register it as shared so this should be fine.

As for your other suggestion of "log other interrupt sources
numerically", could you explain this or point to an example of what you
mean?

>>> +	if (aic31xx->irq > 0) {
>>> +		regmap_update_bits(aic31xx->regmap, AIC31XX_GPIO1,
>>> +				   AIC31XX_GPIO1_FUNC_MASK,
>>> +				   AIC31XX_GPIO1_INT1 <<
>>> +				   AIC31XX_GPIO1_FUNC_SHIFT);
>>
>> Is the interrupt only available on GPIO1?
>>
> 
> Some devices can route this to GPIO2 IIRC.
> 
> I'm not sure how that would be supported, I think we would need to add
> interrupt names to DT so users could specify which gpio they wired their
> IRQ lines to.
> 
> interrupt = <&host 23>;
> interrupt-name = "gpio2";
> 
> or similar?
> 
