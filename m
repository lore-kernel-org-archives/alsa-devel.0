From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: pcmcia hdsp problems
Date: Thu, 08 May 2003 13:18:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Doyy-0000ne-00@sc8-sf-list1.sourceforge.net>
References: <1052411146.1361.54.camel@localhost.localdomain>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "08 May 2003 12:25:34 EDT."
             <1052411146.1361.54.camel@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jfm3 <jfm3@ouroboros-complex.org>
Cc: ALSA Developer List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>I put 'modprobe snd-hammerfall-mem enable=1' as the first thing that
>happens in /etc/rc.sysinit. It doesn't seem to allocate any memory. When
>the machine first boots with the PCMCIA card in, it lists it as this: 
>
>$ lspci
>...
>01:00.0 Class ffff: Illegal Vendor ID: Unknown device ffff (rev ff)
>
>If I remove the card with cardctl eject and put it back in, it shows up.
>
>$ lspci
>...
>01:00.0 Multimedia audio controller: Xilinx, Inc. RME Hammerfall DSP
>(rev 0b)
>
>At this point I can reload snd-hammerfall-mem and snd-hdsp and they
>don't complain. The bright red HOST light is still on though. Of course,
>at this point, it is probably too late for snd-hammerfall-mem to have
>been loaded correctly.
>
>Does the enable argument to snd-hammerfall-mem do anything anymore? Any
>other ideas?

it didn't work because of the erroneous PCI ID that appeared for the
h/w. the hammerfall-mem module counts how many Hammerfall-ish devices
it can find, and allocates memory for them. a device claiming to be
vendor 0xffff is not only illegal, its definitely not a hammerfall :)

--p


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
