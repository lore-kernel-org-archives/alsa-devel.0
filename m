From: Paul Davis <pbd@op.net>
Subject: Re: HDSP - snd-hdsp.o: init_module: No such device
Date: Fri, 17 May 2002 12:46:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205171645.g4HGjBT11592@post2.fast.net>
References: <E178eZd-0000DB-00@satellite>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA22157
	for <alsa-devel@alsa-project.org>; Fri, 17 May 2002 18:45:26 +0200
In-Reply-To: Your message of "Fri, 17 May 2002 12:02:56 +0200."
             <E178eZd-0000DB-00@satellite>
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
>
>cat /proc/pci outputs
>Bus  3, device   0, function  0:
>    Multimedia audio controller: PCI device 10ee:3fc5 (rev 10).
>      IRQ 10.
>      Master Capable.  Latency=64.
>      Non-prefetchable 32 bit memory at 0xd2400000 [0xd20fffff].
>but syslog shows
>May 16 09:54:57 satellite kernel: cs: cb_alloc(bus 3): vendor 0x10ee, device 
>0x3fc5
>May 16 09:54:57 satellite kernel: PCI: Failed to allocate resource 
>0(d2400000-d20fffff) for 03:00.0
>May 16 09:54:57 satellite kernel: PCI: Enabling device 03:00.0 (0080 -> 0082)
>May 16 09:54:57 satellite cardmgr[258]: socket 0: CardBus hotplug device
>
>Any idea?

send the output of lspci -vv please, with and without the PCMCIA
interface plugged in. 

this is not an ALSA issue (yet). it appears that the cardbus/pci
bridge code in the kernel may not be working correctly ..

--p

_______________________________________________________________

Hundreds of nodes, one monster rendering program.
Now that’s a super model! Visit http://clustering.foundries.sf.net/
