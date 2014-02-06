From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 4/8] regulator: da9055: Add DT support
Date: Thu, 6 Feb 2014 11:31:13 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376B7E1669@SW-EX-MBX02.diasemi.com>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
 <6d76ae40cd435eaae0323f3e806515130b06a376.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
 <20140205183642.GH32298@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 56D4726516B
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2014 12:31:17 +0100 (CET)
In-Reply-To: <20140205183642.GH32298@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alessandro Zummo <a.zummo@towertech.it>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 05, 2014 at 18:37:21PM +0000, Mark Brown wrote:

> On Wed, Feb 05, 2014 at 05:48:35PM +0000, Adam Thomson wrote:
> 
> > +#ifdef CONFIG_OF
> > +#include <linux/of.h>
> > +#include <linux/regulator/of_regulator.h>
> > +#endif /* CONFIG_OF */
> 
> Don't do ifdefs for includes like this, it's not worth it.

Fine. Seen examples of both in the kernel, but happy to remove it.

> 
> > +	for_each_child_of_node(nproot, np) {
> > +		if (!of_node_cmp(np->name,
> > +				 regulator->info->reg_desc.name)) {
> > +			config->init_data = of_get_regulator_init_data(
> > +				&pdev->dev, np);
> > +			config->of_node = np;
> > +			break;
> > +		}
> > +	}
> 
> I think you're looking for of_regulator_match() here.

Used another driver as an example for this, but if there's a better method
then I'm happy to use it. Will have a look.

> 
> >  	if (pdata && pdata->regulators)
> >  		config.init_data = pdata->regulators[pdev->id];
> > +	else {
> > +		ret = da9055_regulator_dt_init(pdev, regulator, &config);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> 
> Coding style, both sides of the if should have braces if one does.

Fine. Will update.

> 
> >  	/* Only LDO 5 and 6 has got the over current interrupt */
> >  	if (pdev->id == DA9055_ID_LDO5 || pdev->id ==  DA9055_ID_LDO6) {
> > -		irq = platform_get_irq_byname(pdev, "REGULATOR");
> > -		irq = regmap_irq_get_virq(da9055->irq_data, irq);
> > +		irq = regmap_irq_get_virq(da9055->irq_data,
> > +					  DA9055_IRQ_REGULATOR);
> 
> This seems like a bit of a step backwards - what happened in the MFD
> (and why didn't it update the users to avoid breaking bisection)?

I tested this on target, when doing tests for devicetree. What was happening was
that platform_get_irq_byname() was returning the VIRQ number already (368 in one
test case where onkey was being probed) rather than the local IRQ number for the
device (the resource information seemed to have been updated with the VIRQ
number instead of the local IRQ number). So when that was passed to
regmap_irq_get_virq() it would then return an incorrect IRQ number (0 in the
same scenario, when I enabled DEBUG in irqdomain.c, I would see the message
"error: hwirq 0x170 is too large for da9055_irq"). That incorrect irq was then
being passed to devm_request_threaded_irq() which subsequently failed. This is
why I made the change. Is it preferrable to use platform_get_irq_byname()
instead of regmap_irq_get_virq() as using them both doesn't seem to work, unless
I'm missing something fundamental here.
