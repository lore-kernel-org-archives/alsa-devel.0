From: Nicolas Pitre <nico@cam.org>
Subject: Re: ucb1400 + ac97
Date: Tue, 11 Apr 2006 16:35:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604111631490.2215@localhost.localdomain>
References: <Pine.LNX.4.63.0604112023390.1093@thuis.unkie.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1B3A8161
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2006 22:35:54 +0200 (MEST)
Received: from xanadu.home ([74.56.105.38]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IXK00FWORVSH6B0@VL-MO-MR004.ip.videotron.ca> for
 alsa-devel@alsa-project.org; Tue, 11 Apr 2006 16:35:52 -0400 (EDT)
In-reply-to: <Pine.LNX.4.63.0604112023390.1093@thuis.unkie.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Pustjens <pustjens@dds.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Apr 2006, Mark Pustjens wrote:

> Hi,
> 
> I'm trying to port two drivers from kernel 2.6.11 to 2.6.15.6. One is a driver
> for ucb1400 on a ac97 bus (UCB1400), the second is a driver for the
> touchscreen controller on the chip (UCB1400_TS).
> 
> The problem is that after loading UCB1400, the probing function is not called.
> This was the case in kernel 2.6.15.6.
> 
> The order of loading modules is:
> 1) snd-ac97-bus
> 2) UCB1400
> 3) UCB1400_TS

You're missing the actual AC97 driver for your platform.

With PXA2xx machines this is the snd-pxa2xx-ac97 module.

And yet for that module to probe anything you need to have the 
appropriate platform-defice registered in your board specific code. See 
arch/arm/mach-pxa/mainstone.c for example.


Nicolas


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
