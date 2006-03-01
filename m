From: Olaf Hering <olh@suse.de>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
Date: Wed, 1 Mar 2006 23:30:34 +0100
Message-ID: <20060301223034.GA5965@suse.de>
References: <jehd7527wq.fsf@sykes.suse.de> <1139783738.5247.54.camel@localhost.localdomain> <20060226173908.GA4871@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 511651D1
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 23:30:35 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060226173908.GA4871@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alsa-devel@alsa-project.org, Ben Collins <ben.collins@ubuntu.com>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

 On Sun, Feb 26, Olaf Hering wrote:

>  On Mon, Feb 13, Benjamin Herrenschmidt wrote:
> 
> > On Sat, 2006-02-11 at 17:10 +0100, Andreas Schwab wrote:
> > > When booting with line out or headphone plugged, you won't hear anything.
> > > The problem is that after reset all channels are muted, but the actual
> > > value of the gpio port doesn't exactly match the active_val settings as
> > > expected by check_audio_gpio.  For example, the line_mute port is set to
> > > 7, but check_audio_gpio would expect 0xd or 0xf, thus its return value
> > > indicates that it is not active, even though it is.  AFAICS only looking
> > > at the low bit is enough to determine whether the port is active.
> > > 
> > > Signed-off-by: Andreas Schwab <schwab@suse.de>
> > > 
> > > Index: linux-2.6.16-rc2/sound/ppc/tumbler.c
> > > ===================================================================
> > > --- linux-2.6.16-rc2.orig/sound/ppc/tumbler.c	2006-02-03 19:43:50.000000000 +0100
> > > +++ linux-2.6.16-rc2/sound/ppc/tumbler.c	2006-02-11 03:46:30.000000000 +0100
> > > @@ -207,7 +207,7 @@ static int check_audio_gpio(struct pmac_
> > >  
> > >  	ret = do_gpio_read(gp);
> > >  
> > > -	return (ret & 0xd) == (gp->active_val & 0xd);
> > > +	return (ret & 0x1) == (gp->active_val & 0x1);
> > >  }
> > >  
> > >  static int read_audio_gpio(struct pmac_gpio *gp)
> 
> This (sort of) breaks PowerMac3,4 (69 (PowerMac G4 Silver)). I have to
> force it on up to now, but with this patch the internal speaker will not
> work with or without my patch to force it on.

But the patch fixes also my PowerBook4,1, I dont have to toggle the headphone
once to get the built-in speakers enabled.
Looks like 2.6.16 stuff, but its been broken for so long now...


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
