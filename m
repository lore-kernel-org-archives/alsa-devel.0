From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: hdsp driver changes: something has broken
Date: Wed, 15 May 2002 22:28:13 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0205152226450.7094-100000@cmn37.stanford.edu>
References: <200205160247.g4G2ldB04725@op.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA26712
	for <alsa-devel@alsa-project.org>; Thu, 16 May 2002 07:28:46 +0200
In-Reply-To: <200205160247.g4G2ldB04725@op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> as fernando reported:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.19-pre6/kernel/sound/pci/rme9652/snd-hammerfall-mem.o
> depmod:         pci_free_consistent
> depmod:         pci_alloc_consistent
> depmod:         pci_devices
> depmod:         mem_map
> depmod:         printk
> depmod: *** Unresolved symbols in /lib/modules/2.4.19-pre6/kernel/sound/pci/rme9652/snd-hdsp.o
> de
> 
> these errors did not occur on the builds that i did before jaroslav
> committed my changes. jaroslav - can you please review what you did to
> see if there is something that may have caused this? 
> 
> in addition, i noted that rme9652_mem.c should be removed from
> CVS. the one in alsa-kernel has been, but the one in alsa-driver is
> still there. this has caused a number of problems for several people...

I did not check if rme9652_mem was still there but I managed to compile 
cvs today with no missing symbols so somebody must have fixed something. 

-- Fernando


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
