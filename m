From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000688]: Errors in testing gcc and ld in the sparc and sparc64 sections of the configure file
Date: Mon, 29 Nov 2004 16:19:16 +0100
Message-ID: <a8b278edf92af8b51756f791112dc706@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 832001E7
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 16:19:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=688> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   688
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-28-2004 19:36 CET
Last Modified:              11-29-2004 16:19 CET
======================================================================
Summary:                    Errors in testing gcc and ld in the sparc and
sparc64 sections of the configure file
Description: 
Here is a patch to fix the configure script so that it less incorrectly
tests gcc and ld functionality on sparc and sparc64.  You will want to fix
configure.in, of course.
======================================================================

----------------------------------------------------------------------
 jdthood - 11-29-04 16:12 
----------------------------------------------------------------------
I have updated from cvs but the bug is still there.

----------------------------------------------------------------------
 tiwai - 11-29-04 16:19 
----------------------------------------------------------------------
The anonymous CVS on sourceforge is sync'ed only once per day.
So wait for a while...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 19:36 jdthood        New Issue                                    
11-28-04 19:36 jdthood        File Added:
alsa-driver-configure.jdth20041128.patch                    
11-29-04 15:25 tiwai          Note Added: 0002637                          
11-29-04 15:38 jdthood        Note Added: 0002641                          
11-29-04 15:39 jdthood        Note Edited: 0002641                         
11-29-04 15:40 jdthood        Note Edited: 0002641                         
11-29-04 15:49 tiwai          Status                   assigned => resolved
11-29-04 15:49 tiwai          Resolution               open => fixed       
11-29-04 15:49 tiwai          Note Added: 0002645                          
11-29-04 16:12 jdthood        Status                   resolved => feedback
11-29-04 16:12 jdthood        Resolution               fixed => reopened   
11-29-04 16:12 jdthood        Note Added: 0002649                          
11-29-04 16:19 tiwai          Status                   feedback => resolved
11-29-04 16:19 tiwai          Resolution               reopened => fixed   
11-29-04 16:19 tiwai          Note Added: 0002652                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
