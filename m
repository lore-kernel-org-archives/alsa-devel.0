From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001316]: can't run mixer to adjusting volumes / no sound
Date: Tue, 20 Dec 2005 01:09:53 +0100
Message-ID: <2668149cb68177a2163d31894655838c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0C87419C
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 01:09:54 +0100 (MET)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               Debian stable
Kernel Version:             2.6.13-rc5-git3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-06-2005 11:11 CEST
Last Modified:              12-20-2005 01:09 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001429 hda_codec: Unknown model for ALC880
======================================================================

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

----------------------------------------------------------------------
 rlrevell - 11-23-05 20:33 
----------------------------------------------------------------------
Possibly fixed in CVS.  See the patch from bug #1563.

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
09-26-05 19:14 rlrevell       Relationship added       duplicate of 0001429
11-23-05 20:33 rlrevell       Note Added: 0006829                          
12-20-05 01:09 rlrevell       Status                   assigned => resolved
12-20-05 01:09 rlrevell       Resolution               open => fixed       
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
