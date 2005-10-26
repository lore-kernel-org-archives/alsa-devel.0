From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PXA2XX] make pxa2xx audio driver sparse clean
Date: Wed, 26 Oct 2005 11:44:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510261143590.5288@localhost.localdomain>
References: <1130335228.5700.13.camel@icampbell-debian>
 <s5hd5ls74mh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ABEDB18D
	for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2005 17:44:51 +0200 (MEST)
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IOZ001ZR52Q66H0@VL-MO-MR001.ip.videotron.ca> for
 alsa-devel@alsa-project.org; Wed, 26 Oct 2005 11:44:50 -0400 (EDT)
In-reply-to: <s5hd5ls74mh.wl%tiwai@suse.de>
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
Cc: Ian Campbell <icampbell@arcom.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Oct 2005, Takashi Iwai wrote:

> At Wed, 26 Oct 2005 15:00:27 +0100,
> Ian Campbell wrote:
> > 
> > Hi,
> > 
> > Sparse complains because the PXA255 registers are defined as volatile
> > unsigned long * (through the __REGS macro in
> > include/asm-arm/arch-pxa/hardware.h) and the variable being assigned to
> > a u32 (and hence an unsigned int).
> 
> Hmm, is unsigned long a really correct type?
> u32 looks correct to me...

Unsigned long is correct as well on ARM.


Nicolas


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
