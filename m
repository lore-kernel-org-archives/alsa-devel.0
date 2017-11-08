From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 8/9] ASoC: tlv320aic31xx: Fix the reset GPIO OF name
Date: Wed, 8 Nov 2017 17:25:20 -0600
Message-ID: <1374534b-ac17-82ef-7b3b-3c6e4d4c5cc9@ti.com>
References: <20171108212505.28320-1-afd@ti.com>
 <20171108212505.28320-9-afd@ti.com>
 <20171108213639.iymb7wuyjpuirbdu@sirena.co.uk>
 <80169c43-ad7f-d89c-61bf-5ca054aacda5@ti.com>
 <20171108221814.m6j3dgrlqpy4htxf@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171108221814.m6j3dgrlqpy4htxf-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 11/08/2017 04:18 PM, Mark Brown wrote:
> On Wed, Nov 08, 2017 at 03:53:51PM -0600, Andrew F. Davis wrote:
>> On 11/08/2017 03:36 PM, Mark Brown wrote:
>>> On Wed, Nov 08, 2017 at 03:25:04PM -0600, Andrew F. Davis wrote:
> 
>>> This is obviously an incompatible change in the binding which will break
>>> any production DTs relying on the current behaviour.  You need to keep
>>> support for the existing property.
> 
>> I understand the reasons not to change driver behavior wrt DT, but this
>> driver did not make functional use of this gpio, only going forward will
>> this gpio be used for actually reseting the device (in some patches I
>> will post soon). So I would like to fix this incorrect binding *before*
>> fixing it will cause behavior incompatibilities.
> 
> There is code in the driver to use the GPIO, including in the probe
> where the GPIO is requested and set to high (which will bring it out of
> reset if the default state was low).  At least the probe seems rather
> likely to have a concrete effect.
> 

None of the 4 boards that defined this gpio have this pulled low in the
pin control, boards should have an external pull-up on the reset line.

At any-rate, I'm pushing this fix to allow the driver to use new kernel
frameworks that depend on the correct binding being used. This is not a
case of a badly designed binding or trying to add incompatible
functionality, it is a typo fix. If we have to keep this driver back
using old frameworks and needlessly bloat the code solely for the sake
of compatibility with a typo, then DT "stability" here is causing more
issues than it solves. </rant>




I guess the alternative would be to have of_find_gpio() also consider
prefixing, the 'gpio_suffixes' to 'con_id' and checking for those. That
is rather ugly and probably encourages the spread of this bad binding
property, but whatever the best fix is it cannot be to force bloat into
the driver.

>>> It also doesn't look like a good fix if we're aiming for conformance
>>> with DT naming conventions as unless things changed all GPIO related
>>> properties are supposed to end -gpios even if they can only ever specify
>>> a single GPIO.
> 
>> If that is the new standard I can fix this patch to use -gpios.
> 
> It's always been the standard AFAIK.
> 

Will fix for v2.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
