From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000028]: ALSA OSS Sequencer is broken for recording from external MIDI devices
Date: Fri, 24 Sep 2004 13:43:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924114335.A36E5101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1B55A288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:43:36 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000028
======================================================================
Reported By:                Will
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     28
Category:                   CORE - sequencer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               any
Kernel Version:             2.4.x and 2.6.x
======================================================================
Date Submitted:             02-02-2004 13:51 CET
Last Modified:              09-24-2004 13:43 CEST
======================================================================
Summary:                    ALSA OSS Sequencer is broken for recording from external MIDI devices
Description: 
Recording using ALSA's /dev/sequencer OSS emulation is very broken. The
times of note-on and note-off events are severely corrupted in MIDI
recordings that contain a sequence of chords of _two or more_ different
notes played at the same time.  However, interestingly, MIDI recordings
which contain only a sequence of _single_ notes (only one note at a time),
work ok, presumably because the bug was partially fixed in
alsa-driver-0.9.1 released around 15th March 2003.

Only MIDI recording from ALSA's /dev/sequencer OSS emulation is broken,
e.g. when using an OSS sequencer client. However, MIDI recording from
ALSA's /dev/snd/midi* using an ALSA sequencer client like the new
Rosegarden4
(http://heanet.dl.sourceforge.net/sourceforge/rosegarden/rosegarden-4-0.9.6.tar.bz2)
works fine.
======================================================================

----------------------------------------------------------------------
 Will - 02-02-2004 13:58 CET 
----------------------------------------------------------------------
For details of how to reproduce this bug please see the "Advanced View":
http://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=28

I would like to stop using the old OSS sound driver but I cannot do that
until ALSA's OSS emulation of /dev/sequencer is working correctly. Any
help would be greatly appreciated.

----------------------------------------------------------------------
 Clemens Ladisch - 08-27-2004 15:28 CEST 
----------------------------------------------------------------------
This is a bug in Rosegarden 2.1pl4 which is fixed by the attached patch.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-02-04 13:51 Will           New Bug                                      
02-02-04 13:51 Will           File Added: ossall-bugs                      
02-02-04 13:58 Will           Bugnote Added: 0000104                       
08-27-04 15:26 Clemens LadischAssigned To               => Clemens Ladisch 
08-27-04 15:26 Clemens LadischStatus                   new => assigned     
08-27-04 15:27 Clemens LadischFile Added: rosegarden-2.1pl4.patch                    
08-27-04 15:28 Clemens LadischBugnote Added: 0001643                       
08-27-04 15:28 Clemens LadischResolution               open => not a bug   
08-27-04 15:28 Clemens LadischStatus                   assigned => resolved
09-24-04 13:43 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
