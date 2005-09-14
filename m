From: Daniel James <daniel@64studio.com>
Subject: Re: More info on hard lock-ups with MIDI on envy24, x86_64 machine
Date: Wed, 14 Sep 2005 12:18:49 +0100
Message-ID: <200509141218.49448.daniel@64studio.com>
References: <200508111525.07881.daniel@64studio.com> <200508111643.27160.daniel@64studio.com> <1123777147.6980.37.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1123777147.6980.37.camel@mindpipe>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net, Free Ekanayaka <free@64studio.com>
List-Id: alsa-devel@alsa-project.org

Hi Lee,

We have now applied your patch to 2.6.13 and tried the test again. I 
get the same result, and there is still nothing relevant output 
to /var/log/messages

However, I am beginning to think that this may be a hardware fault or 
a problem specific to this motherboard or hardware combination. After 
a freeze-up triggered with strace seq24, I reboot and sometimes see 
this message from the BIOS (ie, before GRUB is loaded):

PCI IRQ ROUTING TABLE ERROR [02:00:00]

I don't know if this is the cause of the freeze-up, or just a 
consequence of it. A cold reboot makes the BIOS message go away.

To make sure this is a one-off problem, I'm going to build another 
Opteron machine and test ALSA with that.

Cheers!

Daniel


> On Thu, 2005-08-11 at 16:43 +0100, Daniel James wrote:
> > Hi Lee,
> >
> > > I guess you have tried to trigger the crash from a console as
> > > well as X
> >
> > I've done that now. If I boot the system, switch to a console
> > with ctrl-alt-f1 and run nothing but:
> >
> > strace seq24
> >
> > it starts to go wrong after:
> >
> > open ("/dev/snd/seq", O_RDWR)
> >
> > There are a bunch of lines beginning with ioctl, then the killer
> > blow is dealt by:
> >
> > ioctl (3, CDROM_DEBUG or SNDRV_SEQ_IOCTL_SUBSCRIBE_PORT
> >
> > (This is retyped from hand-written notes of course). The machine
> > is then locked up solid - it's very reproducible too, same output
> > every time.
> >
> > > and there's no Oops output?
> >
> > Nothing at all appears in the console or in /var/log/messages.
> > Should I try increasing the log level or something like that?
>
> Try this (not even compile tested) patch.  Right now it looks like
> the interrupt handler could loop forever if something weird
> happened.  Now it will at least printk, and try to clear the
> interrupt pending register.  This is shamelessly copied from the
> emu10k1 IRQ handler.
>
> Index: alsa-kernel/pci/ice1712/ice1712.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/ice1712.c,v
> retrieving revision 1.68
> diff -u -r1.68 ice1712.c
> --- alsa-kernel/pci/ice1712/ice1712.c	3 Aug 2005 12:40:11
> -0000	1.68 +++ alsa-kernel/pci/ice1712/ice1712.c	11 Aug 2005
> 16:16:42 -0000 @@ -410,13 +410,14 @@
>  static irqreturn_t snd_ice1712_interrupt(int irq, void *dev_id,
> struct pt_regs *regs) {
>  	ice1712_t *ice = dev_id;
> -	unsigned char status;
> +	unsigned char status, orig_status;
>  	int handled = 0;
>
>  	while (1) {
>  		status = inb(ICEREG(ice, IRQSTAT));
>  		if (status == 0)
>  			break;
> +		orig_status = status;
>  		handled = 1;
>  		if (status & ICE1712_IRQ_MPU1) {
>  			if (ice->rmidi[0])
> @@ -472,6 +473,20 @@
>  				snd_pcm_period_elapsed(ice->playback_con_substream);
>  			outb(ICE1712_IRQ_CONPBK, ICEREG(ice, IRQSTAT));
>  		}
> +		if (status) {
> +			unsigned char bits;
> +			snd_printk(KERN_ERR "ice1712: unhandled interrupt: 0x%08x\n",
> status); +			bits = ICE1712_IRQ_MPU1 |
> +			       ICE1712_IRQ_TIMER |
> +			       ICE1712_IRQ_MPU2 |
> +			       ICE1712_IRQ_PROPCM |
> +			       ICE1712_IRQ_FM |
> +			       ICE1712_IRQ_PBKDS |
> +			       ICE1712_IRQ_CONCAP |
> +			       ICE1712_IRQ_CONPBK;
> +			outb(bits, ICEREG(ice, IRQSTAT));
> +		}
> +		outb(orig_status, ICEREG(ice, IRQSTAT));
>  	}
>  	return IRQ_RETVAL(handled);
>  }



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
