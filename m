From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001413]: Module update removed support for SB live! 24bit
Date: Sun, 11 Sep 2005 20:48:32 +0200
Message-ID: <f3c4644ad50c36d32514558cdce94b66@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7D20F186
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2005 20:48:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1413> 
======================================================================
Reported By:                csabo2
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1413
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.x
======================================================================
Date Submitted:             09-11-2005 15:13 CEST
Last Modified:              09-11-2005 20:48 CEST
======================================================================
Summary:                    Module update removed support for SB live! 24bit
Description: 
I noticed after installing the new fedora core, which came with alsa 1.0.9
I no longer had support for my card.  When I tried to configure it, it
said the module audigyls was not included.  So I asked around and found
out you replaced it with the module im filing this under.  I have been
unable to get sound working on it, and no one in the support channels has
been successful thus far.  Seeing as ALSA comes with the kernel now, I
cannot remove it to install the needed version (1.0.7) If theres anyway I
can help please let me know.  I'll even MAIL you my card.
======================================================================

----------------------------------------------------------------------
 rlrevell - 09-11-05 20:48 
----------------------------------------------------------------------
FC4 comes with a buggy ALSA version that doesn't support your card
properly.  Install ALSA 1.0.10-rc1 from source.  Also file an FC4 bug
report.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-11-05 15:13 csabo2         New Issue                                    
09-11-05 15:13 csabo2         Kernel Version            => 2.6.x           
09-11-05 20:48 rlrevell       Note Added: 0006142                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
