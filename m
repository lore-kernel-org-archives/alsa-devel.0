From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000698]: Random beeps, ticks and clicks
Date: Fri, 3 Dec 2004 05:30:38 +0100
Message-ID: <9b2a0dc8c0b4938140ba5825cb4c9255@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2965C267
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2004 05:30:38 +0100 (MET)
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
Last Modified:              12-03-2004 05:30 CET
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
 moonlite - 12-03-04 01:18 
----------------------------------------------------------------------
I did this:

setpci -v -d *:* latency_timer=b0      #all cards
setpci -v -s 01:00.0 latency_timer=ff  #graphics-card
setpci -v -s 00:0d.0 latency_timer=ff  #network-card

It was explained in an article by daniel robbins on ibm.com.
I have no real clue to if these values are good or bad in any way.
He used it to make sound work when an AGP-card that had agp turned of
(thus putting LOTS of data on the pci-bus) would make his soundcard make
distorted sound.
He wanted to keep his graphics-card and network-card being able to put
lots of data on the bus but still making more room for other stuf or
something.

Anyway. It seems to work pretty ok. 
But, if anyone has some other, maybe more sensible, values for my
pci-latency settings, please post them! :)
But for now i'm just glad it all seems to work.

----------------------------------------------------------------------
 rlrevell - 12-03-04 05:30 
----------------------------------------------------------------------
According to Eugene Gavrilov (author of the kX driver) the original OSS
driver from opensource.creative.com driver and the Windows driver from
creative set the PCI latency to 255.  At some point this code was removed.
 Maybe this needs to be put back.

FWIW, other ALSA drivers (RME for example) have code to raise the PCI
latency.

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
12-03-04 00:55 moonlite       Note Added: 0002705                          
12-03-04 01:18 moonlite       Note Added: 0002706                          
12-03-04 05:30 rlrevell       Note Added: 0002707                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
