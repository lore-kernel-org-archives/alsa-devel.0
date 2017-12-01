From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 15/19] ASoC: tlv320aic31xx: Reset
 registers during power up
Date: Fri, 1 Dec 2017 09:04:41 -0600
Message-ID: <f8b03c59-c7c5-da32-c0fb-de366e931bc9@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-16-afd@ti.com>
 <20171201133723.vlxqci4paw7szjce@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 94E0D267029
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 16:04:42 +0100 (CET)
In-Reply-To: <20171201133723.vlxqci4paw7szjce@sirena.org.uk>
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

On 12/01/2017 07:37 AM, Mark Brown wrote:
> On Wed, Nov 29, 2017 at 03:32:56PM -0600, Andrew F. Davis wrote:
> 
>> +		gpiod_set_value(aic31xx->gpio_reset, 1);
>> +		ndelay(10); /* At least 10ns */
>> +		gpiod_set_value(aic31xx->gpio_reset, 0);
> 
> _cansleep(), this isn't being done from interrupt context.
> 

will fix

>> +	} else {
>> +		ret = regmap_write(aic31xx->regmap, AIC31XX_RESET, 1);
>> +		if (ret < 0)
>> +			dev_err(aic31xx->dev, "Could not reset device\n");
> 
> Print the error to help people doing debug.
> 

Do you mean by adding the ret code to the print?
