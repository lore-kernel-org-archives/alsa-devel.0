From: Thomas Charbonnel <thomas@undata.org>
Subject: HDSP -- snd-hdsp.o: init_module: No such device
Date: Thu, 16 May 2002 12:37:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E178Ifc-0001pW-00@satellite>
Reply-To: thomas@undata.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite (ALyon-101-1-6-151.abo.wanadoo.fr [217.128.18.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA30334
	for <alsa-devel@alsa-project.org>; Thu, 16 May 2002 12:48:14 +0200
Received: from toma by satellite with local (Exim 3.35 #1 (Debian))
	id 178Ifc-0001pW-00
	for <alsa-devel@alsa-project.org>; Thu, 16 May 2002 12:39:40 +0200
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

Hi,
I was very excited and pleased to see hdsp driver had reached cvs (thank you 
Paul !) , so I gave it a try. Here are the results.
I manage to insmod everything needed except the snd-hdsp module. I get the 
following in syslog:
May 16 12:11:18 satellite kernel: RME Hammerfall-DSP: no cards found
May 16 12:15:36 satellite kernel: ALSA 
../../alsa-kernel/pci/rme9652/hdsp.c:455: Hammerfall-DSP: no Digiface or 
Multiface connected!
May 16 12:15:36 satellite kernel: RME Hammerfall-DSP: no cards found

I'm using a cardbus hdsp + multiface on a toshiba satellite notebook, with 
kernel 2.4.18. The computer fails to boot with the card inserted, but accepts 
the card afterwards, and the host led on the multiface switches down.

cat /proc/pci outputs
Bus  3, device   0, function  0:
    Multimedia audio controller: PCI device 10ee:3fc5 (rev 10).
      IRQ 10.
      Master Capable.  Latency=64.
      Non-prefetchable 32 bit memory at 0xd2400000 [0xd20fffff].
but syslog shows
May 16 09:54:57 satellite kernel: cs: cb_alloc(bus 3): vendor 0x10ee, device 
0x3fc5
May 16 09:54:57 satellite kernel: PCI: Failed to allocate resource 
0(d2400000-d20fffff) for 03:00.0
May 16 09:54:57 satellite kernel: PCI: Enabling device 03:00.0 (0080 -> 0082)
May 16 09:54:57 satellite cardmgr[258]: socket 0: CardBus hotplug device

Any idea?

Regards,
Thomas


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
