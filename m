From: Oscon <oscon@mail.datanet.hu>
Subject: unknown card works
Date: Sat, 30 May 2009 14:36:45 +0200
Message-ID: <200905301436.46006.oscon@mail.datanet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx8.datanet.hu (mx8.datanet.hu [194.149.13.161])
	by alsa0.perex.cz (Postfix) with ESMTP id 102971037F4
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 14:36:57 +0200 (CEST)
Received: from oz466ebebb.adsl.datanet.hu (oz466ebebb.adsl.datanet.hu
	[91.120.77.89]) by mx8.datanet.hu (DataNet) with ESMTP id 698FDEBF04
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 14:36:55 +0200 (CEST)
Content-Disposition: inline
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

Hello!

I have got a "retro" :) PCI analog tuner card.

id: unknown card 0x878-0x144f:0x3000

board name:         Askey Computer Corp. MagicTView'99 

digital audio rate: 48000 Hz (?)

------------------

Other informations: / dmesg, modules.conf, lspci, system information (version 
of kernel+alsa-utils)

dmesg:

May 30 14:19:51 osconsfortress kernel: unknown card 0x878-0x144f:0x3000
May 30 14:19:51 osconsfortress kernel: please mail id, board name, and, if it 
works, the correct digital_rate option to <alsa-devel@alsa-project.org>
May 30 14:19:51 osconsfortress kernel: Bt87x 0000:03:06.1: PCI INT A -> GSI 21 
(level, low) -> IRQ 21
May 30 14:19:51 osconsfortress kernel: bt87x0: Using board 0, analog, digital 
(rate 48000 Hz)

--------------------

modules.conf:

options snd-bt87x index=2 enable=1 load_all=1 digital_rate=48000

--------------------

lspci -vvv

03:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
02)
        Subsystem: Askey Computer Corp. MagicTView CPH060 - Audio
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at f8ffe000 (32-bit, prefetchable) [size=4K]
        Kernel driver in use: Bt87x

---------------------------
System information:

Debian Lenny

kernel:
root@osconsfortress:~# uname -a
Linux osconsfortress 2.6.27-limbo #1 SMP Thu Mar 5 11:18:25 CET 2009 i686 
GNU/Linux
root@osconsfortress:~#

(based on 2.6.27.10+grsec+layer7)

root@osconsfortress:~# uptime
 14:32:12 up 48 days, 19:41,  3 users,  load average: 0.28, 0.30, 0.35

alsa-base :Version: 1.0.17.dfsg-4

--------------------

Cheers,
Oscon
