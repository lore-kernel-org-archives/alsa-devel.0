From: Nicolas Pitre <nico@cam.org>
Subject: Re: pxa2xx ac97 driver
Date: Fri, 11 Feb 2005 10:50:22 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0502111049190.25848@localhost.localdomain>
References: <1108123181.3181.23.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 254C41E2
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2005 16:50:25 +0100 (MET)
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IBR004SA8000Z@VL-MO-MR007.ip.videotron.ca> for
 alsa-devel@alsa-project.org; Fri, 11 Feb 2005 10:50:24 -0500 (EST)
In-reply-to: <1108123181.3181.23.camel@icampbell-debian>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ian Campbell <icampbell@arcom.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Feb 2005, Ian Campbell wrote:

> Hi Nico,
> 
> I've just grabbed your pxa2xx audio driver from alsa CVS and given it a
> go on my PXA255 based board. I'm running 2.6.10 with the DMA mmap API
> backported. I got it working pretty quick with only a couple of issues
> -- thanks!
> 
> First issue was minor: I think *_EOC only exist on PXA270, or at least
> they aren't documented on the 255 and the symbols aren't defined for
> CONFIG_PXA25x so I wrapped them in CONFIG_PXA27x. I don't know if it
> would hurt to write to the reserved bits on 255...
> 
> Second issue is a bit strange. The code in the reset function does:
> 	GCR = GCR_COLD_RST;
> 	GCR |= GCR_PRIRDY_IEN|GCR_SECRDY_IEN;
> 	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
> which either causes a hang or causes repeated interrupts so that it is
> impossible to see what is going on (didn't see anything from a printk in
> the irq handler though). I changed it to 
> 	GCR = GCR_COLD_RST;
> 	GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
> 	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
> which matches the way the old OSS driver did the reset and now the
> driver works great.
> 
> I don't understand this though since the documentation would appear to
> suggest that the PRIRDY way makes more sense. I guess it's possible that
> it is related to 255 errata #30 ("Invalid AC'97 interrupt during cold
> reset") but I'm not sure...
> 
> Anyway, here is the patch for the changes I made, what do you think?
> 
> Signed-off-by: Ian Campbell <icampbell@arcom.com>

Looks fine to me.

Signed-off-by: Nicolas Pitre <nico@cam.org>

> Index: 2.6/sound/arm/pxa2xx-ac97.c
> ===================================================================
> --- 2.6.orig/sound/arm/pxa2xx-ac97.c	2005-02-11 10:38:07.000000000 +0000
> +++ 2.6/sound/arm/pxa2xx-ac97.c	2005-02-11 11:33:40.659553892 +0000
> @@ -115,7 +117,7 @@
>  	udelay(50);
>  #else
>  	GCR = GCR_COLD_RST;
> -	GCR |= GCR_PRIRDY_IEN|GCR_SECRDY_IEN;
> +	GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
>  	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
>  #endif
>  
> @@ -157,12 +159,14 @@
>  		gsr_bits |= status;
>  		wake_up(&gsr_wq);
>  
> +#ifdef CONFIG_PXA27x
>  		/* Although we don't use those we still need to clear them
>  		   since they tend to spuriously trigger when MMC is used
>  		   (hardware bug? go figure)... */
>  		MISR = MISR_EOC;
>  		PISR = PISR_EOC;
>  		MCSR = MCSR_EOC;
> +#endif
>  
>  		return IRQ_HANDLED;
>  	}
> 
> Cheers,
> Ian.
> -- 
> Ian Campbell, Senior Design Engineer
>                                         Web: http://www.arcom.com
> Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
> Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200
> 


Nicolas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
