From: Ian Campbell <icampbell@arcom.com>
Subject: Re: pxa2xx ac97 driver
Date: Fri, 11 Feb 2005 13:22:14 +0000
Message-ID: <1108128134.3181.26.camel@icampbell-debian>
References: <1108123181.3181.23.camel@icampbell-debian>
	 <1108125526.7954.29.camel@odin.gnova.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail9.messagelabs.com (mail9.messagelabs.com [194.205.110.133])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 11698206
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2005 14:22:17 +0100 (MET)
In-Reply-To: <1108125526.7954.29.camel@odin.gnova.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: Nicolas Pitre <nico@cam.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-02-11 at 12:38 +0000, Liam Girdwood wrote:
> Hi Ian,
> 
> On Fri, 2005-02-11 at 11:59 +0000, Ian Campbell wrote:
> 
> > Second issue is a bit strange. The code in the reset function does:
> > 	GCR = GCR_COLD_RST;
> > 	GCR |= GCR_PRIRDY_IEN|GCR_SECRDY_IEN;
> > 	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
> > which either causes a hang or causes repeated interrupts so that it is
> > impossible to see what is going on (didn't see anything from a printk in
> > the irq handler though). I changed it to 
> > 	GCR = GCR_COLD_RST;
> > 	GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
> > 	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
> > which matches the way the old OSS driver did the reset and now the
> > driver works great.
> 
> I've not had any problems with this code on PXA27x. I know there are
> some differences between the PXA25x and PXA27x wrt AC97 CDONE/SDONE bits
> that can cause some problems.
> 
> Perhaps we should use your changes for the PXA25x and Nico's for
> PXA27x ?

I should have quoted a bit more context from the function in question --
the code I gave is actually already inside the #else of a #ifdef
CONFIG_PXA27x (i.e. it's 25x specific).

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
