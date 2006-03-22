From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000698]: Random beeps, ticks and clicks
Date: Wed, 22 Mar 2006 03:17:36 +0100
Message-ID: <21b63e177cfd639001a599b752f4bab1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EF6581A6
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:17:36 +0100 (MET)
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
Last Modified:              03-22-2006 03:17 CET
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
 jdthood - 09-14-05 16:06 
----------------------------------------------------------------------
> I did this:
>
> setpci -v -d *:* latency_timer=b0 #all cards
> setpci -v -s 01:00.0 latency_timer=ff #graphics-card
> setpci -v -s 00:0d.0 latency_timer=ff #network-card
> 
> Anyway. It seems to work pretty ok. 

Any progress on this issue on the ALSA side?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:17 
----------------------------------------------------------------------
Any improvement with later ALSA versions?  Is the setpci hack still
required?

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
12-03-04 12:27 moonlite       Note Added: 0002708                          
12-03-04 12:28 moonlite       Note Edited: 0002708                         
09-14-05 16:06 jdthood        Note Added: 0006172                          
03-22-06 03:17 rlrevell       Note Added: 0008807                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
