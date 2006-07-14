From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002277]: sound available only after
	moving the volume slides in the sound mixers
Date: Fri, 14 Jul 2006 19:59:19 +0200
Message-ID: <345c9f5d1b46b955722bf352b8664331@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 26F4C13D
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Jul 2006 19:59:20 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2277> 
======================================================================
Reported By:                veli
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2277
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-12-2006 07:50 CEST
Last Modified:              07-14-2006 19:59 CEST
======================================================================
Summary:                    sound available only after moving the volume slides
in the sound mixers
Description: 
 2.6.15-26-686 #1 SMP PREEMPT Fri Jul 7 19:48:22 UTC 2006 i686 GNU/Linux

Loaded Modules --------------------------------------------
snd_maestro3           27780  4
snd_ac97_codec        100224  1 snd_maestro3
snd_ac97_bus            2400  1 snd_ac97_codec
snd_pcm_oss            56448  0
snd_mixer_oss          20544  1 snd_pcm_oss
snd_pcm                96708  5 snd_maestro3,snd_ac97_codec,snd_pcm_oss
snd_timer              26884  1 snd_pcm
snd_page_alloc         11304  1 snd_pcm
snd                    60004  12
snd_maestro3,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer

Modprobe Conf ---------------------------------------------
Warning: module config file does not exist
This means any kernel modules will not be auto loaded
See your linux distro docs on how to create this file

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).
0 [PCI            ]: Allegro - ESS Allegro PCI
                     ESS Allegro PCI at 0x7800, irq 9
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer
cat: /proc/asound/hwdep: No such file or directory
00-00: Allegro : Allegro : playback 2 : capture 1
cat: /proc/asound/seq/clients: No such file or directory

Dev Snd ---------------------------------------------------
controlC0  pcmC0D0c  pcmC0D0p  timer

CPU -------------------------------------------------------
model name      : Pentium III (Coppermine)
cpu MHz         : 662.353

RAM -------------------------------------------------------
MemTotal:       255520 kB
SwapTotal:      522072 kB

Hardware --------------------------------------------------
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
0000:00:02.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management
(rev 20)
0000:00:12.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1
(rev 10)


======================================================================

----------------------------------------------------------------------
 Raymond - 07-14-06 16:28 
----------------------------------------------------------------------
Post output of 'lspci -vn' of Multimedia audio controller

Is it an onboard sound or pci sound card ?

----------------------------------------------------------------------
 veli - 07-14-06 19:59 
----------------------------------------------------------------------
The sound card in onboard.

veliko@veliko-desktop:~$ lspci -vn
0000:00:00.0 0600: 1106:0691 (rev c4)
        Flags: bus master, medium devsel, latency 8
        Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: <available only to root>

0000:00:01.0 0604: 1106:8598
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: feb00000-febfffff
        Prefetchable memory behind bridge: f0000000-fe9fffff
        Capabilities: <available only to root>

0000:00:02.0 0601: 1106:0596 (rev 12)
        Flags: bus master, stepping, medium devsel, latency 0

0000:00:02.1 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, stepping, medium devsel, latency 32
        I/O ports at fff0 [size=16]

0000:00:02.2 0c03: 1106:3038 (rev 08)
        Subsystem: 0925:1234
        Flags: bus master, medium devsel, latency 22, IRQ 10
        I/O ports at fce0 [size=32]

0000:00:02.3 0600: 1106:3050 (rev 20)
        Flags: medium devsel

0000:00:0e.0 0780: 11c1:048c (rev 02)
        Subsystem: 11c1:044c
        Flags: bus master, medium devsel, latency 208, IRQ 9
        Memory at feaffe00 (32-bit, non-prefetchable) [size=256]
        I/O ports at 6c78 [size=8]
        I/O ports at 7000 [size=256]
        Capabilities: <available only to root>

0000:00:10.0 0200: 1106:3106 (rev 8b)
        Subsystem: 1186:1403
        Flags: bus master, stepping, medium devsel, latency 24, IRQ 10
        I/O ports at 7400 [size=256]
        Memory at feafff00 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

0000:00:12.0 0401: 125d:1988 (rev 10)
        Subsystem: 1014:017b
        Flags: bus master, medium devsel, latency 16, IRQ 9
        I/O ports at 7800 [size=256]
        Capabilities: <available only to root>

0000:01:00.0 0300: 5333:8a22 (rev 03)
        Subsystem: 105d:05af
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 11
        Memory at feb80000 (32-bit, non-prefetchable) [size=512K]
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at f8000000 [disabled] [size=64K]
        Capabilities: <available only to root>

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-12-06 07:50 veli           New Issue                                    
07-13-06 16:29 Raymond        Note Added: 0010994                          
07-13-06 20:25 veli           Note Added: 0010995                          
07-14-06 16:28 Raymond        Note Added: 0011000                          
07-14-06 19:59 veli           Note Added: 0011002                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
