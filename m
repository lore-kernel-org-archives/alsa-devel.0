From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001580]: Test fixes for GCC4
Date: Sat, 19 Nov 2005 20:35:16 +0100
Message-ID: <969c1927a6da799289f7799418a5f807@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 897BD174
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2005 20:35:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1580> 
======================================================================
Reported By:                Flameeyes
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1580
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-19-2005 20:35 CET
Last Modified:              11-19-2005 20:35 CET
======================================================================
Summary:                    Test fixes for GCC4
Description: 
code.c, pcm.c and latency.c files has invalid syntax for GCC4, the attached
patch allows to build them clean.

See also bug #0001540 that I filed on the wrong component and I can't
close myself :|

This patch also fixes pcm.c and latency.c from latest alsa-lib version.

HTH,
Diego
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-05 20:35 Flameeyes      New Issue                                    
11-19-05 20:35 Flameeyes      File Added: alsa-lib-1.0.10-test-gcc4.patch       
            
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
