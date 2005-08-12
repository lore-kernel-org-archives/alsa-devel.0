From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001323]: MIC jack not supported
Date: Fri, 12 Aug 2005 23:09:42 +0200
Message-ID: <f26b11b0da4047d6777fe363c8ac63b4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5BFCF174
	for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2005 23:09:42 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1323> 
======================================================================
Reported By:                submax82
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1323
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               debian 3.1 sarge
Kernel Version:             linux 2.6.12.4
======================================================================
Date Submitted:             08-08-2005 22:10 CEST
Last Modified:              08-12-2005 23:09 CEST
======================================================================
Summary:                    MIC jack not supported
Description: 
The problem is simple but important! The alsamixer do not show the volume
of the MIC therefore this do not work!
======================================================================

----------------------------------------------------------------------
 rlrevell - 08-10-05 05:21 
----------------------------------------------------------------------
Known problem, capture is not supported in that ALSA version.  You need the
latest ALSA sources from CVS (I think 1.0.9b also supports capture with
that device).

----------------------------------------------------------------------
 jcdutton - 08-12-05 23:09 
----------------------------------------------------------------------
Waiting for feedback. Does upgrading to alsa-driver 1.0.9b help?


Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-05 22:10 submax82       New Issue                                    
08-08-05 22:10 submax82       Distribution              => debian 3.1 sarge
08-08-05 22:10 submax82       Kernel Version            => linux 2.6.12.4  
08-08-05 22:59 submax82       Issue Monitored: submax82                    
08-08-05 23:00 submax82       Note Added: 0005714                          
08-10-05 05:21 rlrevell       Note Added: 0005746                          
08-12-05 23:09 jcdutton       Note Added: 0005790                          
08-12-05 23:09 jcdutton       Status                   assigned => feedback
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
