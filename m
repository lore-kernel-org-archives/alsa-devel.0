From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001548]: "alsa-play: xrun of at least 0.009 msecs. resetting stream" : inopportune small pauses while playing
Date: Sat, 12 Nov 2005 10:58:36 +0100
Message-ID: <29848747669f6aed1748199ee0ea1e33@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 290A4150
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2005 10:58:36 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              11-12-2005 10:58 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-05 10:58 moncnam        New Issue                                    
11-12-05 10:58 moncnam        Distribution              => debian sarge 3.1
11-12-05 10:58 moncnam        Kernel Version            => 2.6.13-rc7      
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
