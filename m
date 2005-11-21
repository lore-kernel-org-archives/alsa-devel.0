From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001548]: "alsa-play: xrun of at least 0.009 msecs. resetting stream" : inopportune small pauses while playing
Date: Mon, 21 Nov 2005 23:56:55 +0100
Message-ID: <9183e8077208a7f4d8de898c45af8eae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7E4C19C
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2005 23:56:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1548> 
======================================================================
Reported By:                moncnam
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1548
Category:                   PCI - intel8x0m
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               debian sarge 3.1
Kernel Version:             2.6.13-rc7
======================================================================
Date Submitted:             11-12-2005 10:58 CET
Last Modified:              11-21-2005 23:56 CET
======================================================================
Summary:                    "alsa-play: xrun of at least 0.009 msecs. resetting
stream" : inopportune small pauses while playing
Description: 
whatever the player i use (alsaplayer, xmms, mplayer) i experience small
pause while playing (half of a second)
using mplayer, i can see the following message appearing when the pause
occur
<<alsa-play: xrun of at least 0.009 msecs. resetting stream>>
the playing doesn't stop, it continue well, just a small pause
i have no other messages in `dmesg` or in syslog
======================================================================

----------------------------------------------------------------------
 sashak - 11-21-05 23:56 
----------------------------------------------------------------------
I guess you are about sound driver 'intel8x0' and not about 'intel8x0m'
(modem driver). If so it should be in 'intel8x0' category.

The error message reports about underruns and likely it results pauses.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-05 10:58 moncnam        New Issue                                    
11-12-05 10:58 moncnam        Distribution              => debian sarge 3.1
11-12-05 10:58 moncnam        Kernel Version            => 2.6.13-rc7      
11-21-05 23:56 sashak         Note Added: 0006779                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
