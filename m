From: Olaf Hering <olh@suse.de>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
Date: Sun, 26 Feb 2006 18:39:08 +0100
Message-ID: <20060226173908.GA4871@suse.de>
References: <jehd7527wq.fsf@sykes.suse.de> <1139783738.5247.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 85CC618E
	for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2006 19:39:12 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <1139783738.5247.54.camel@localhost.localdomain>
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
Cc: Andreas Schwab <schwab@suse.de>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Ben Collins <ben.collins@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

 On Mon, Feb 13, Benjamin Herrenschmidt wrote:

> On Sat, 2006-02-11 at 17:10 +0100, Andreas Schwab wrote:
> > When booting with line out or headphone plugged, you won't hear anything.
> > The problem is that after reset all channels are muted, but the actual
> > value of the gpio port doesn't exactly match the active_val settings as
> > expected by check_audio_gpio.  For example, the line_mute port is set to
> > 7, but check_audio_gpio would expect 0xd or 0xf, thus its return value
> > indicates that it is not active, even though it is.  AFAICS only looking
> > at the low bit is enough to determine whether the port is active.
> > 
> > Signed-off-by: Andreas Schwab <schwab@suse.de>
> > 
> > Index: linux-2.6.16-rc2/sound/ppc/tumbler.c
> > ===================================================================
> > --- linux-2.6.16-rc2.orig/sound/ppc/tumbler.c	2006-02-03 19:43:50.000000000 +0100
> > +++ linux-2.6.16-rc2/sound/ppc/tumbler.c	2006-02-11 03:46:30.000000000 +0100
> > @@ -207,7 +207,7 @@ static int check_audio_gpio(struct pmac_
> >  
> >  	ret = do_gpio_read(gp);
> >  
> > -	return (ret & 0xd) == (gp->active_val & 0xd);
> > +	return (ret & 0x1) == (gp->active_val & 0x1);
> >  }
> >  
> >  static int read_audio_gpio(struct pmac_gpio *gp)

This (sort of) breaks PowerMac3,4 (69 (PowerMac G4 Silver)). I have to
force it on up to now, but with this patch the internal speaker will not
work with or without my patch to force it on.

I get these values:

check_audio_gpio gp c040fc14 addr 0000006f ret 00000007
check_audio_gpio gp c040fbfc addr 00000070 ret 00000004

With speakers plugged in, both give 0x07

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50:
linux,device     cfdc7808
name             "gpio"
linux,phandle    ff90fcd0
reg              00000050 00000030
built-in        
device_type      "gpio"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/extint-gpio16:
name             "extint-gpio16"
linux,phandle    ff910a00
interrupt-parent ff90fa80
interrupts       0000003e 00000000
AAPL,address     80000068
built-in        
one-wire-bus     "speaker-id"
AAPL,driver-name ".DallasDriver"
compatible       "keywest-gpio16"
device_type      "extint-gpio16"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/extint-gpio15:
name             "extint-gpio15"
linux,phandle    ff9107f8
interrupt-parent ff90fa80
interrupts       0000003d 00000000
AAPL,address     80000067
built-in        
compatible       "keywest-gpio15"
device_type      "extint-gpio15"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/gpio11:
name             "gpio11"
linux,phandle    ff9105f8
AAPL,address     80000075
built-in        
audio-gpio-active-state 00000000
audio-gpio       "audio-hw-reset"
compatible       "keywest-11"
device_type      "gpio11"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/gpio6:
name             "gpio6"
linux,phandle    ff910400
AAPL,address     80000070
built-in        
audio-gpio-active-state 00000000
audio-gpio       "amp-mute"
compatible       "keywest-6"
device_type      "gpio6"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/gpio5:
name             "gpio5"
linux,phandle    ff910208
AAPL,address     8000006f
built-in        
audio-gpio-active-state 00000000
audio-gpio       "headphone-mute"
compatible       "keywest-5"
device_type      "gpio5"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/programmer-switch:
name             "programmer-switch"
linux,phandle    ff910058
interrupt-parent ff90fa80
interrupts       00000037 00000000
built-in        
device_type      "programmer-switch"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/extint-gpio1:
name             "extint-gpio1"
linux,phandle    ff90fe38
AAPL,interrupt-priorities 00000001
interrupt-parent ff90fa80
interrupts       0000002f 00000001
built-in        
compatible       "keywest-gpio1"
device_type      "extint-gpio1"





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
