From: Paul Davis <pbd@op.net>
Subject: hdsp driver changes: something has broken
Date: Wed, 15 May 2002 22:47:39 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205160247.g4G2ldB04725@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA25182
	for <alsa-devel@alsa-project.org>; Thu, 16 May 2002 04:47:13 +0200
Received: from unknown (HELO op.net) ([209.92.227.113]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 16 May 2002 02:47:10 -0000
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

as fernando reported:

depmod: *** Unresolved symbols in /lib/modules/2.4.19-pre6/kernel/sound/pci/rme9652/snd-hammerfall-mem.o
depmod:         pci_free_consistent
depmod:         pci_alloc_consistent
depmod:         pci_devices
depmod:         mem_map
depmod:         printk
depmod: *** Unresolved symbols in /lib/modules/2.4.19-pre6/kernel/sound/pci/rme9652/snd-hdsp.o
de

these errors did not occur on the builds that i did before jaroslav
committed my changes. jaroslav - can you please review what you did to
see if there is something that may have caused this? 

in addition, i noted that rme9652_mem.c should be removed from
CVS. the one in alsa-kernel has been, but the one in alsa-driver is
still there. this has caused a number of problems for several people...

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
