From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000698]: Random beeps, ticks and clicks
Date: Fri, 3 Dec 2004 00:49:31 +0100
Message-ID: <89e376c0c369d0d7ced6fd37c67b4e82@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 97337275
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2004 00:49:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=698> 
======================================================================
Reported By:                moonlite
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   698
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-02-2004 02:56 CET
Last Modified:              12-03-2004 00:49 CET
======================================================================
Summary:                    Random beeps, ticks and clicks
Description: 
Below is what i posted to the gentoo-forums without getting without getting
help that solved any of my problems.
 
URL:
http://forums.gentoo.org/viewtopic.php?t=255710&start=0&postdays=0&postorder=asc&highlight=
---
I have a problem with alsa and my SBLive-card and kernels newer than
2.4.19.
All in all it works without error-messages and the sound is pretty nice
etc.
But every now and then the music i listen to is interrupted for a small
period of time (around 0.5s most of the time) and during this time i can't
type or move the mouse and an annoying beep comes from my speakers. I am
pretty sure that it is some sort of interruption because the few times the
interrupts are long i am sure that the music continues from where it were
and also, as i said above, i can't type etc during this small period.
This seems to happen more during heavy load than under normal load but it
still happens a lot at any given time. 
---
This problem happened with these kernels:
vanilla-sources-2.4.20
vanilla-sources-2.4.28
gentoo-sources-2.4.20
gentoo-sources-2.4.26-r12
gentoo-dev-sources-2.6.9-r4

(gentoo-sources are gentoo's own patchsets)

Anyway. Since i posted this i've realized that the beeps (and sometimes
also clicks/ticks) also happen more frequent during high network-load and
not only normal load.
Especially the clicking and ticking noise appear more frequent when
downloading large amount of data with high transfer-rates.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-03-04 00:35 
----------------------------------------------------------------------
Can you provide a detailed hardware description including the motherboard
chipset?   Is this an AMD64 or VIA KT266 based system?  There is a very
similar, long standing bug report in the kX forums (Windows driver for
emu10k*).  This was never really solved and the consensus seems to be
buggy hardware.

Maybe you have an extreme PCI latency setting or something.

----------------------------------------------------------------------
 moonlite - 12-03-04 00:49 
----------------------------------------------------------------------
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP]
0000:00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 0a)
0000:00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game
Port (rev 0a)
0000:00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M
[Tornado] (rev 74)

It was a while ago that i bought the system so i couldn't recall really,
but a fast google told me that it was kt266.
Anyway. The problem goes away as soon as i do a "rmmod 3c59x".
So really. It has something to do with my networks-card and
kernel-versions >2.4.19

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-02-04 02:56 moonlite       New Issue                                    
12-02-04 02:56 moonlite       Distribution              => Gentoo          
12-02-04 02:56 moonlite       Kernel Version            => 2.6.9           
12-02-04 17:32 pzad           Note Added: 0002687                          
12-02-04 23:27 moonlite       Note Added: 0002699                          
12-02-04 23:54 moonlite       Note Added: 0002700                          
12-03-04 00:23 moonlite       Note Added: 0002701                          
12-03-04 00:23 moonlite       Note Added: 0002702                          
12-03-04 00:23 moonlite       Note Deleted: 0002701                        
12-03-04 00:35 rlrevell       Note Added: 0002703                          
12-03-04 00:49 moonlite       Note Added: 0002704                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
