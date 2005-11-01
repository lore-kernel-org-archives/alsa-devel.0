From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001270]: "External amplifier" consistently mis-configured on upgrade, breaks sound
Date: Tue, 1 Nov 2005 15:39:58 +0100
Message-ID: <4b1119a965f2f925631bd6545f46d594@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BB0E112B
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 15:39:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1270> 
======================================================================
Reported By:                eyequeue
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1270
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu (breezy)
Kernel Version:             2.6.12
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             07-21-2005 09:10 CEST
Last Modified:              11-01-2005 15:39 CET
======================================================================
Summary:                    "External amplifier" consistently mis-configured on
upgrade, breaks sound
Description: 
Each time the ALSA packages are upgraded, sound becomes inoperative.

To fix, I have to run alsamixer as root, and DISable the "External
amplifier" setting, which somehow keeps getting turned on, upon package
upgrade.

This is a laptop, so there is no "external" anything, and turning this
setting off again allows sound to once again work.

Upon asking advice on IRC i was told this was an upstream "AC97 codec bug"
if that phrase helps you in any way.

======================================================================

----------------------------------------------------------------------
 jdthood - 11-01-05 15:39 
----------------------------------------------------------------------
One bug like this was fixed in Ubuntu Breezy.


Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-21-05 09:10 eyequeue       New Issue                                    
07-21-05 09:10 eyequeue       Distribution              => Ubuntu (breezy) 
07-21-05 09:10 eyequeue       Kernel Version            => 2.6.12          
07-21-05 09:11 eyequeue       Issue Monitored: eyequeue                    
11-01-05 15:39 jdthood        Note Added: 0006595                          
11-01-05 15:39 jdthood        Status                   new => closed       
11-01-05 15:39 jdthood        Resolution               open => not an issue
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
