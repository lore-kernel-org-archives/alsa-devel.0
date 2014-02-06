From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 0/8] da9055: Driver initialisation fixes, add DT support
Date: Thu, 06 Feb 2014 05:22:41 -0800
Message-ID: <52F38CA1.8020806@roeck-us.net>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com> <20140206005406.GC1308@roeck-us.net> <2E89032DDAA8B9408CB92943514A03376B7E368A@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2E89032DDAA8B9408CB92943514A03376B7E368A-68WUHU125fLzLL1Oxlh9IgLouzNaz+3S@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 02/06/2014 03:46 AM, Opensource [Adam Thomson] wrote:
> On Thu, Feb 06, 2014 at 00:54:11AM +0000, Guenter Roeck wrote:
>
>> Adam,
>>
>> You don't really explain what the problem actually is. Can you elaborate ?
>
> Sorry, yes. For the conflicting device Ids, both the PMIC and the CODEC used
> the same I2C Id string, which meant if you tried to intiate both together on the
> same bus, then the second would fail.
>
> For the removal of platform_get_irq_byname(), the reason for this was that it
> was conflicting with regmap_irq_get_virq() when the IRQ value returned from
> platform_get_irq_byname() was being passed to regmap_irq_get_virq(). The result
> for the code was that it would try to request a threaded IRQ using an invalid
> IRQ number (have also described this further in patch 0004 mail thread,
> https://lkml.org/lkml/2014/2/6/126).
>
>>
>> Also, I have been using platform_get_irq() to get the interrupt resource
>> in mfd client drivers and similar situations. Wouldn't this work here as well
>> if you don't want to use platform_get_irq_byname() ?
>
> What I could've done is use platform_get_irq_byname() and avoided using
> regmap_irq_get_virq() as I would already have the correct VIRQ to pass to
> request_threaded_irq(), but I figured that using regmap_irq_get_virq() made
> more sense at the time, and was unable to use both.
>

I may be missing something, but I think the problem may be that you are
doing two mappings instead of just one. I don't think you need to call
regmap_irq_get_virq() at all.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
