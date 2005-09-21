From: Allan Klinbail <allan_k@dodo.com.au>
Subject: Re: [ALSA - driver 0001203]: mtpav driver locks X
	on	64 bit native system
Date: Thu, 22 Sep 2005 02:03:37 +1000
Message-ID: <1127318617.9212.4.camel@daw.littlewolf>
References: <4a2952cca628b67c731e72971c492bf2@bugtrack.alsa-project.org>
	 <1126161408.9937.7.camel@daw.littlewolf>
	 <1126197394.12697.2.camel@mindpipe>  <s5hk6hrsdkt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from relay02.mail-hub.dodo.com.au (relay02.mail-hub.dodo.com.au [202.136.32.45])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D102017B
	for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2005 18:01:51 +0200 (MEST)
In-Reply-To: <s5hk6hrsdkt.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry I haven't been on for a little while... how do I apply this patch?



On Thu, 2005-09-08 at 18:56 +0200, Takashi Iwai wrote:
> At Thu, 08 Sep 2005 12:36:33 -0400,
> Lee Revell wrote:
> > 
> > On Thu, 2005-09-08 at 16:36 +1000, Allan Klinbail wrote:
> > > Is any work being done on this... 
> > > 
> > > To my horror and disgust for work purposes I needed to install winblows
> > > on the amd64 and the MOTU proprietary 32 bit driver works...
> > > 
> > > This simply confirms I have all my printer port settings correct in
> > > BIOS...  
> > 
> > Um, no, because the ALSA developers almost certainly don't have the
> > hardware.  YOU need to work on it.
> 
> The problem is that we haven't changed the driver so much for a long
> time.  And the driver is quite simple.  It's a parallel port.
> So, I'm wondering what is broken.
> 
> You can try the following patch just for testing.  It postpones the
> request_irq() call, in case any wandering irq caused the trouble.
> 
> 
> Takashi
> 
> 
> Index: alsa-kernel/drivers/mtpav.c
> ===================================================================
> RCS file: /home/iwai/cvs/alsa/alsa-kernel/drivers/mtpav.c,v
> retrieving revision 1.29
> diff -u -r1.29 mtpav.c
> --- alsa-kernel/drivers/mtpav.c	5 Sep 2005 16:16:33 -0000	1.29
> +++ alsa-kernel/drivers/mtpav.c	8 Sep 2005 16:55:34 -0000
> @@ -592,13 +592,18 @@
>  /*
>   * get ISA resources
>   */
> -static int snd_mtpav_get_ISA(mtpav_t * mcard)
> +static int __init snd_mtpav_get_ISA_port(mtpav_t * mcard)
>  {
>  	if ((mcard->res_port = request_region(port, 3, "MotuMTPAV MIDI")) == NULL) {
>  		snd_printk("MTVAP port 0x%lx is busy\n", port);
>  		return -EBUSY;
>  	}
>  	mcard->port = port;
> +	return 0;
> +}
> +
> +static int __init snd_mtpav_get_ISA_irq(mtpav_t * mcard)
> +{
>  	if (request_irq(irq, snd_mtpav_irqh, SA_INTERRUPT, "MOTU MTPAV", (void *)mcard)) {
>  		snd_printk("MTVAP IRQ %d busy\n", irq);
>  		return -EBUSY;
> @@ -742,7 +747,7 @@
>  		return -ENOMEM;
>  	}
>  
> -	err = snd_mtpav_get_ISA(mtp_card);
> +	err = snd_mtpav_get_ISA_port(mtp_card);
>  	//printk("snd_mtpav_get_ISA returned: %d\n", err);
>  	if (err < 0)
>  		goto __error;
> @@ -769,6 +774,10 @@
>  
>  	snd_mtpav_portscan(mtp_card);
>  
> +	err = snd_mtpav_get_ISA_irq(mtp_card);
> +	if (err < 0)
> +		goto __error;
> +
>  	printk(KERN_INFO "Motu MidiTimePiece on parallel port irq: %d ioport: 0x%lx\n", irq, port);
>  
>  	return 0;
> 
-- 
Allan Klinbail <allan_k@dodo.com.au>



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
