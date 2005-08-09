From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001084]: alsactl --force option does not work
Date: Tue, 9 Aug 2005 13:44:44 +0200
Message-ID: <07ba778b9e7c9afe6d66d67992401680@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1799E1F4
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:44:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1084> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1084
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-02-2005 11:07 CEST
Last Modified:              08-09-2005 13:44 CEST
======================================================================
Summary:                    alsactl --force option does not work
Description: 
According to the man page '--force' is a synonym for '-F'.  However:

# alsactl -F restore
# alsactl --force restore
alsactl: Specify command...

======================================================================

----------------------------------------------------------------------
 tiwai - 05-17-05 18:18 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-02-05 11:07 jdthood        New Issue                                    
05-17-05 18:18 tiwai          Status                   new => resolved     
05-17-05 18:18 tiwai          Resolution               open => fixed       
05-17-05 18:18 tiwai          Assigned To               => tiwai           
05-17-05 18:18 tiwai          Note Added: 0004683                          
08-09-05 13:44 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
