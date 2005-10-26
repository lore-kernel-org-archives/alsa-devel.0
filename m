From: Ian Campbell <icampbell@arcom.com>
Subject: Re: [PXA2XX] make pxa2xx audio driver sparse clean
Date: Wed, 26 Oct 2005 15:39:03 +0100
Message-ID: <1130337543.5700.42.camel@icampbell-debian>
References: <1130335228.5700.13.camel@icampbell-debian>
	 <s5hd5ls74mh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail9.messagelabs.com (mail9.messagelabs.com [194.205.110.133])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B9FEF18D
	for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2005 16:39:13 +0200 (MEST)
In-Reply-To: <s5hd5ls74mh.wl%tiwai@suse.de>
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
Cc: Nicolas Pitre <nico@cam.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-10-26 at 16:08 +0200, Takashi Iwai wrote:
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

Interesting question. Other than SA1100 most other ARM subarches which
have a __REG macro do use u32. The change below causes some
"initialization from incompatible pointer type" type warnings on my
platform and on lubbock/mainstone but nothing which looks important, my
platform continues to work.

(I guess if this discussion goes any further we should redirect to the
linux-arm-kernel list...)

Ian.

Index: 2.6/include/asm-arm/arch-pxa/hardware.h
===================================================================
--- 2.6.orig/include/asm-arm/arch-pxa/hardware.h        2005-10-20 10:32:59.000000000 +0100
+++ 2.6/include/asm-arm/arch-pxa/hardware.h     2005-10-26 15:20:01.000000000 +0100
@@ -44,12 +44,12 @@

 #ifndef __ASSEMBLY__

-# define __REG(x)      (*((volatile unsigned long *)io_p2v(x)))
+# define __REG(x)      (*((volatile u32 *)io_p2v(x)))

 /* With indexed regs we don't want to feed the index through io_p2v()
    especially if it is a variable, otherwise horrible code will result. */
 # define __REG2(x,y)   \
-       (*(volatile unsigned long *)((unsigned long)&__REG(x) + (y)))
+       (*(volatile u32 *)((u32)&__REG(x) + (y)))

 # define __PREG(x)     (io_v2p((u32)&(x)))




-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
