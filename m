From: Paul Davis <pbd@op.net>
Subject: Re: HDSP -- snd-hdsp.o: init_module: No such device
Date: Sun, 26 May 2002 07:54:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205261151.g4QBpcn03679@post2.fast.net>
References: <E178Ifc-0001pW-00@satellite>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA03182
	for <alsa-devel@alsa-project.org>; Sun, 26 May 2002 13:51:56 +0200
In-Reply-To: Your message of "Thu, 16 May 2002 12:37:52 +0200."
             <E178Ifc-0001pW-00@satellite>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: thomas@undata.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Hi,
>I was very excited and pleased to see hdsp driver had reached cvs (thank you 
>Paul !) , so I gave it a try. Here are the results.
>I manage to insmod everything needed except the snd-hdsp module. I get the 
>following in syslog:
>May 16 12:11:18 satellite kernel: RME Hammerfall-DSP: no cards found
>May 16 12:15:36 satellite kernel: ALSA 
>../../alsa-kernel/pci/rme9652/hdsp.c:455: Hammerfall-DSP: no Digiface or 
>Multiface connected!
>May 16 12:15:36 satellite kernel: RME Hammerfall-DSP: no cards found
>
>I'm using a cardbus hdsp + multiface on a toshiba satellite notebook, with 
>kernel 2.4.18. The computer fails to boot with the card inserted, but accepts 
>the card afterwards, and the host led on the multiface switches down.

there are problems with the kernel's support for pcmcia cards. i am
still (slowly) tracking them down. the problem is *not* in ALSA or the
H-DSP driver. we need the PCI side of the kernel to know what to do,
and right now, it apparently does not.

the PCI interface works just fine.

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
