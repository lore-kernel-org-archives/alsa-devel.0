From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [RFC][ASoC] New device/driver arch
Date: Fri, 15 Jun 2007 17:36:54 +0530
Message-ID: <8d6898730706150506i5e26a600t35cb0aba0b556890@mail.gmail.com>
References: <1181842832.26658.42.camel@localhost.localdomain>
	<20070614180656.GA22664@roarinelk.homelinux.net>
	<1181898259.26658.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.235])
	by alsa0.perex.cz (Postfix) with ESMTP id BE53624669
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 14:06:55 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so842760nzf
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2007 05:06:54 -0700 (PDT)
In-Reply-To: <1181898259.26658.53.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Manuel Lauss <mano@roarinelk.homelinux.net>, alsa-devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

So in this architecture we will have so many devices registered to the kernel?

On 6/15/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> On Thu, 2007-06-14 at 20:06 +0200, Manuel Lauss wrote:
> > Hi Liam,
> >
> > Is it possible to have 2 physical I2S units (which are connected to the same
> > codec) be repesented as a single ASoC device? (The SH7760 has 2 I2S units
> > which are "halfduplex" (only transmit OR capture at a time). My dev platform
> > simply uses the second unit for capture
> >
>
> Yes. I would create two struct snd_soc_device_drivers in your i2s.c
> file. The first would be the driver for the 2 halfduplex I2S units and
> the second would be a full duplex driver for a merged I2S controller
> (made up of the 2 halfduplex units). This way a device can either probe
> against the halfduplex or full duplex driver based on the driver ID.
>
> >
> > I need a trigger callback in the  machine driver to properly support
> > multichannel I2S audio on Au1200 (the  Au1200 can only do stereo; to get
> > more channels we double/quadruple the I2S LRCLK coming from the codec;
> > however the CPLD needs to be told when a new sample starts; although
> > maybe that can be worked around in VHDL)
> >
>
> I'll add trigger. Probably easier to do this in C than VHDL ;)
>
> Liam
>
>
