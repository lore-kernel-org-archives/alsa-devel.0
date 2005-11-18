From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001576]: free on invalid pointer
Date: Fri, 18 Nov 2005 16:17:24 +0100
Message-ID: <976992fad595b22f58c0185258d343c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CD8BF178
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2005 16:17:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1576> 
======================================================================
Reported By:                matled
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1576
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-18-2005 16:17 CET
Last Modified:              11-18-2005 16:17 CET
======================================================================
Summary:                    free on invalid pointer
Description: 
In src/conf.c the parse_args functions uses free on val even if the pointer
has not been initialized. My suggestion is either to initialize val with
NULL or change the error handling to prevent free(val) if parse_arg
returned a value != 0.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-18-05 16:17 matled         New Issue                                    
11-18-05 16:17 matled         File Added: patch                            
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
