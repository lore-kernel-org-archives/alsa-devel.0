From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001316]: can't run mixer to adjusting volumes / no sound
Date: Mon, 5 Sep 2005 13:48:53 +0200
Message-ID: <d7218d2a52029b602a44335bdd76ede2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8142419D
	for <alsa-devel@alsa-project.org>; Mon,  5 Sep 2005 13:48:53 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1316> 
======================================================================
Reported By:                boris
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1316
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian stable
Kernel Version:             2.6.13-rc5-git3
======================================================================
Date Submitted:             08-06-2005 11:11 CEST
Last Modified:              09-05-2005 13:48 CEST
======================================================================
Summary:                    can't run mixer to adjusting volumes / no sound
Description: 
When I try to run alsamixer it fails with:
alsamixer: function snd_mixer_load failed: Invalid argument

running ogg123 seems to work ...

running aumix over oss-emu only shows a view controls 
which have no effect -> no sound

This happened with 2.6.13-rc[3,5]-git?.
2.6.12-rc5-git8 (for example) works. 

HW: Aopen 915gmm-hfs.

======================================================================

----------------------------------------------------------------------
 boris - 08-17-05 15:39 
----------------------------------------------------------------------
With cvs from 15.08.05 (kernel 2.6.13-rc6) problem is gone.

----------------------------------------------------------------------
 imre - 09-05-05 13:48 
----------------------------------------------------------------------
I've got the same problem, no sound.
Kernel version: 2.6.13-git4
alsa version: v1.0.10rc1
hardware: Clevo M400A
root@eridanus:~# alsamixer 

alsamixer: function snd_mixer_load failed: Invalid argument

root@eridanus:~# cat /dev/snd/controlC0
cat: /dev/snd/controlC0: File descriptor in bad state
root@eridanus:~# 

lspci -vvn

0000:00:1b.0 0403: 8086:2668 (rev 04)
        Subsystem: 1558:04a0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at c0000000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] #10 [0091]

dmesg:
ALSA sound/pci/hda/hda_intel.c:1074: azx_pcm_prepare: bufsize=0xc030,
fragsize=0x6018, format=0x11
ALSA sound/pci/hda/hda_codec.c:560: hda_codec_setup_stream: NID=0x7,
stream=0x1, channel=0, format=0x11
ALSA sound/pci/hda/hda_codec.c:560: hda_codec_setup_stream: NID=0x7,
stream=0x0, channel=0, format=0x0
ALSA sound/pci/hda/hda_intel.c:1074: azx_pcm_prepare: bufsize=0x10000,
fragsize=0x1000, format=0x4011
ALSA sound/pci/hda/hda_codec.c:560: hda_codec_setup_stream: NID=0x6,
stream=0x5, channel=0, format=0x4011
ALSA sound/pci/hda/hda_codec.c:560: hda_codec_setup_stream: NID=0xfffe,
stream=0x5, channel=0, format=0x4011
ALSA sound/pci/hda/hda_codec.c:560: hda_codec_setup_stream: NID=0x1,
stream=0x5, channel=0, format=0x4011
ALSA sound/pci/hda/hda_codec.c:560: hda_codec_setup_stream: NID=0xffff,
stream=0x5, channel=0, format=0x4011
hda_codec: num_steps = 0 for NID=0xb
ALSA sound/pci/hda/hda_codec.c:560: hda_codec_setup_stream: NID=0xfffe,
stream=0x0, channel=0, format=0x0
ALSA sound/pci/hda/hda_codec.c:560: hda_codec_setup_stream: NID=0x1,
stream=0x0, channel=0, format=0x0
ALSA sound/pci/hda/hda_codec.c:560: hda_codec_setup_stream: NID=0xffff,
stream=0x0, channel=0, format=0x0
ALSA sound/pci/hda/hda_codec.c:560: hda_codec_setup_stream: NID=0x6,
stream=0x0, channel=0, format=0x0
hda_codec: num_steps = 0 for NID=0xb

The kernel version 2.6.12-rc5-git8 works, with a low quality sound.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-06-05 11:11 boris          New Issue                                    
08-06-05 11:11 boris          Distribution              => Debian stable   
08-06-05 11:11 boris          Kernel Version            => 2.6.13-rc5-git3 
08-17-05 15:39 boris          Note Added: 0005837                          
08-18-05 10:41 pshou          Issue Monitored: pshou                       
09-05-05 13:18 imre           Issue Monitored: imre                        
09-05-05 13:48 imre           Note Added: 0006040                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
