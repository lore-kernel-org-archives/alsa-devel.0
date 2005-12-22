From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001580]: Test fixes for GCC4
Date: Thu, 22 Dec 2005 02:15:42 +0100
Message-ID: <2f42f2a408f13c0d41a88050cf2a94d6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 930891B9
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 02:15:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1580> 
======================================================================
Reported By:                Flameeyes
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - lib
Issue ID:                   1580
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-19-2005 20:35 CET
Last Modified:              12-22-2005 02:15 CET
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

----------------------------------------------------------------------
 Flameeyes - 12-22-05 02:11 
----------------------------------------------------------------------
This is fixed as of 1.0.11_rc1.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-05 20:35 Flameeyes      New Issue                                    
11-19-05 20:35 Flameeyes      File Added: alsa-lib-1.0.10-test-gcc4.patch       
            
12-22-05 02:11 Flameeyes      Note Added: 0007116                          
12-22-05 02:15 rlrevell       Status                   new => resolved     
12-22-05 02:15 rlrevell       Resolution               open => fixed       
12-22-05 02:15 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
