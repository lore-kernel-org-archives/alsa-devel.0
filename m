From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000508]: JACK connecting to SPDIF failes!
Date: Mon, 20 Sep 2004 14:05:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040920120540.883E54904C@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E72B4318
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2004 14:05:40 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000508
======================================================================
Reported By:                hothead
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     508
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-20-2004 13:25 CEST
Last Modified:              09-20-2004 14:05 CEST
======================================================================
Summary:                    JACK connecting to SPDIF failes!
Description: 
Trying to connect trough alsa to the spdif output on an
nforce2 soundchip via JACK failes with the following error message:

13:16:14.915 /usr/bin/jackd -R -dalsa -dhw:0,2 -r48000 -p1024 -n2 -S -i2
-o2
13:16:14.936 JACK was started with PID=12828 (0x321c).
jackd 0.98.1
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
loading driver ..
apparent rate = 48000
creating alsa driver ...
hw:0,2|hw:0,2|1024|2|48000|2|2|nomon|swmeter|-|16bit
ALSA lib pcm_hw.c:1155:(snd_pcm_hw_open) open /dev/snd/pcmC0D2c failed: No
such file or directory
jackd: pcm.c:690: snd_pcm_nonblock: Assertion `pcm' failed.
13:16:14.994 JACK was stopped successfully.
13:16:16.966 Could not connect to JACK server as client.
======================================================================

----------------------------------------------------------------------
 mistatapas - 09-20-2004 14:05 CEST 
----------------------------------------------------------------------
hw:0,2 is probably a playback only device so start jackd with the -P
option. 

ALSA lib pcm_hw.c:1155:(snd_pcm_hw_open) open /dev/snd/pcmC0D2c failed: No
such file or directory

One might think about making jackd's error message a little more verbose
though. This one is confusing new users. But this should rather be
discussed on the jackit-devel mailing list..

Alternatively to starting with the -P option you might also try specifying
a valid pcm device for capturing [Use -C hw:0,0 for example]

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-20-04 13:25 hothead        New Bug                                      
09-20-04 14:05 mistatapas     Bugnote Added: 0001785                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
