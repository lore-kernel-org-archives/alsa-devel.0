From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001761]: sound doesn't work anymore, even after running `alsaconf`
Date: Thu, 19 Jan 2006 03:58:02 +0100
Message-ID: <1e4a93172007f1755a96526b2b19a9a0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A249816A
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 03:58:02 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1761> 
======================================================================
Reported By:                redwood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1761
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               compiled from sources
Kernel Version:             2.6.15, 2.6.15.1
======================================================================
Date Submitted:             01-19-2006 03:58 CET
Last Modified:              01-19-2006 03:58 CET
======================================================================
Summary:                    sound doesn't work anymore, even after running
`alsaconf`
Description: 
I have an ASUSTeK Computer Inc. A7V8X motherboard with AMD 2800+ Athlon XP
with integrated sound and also a Turtle Beach Santa Cruz pci sound card.
Both cards have always worked. Now after upgrading to latest 2.6.15 kernel

and alsa-1.0.10 I no longer have any sound.

`lspci -vv` reports:
00:0d.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: Voyetra Technologies Unknown device 3307
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (1000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at dd800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: Memory at dd000000 (32-bit, non-prefetchable) [size=2M]

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: ASUSTeK Computer Inc. Unknown device 810d
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 20
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


My /etc/modprobe.conf :
alias snd-card-0 snd-cs46xx
alias sound-slot-0 snd-cs46xx
alias snd-card-1 snd-via82xx
alias sound-slot-1 snd-via82xx

# ls /proc/asound/
CS46xx  V8237  card0  card1  cards  devices  modules  oss  pcm  seq 
timers  version


dmesg reports the following error for snd_via82xx:
PCI: Via IRQ fixup for 0000:00:11.5, from 0 to 4
PCI: Setting latency timer of device 0000:00:11.5 to 64
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]

Even after I unload snd_via82xx and snd_cs46xx,
modprobe -r snd_via82xx; modprobe -r snd_cs46xx
and then reload snd_cs46xx I still have no sound from my Turtle Beach
sound card.

# lsmod|grep snd
snd_via82xx            21144  0
snd_mpu401_uart         5376  1 snd_via82xx
snd_cs46xx             73672  0
snd_rawmidi            18208  2 snd_mpu401_uart,snd_cs46xx
snd_seq_device          6412  1 snd_rawmidi
snd_ac97_codec         79264  2 snd_via82xx,snd_cs46xx
snd_ac97_bus            1920  1 snd_ac97_codec
snd_pcm_oss            41504  0
snd_mixer_oss          14336  1 snd_pcm_oss
snd_pcm                68360  4
snd_via82xx,snd_cs46xx,snd_ac97_codec,snd_pcm_oss
snd_timer              18308  1 snd_pcm
snd                    40932  10
snd_via82xx,snd_mpu401_uart,snd_cs46xx,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               7008  1 snd
snd_page_alloc          7560  3 snd_via82xx,snd_cs46xx,snd_pcm

# modprobe -l |grep snd
/lib/modules/2.6.15.1/kernel/sound/pci/snd-via82xx.ko
/lib/modules/2.6.15.1/kernel/sound/pci/snd-intel8x0.ko
/lib/modules/2.6.15.1/kernel/sound/pci/cs46xx/snd-cs46xx.ko
/lib/modules/2.6.15.1/kernel/sound/pci/ac97/snd-ac97-codec.ko
/lib/modules/2.6.15.1/kernel/sound/pci/ac97/snd-ac97-bus.ko
/lib/modules/2.6.15.1/kernel/sound/drivers/snd-virmidi.ko
/lib/modules/2.6.15.1/kernel/sound/drivers/snd-serial-u16550.ko
/lib/modules/2.6.15.1/kernel/sound/drivers/snd-mtpav.ko
/lib/modules/2.6.15.1/kernel/sound/drivers/mpu401/snd-mpu401.ko
/lib/modules/2.6.15.1/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko
/lib/modules/2.6.15.1/kernel/sound/core/snd.ko
/lib/modules/2.6.15.1/kernel/sound/core/snd-timer.ko
/lib/modules/2.6.15.1/kernel/sound/core/snd-rtctimer.ko
/lib/modules/2.6.15.1/kernel/sound/core/snd-rawmidi.ko
/lib/modules/2.6.15.1/kernel/sound/core/snd-pcm.ko
/lib/modules/2.6.15.1/kernel/sound/core/snd-page-alloc.ko
/lib/modules/2.6.15.1/kernel/sound/core/seq/snd-seq.ko
/lib/modules/2.6.15.1/kernel/sound/core/seq/snd-seq-virmidi.ko
/lib/modules/2.6.15.1/kernel/sound/core/seq/snd-seq-midi.ko
/lib/modules/2.6.15.1/kernel/sound/core/seq/snd-seq-midi-event.ko
/lib/modules/2.6.15.1/kernel/sound/core/seq/snd-seq-dummy.ko
/lib/modules/2.6.15.1/kernel/sound/core/seq/snd-seq-device.ko
/lib/modules/2.6.15.1/kernel/sound/core/seq/oss/snd-seq-oss.ko
/lib/modules/2.6.15.1/kernel/sound/core/oss/snd-pcm-oss.ko
/lib/modules/2.6.15.1/kernel/sound/core/oss/snd-mixer-oss.ko


YES, I've run `alsamixer 0; alsamixer 1` and unmuted the appropriate
channels
and set the volume. But still no sound.


This is the first time I've never had any sound on this computer.
Any ideas would be appreciated.
If there's some information you need which I've not provided
tell me how to get it and I'll send it to you.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-19-06 03:58 redwood        New Issue                                    
01-19-06 03:58 redwood        Distribution              => compiled from sources
01-19-06 03:58 redwood        Kernel Version            => 2.6.15, 2.6.15.1
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
