From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: Re: alsa-driver-1.0.0pre3 - UltraSound PnP card not found?
Date: Fri, 12 Dec 2003 02:33:28 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031212023329.071274955@marimba.home.net>
References: <20031127015445.4CA824958@marimba.home.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: My message of "Thu, 27 Nov 2003 01:54:45 GMT"
	     <20031127015445.4CA824958@marimba.home.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Ted <ted@nowtsfree.freeserve.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello, I previously reported a problem loading the snd-interwave
module from alsa-driver-1.0.0pre3 into linux-2.2.25.

I found a fix, but not the complete answer, because I'm not yet clear
about the different roles of the support/isapnp and support/pnp code.

The problem is that support/pnp/pnp.c refers to functions in the
support/isapnp code so it #includes isapnp.h without CONFIG_ISAPNP
being defined. The result is that dummy isapnp functions defined
in isapnp.h to do nothing are used, instead of the working functions
in the snd-isapnp module.

See support/isapnp/isapnp.h around lines 308-376.
As a temporary fix I simply defined CONFIG_ISAPNP at line 308,
but this will not suit everyone else's configurations.

I suspect that CONFIG_ISAPNP should be defined in the files under
support/pnp when they need to link with support/isapnp code, before
isapnp.h is include in them, rather the way I have hacked it.

Ted.

> To: alsa-devel@lists.sourceforge.net
> Cc: Ted <ted@nowtsfree.freeserve.co.uk>
> Subject: alsa-driver-1.0.0pre3 - UltraSound PnP card not found?
> Date: Thu, 27 Nov 2003 01:54:45 +0000
> From: Ted <ted@nowtsfree.freeserve.co.uk>
> Message-Id: <20031127015445.4CA824958@marimba.home.net>
>
> Hi,
>     I'm trying to use alsa-driver-1.0.0pre3 with linux-2.2.25 and
> gcc-2.95.3 for a GravisUltrasound PNP Pro and TMC PCI54ITS motherboard.
>
> Previously, with alsa-driver-0.9.0rc6 and linux-2.2.20, I used isapnp
> to map out certain IRQs after a cold-boot, before the snd-card-interwave
> module would load.
>
> Now I'm trying to use alsa-driver-1.0.0pre3 with linux-2.2.25.
>
> After a minor fix (see separate message) the modules appear to build
> successfully and, after a cold boot, when snd-isapnp is loaded...
>
> # modprobe -v snd-isapnp
> /sbin/insmod /lib/modules/2.2.25/misc/snd-isapnp.o \
> 	isapnp_verbose=2 isapnp_reserve_irq=5,7,11,12,13
> Using /lib/modules/2.2.25/misc/snd-isapnp.o
> Symbol version prefix ''
>
> and the soundcard is reported by syslog...
> 	kernel: isapnp: Card 'UltraSound Plug & Play'
> 	kernel: isapnp:	  Device 'UltraSound Plug & Play'
> 	last message repeated 4 times
> 	kernel: isapnp: 1 Plug & Play card detected total
>
> Yet later, snd-interwave fails to load...
>
> # modprobe -v snd-interwave
> /sbin/insmod /lib/modules/2.2.25/misc/snd-interwave.o \
>         index=0 id=GusPnP enable=1 isapnp=1 port=0x220 irq=15 \
>         dma1=5 dma2=7 midi=0 pcm_channels=8 effect=1
> Using /lib/modules/2.2.25/misc/snd-interwave.o
> Symbol version prefix ''
> /lib/modules/2.2.25/misc/snd-interwave.o: \
>         init_module: Device or resource busy
> Hint: insmod errors can be caused by incorrect module \
>         parameters, including invalid IO or IRQ parameters
> /lib/modules/2.2.25/misc/snd-interwave.o: \
>         insmod /lib/modules/2.2.25/misc/snd-interwave.o failed
> /lib/modules/2.2.25/misc/snd-interwave.o: \
>         insmod snd-interwave failed
>
> and syslog reports...
> 	kernel: InterWave soundcard not found or device busy
>
> The linux-2.2.25 kernel is configured with...
> # CONFIG_PNP is not set
> CONFIG_SOUND=m
> # CONFIG_SOUND_* are not set
>
> and the alsa-driver-1.0.0pre3 with...
> # ./configure --with-sequencer=yes --with-debug=detect \
> 	--with-isapnp=yes --with-oss=yes --with-cards=interwave
>
> Does anything here look amiss, before I start adding printk's to
> the source code?
>
> Ted.
> --
> Ted <ted@nowtsfree.freeserve.co.uk>
>    http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
