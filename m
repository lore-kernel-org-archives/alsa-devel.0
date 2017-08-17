From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: mediatek: Correct the interrupt property
Date: Thu, 17 Aug 2017 16:19:51 -0500
Message-ID: <20170817211951.27ozvzb62luwczan@rob-hp-laptop>
References: <43a7fb98e7252d0b7b73cdabf1eedd0bf896d68c.1502784169.git.ryder.lee@mediatek.com>
 <20170815115309.glj52jx3kpq4jxq3@sirena.org.uk>
 <1502805100.25910.8.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502805100.25910.8.camel@mtkswgap22>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 15, 2017 at 09:51:40PM +0800, Ryder Lee wrote:
> On Tue, 2017-08-15 at 12:53 +0100, Mark Brown wrote:
> > On Tue, Aug 15, 2017 at 04:07:02PM +0800, Ryder Lee wrote:
> > 
> > > This patch update interrupt property since we only use ASYS IRQ
> > > in the driver, and this may confuse people.
> > 
> > > -		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> > > -			     <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> > > +		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> > 
> > What harm does having the extra information in the bindings do?  If it's
> > possible there might be a use for the extra interrupt it seems better to
> > have people describe it.

Agreed. It should describe interrupts the h/w has, not what the driver 
(currently) uses.
> 
> Yes you're right. The current driver get IRQ number by index "0" but
> actually it should be "1" (GIC 132). Perhaps we can switch to use the
> platform_get_irq_byname() and add interrupt-name in DT so that binding
> can be agnostic of the IRQ order. 

The binding is wrong already in that it says a single interrrupt. The 
example has 2 though. Add the 2nd interrupt and define the order such 
that you don't break the current driver. Probably that means ASYS is 
first.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
