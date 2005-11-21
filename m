From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001540]: alsa-lib make check: code.c does not compile with GCC4
Date: Mon, 21 Nov 2005 11:49:17 +0100
Message-ID: <341860dbd021c839e280f32382120e52@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E992E16A
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2005 11:49:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1540> 
======================================================================
Reported By:                Flameeyes
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1540
Category:                   aconnect
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-10-2005 12:40 CET
Last Modified:              11-21-2005 11:49 CET
======================================================================
Summary:                    alsa-lib make check: code.c does not compile with
GCC4
Description: 
test/code.c source file does not compile with GCC4 as it uses casted
lvalues (that are deprecated in GCC 3.4 and invalid in GCC4).
The attached patch should solve without problems.

HTH,
Diego
======================================================================

----------------------------------------------------------------------
 Flameeyes - 11-21-05 00:58 
----------------------------------------------------------------------
Can someone close this, as I reported it in the right project already?

----------------------------------------------------------------------
 tiwai - 11-21-05 11:49 
----------------------------------------------------------------------
Fixed on CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-10-05 12:40 Flameeyes      New Issue                                    
11-10-05 12:40 Flameeyes      File Added: alsa-lib-1.0.10_rc3-test.patch        
           
11-21-05 00:58 Flameeyes      Note Added: 0006769                          
11-21-05 11:49 tiwai          Status                   new => resolved     
11-21-05 11:49 tiwai          Resolution               open => fixed       
11-21-05 11:49 tiwai          Assigned To               => tiwai           
11-21-05 11:49 tiwai          Note Added: 0006770                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
