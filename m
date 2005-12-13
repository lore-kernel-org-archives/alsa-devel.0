From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000926]: dmix segfaults
Date: Tue, 13 Dec 2005 12:32:45 +0100
Message-ID: <bf41da2e6cbe90c658eed8d3b1e406d9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 53E03166
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 12:32:45 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=926> 
======================================================================
Reported By:                jiyuan
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   926
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-20-2005 03:18 CET
Last Modified:              12-13-2005 12:32 CET
======================================================================
Summary:                    dmix segfaults
Description: 
#warning Please, recode mix_areas1() routine to your architecture...
#warning Please, recode mix_areas2() routine to your architecture...
Therefore, when you using dmix under other architecture CPU, the dmix will
crash down, and make error segmentation fault.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000824 sparc, powerpc, hppa, alpha, ia64: &quo...
======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-05 19:08 
----------------------------------------------------------------------
Try the CVS version (better wait until tomorrow).

If you still get segfault, it's not in the part with warnings above. 
Possibly, either SYSV shm or semaphore...

----------------------------------------------------------------------
 jdthood - 12-13-05 12:32 
----------------------------------------------------------------------
Submitter: Does dmix still segfault on you?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-20-05 03:18 jiyuan         New Issue                                    
03-16-05 22:33 jdthood        Note Added: 0003970                          
03-17-05 08:16 perex          Relationship added       related to 0000824  
03-29-05 19:08 tiwai          Note Added: 0004256                          
03-31-05 20:44 jdthood        Summary                  There is no source code
for the functions mix_areas1() and mix_areas2() in the file pcm_dmix.c! => dmix
segfaults
04-29-05 09:15 mandreiana     Issue Monitored: mandreiana                    
12-13-05 12:32 jdthood        Note Added: 0006993                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
