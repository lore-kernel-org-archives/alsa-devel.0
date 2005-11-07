From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001320]: CA0106 with Soundblaster 24-bit live does not allow recording
Date: Mon, 7 Nov 2005 18:34:05 +0100
Message-ID: <98c10bad5cac6fdbd953fb95fb81cb7c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8BEBD193
	for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2005 18:34:05 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1320> 
======================================================================
Reported By:                ammiellodebar
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1320
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Arch Linux
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-08-2005 06:03 CEST
Last Modified:              11-07-2005 18:34 CET
======================================================================
Summary:                    CA0106 with Soundblaster 24-bit live does not allow
recording
Description: 
When I use the line in on the card, it will not capture unless i crank up
the mixer to near peak, and then its garbled and distorted sound, my
capture is up all the way and i know its not a dumb mistake of mine


======================================================================

----------------------------------------------------------------------
 qqtortqq - 11-07-05 16:56 
----------------------------------------------------------------------
Aha!  My stupidity prevails again.. Either I was using alsamixer-gui
improperly, or it is necessary to use the text alsamixer, but I think I've
seen it mentioned before to use the text mode alsamixer.  It is working
properly, so if no one else is having trouble, the bug can probably be
closed, along with the related one.

Thanks a bunch, not only for your help, but for the work you have done.

----------------------------------------------------------------------
 jcdutton - 11-07-05 18:34 
----------------------------------------------------------------------
User reports the problem as fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-05 06:03 ammiellodebar  New Issue                                    
08-08-05 06:03 ammiellodebar  Distribution              => Arch Linux      
08-09-05 04:13 ammiellodebar  Note Added: 0005717                          
08-12-05 23:11 jcdutton       Note Added: 0005791                          
08-12-05 23:11 jcdutton       Status                   assigned => feedback
08-13-05 03:40 ammiellodebar  Note Added: 0005800                          
08-21-05 23:56 ammiellodebar  Note Added: 0005887                          
08-21-05 23:56 ammiellodebar  Note Edited: 0005717                         
09-10-05 10:36 jcdutton       Note Added: 0006108                          
09-10-05 18:15 ammiellodebar  Note Added: 0006124                          
09-15-05 06:37 qqtortqq       Note Added: 0006192                          
09-15-05 06:51 qqtortqq       Issue Monitored: qqtortqq                    
10-12-05 06:45 qqtortqq       Note Added: 0006461                          
10-23-05 19:37 jcdutton       Note Added: 0006513                          
10-30-05 03:54 qqtortqq       Note Added: 0006572                          
10-30-05 20:57 jcdutton       Status                   feedback => assigned
10-30-05 20:58 jcdutton       Note Added: 0006575                          
10-30-05 20:58 jcdutton       Status                   assigned => feedback
10-31-05 03:10 qqtortqq       Note Added: 0006580                          
11-06-05 23:59 jcdutton       Note Added: 0006609                          
11-07-05 16:56 qqtortqq       Note Added: 0006615                          
11-07-05 18:34 jcdutton       Status                   feedback => closed  
11-07-05 18:34 jcdutton       Note Added: 0006616                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
