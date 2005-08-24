From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001337]: AWE 32/64 driver crashes when using the skype program.
Date: Wed, 24 Aug 2005 07:09:57 +0200
Message-ID: <a9e534f08b0023001a0f2f9c3403d37e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D4FF0215
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 07:09:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1337> 
======================================================================
Reported By:                philneves
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1337
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Slackware 10, and Redhat 7.3
Kernel Version:             2.4 series.
======================================================================
Date Submitted:             08-15-2005 03:20 CEST
Last Modified:              08-24-2005 07:09 CEST
======================================================================
Summary:                    AWE 32/64 driver crashes when using the skype
program.
Description: 
This is a serious bug with the sb16/sbawe driver. It seems to crash when
running the skype program. Problem can be reproduced on a regular basis.
Although frequency of occurence is random. Once the driver crashes it
disables all sound on my system and I must restart the computer to get the
sound back. Reloading the driver doesn't work. Problem occurs on all
versions of alsa and all versions of the 2.4 kernel. 





======================================================================

----------------------------------------------------------------------
 philneves - 08-24-05 07:09 
----------------------------------------------------------------------
Problem occures in all versions of linux. Even 2.6. It took me a couple of
hours running skype but it finally crashed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-15-05 03:20 philneves      New Issue                                    
08-15-05 03:20 philneves      Distribution              => Slackware 10, and
Redhat 7.3
08-15-05 03:20 philneves      Kernel Version            => 2.4 series.     
08-24-05 07:09 philneves      Note Added: 0005924                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
