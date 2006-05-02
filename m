From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002084]: If the PCM channel is being used and the same time that X is on-screen, ... total hard crash of whole system.
Date: Tue, 2 May 2006 18:06:19 +0200
Message-ID: <f3b021bc1071fe38dc1dc40639ad0fdb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B453019F
	for <alsa-devel@alsa-project.org>; Tue,  2 May 2006 18:06:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2084> 
======================================================================
Reported By:                terrym
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2084
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               ROCK Linux, both 2.0.3 and trunk
Kernel Version:             2.4.x and 2.6.x, currently running 2.6.16.2
======================================================================
Date Submitted:             04-29-2006 04:40 CEST
Last Modified:              05-02-2006 18:06 CEST
======================================================================
Summary:                    If the PCM channel is being used and the same time
that X is on-screen, ... total hard crash of whole system.
Description: 
X can be running as long as it is not on screen, that is, a text console is
in use. It does not matter if the sound app is console based or GUI (X
based), the result is the same: the moment sound plays via PCM and X is on
screen, there is a hard crash that instantly locks up the whole system,
the kernel it self crashes, as an already issued shutdown w/delay will not
finish.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-02-06 18:06 
----------------------------------------------------------------------
Please elaborate the hardware details.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-29-06 04:40 terrym         New Issue                                    
04-29-06 04:40 terrym         Distribution              => ROCK Linux, both
2.0.3 and trunk
04-29-06 04:40 terrym         Kernel Version            => 2.4.x and 2.6.x,
currently running 2.6.16.2
05-02-06 18:06 tiwai          Note Added: 0009565                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
