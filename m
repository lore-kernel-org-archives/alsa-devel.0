From: Ted <ted@nowtsfree.freeserve.co.uk>
Subject: Re: alsa-driver-1.0.0pre3 - UltraSound PnP card not found?
Date: Fri, 28 Nov 2003 00:37:11 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031128003712.13D7A4955@marimba.home.net>
References: <s5hu14qc528.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 27 Nov 2003 14:30:07 +0100."
             <s5hu14qc528.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Ted <ted@nowtsfree.freeserve.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

> Takashi Iwai wrote:
> Ted wrote:
> >
> > # modprobe -v snd-interwave
> > /sbin/insmod /lib/modules/2.2.25/misc/snd-interwave.o \
> >         index=0 id=GusPnP enable=1 isapnp=1 port=0x220 irq=15 \
> >         dma1=5 dma2=7 midi=0 pcm_channels=8 effect=1
>
> what happens if you don't pass the port, irq and dma parameters?

The same "init_module: Device or resource busy" messages as before.

I've tried missing out various combinations of parameters + cold-rebooting
(or not), so the BIOS/whatever does (or doesnt) set up the PNP card first.
The port, irq and dma parameters I used at first were the ones that
DOS/Win95 store in the C:\ULTRAPNP\IW.INI file for the card.

Ted.
-- 
Ted <ted@nowtsfree.freeserve.co.uk>
   http://www.nowtsfree.freeserve.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
