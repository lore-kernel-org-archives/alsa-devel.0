From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001451]: SPDF and Line out simultaneously
Date: Wed, 9 Nov 2005 13:42:07 +0100
Message-ID: <747c2c88f19dd2779901052fade45202@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AF6DC1A8
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2005 13:42:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1451> 
======================================================================
Reported By:                anli
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1451
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-24-2005 15:46 CEST
Last Modified:              11-09-2005 13:42 CET
======================================================================
Summary:                    SPDF and Line out simultaneously
Description: 
I tried to get the answer from user and dev lists to this question: how to
configure the driver to make SPDF and Line-out work simultaneously. I was
not lucky to get an answer. I have concluded, it's impossible. So -
reporting the bug.

It is almost impossible to do any serious mastering/editing work without
such opportunity.
======================================================================

----------------------------------------------------------------------
 anli - 11-01-05 20:38 
----------------------------------------------------------------------
Takashi,

If you still remember, we have tried about 6 patches to resolve the issue,
but without success. Probably an opposite way is possible: to mirror an
spdif out to analog rather analog to spdif. From user's point  (or, at
least, my one :-)) these ways are equal.

Andrew

----------------------------------------------------------------------
 tiwai - 11-09-05 13:42 
----------------------------------------------------------------------
OK, point taken
Then "spdif" device isn't appropriate because it outputs via a special PCM
device (hw:0,2) for raw output to avoid the modification of data.

You may output to SPDIF from hw:0,0 and toggling "IEC958 Optical Raw"
switch manually (may need "SB Live Analog/Digital Output Jack", too).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-05 15:46 anli           New Issue                                    
10-05-05 19:01 tiwai          Note Added: 0006438                          
10-06-05 17:25 anli           Issue Monitored: anli                        
10-11-05 17:24 tiwai          Note Added: 0006456                          
10-11-05 21:30 anli           Note Added: 0006460                          
11-01-05 20:38 anli           Note Added: 0006599                          
11-09-05 13:42 tiwai          Note Added: 0006649                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
