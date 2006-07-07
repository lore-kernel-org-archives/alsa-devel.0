From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002262]: Why does the hadware mixer of
	"sound blaster live 24bit model sb04100 chip ca0106" never
	was implemented??? There is no one??
Date: Fri, 7 Jul 2006 03:06:51 +0200
Message-ID: <55a28fafffacc99edb730eb72f48a510@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1553B227
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 03:06:52 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2262> 
======================================================================
Reported By:                gwagner
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2262
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-07-2006 01:39 CEST
Last Modified:              07-07-2006 03:06 CEST
======================================================================
Summary:                    Why does the hadware mixer of "sound blaster live
24bit model sb04100 chip ca0106" never was implemented??? There is no one??
Description: 
I already read that the "sound blaster live 24bit" has no hadware mixer,
but I don't believe that. Someone really know something about it???
======================================================================

----------------------------------------------------------------------
 rlrevell - 07-07-06 01:44 
----------------------------------------------------------------------
Believe it or not, it's true.  The CA0106 has no hardware mixing.  All
mixing is done in software by the Windows driver (or ALSA + dmix).

Creative really screwed their users and damaged their brand by calling
this an "SBLive"

----------------------------------------------------------------------
 gwagner - 07-07-06 03:06 
----------------------------------------------------------------------
I'm hating this card I will sell it... They're stealing their consumers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-07-06 01:39 gwagner        New Issue                                    
07-07-06 01:44 rlrevell       Note Added: 0010890                          
07-07-06 03:06 gwagner        Note Added: 0010891                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
