From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000462]: Sound OK but w/o mixer
Date: Thu,  9 Sep 2004 04:46:45 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040909024645.E6A7514027@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 42BED2DC
	for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2004 04:46:46 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000462
======================================================================
Reported By:                equake
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     462
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Unstable
Kernel Version:             2.6.8
======================================================================
Date Submitted:             08-23-2004 02:13 CEST
Last Modified:              09-09-2004 04:46 CEST
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
 tiwai - 08-25-2004 19:58 CEST 
----------------------------------------------------------------------
It's a new AC97 codec from c-media.  Unfortunately there is no
proper datasheet with the register description.

But, c-media provided its own linux driver, and I could see some info
from the source code.

Could you try the attached patch?

----------------------------------------------------------------------
 equake - 08-27-2004 02:53 CEST 
----------------------------------------------------------------------
I've applyed the patch and now I've lost the sound completly. 
Seems that the mixer is always muted now (no error messages when trying to
play a sound).

----------------------------------------------------------------------
 equake - 08-27-2004 02:59 CEST 
----------------------------------------------------------------------
When I mute/unmutee the PCM channel I can hear a "click" on my speakers, so
I think that the volume is at level 0 and not muted.

----------------------------------------------------------------------
 tiwai - 08-27-2004 19:36 CEST 
----------------------------------------------------------------------
It seems that this chip doesn't have PCM volume as well as CM9739.
Only PCM mute is possible.

Anyway please attach /etc/asound.state after patch applied.

----------------------------------------------------------------------
 equake - 09-09-2004 04:46 CEST 
----------------------------------------------------------------------
Sorry about the delay. The file is attached.
Tks!

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-23-04 02:13 equake         New Bug                                      
08-23-04 02:13 equake         Distribution              => Debian Unstable 
08-23-04 02:13 equake         Kernel Version            => 2.6.8           
08-25-04 19:58 tiwai          Bugnote Added: 0001626                       
08-25-04 19:58 tiwai          File Added: cm9761-add.dif                    
08-27-04 02:53 equake         Bugnote Added: 0001640                       
08-27-04 02:59 equake         Bugnote Added: 0001641                       
08-27-04 19:36 tiwai          Bugnote Added: 0001646                       
09-09-04 04:46 equake         File Added: asound.state                     
09-09-04 04:46 equake         Bugnote Added: 0001743                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
