From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000658]: processor detection in configure.in breaks detection of kernel config options
Date: Fri, 19 Nov 2004 12:13:32 +0100
Message-ID: <30cdf8018c6034f093776b6b96a0cd76@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E3B21203
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2004 12:13:36 +0100 (MET)
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
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.7
======================================================================
Date Submitted:             11-19-2004 12:13 CET
Last Modified:              11-19-2004 12:13 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-04 12:13 eradicator     New Issue                                    
11-19-04 12:13 eradicator     File Added: alsa-driver-1.0.7-configure.patch     
              
11-19-04 12:13 eradicator     Distribution              => Gentoo          
11-19-04 12:13 eradicator     Kernel Version            => 2.6.7           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
