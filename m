From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000059]: On au8820 left and right channels are swapped
Date: Fri, 26 Aug 2005 15:12:15 +0200
Message-ID: <59a57dab91cb705c97777046b707c0c3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E2AFB1E8
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2005 15:12:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=59> 
======================================================================
Reported By:                kernel_bug
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   59
Category:                   PCI - au88x0
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     confirmed
Distribution:               
Kernel Version:             2.6.2
======================================================================
Date Submitted:             02-13-2004 11:40 CET
Last Modified:              08-26-2005 15:12 CEST
======================================================================
Summary:                    On au8820 left and right channels are swapped
Description: 
In most cases, left and right channels are swapped. But in approx. 5% cases
all OK. Looks like the matter is somewhere in byte alignment...
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000949 Randomly, left and right tracks are swaped
======================================================================

----------------------------------------------------------------------
 Raymond - 08-26-05 14:50 
----------------------------------------------------------------------
Try the speaker-test in alsa-utils

speaker-test -D hw:0,0 -c 2


Please post the output of

lspci -vvn

cat /proc/asound/au8820/codec97#0/ac97#0-0+regs

----------------------------------------------------------------------
 kernel_bug - 08-26-05 15:12 
----------------------------------------------------------------------
> Try the speaker-test in alsa-utils
> speaker-test -D hw:0,0 -c 2
Just after `modprobe snd-au8820` and `alsactl restore`:
=================================
$./speaker-test -D hw:0,0 -c 2

speaker-test 1.0.6

Playback device is hw:0,0
Stream parameters are 48000Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2 to 16384
Period size range from 1 to 1024
Buffer time size 2525
To choose buffer_size = 2520
To choose period_size = 315
was set period_size = 256
was set buffer_size = 2560
  - Front Left
  - Front Right
  - Front Left
  - Front Right
=================================
Channels are swapped (e.g., when speaker-test says 'Front left' I hear
sound from right speaker). Mixer works correctly.

Running speaker-test again:
=================================
$ ./speaker-test -D hw:0,0 -c 2

speaker-test 1.0.6

Playback device is hw:0,0
Stream parameters are 48000Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2 to 16384
Period size range from 1 to 1024
Buffer time size 2525
To choose buffer_size = 2520
To choose period_size = 315
was set period_size = 256
was set buffer_size = 2560
  - Front Left
  - Front Right
  - Front Left
=================================
This time (and all consequent) all works fine.



> Please post the output of
> lspci -vvn
# lspci -vvn
00:00.0 Class 0600: 8086:2570 (rev 02)
        Subsystem: 1458:2570
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] Vendor Specific Information
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x4

00:01.0 Class 0604: 8086:2571 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f4000000-f5ffffff
        Prefetchable memory behind bridge: f0000000-f3ffffff
        Secondary status: 66Mhz+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 Class 0c03: 8086:24c2 (rev 02)
        Subsystem: 1458:24c2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 185
        Region 4: I/O ports at b800 [size=32]

00:1d.1 Class 0c03: 8086:24c4 (rev 02)
        Subsystem: 1458:24c2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 193
        Region 4: I/O ports at b000 [size=32]

00:1d.2 Class 0c03: 8086:24c7 (rev 02)
        Subsystem: 1458:24c2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 169
        Region 4: I/O ports at b400 [size=32]

00:1d.7 Class 0c03: 8086:24cd (rev 02) (prog-if 20)
        Subsystem: 1458:5006
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 177
        Region 0: Memory at f6100000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 Class 0604: 8086:244e (rev 82)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: f6000000-f60fffff
        Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 Class 0601: 8086:24c0 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 Class 0101: 8086:24cb (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: 1458:24c2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at f000 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 Class 0c05: 8086:24c3 (rev 02)
        Subsystem: 1458:24c2
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1400 [size=32]

00:1f.5 Class 0401: 8086:24c5 (rev 02)
        Subsystem: 1458:a002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 217
        Region 0: I/O ports at c000 [size=256]
        Region 1: I/O ports at c400 [size=64]
        Region 2: Memory at f6101000 (32-bit, non-prefetchable)
[size=512]
        Region 3: Memory at f6102000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 Class 0300: 1002:5446
        Subsystem: 1002:0008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at f5000000 (32-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x4
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.0 Class 0200: 1186:1300 (rev 10)
        Subsystem: 1186:1301
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 201
        Region 0: I/O ports at a000 [size=256]
        Region 1: Memory at f6020000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 Class 0401: 12eb:0001 (rev 02)
        Subsystem: 12eb:0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 3000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 209
        Region 0: Memory at f6000000 (32-bit, non-prefetchable)
[size=128K]
        Region 1: I/O ports at a400 [size=8]
        Region 2: I/O ports at a800 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


> cat /proc/asound/au8820/codec97#0/ac97#0-0+regs
Just after loading module:
$ cat /proc/asound/au8820/codec97#0/ac97#0-0+regs
0:00 = 0140
0:02 = 0000
0:04 = 0000
0:06 = 003f
0:08 = 0000
0:0a = 001e
0:0c = 001f
0:0e = 005f
0:10 = 0000
0:12 = 1f1f
0:14 = 1f1f
0:16 = 1f1f
0:18 = 1111
0:1a = 0606
0:1c = 8000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0000
0:2a = 0000
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 574d
0:7e = 4c00

After running speaker-test first time:

$ cat /proc/asound/au8820/codec97#0/ac97#0-0+regs
0:00 = 0140
0:02 = 0000
0:04 = 0000
0:06 = 003f
0:08 = 0000
0:0a = 001e
0:0c = 001f
0:0e = 005f
0:10 = 0000
0:12 = 1f1f
0:14 = 1f1f
0:16 = 1f1f
0:18 = 1111
0:1a = 0606
0:1c = 8000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0000
0:2a = 0000
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 574d
0:7e = 4c00

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 11:40 kernel_bug     New Issue                                    
02-21-04 15:40 kernel_bug     Note Added: 0000280                          
03-02-04 02:56 Tim            Note Added: 0000429                          
04-09-04 11:54 kernel_bug     Note Added: 0000774                          
04-09-04 18:35 mjander        Note Added: 0000777                          
04-17-04 18:59 mjander        Status                   assigned => closed  
04-17-04 18:59 mjander        Note Added: 0000849                          
04-26-04 17:04 kernel_bug     Status                   closed => feedback  
04-26-04 17:04 kernel_bug     Resolution               open => reopened    
04-26-04 17:04 kernel_bug     Note Added: 0000953                          
04-26-04 23:27 mjander        Note Added: 0000956                          
03-10-05 15:31 jdthood        Note Added: 0003866                          
03-10-05 16:44 mjander        Note Added: 0003867                          
03-10-05 21:25 kernel_bug     Note Added: 0003873                          
03-22-05 22:33 jdthood        Relationship added       related to 0000949  
03-28-05 04:27 jdthood        Note Added: 0004235                          
03-28-05 04:27 jdthood        Status                   feedback => assigned
03-28-05 04:29 jdthood        Status                   assigned => confirmed
08-26-05 14:50 Raymond        Note Added: 0005951                          
08-26-05 15:12 kernel_bug     Note Added: 0005955                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
