From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001869]: Playing surround sound produces 100% CPU load
Date: Thu, 23 Feb 2006 00:48:05 +0100
Message-ID: <f21a26d6718aa45cf60d8148e16b7ae4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 627E419D
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2006 00:48:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1869> 
======================================================================
Reported By:                bitmage2
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1869
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               SuSE Linux 10.0
Kernel Version:             Linux 2.6.13-15.8-default #1 Tue Feb 7 11:07:24 UTC
2006 i686 athlon i386 GNU/Linux
======================================================================
Date Submitted:             02-23-2006 00:48 CET
Last Modified:              02-23-2006 00:48 CET
======================================================================
Summary:                    Playing surround sound produces 100% CPU load
Description: 
I am using the CS46xx with a Hercules Gametheater XP 5.1 . It plays back
stereo without problems.
I wanted to use the rest of my 5.1 speaker set, so for a test I ran the
speaker-test program. Running it without parameters or with 2 or 4.0
channels works also fine. So far so good.

But when I run it with 5.0 channels or 5.1 channels the CPU load of
speaker-test goes to 100%. I'll show the output of top along with the
command lines below (for the 2.0 and 5.1 case) in the "Additional
Information" box.



======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-06 00:48 bitmage2       New Issue                                    
02-23-06 00:48 bitmage2       Distribution              => SuSE Linux 10.0 
02-23-06 00:48 bitmage2       Kernel Version            => Linux
2.6.13-15.8-default #1 Tue Feb 7 11:07:24 UTC 2006 i686 athlon i386 GNU/Linux
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
