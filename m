From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001413]: Module update removed support for SB live! 24bit
Date: Sun, 23 Oct 2005 19:42:10 +0200
Message-ID: <1f3fa1343111d64cb9c76f268e9c9630@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C3442144
	for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2005 19:42:10 +0200 (MEST)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               
Kernel Version:             2.6.x
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-11-2005 15:13 CEST
Last Modified:              10-23-2005 19:42 CEST
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

----------------------------------------------------------------------
 jcdutton - 10-23-05 19:42 
----------------------------------------------------------------------
The audigyls module name was changed to ca0106.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-11-05 15:13 csabo2         New Issue                                    
09-11-05 15:13 csabo2         Kernel Version            => 2.6.x           
09-11-05 20:48 rlrevell       Note Added: 0006142                          
10-23-05 19:42 jcdutton       Status                   assigned => closed  
10-23-05 19:42 jcdutton       Note Added: 0006515                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
