From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000658]: processor detection in configure.in breaks detection of kernel config options
Date: Mon, 29 Nov 2004 16:14:26 +0100
Message-ID: <44af6faa6355ded5b6cefbe3fcd2bd2b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 710002C8
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 16:14:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=658> 
======================================================================
Reported By:                eradicator
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   658
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.7
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-19-2004 12:13 CET
Last Modified:              11-29-2004 16:14 CET
======================================================================
Summary:                    processor detection in configure.in breaks detection
of kernel config options
Description: 
The location of the processor detection code in configure.in needs to be
moved to the end of configure.in after all calls to CHECK_KERNEL_CONFIG
and AC_TRY_RUN.  This is because the processor detection code changes CC
(which is used by CHECK_KERNEL_CONFIG) to the compiler used by kernel
compilation.  The kernel compiler might not be able to make runable
binaries (such as when libc is not available for its target and thus
should not be used for AC_TRY_RUN (which is used by CHECK_KERNEL_CONFIG). 
This was experienced on Gentoo/Sparc and resulted in kernel modules being
built for the wrong kernel configuration (such as not detecting procfs).
======================================================================

----------------------------------------------------------------------
 tiwai - 11-29-04 16:14 
----------------------------------------------------------------------
This should have been fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-04 12:13 eradicator     New Issue                                    
11-19-04 12:13 eradicator     File Added: alsa-driver-1.0.7-configure.patch     
              
11-19-04 12:13 eradicator     Distribution              => Gentoo          
11-19-04 12:13 eradicator     Kernel Version            => 2.6.7           
11-29-04 16:14 tiwai          Status                   assigned => resolved
11-29-04 16:14 tiwai          Resolution               open => fixed       
11-29-04 16:14 tiwai          Note Added: 0002651                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
