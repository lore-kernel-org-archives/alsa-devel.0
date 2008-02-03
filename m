From: Richard Kennedy <richard@rsk.demon.co.uk>
Subject: Re: Intel ICH Modem init fails for laptop	built-in	SiS
	modem
Date: Sun, 03 Feb 2008 14:30:21 +0000
Message-ID: <1202049021.2986.11.camel@castor.localdomain>
References: <1201797931.2968.16.camel@castor.localdomain>
	<s5h7iho3lge.wl%tiwai@suse.de>
	<1201870843.2956.14.camel@castor.localdomain>
	<s5h3asc3ikc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net
	[194.217.242.89])
	by alsa0.perex.cz (Postfix) with ESMTP id C7DAD24647
	for <alsa-devel@alsa-project.org>; Sun,  3 Feb 2008 15:30:24 +0100 (CET)
In-Reply-To: <s5h3asc3ikc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> > > Richard Kennedy wrote:
> > > > 
> > > > My JVC mininote laptop has an inbuilt SiS modem
> > > >  00:01.6 Modem [0703]: Silicon Integrated Systems [SiS] AC'97 Modem Controller [1039:7013] (rev a0)
> > ...
> > > > kernel: Intel ICH Modem: probe of 0000:00:01.6 failed with error -5
> > > > 
> > > > I never use the modem so I blacklisted the snd-intel8x0m module in
> > > > modprobe.conf just to make the messages go away.
> > > > 
> > > > I'm currently running the fedora 2.6.23 kernel but it has been broken
> > > > for a long time.
> > > > 
> > > > Is this fixable?
> > > > or shall I just go on ignoring it ;) ?
> > > 
> > > The latter unless you really need the support of it ;)
> > > We have no datasheet for this SIS chipset, so it's hard to fix,
> > > unfortuantely.
> > > 
> > > 
> > > Takashi
> > 
> > Right, thanks.
> > 
> > In that case should we remove it from then supported devices list ?
> 
> Maybe.  But it might work on other machines with the same chipset.
> It can't be confirmed easily...
> 
> 
> Takashi
> 
OK. But spamming the log with 400+ messages just because it _might_ work
somewhere seems wrong to me, when we know it doesn't work on this
particular chip.

> kernel: codec_semaphore: semaphore is not ready [0x1][0x300]
> kernel:last message repeated 431 times

isn't there any way to blacklist this particular variant of the chip in
the driver ?
OTOH maybe just rate limiting the output from code_semaphore would be
good enough ?

Richard
