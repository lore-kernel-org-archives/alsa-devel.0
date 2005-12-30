From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000462]: Sound OK but w/o mixer
Date: Fri, 30 Dec 2005 05:25:10 +0100
Message-ID: <a3053e9907d369c79a044c7171ff6e07@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ADA5D193
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:25:10 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=462> 
======================================================================
Reported By:                equake
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   462
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian Unstable
Kernel Version:             2.6.8
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-23-2004 02:13 CEST
Last Modified:              12-30-2005 05:25 CET
======================================================================
Summary:                    Sound OK but w/o mixer
Description: 
I have a Soyo SY-KT600 Dragon Plus v2.0 mother board, w/ the VIA 8233
chipset.
When I load the drivers, I can hear sound but everything that I change on
alsamixergui simply have no effect. I can set Master Volume to ZERO and I
still have the sound, at the same volume.
Any idea?
I've tried ac97_quirk from -1 to 4 and nothing.

# lspci -vv
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: Elitegroup Computer Systems: Unknown device a101
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 193
        Region 0: I/O ports at c000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

# cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: C-Media Electronics id 83

Revision         : 0x01
Compat. Class    : 0x03
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 AMAP LDAC SDAC CDAC DSA=0 DRA
Extended status  : SPCV LDAC SDAC CDAC


# cat /proc/asound/card0/codec97#0/ac97#0-0+regs
0:00 = 0000
0:02 = 1a1a
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 801e
0:0c = 0000
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 0000
0:16 = 9f1f
0:18 = 0808
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0bc2
0:2a = 05f0
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 8080
0:38 = 8080
0:3a = 2000
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
0:5c = 0004
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 3038
0:66 = 0016
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0030
0:74 = c000
0:76 = 393c
0:78 = 0000
0:7a = 0000
0:7c = 434d
0:7e = 4983

======================================================================

----------------------------------------------------------------------
 jdthood - 04-09-05 14:28 
----------------------------------------------------------------------
Submitter: Has this bug been fixed now?

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:25 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-23-04 02:13 equake         New Issue                                    
08-23-04 02:13 equake         Distribution              => Debian Unstable 
08-23-04 02:13 equake         Kernel Version            => 2.6.8           
08-25-04 19:58 tiwai          Note Added: 0001626                          
08-25-04 19:58 tiwai          File Added: cm9761-add.dif                    
08-27-04 02:53 equake         Note Added: 0001640                          
08-27-04 02:59 equake         Note Added: 0001641                          
08-27-04 19:36 tiwai          Note Added: 0001646                          
09-09-04 04:46 equake         File Added: asound.state                     
09-09-04 04:46 equake         Note Added: 0001743                          
04-09-05 14:28 jdthood        Note Added: 0004398                          
04-09-05 14:28 jdthood        Status                   new => feedback     
12-30-05 05:25 rlrevell       Status                   feedback => closed  
12-30-05 05:25 rlrevell       Note Added: 0007245                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
