From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001408]: Ask for driver support
Date: Fri, 9 Sep 2005 12:27:52 +0200
Message-ID: <1ee7404f52acb43b7e6e4a4175418fe9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E9191155
	for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2005 12:27:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1408> 
======================================================================
Reported By:                war0060
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1408
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-09-2005 12:12 CEST
Last Modified:              09-09-2005 12:27 CEST
======================================================================
Summary:                    Ask for driver support
Description: 
The startup message told me that ALSA can't find the right driver for my
card. The  sound card is built-in on ASUS P5GL-MX motherboard.

the message of "lspci":
--------------------------------------------------------------------------------
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 05)
--------------------------------------------------------------------------------
I've tried "intel8x0" driver but doesn't work. Or I should use another
driver?
======================================================================

----------------------------------------------------------------------
 tiwai - 09-09-05 12:27 
----------------------------------------------------------------------
It's snd-hda-intel driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-09-05 12:12 war0060        New Issue                                    
09-09-05 12:27 tiwai          Note Added: 0006092                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
