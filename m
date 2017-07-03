From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 01/17] mfd: madera: Add register definitions for
 Cirrus Logic Madera codecs
Date: Mon, 03 Jul 2017 04:26:54 -0700
Message-ID: <1499081214.9885.15.camel@perches.com>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
         <1496415790-19164-2-git-send-email-rf@opensource.wolfsonmicro.com>
         <20170703103330.uka6otpdes462eym@dell>
         <1499079166.9885.13.camel@perches.com>
         <20170703112116.zgatgnazk24qja4e@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170703112116.zgatgnazk24qja4e@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-07-03 at 12:21 +0100, Lee Jones wrote:
> On Mon, 03 Jul 2017, Joe Perches wrote:
> 
> > On Mon, 2017-07-03 at 11:33 +0100, Lee Jones wrote:
> > > On Fri, 02 Jun 2017, Richard Fitzgerald wrote:
> > > 
> > > > This patch adds a header file of register definitions for Cirrus
> > > > Logic "Madera" class codecs. These codecs are all based off a common
> > > > set of hardware IP so have a common register map (with a few minor
> > > > device-to-device variations). These are complex devices with a large
> > > > number of features and so have a correspondingly large register set.
> > > > The registers.h file has been auto-generated from the hardware register
> > > > definitions, stripped down to only registers we need to access from
> > > > the driver
> > > > 
> > > > Signed-off-by: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> > > > ---
> > > > Changes since V2:
> > > > - Used new field names for IRQ1_STATUS_33 register
> > > > 
> > > >  MAINTAINERS                          |   10 +
> > > >  include/linux/mfd/madera/registers.h | 8832 ++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 8842 insertions(+)
> > > >  create mode 100644 include/linux/mfd/madera/registers.h
> > > 
> > > Applied, thanks.
> > 
> > followed by 400k of useless quoted reply!!!
> > 
> > Lee.  Seriously.  Don't be impolite to others.
> > Remember to trim  your replies.
> 
> "Applied, thanks" is *obviously* the last message in my reply.  Did
> you waste any time reading past that, or are you just being pedantic?

Nope, I just looked at the size and the delay
in loading this message over my phone's hotspot.

> If you are truly concerned over 400k of bandwidth you need to switch
> to a new internet provider.

Not everyone uses continuously fast connections.

> This isn't the 1980s.

2017 last I checked.

Being thoughtful to others is still something you
seem content to overlook.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
