From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001384]: CMI8738 - Mic Boost on Capture
Date: Fri, 2 Sep 2005 19:38:13 +0200
Message-ID: <c5f9628c8e6234e46e3cd139097f4aa2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF75F175
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 19:38:13 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1384> 
======================================================================
Reported By:                register
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1384
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Slackware and upgrades
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-31-2005 20:25 CEST
Last Modified:              09-02-2005 19:38 CEST
======================================================================
Summary:                    CMI8738 - Mic Boost on Capture
Description: 
Under winXP, CMedia 8738 *proprietary* mixer enables Mic BOOST also for
capture function. Under linux + alsa, Mic BOOST is enabled only for
playback function.

The result of this is that VO-IP and recording applications have a mic
volume TOO LOW!


======================================================================

----------------------------------------------------------------------
 register - 08-31-05 21:41 
----------------------------------------------------------------------
Please, condider this problem as SOLVED.

I've found this post:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1192

The *.diff file reported in this post has correctly patched the CMIPCI
driver of 1.09 driver packages. Compiling, installing and rebooting has
solved my problem. Now MIC BOOST is present also on Capture.

Regards.

----------------------------------------------------------------------
 tiwai - 09-02-05 19:38 
----------------------------------------------------------------------
The patch was already on 1.0.10rc1.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-31-05 20:25 register       New Issue                                    
08-31-05 20:25 register       Distribution              => Slackware and
upgrades
08-31-05 20:25 register       Kernel Version            => 2.6.10          
08-31-05 21:41 register       Note Added: 0005992                          
09-02-05 19:38 tiwai          Status                   assigned => resolved
09-02-05 19:38 tiwai          Resolution               open => fixed       
09-02-05 19:38 tiwai          Note Added: 0006016                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
