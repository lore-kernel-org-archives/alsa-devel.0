From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002200]: PCM channel doesn't exist!
Date: Tue, 27 Jun 2006 12:47:06 +0200
Message-ID: <ccd59d9e2164b47f52fe88249fc87a9e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EC287267
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 12:47:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2200> 
======================================================================
Reported By:                quetzyg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2200
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Slackware
Kernel Version:             2.6.16.20 (but any version >= 2.6.16 should be
enough to reproduce this)
======================================================================
Date Submitted:             06-11-2006 17:50 CEST
Last Modified:              06-27-2006 12:47 CEST
======================================================================
Summary:                    PCM channel doesn't exist!
Description: 
Since the early release candidates of ALSA 1.0.11, up to the final version,
I seem to have lost the PCM channel from alsamixer.
======================================================================

----------------------------------------------------------------------
 quetzyg - 06-27-06 12:47 
----------------------------------------------------------------------
Well, HG changeset patch against 1.0.12rc1 fixed the PCM issue!
PCM is back, but the volume is not affected at all. Being at 0% or 100%
its the same.

And, I used to have a Master channel as well.

Any suggestions?

Cheers,
Quetzy Garcia

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-06 17:50 quetzyg        New Issue                                    
06-11-06 17:50 quetzyg        Distribution              => Slackware       
06-11-06 17:50 quetzyg        Kernel Version            => 2.6.16.20 (but any
version >= 2.6.16 should be enough to reproduce this)
06-11-06 17:51 quetzyg        Issue Monitored: quetzyg                     
06-27-06 12:47 quetzyg        Note Added: 0010587                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
