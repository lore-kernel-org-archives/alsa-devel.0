From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000688]: Errors in testing gcc and ld in the sparc and sparc64 sections of the configure file
Date: Mon, 29 Nov 2004 15:38:08 +0100
Message-ID: <886c365a92398288c8ee519985211a05@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 98A6B2C2
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 15:38:08 +0100 (MET)
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
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-28-2004 19:36 CET
Last Modified:              11-29-2004 15:38 CET
======================================================================
Summary:                    Errors in testing gcc and ld in the sparc and
sparc64 sections of the configure file
Description: 
Here is a patch to fix the configure script so that it less incorrectly
tests gcc and ld functionality on sparc and sparc64.  You will want to fix
configure.in, of course.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-29-04 15:25 
----------------------------------------------------------------------
Could you try the CVS version.  The configure script was changed much since
1.0.7 release.

----------------------------------------------------------------------
 jdthood - 11-29-04 15:38 
----------------------------------------------------------------------
The cvs version still contains these lines:

    test $KCC -m32 -S -o /dev/null -xc /dev/null >/dev/null 2>&1 &&
IS_EGCS=y
    test $CROSS_COMPILE$KLD --version 2>&1 | grep 'elf64_sparc' >
/dev/null && NEW_GAS=y

1. The 'test' does not belong at the beginning of these lines; it's a
   straightforward syntax error.
2. Setting IS_EGCS=y causes "-m32" not to be used, so it's peculiar to
set
   IS_EGCS=y when the command _succeeds_ with "-m32".
   (Bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 hides bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2.)
3. ld --version does not output a list of supported emulations, but
   ld -V does output such a list.  The sparc64 section uses "-V".

My guess is that these lines should be:

    $KCC -m32 -S -o /dev/null -xc /dev/null >/dev/null 2>&1 || IS_EGCS=y
    CROSS_COMPILE$KLD -V 2>&1 | grep 'elf64_sparc' > /dev/null &&
NEW_GAS=y

-- 
Thomas Hood

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 19:36 jdthood        New Issue                                    
11-28-04 19:36 jdthood        File Added:
alsa-driver-configure.jdth20041128.patch                    
11-29-04 15:25 tiwai          Note Added: 0002637                          
11-29-04 15:38 jdthood        Note Added: 0002641                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
