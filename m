From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001715]: after driver update message "(MIXER,'Front Playback Volume',0,0,0) appears twice or more" is shown
Date: Thu, 5 Jan 2006 10:33:33 +0100
Message-ID: <993fb6eded585778c556930ae2ac3724@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D05CF154
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2006 10:33:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1715> 
======================================================================
Reported By:                dalth
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1715
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.15, no 4K-stacks, no regparm, highmem=off
======================================================================
Date Submitted:             01-04-2006 20:56 CET
Last Modified:              01-05-2006 10:33 CET
======================================================================
Summary:                    after driver update message "(MIXER,'Front Playback
Volume',0,0,0) appears twice or more" is shown
Description: 
After update Linux kernel from 2.6.14 (it has ALSA 1.0.10rc1 included) to
2.6.15 (it contains ALSA 1.0.10rc3) all alsa utilities exits with the
following message:

ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback
Volume',0,0,0) appears twice or more

In fact, I test it with following combinations:

alsa-driver-1.0.10rc1 from 2.6.14 and alsa-lib-1.0.9 works fine
alsa-driver-1.0.10rc1 from 2.6.14 and alsa-lib-1.0.10 works fine

alsa-driver-1.0.10rc3 from 2.6.14 and alsa-lib-1.0.9 doesn't work
alsa-driver-1.0.10 (from this site) and alsa-lib-1.0.10 doesn't work
alsa-driver-1.0.11rc2 and alsa-lib-1.0.10 doesn't work

I tried to create a simple quick-n-dirty workaround in the alsa-lib source
that passed over this check and allows me to avoid alsa utilities
termination. So I forced alsamixer, amixer and some other alsa-dependent
applications like esd or beep-media-player to work properly.

But Line-In is not working (I checked that line-in control was set to 100%
and it is not in Mute state), so when I use a TV-tuner that connected to
line-in jack, there are no sound.
======================================================================

----------------------------------------------------------------------
 dalth - 01-04-06 21:22 
----------------------------------------------------------------------
Ooops! I found a similar topic in buglist - it is a bug 0001681 that is
open:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1681
In fact, "jcdutton" has the same card and the same problem.

----------------------------------------------------------------------
 dalth - 01-05-06 10:33 
----------------------------------------------------------------------
I was stupid.

Problem has been solved - I've described dirty solution in a bug 1681
notes,
so now all works fine - except mplayer "tv" mode with v4l2, but it's not
an
ALSA problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 20:56 dalth          New Issue                                    
01-04-06 20:56 dalth          Kernel Version            => 2.6.15, no 4K-stacks,
no regparm, highmem=off
01-04-06 21:22 dalth          Note Added: 0007452                          
01-05-06 10:33 dalth          Note Added: 0007467                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
