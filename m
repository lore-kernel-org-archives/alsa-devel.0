From: Paul Davis <pbd@op.net>
Subject: floating point in kernel
Date: Thu, 16 May 2002 21:52:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205170152.g4H1q9626315@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA10776
	for <alsa-devel@alsa-project.org>; Fri, 17 May 2002 03:51:34 +0200
Received: from unknown (HELO op.net) ([209.92.228.136]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 17 May 2002 01:51:28 -0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

from slashdot, discussing the ia64 (itanium) architecture:

 Re:No FP in kernel?

 by descubes on Thursday May 16, @05:38PM (Score:4, Informative) (#3532917) 
 (User #35093 Info) http://home.earthlink.net/~descubes [ Neutral ] 

 There are two reasons:

 1/ The massive amount of FP state in IA-64 (128 FP registers). So the
 linux kernel is compiled in such a way that only some FP registers
 can be used by the compiler. This means that on kernel entry and
 exit, only those FP registers need to be saved/restored. Also, by
 software conventions, these FP registers are "scratch" (modified by a
 call), so the kernel needs not save/restore them on a system call
 (which is seen as a call by the user code)

 2/ The "software assist" for some FP operations. For instance, the FP
 divide and square root are not completely implemented in hardware
 (it's actually dependent on the particular IA-64 implementation, so
 future chips may implement it). For corner cases such as overflow,
 underflow, infinites, etc, the processor traps ("floating-point
 software assist" or FPSWA trap). The IA-64 Linux kernel designers
 decided to not support FPSWA from the kernel itself, which means that
 you can't do a FP divide in the kernel. I suspect this is what is
 more problematic for the application in question (load balancer doing
 FP computations, probably has some divides in there...)

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
