From: Manuel Naranjo <manuel@aircable.net>
Subject: Via vt8237 sometimes fails to load
Date: Mon, 13 Apr 2009 10:43:25 -0300
Message-ID: <49E3417D.30709@aircable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f132.google.com (mail-qy0-f132.google.com
	[209.85.221.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 303F11037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Apr 2009 15:43:35 +0200 (CEST)
Received: by qyk38 with SMTP id 38so3299164qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2009 06:43:34 -0700 (PDT)
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

Hello guys,

I have a KT880 based mobo made by MSI, I haven't used this computer for 
a while (a year or so) I remember that before the audio was working, 
even though sometimes it was initializated with noise and required me 
restarting alsa. Now it doesn't even load, and I get some weird errors 
in dmesg.

I've checked the wiki and the bug tracker but still couldn't find a 
solution.

This is lspci -vv -nn
00:11.5 Multimedia audio controller [0401]: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller [1106:3059] (rev 60)
        Subsystem: Micro-Star International Co., Ltd. Device [1462:0470]
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at a800 [size=256]
        Capabilities: <access denied>
        Kernel modules: snd-via82xx

And dmesg
ALSA /tmp/alsa/alsa-driver-1.0.19/pci/via82xx.c:581: codec_read: codec 0 
is not valid [0x1fc0000]
ALSA /tmp/alsa/alsa-driver-1.0.19/pci/via82xx.c:581: codec_read: codec 0 
is not valid [0x1fe0000]
ALSA /tmp/alsa/alsa-driver-1.0.19/pci/via82xx.c:523: codec_ready: codec 
0 is not ready [0x1000000]
ALSA /tmp/alsa/alsa-driver-1.0.19/pci/via82xx.c:523: codec_ready: codec 
0 is not ready [0x1000000]
ALSA /tmp/alsa/alsa-driver-1.0.19/pci/via82xx.c:581: codec_read: codec 0 
is not valid [0x1fc0000]
ALSA /tmp/alsa/alsa-driver-1.0.19/pci/via82xx.c:581: codec_read: codec 0 
is not valid [0x1fe0000]
ALSA /tmp/alsa/alsa-driver-1.0.19/pci/ac97/ac97_codec.c:2077: AC'97 0 
access is not valid [0xffffffff], removing mixer.
VIA 82xx Audio 0000:00:11.5: PCI INT C disabled
VIA 82xx Audio: probe of 0000:00:11.5 failed with error -5

Thanks,
Manuel
