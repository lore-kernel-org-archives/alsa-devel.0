From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001918]: No sound when I boot into Linux
Date: Tue, 25 Apr 2006 02:45:20 +0200
Message-ID: <61b8dea48d2d2c97224888368b00b613@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ECF3915D
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 02:45:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1918> 
======================================================================
Reported By:                gordon3913
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1918
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-13-2006 03:04 CET
Last Modified:              04-25-2006 02:45 CEST
======================================================================
Summary:                    No sound when I boot into Linux
Description: 
I do not have sound every time that I boot into Linux
When I run "alsaconf" and follow the prompts in a terminal my sound will
work.
Next time I start my computer - no sound.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-13-06 03:09 
----------------------------------------------------------------------
After "alsaconf" gets your sound working try running "alsactl store".  Then
reboot, and if you don't get sound, run "alsactl restore".

If this works then the bug is in your distro, maybe you don't have all the
alsa packages installed.

----------------------------------------------------------------------
 gordon3913 - 04-25-06 02:45 
----------------------------------------------------------------------
Tried "alsactl store" & "alsactl restore" but still does not work.
I am running Suse 10.0 on a Shuttle MV4213(N) motherboard with sound by
VIA AC'97 enhanced Audio Controller.
I keep updating my Alsa software through Yast Online Update but still with
no success.
Is there something else I could try?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-13-06 03:04 gordon3913     New Issue                                    
03-13-06 03:09 rlrevell       Note Added: 0008437                          
04-25-06 02:45 gordon3913     Note Added: 0009482                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
