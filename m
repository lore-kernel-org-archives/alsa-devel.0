From: walt <w41ter@gmail.com>
Subject: ECS K7VTA3:  Mixer channels reversed
Date: Mon, 23 Jun 2008 16:15:05 -0700
Message-ID: <g3paoc$41v$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CDB224946
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jun 2008 01:20:08 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KAvKN-00039u-0s
	for alsa-devel@alsa-project.org; Mon, 23 Jun 2008 23:20:03 +0000
Received: from adsl-69-234-192-13.dsl.irvnca.pacbell.net ([69.234.192.13])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2008 23:20:03 +0000
Received: from w41ter by adsl-69-234-192-13.dsl.irvnca.pacbell.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2008 23:20:03 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi list,

I just replaced a mobo with an ECS K7VTA3 and I find that the
Headphones control is now controlling the master channel and the
Master control does nothing.

I tried 'modprobe via82xx ac97_quirk=hp_only' but that makes the
audio device unusable (although alsamixer still seems happy to set
the individual channels).  Any other quirks I should try?

Here is some hardware info:

ALSA sound/pci/via82xx.c:2409: via82xx: DXS white list for ESC K8 found

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
         Subsystem: Elitegroup Computer Systems Unknown device 1841
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin C routed to IRQ 5
         Region 0: I/O ports at dc00 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: VIA 82xx Audio
         Kernel modules: snd-via82xx

I'm running Linus' git kernel, current as of today, and alsa 1.0.16.
