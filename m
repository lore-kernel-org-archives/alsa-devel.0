From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000698]: Random beeps, ticks and clicks
Date: Fri, 3 Dec 2004 00:23:28 +0100
Message-ID: <e13e5bfe699e8176731780eec6159fa9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 20BF525E
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2004 00:23:29 +0100 (MET)
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
Last Modified:              12-03-2004 00:23 CET
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
 moonlite - 12-03-04 00:23 
----------------------------------------------------------------------
I changed the setting in BIOS, setting IRQ 11 to "reserved". I am not sure
what that meant but now eth0 is on IRQ 10 instead of sharing with emu10k1
which is good i guess.
However that did not help me at all since the random beeps are still there
:(

----------------------------------------------------------------------
 moonlite - 12-03-04 00:23 
----------------------------------------------------------------------
I changed the setting in BIOS, setting IRQ 11 to "reserved". I am not sure
what that meant but now eth0 is on IRQ 10 instead of sharing with emu10k1
which is good i guess.
However that did not help me at all since the random beeps are still there
:(

           CPU0       
  0:     220060          XT-PIC  timer
  1:       1245          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:       2871          XT-PIC  eth0
 11:       1504          XT-PIC  EMU10K1
 12:      14596          XT-PIC  i8042
 14:       9839          XT-PIC  ide0
 15:         31          XT-PIC  ide1
NMI:          0 
ERR:          0

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
