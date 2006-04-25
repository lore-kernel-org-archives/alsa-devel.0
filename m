From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002049]: No sound output on Sony Vaio PCG FR130
Date: Tue, 25 Apr 2006 17:40:09 +0200
Message-ID: <4f7111bd802521fd5955657c43f52614@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 74169157
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 17:40:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2049> 
======================================================================
Reported By:                gerd94706
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2049
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-21-2006 04:43 CEST
Last Modified:              04-25-2006 17:40 CEST
======================================================================
Summary:                    No sound output on Sony Vaio PCG FR130
Description: 
The driver compiles & loads fine, but sound output does not work.
Don't recall if the sound output was choppy or not-present, since it's
been a while since I last tried.

======================================================================

----------------------------------------------------------------------
 gerd94706 - 04-21-06 06:00 
----------------------------------------------------------------------
Sorry, I selected the wrong Category.
This is what happens if you file a trouble-ticker just from memory.
I believe it was the via-something drier, not cs46xx.
Anyway, I looked it up at the time (whatever PCI id fit) and it loaded
and
recognized the chip. Just the sound-output didn't work!

----------------------------------------------------------------------
 tiwai - 04-25-06 17:40 
----------------------------------------------------------------------
The description is too ambiguous (what is via-something?).
Which driver did you try exactly?  Did you unmute and adjust mixer
properly after loading the driver?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-06 04:43 gerd94706      New Issue                                    
04-21-06 06:00 gerd94706      Note Added: 0009407                          
04-25-06 17:40 tiwai          Note Added: 0009492                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
