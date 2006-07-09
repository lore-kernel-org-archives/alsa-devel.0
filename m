From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001891]: Sound freezes until I move
	the mouse
Date: Sun, 9 Jul 2006 12:14:39 +0200
Message-ID: <d9c307f413d42a8f9f9f5ec25b29b7d5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B9CB926E
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 12:14:39 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1891> 
======================================================================
Reported By:                moobaxx
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1891
Category:                   1_OTHERS
Reproducibility:            N/A
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Slackware
Kernel Version:             2.4
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             03-04-2006 22:31 CET
Last Modified:              07-09-2006 12:14 CEST
======================================================================
Summary:                    Sound freezes until I move the mouse
Description: 
I have a strange problem: when a sound is played (ex. beep when I get a
message in Gaim, or in UT2004,or xmms etc.) then the sound sort of freezes
and keeps repeating until I move the mouse. If I move it fast, sounds
great... 
Does anyone have any idea ? Tnx!
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-05-06 22:59 
----------------------------------------------------------------------
What hardware?

Can you try a newer kernel like 2.6.15?

----------------------------------------------------------------------
 tiwai - 03-23-06 17:53 
----------------------------------------------------------------------
I bet it's an IRQ routing problem.  Play with ACPI boot option.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-06 22:31 moobaxx        New Issue                                    
03-04-06 22:31 moobaxx        Distribution              => Slackware       
03-04-06 22:31 moobaxx        Kernel Version            => 2.4             
03-05-06 22:59 rlrevell       Note Added: 0008359                          
03-23-06 17:53 tiwai          Note Added: 0008899                          
07-09-06 12:14 Adrian Bunk    Status                   new => closed       
07-09-06 12:14 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
