From: Paul Davis <pbd@op.net>
Subject: Re: HDSP CardBus issue - /proc/ioports /proc/iomem
Date: Sun, 26 May 2002 08:02:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205261200.OAA03306@alsa.alsa-project.org>
References: <001201c2043c$e7e55330$ac1f830a@ico>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA03306
	for <alsa-devel@alsa-project.org>; Sun, 26 May 2002 14:00:07 +0200
In-Reply-To: Your message of "Sat, 25 May 2002 18:38:30 EDT."
             <001201c2043c$e7e55330$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>I changed my lilo.conf accordingly.
>
>The original entry had a nobiospnp option (nobiospnp was there since
>initially that prevented me from booting due to fact that long time ago
>Mdk froze at boot time when it came to probing pcmcia service, however
>I've changed it and it made no difference).
>
>I did /sbin/lilo (which installed the thing) and booted from it. No
>significant changes occurred, however. I still get the segfault, as well
>as no reports of pcmcia at /proc/interrupts. Here's the pertinent info:

this is somewhat helpful. i need to see the output of lspci -vv as
well.

what i notice:

     * your system has no problem allocating io memory
     * your kernel panic is not in the H-DSP driver or even in ALSA;
        its in the usbcore module. 

i'd like to know if lsmod shows any ALSA code loaded after this
panic. if not, then it points to a bug in the usb driver code that is
presumably tripping up over the appearance of a cardbus device. if
ALSA is there (particularly if the H-DSP driver is loaded), then that
would put the ball back in my court. i can't tell because i don't use
USB for anything - its not even compiled into my kernels.
     
>Finally, if I do insert the card, I get the same notice as Thomas about
>the insterted pcmcia card.

which message is that? if its the "unsupported card" message, thats
OK. cardmgr is a userspace daemon, and its just that your config file
is missing an entry. as far as i can tell its not a problem per se.

--p



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
