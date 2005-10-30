From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001513]: Add largefile support to alsa-utils
Date: Sun, 30 Oct 2005 13:21:42 +0100
Message-ID: <9997ebc868170d5ba60dd7ed6d32a16e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6A7EC1A8
	for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2005 13:21:42 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1513> 
======================================================================
Reported By:                Flameeyes
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1513
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-30-2005 13:21 CET
Last Modified:              10-30-2005 13:21 CET
======================================================================
Summary:                    Add largefile support to alsa-utils
Description: 
The attached patch allows to play/record and in general open large files
(>=2GB) with 32-bit systems (like x86).

It's just a matter of checking largefile support in libc and then enable
it.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-30-05 13:21 Flameeyes      New Issue                                    
10-30-05 13:21 Flameeyes      File Added: alsa-utils-1.0.10_rc1-largefile.patch 
                  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
