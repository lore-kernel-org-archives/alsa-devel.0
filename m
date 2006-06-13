From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001389]: snd-ens1371 / es1938 Creative
	Ectiva silent playout + new line-in capture failure
Date: Tue, 13 Jun 2006 16:51:08 +0200
Message-ID: <c1529cf9994303cb442798e09ed76c9f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BFD4B160
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jun 2006 16:51:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1389> 
======================================================================
Reported By:                wood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1389
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Modified Redhat 9.0
Kernel Version:             2.4.24 self compiled
======================================================================
Date Submitted:             09-01-2005 20:32 CEST
Last Modified:              06-13-2006 16:51 CEST
======================================================================
Summary:                    snd-ens1371 / es1938 Creative Ectiva silent playout
+ new line-in capture failure
Description: 
Soundcard: Creative Soundblaster PCI (Ectiva) Model:CT4730
Chip Label: Creative EV1938

Platform: Stable 2.4.24 Linux kernel on VIA MiniITX ME6000/M10000
          w/ multiple soundcards. ALSA compiled from source
          works with VIA motherboard Audio
          and some other Creative PCI soundcards. Need a stable ALSA
driver
          for this soundcard.

Problem:
The snd-ens1371 module loads correctly as 3rd sound device (First audio
device is VIA 8235 from motherboard, 2nd is PCSP).

Alsamixer -c 2 shows a reasonable set of
controls. Playout either with OSS emulation (play) or ALSA player
(aplay) plays WAV files but only silence for both 1.0.9 and 1.0.10rc1
releases.  
On ALSA 1.0.9 codebase,the Master Volume does not always show in
alsamixer. 
In 1.0.10rc1 it does always show.
ALSO:
  On ALSA 1.0.9 code, the Line-In capture works under both OSS Emulation
and with ALSA arecord.
On the latest development release ALSA 1.0.10rc1, the Line-In
capture no longer works. So a new problem has been introduced from .9 to
.10.


Other info:
Native OSS driver es1371 works fine with this card. But I want to switch
to ALSA.

Earlier model Creative PCI128, Model CT4750 loads snd-ens1371 and
works fine with both tested ALSA releases using same platform
configuration.

Audigy 2 Value also works fine using snd-emu10k1 with same configuration
(I included this card info to rule out basic config problems).

======================================================================

----------------------------------------------------------------------
 wood - 06-13-06 16:26 
----------------------------------------------------------------------
Here are the two dumps. NOTE: This is on the system with
the modified 1.0.11rc3 where the sound card works due to 
adding the "special_card" detection hack. If you need these
two dumps from a system using the broken code, let me know.


root@ct4730dev:  cat /proc/asound/card2/codec97#0/ac97#0-0+regs
0:00 = ffff
0:02 = 0140
0:04 = 0909
0:06 = 8000
0:08 = 000a
0:0a = 0000
0:0c = 9f5f
0:0e = 000a
0:10 = 805f
0:12 = 9f1f
0:14 = 1515
0:16 = 0a0a
0:18 = 0b0b
0:1a = 0101
0:1c = 1414
0:1e = 0b0b
0:20 = ffff
0:22 = 0000
0:24 = 0000
0:26 = 0000
0:28 = 000f
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
0:7c = 8384
0:7e = 8384


root@ct4730dev: : lspci -vn
00:00.0 Class 0600: 1106:3123
        Subsystem: 1106:aa01
        Flags: bus master, 66Mhz, medium devsel, latency 8
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 Class 0604: 1106:b091
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d8000000-dbffffff
        Capabilities: [80] Power Management version 2

00:0d.0 Class 0c00: 1106:3044 (rev 80) (prog-if 10)
        Subsystem: 1106:3044
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at de000000 (32-bit, non-prefetchable) [size=2K]
        I/O ports at c000 [size=128]
        Capabilities: [50] Power Management version 2

00:10.0 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1106:3038
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1106:3038
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1106:3038
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 Class 0c03: 1106:3104 (rev 82) (prog-if 20)
        Subsystem: 1106:3104
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at de001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:11.0 Class 0601: 1106:3177
        Subsystem: 1106:aa01
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: 1106:aa01
        Flags: bus master, medium devsel, latency 32
        I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2

00:11.5 Class 0401: 1106:3059 (rev 50)
        Subsystem: 1106:aa01
        Flags: medium devsel, IRQ 12
        I/O ports at d400 [size=256]
        Capabilities: [c0] Power Management version 2

00:12.0 Class 0200: 1106:3065 (rev 74)
        Subsystem: 1106:0102
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at dc00 [size=256]
        Memory at de002000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

00:14.0 Class 0401: 1102:8938
        Subsystem: 1102:5938
        Flags: bus master, slow devsel, latency 32, IRQ 10
        I/O ports at e000 [size=64]
        I/O ports at e400 [size=32]
        Capabilities: [dc] Power Management version 2

01:00.0 Class 0300: 1106:3122 (rev 03)
        Subsystem: 1106:3122
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
        Capabilities: [70] AGP version 2.0

----------------------------------------------------------------------
 Raymond - 06-13-06 16:51 
----------------------------------------------------------------------
Do your CT4750 have 4 channels codec ?

Do your CT4730 have 2 channels codec ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-01-05 20:32 wood           New Issue                                    
09-01-05 20:32 wood           Distribution              => Modified Redhat 9.0
09-01-05 20:32 wood           Kernel Version            => 2.4.24 self compiled
06-13-06 05:06 Raymond        Note Added: 0010186                          
06-13-06 06:43 wood           Note Added: 0010188                          
06-13-06 07:05 Raymond        Note Added: 0010189                          
06-13-06 07:28 Raymond        Note Edited: 0010189                         
06-13-06 16:26 wood           Note Added: 0010194                          
06-13-06 16:51 Raymond        Note Added: 0010196                          
======================================================================
