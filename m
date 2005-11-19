From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001579]: code.c test uses x86 asm, it should be x86/amd64 only
Date: Sat, 19 Nov 2005 20:17:40 +0100
Message-ID: <3b7ef27aff6779c8ed41c9738048118b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2775D168
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2005 20:17:40 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1579> 
======================================================================
Reported By:                Flameeyes
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1579
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-19-2005 20:17 CET
Last Modified:              11-19-2005 20:17 CET
======================================================================
Summary:                    code.c test uses x86 asm, it should be x86/amd64
only
Description: 
As per summary, the code.c test can't be built for any other system but x86
or amd64, as it uses inline asm focused on i386.

The attached patch makes it conditional to those arches.

HTH,
Diego
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-05 20:17 Flameeyes      New Issue                                    
11-19-05 20:17 Flameeyes      File Added: alsa-lib-1.0.10-test-ppc.patch        
           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
