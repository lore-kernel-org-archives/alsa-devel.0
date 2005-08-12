From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001176]: problem with alsa-driver and asus m5a notebook
Date: Fri, 12 Aug 2005 18:45:26 +0200
Message-ID: <089c12a40df1b14543200af25ad8711d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 485601E7
	for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2005 18:45:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1176> 
======================================================================
Reported By:                Ballbreaker
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1176
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.12-rc5
======================================================================
Date Submitted:             06-09-2005 13:44 CEST
Last Modified:              08-12-2005 18:45 CEST
======================================================================
Summary:                    problem with alsa-driver and asus m5a notebook
Description: 
I use gentoo-linux on an asus m5a notebook. Installation of alsa-driver
works without any error messages. xmms, aplay etc. play files, but i can't
hear anything. alsa-mixer shows me all the mixer-controls. I didn't forget
to unmute, and with windows sound is working fine - so i think there is a
problem with the alsa-driver and this notebook (on other notebooks with
the same sound-chip alsa is working).

I tried the following, always with the same results:
- compile alsa in the kernel
- compile alsa as kernel modules
- emerge alsa-driver (version 1.0.9-rc3 - 1.0.9-rc4 is not in portage
yet)
- compile alsa-driver manually (version 1.0.9-rc4)

Everything seems to work fine, but i can't hear anything, so maybe this is
a bug in the alsa-driver.
Would be great if somebody could tell me how i get alsa working on my
notebook  ;-)

Greetz,
thomas


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001311 drivers load but unmuting channels / ad...
======================================================================

----------------------------------------------------------------------
 tiwai - 08-12-05 18:17 
----------------------------------------------------------------------
Good to hear.

Please show the output of "lspci -nv" to add an entry for your device to
select the model asus.

----------------------------------------------------------------------
 Ballbreaker - 08-12-05 18:45 
----------------------------------------------------------------------
there is still one problem left :-(
if i run "/etc/init.d/alsasound start" i get the following output:

 * Loading ALSA modules...
 * Could not detect custom ALSA settings.  Loading all detected alsa
drivers.
 *   Loading: snd_hda_intel...                                           
[ ok ]
 *   Loading: snd-seq-oss...                                             
[ ok ]
 *   Loading: snd-pcm-oss...                                             
[ ok ]
 * Restoring Mixer Levels...
/usr/sbin/alsactl: set_control:894: warning: name mismatch (Front Mic
Playback Volume/Channel Mode) for control #15
/usr/sbin/alsactl: set_control:896: warning: index mismatch (0/0) for
control #15
/usr/sbin/alsactl: set_control:1008: bad control.15.value index          
[ !! ]


any idea what is going wrong here?

--------------------------------------
here's the output of lspci -nv:

0000:00:00.0 Class 0600: 8086:2590 (rev 03)
	Subsystem: 1043:1997
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] #09 [2109]

0000:00:02.0 Class 0300: 8086:2592 (rev 03)
	Subsystem: 1043:1882
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at feb80000 (32-bit, non-prefetchable)
	I/O ports at ec00 [size=8]
	Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Memory at feb40000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [d0] Power Management version 2

0000:00:02.1 Class 0380: 8086:2792 (rev 03)
	Subsystem: 1043:1882
	Flags: bus master, fast devsel, latency 0
	Memory at fea80000 (32-bit, non-prefetchable)
	Capabilities: [d0] Power Management version 2

0000:00:1b.0 Class 0403: 8086:2668 (rev 04)
	Subsystem: 1043:1993
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at feb38000 (64-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
	Capabilities: [70] #10 [0091]

0000:00:1d.0 Class 0c03: 8086:2658 (rev 04)
	Subsystem: 1043:1997
	Flags: bus master, medium devsel, latency 0, IRQ 23
	I/O ports at e400 [size=32]

0000:00:1d.1 Class 0c03: 8086:2659 (rev 04)
	Subsystem: 1043:1997
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at e480 [size=32]

0000:00:1d.2 Class 0c03: 8086:265a (rev 04)
	Subsystem: 1043:1997
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at e800 [size=32]

0000:00:1d.3 Class 0c03: 8086:265b (rev 04)
	Subsystem: 1043:1997
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at e880 [size=32]

0000:00:1d.7 Class 0c03: 8086:265c (rev 04) (prog-if 20)
	Subsystem: 1043:1997
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at feb3fc00 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 Class 0604: 8086:2448 (rev d4) (prog-if 01)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe800000-fe8fffff
	Capabilities: [50] #0d [0000]

0000:00:1f.0 Class 0601: 8086:2641 (rev 04)
	Subsystem: 1043:1997
	Flags: bus master, medium devsel, latency 0

0000:00:1f.1 Class 0101: 8086:266f (rev 04) (prog-if 8a [Master SecP
PriP])
	Subsystem: 1043:1997
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at ffa0 [size=16]

0000:01:03.0 Class 0607: 1180:0476 (rev b3)
	Subsystem: 1043:1997
	Flags: bus master, medium devsel, latency 168, IRQ 21
	Memory at 1f000000 (32-bit, non-prefetchable)
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 1f400000-1f7ff000 (prefetchable)
	Memory window 1: 1f800000-1fbff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

0000:01:03.1 Class 0c00: 1180:0552 (rev 08) (prog-if 10)
	Subsystem: 1043:1997
	Flags: bus master, medium devsel, latency 64, IRQ 22
	Memory at fe8fd800 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2

0000:01:03.2 Class 0805: 1180:0822 (rev 17)
	Subsystem: 1043:1997
	Flags: bus master, medium devsel, latency 64, IRQ 4
	Memory at fe8fe400 (32-bit, non-prefetchable)
	Capabilities: [80] Power Management version 2

0000:01:03.3 Class 0880: 1180:0592 (rev 08)
	Subsystem: 1043:1997
	Flags: medium devsel, IRQ 4
	Memory at fe8fe800 (32-bit, non-prefetchable)
	Capabilities: [80] Power Management version 2

0000:01:04.0 Class 0200: 10ec:8139 (rev 10)
	Subsystem: 1043:1045
	Flags: bus master, medium devsel, latency 64, IRQ 20
	I/O ports at d800
	Memory at fe8fec00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

0000:01:05.0 Class 0280: 8086:4220 (rev 05)
	Subsystem: 8086:2701
	Flags: bus master, medium devsel, latency 64, IRQ 18
	Memory at fe8ff000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-05 13:44 Ballbreaker    New Issue                                    
06-09-05 13:44 Ballbreaker    Distribution              => gentoo          
06-09-05 13:44 Ballbreaker    Kernel Version            => 2.6.12-rc5      
06-09-05 16:11 Ballbreaker    Issue Monitored: Ballbreaker                    
06-09-05 16:12 Ballbreaker    Issue End Monitor: Ballbreaker                    
06-09-05 16:19 Ballbreaker    Issue Monitored: Ballbreaker                    
08-05-05 08:39 perex          Relationship added       related to 0001311  
08-09-05 21:09 askel          Note Added: 0005735                          
08-11-05 14:26 tiwai          Note Added: 0005756                          
08-11-05 19:45 Ballbreaker    Note Added: 0005762                          
08-12-05 15:48 tiwai          Note Added: 0005774                          
08-12-05 15:54 askel          Note Edited: 0005735                         
08-12-05 15:55 askel          Note Edited: 0005735                         
08-12-05 18:09 Ballbreaker    Note Added: 0005784                          
08-12-05 18:17 tiwai          Note Added: 0005785                          
08-12-05 18:45 Ballbreaker    Note Added: 0005786                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
