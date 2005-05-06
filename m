From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001078]: intel8x0 does not work on any (?) 2.6 kernel
Date: Fri, 6 May 2005 08:50:29 +0200
Message-ID: <c57294566a9ca5bdd1864dd28b928013@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 00C161E3
	for <alsa-devel@alsa-project.org>; Fri,  6 May 2005 08:50:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1078> 
======================================================================
Reported By:                columbo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1078
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware Linux 10.1
Kernel Version:             2.6.11.7
======================================================================
Date Submitted:             04-26-2005 21:29 CEST
Last Modified:              05-06-2005 08:50 CEST
======================================================================
Summary:                    intel8x0 does not work on any (?) 2.6 kernel
Description: 
After compilation of ALSA drivers, libs, utilities, and after alsaconf ALSA
modules loads correctly, they are visible in lsmod and so on, but all
programs can't see sound card, /dev/dsp and so on. With kernels 2.4.x
everything is OK.
======================================================================

----------------------------------------------------------------------
 gem7 - 05-06-05 08:50 
----------------------------------------------------------------------
I have an HP pavilion zd7000.  It worked fine up to Linux 2.6.8.1 and Alsa
1.0.4.
After that, all the way up to 2.6.12rc3 and ALSA 1.0.9rc3 no luck.  So I
partially confirm this bug report.

Here are some details:

00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 006a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at 1400 [size=256]
        Region 1: I/O ports at 1c80 [size=64]
        Region 2: Memory at d0000c00 (32-bit, non-prefetchable)
[size=512]
        Region 3: Memory at d0000800 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:1f.6 Modem: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Modem
Controller (rev 02) (prog-if 00 [Generic])
        Subsystem: Hewlett-Packard Company: Unknown device 006a
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at 1800 [size=256]
        Region 1: I/O ports at 1c00 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+


No /etc/asound.rc


When it worked I had two cards in /proc/asound/cards, one for the modem
and one for the sound card.  Now this is all I get there:

0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with unknown codec at 0xd0000c00, irq 17


# cat /proc/asound/card0/codec97#0/ac97#0-0

0-0/0: Conexant id 30

Revision         : 0xff
Compat. Class    : 0x1f
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff
Capabilities     : -reserved1- -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+0dB]
POP path         : post 3D
Sim. stereo      : on
3D enhancement   : on
Loudness         : on
Mono output      : Mic
Mic select       : Mic2
ADC/DAC loopback : on
Extended ID      : codec=3 rev=3 AMAP LDAC SDAC CDAC DSA=3 VRM SPDIF DRA
VRA
Extended status  : PRL PRK PRJ PRI SPCV MADC LDAC SDAC CDAC SPDIF=10/11
VRM SPDIF DRA VRA
PCM front DAC    : 65535Hz
PCM Surr DAC     : 65535Hz
PCM LFE DAC      : 65535Hz
PCM ADC          : 65535Hz
PCM MIC ADC      : 65535Hz
SPDIF Control    : PRO Non-audio Preemph50/15 Category=0x7f Generation=1
Rate=32kHz DRS Validity

                    Gain     Inverted  Buffer delay  Location
Master Out       : -10.5 dBV    X      31/fs         NC/unused
AUX Out          : -10.5 dBV    X      31/fs         NC/unused
Center/LFE Out   : -10.5 dBV    X      31/fs         NC/unused
SPDIF Out        : -10.5 dBV    X      31/fs         NC/unused
Phone In         : -10.5 dBV    X      31/fs         NC/unused
Mic 1            : -10.5 dBV    X      31/fs         NC/unused
Mic 2            : -10.5 dBV    X      31/fs         NC/unused
Line In          : -10.5 dBV    X      31/fs         NC/unused
CD In            : -10.5 dBV    X      31/fs         NC/unused
Video In         : -10.5 dBV    X      31/fs         NC/unused
Aux In           : -10.5 dBV    X      31/fs         NC/unused
Mono Out         : -10.5 dBV    X      31/fs         NC/unused
Extended modem ID: codec=3 CID2 CID1 HSET LIN2 LIN1
Modem status     : GPIO MREF ADC1 DAC1 ADC2 DAC2 HADC HDAC PRA(GPIO)
PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2) PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 65535Hz
Line2 rate       : 65535Hz
Headset rate     : 65535Hz

# cat /proc/asound/card0/codec97/ac97#0-0+regs
0:00 = ffff
0:02 = ffff
0:04 = ffff
0:06 = ffff
0:08 = ffff
0:0a = ffff
0:0c = ffff
0:0e = ffff
0:10 = ffff
0:12 = ffff
0:14 = ffff
0:16 = ffff
0:18 = ffff
0:1a = ffff
0:1c = ffff
0:1e = ffff
0:20 = ffff
0:22 = ffff
0:24 = ffff
0:26 = ffff
0:28 = ffff
0:2a = ffff
0:2c = ffff
0:2e = ffff
0:30 = ffff
0:32 = ffff
0:34 = ffff
0:36 = ffff
0:38 = ffff
0:3a = ffff
0:3c = ffff
0:3e = ffff
0:40 = ffff
0:42 = ffff
0:44 = ffff
0:46 = ffff
0:48 = ffff
0:4a = ffff
0:4c = ffff
0:4e = ffff
0:50 = ffff
0:52 = ffff
0:54 = ffff
0:56 = ffff
0:58 = ffff
0:5a = ffff
0:5c = ffff
0:5e = ffff
0:60 = ffff
0:62 = ffff
0:64 = ffff
0:66 = ffff
0:68 = ffff
0:6a = ffff
0:6c = ffff
0:6e = ffff
0:70 = ffff
0:72 = ffff
0:74 = ffff
0:76 = ffff
0:78 = ffff
0:7a = ffff
0:7c = ffff
0:7e = ffff

Here is what I get in the system logs:

May  4 09:50:16 satchel kernel: ALSA
/usrlocal/src/ALSA/alsa-driver-1.0.9rc3/pci/../alsa-kernel/pci/intel8x0m.c:978:
Unable to initialize codec
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
May  4 09:50:16 satchel kernel: Intel ICH Modem: probe of 0000:00:1f.6
failed wi
th error -13
May  4 09:50:29 satchel kernel: ALSA /usr/local/src/ALSA/alsa-driver-1
.0.9rc3/pci/intel8x0.c:601: codec_write 0: semaphore is not ready for
register 0
x2
May  4 09:50:29 satchel kernel: ALSA /usr/local/src/ALSA/alsa-driver-1
.0.9rc3/pci/intel8x0.c:601: codec_write 0: semaphore is not ready for
register 0
x4


Someone suggested that I add intel8x0m to /etc/hotplug/blacklist and that
did nothing.  I also tried deleting intel8x0m and manually loing intel8x0
and intel8x0m in different order to no effect.

Anything else I can try?

RGDA
GARY

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-05 21:29 columbo        New Issue                                    
04-26-05 21:29 columbo        Distribution              => Slackware Linux 10.1
04-26-05 21:29 columbo        Kernel Version            => 2.6.11.7        
04-29-05 21:06 columbo        Issue Monitored: columbo                     
05-06-05 08:50 gem7           Note Added: 0004590                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
