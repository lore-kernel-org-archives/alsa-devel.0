From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000638]: emerge alsa-driver-1.0.6a fails on kbuild enabled system
Date: Tue, 22 Feb 2005 09:42:10 +0100
Message-ID: <e23711651634b49b29d2763dafece0e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9C1A7CB
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 09:42:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=638> 
======================================================================
Reported By:                eehmke
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   638
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.9-r1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-09-2004 10:42 CET
Last Modified:              02-22-2005 09:42 CET
======================================================================
Summary:                    emerge alsa-driver-1.0.6a fails on kbuild enabled
system
Description: 


My system is kbuild enabled, i.e. the kernel is not built into the
standard /usr/src/linux directory. Only the sourced are here. The kernel
aoutput is in /var/tmp/kernel-output/2.6.9-gentoo-r1, the environment
variable KBUILD_OUTPUT is set correctly. When emerging alsa-driver, the
process fails:

checking for kernel version... The file
/usr/src/linux/include/linux/version.h does not exist.
Please, install the package with full kernel sources for your
distribution
or use --with-kernel=dir option to specify another directory with kernel
sources (default is /lib/modules/2.6.9-gentoo-r1/build).

!!! ERROR: media-sound/alsa-driver-1.0.6a failed.

In fact the missing file is in
/var/tmp/kernel-output/2.6.9-gentoo-r1/include/linux/version.h
which is correct on my system.


======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 10:50 
----------------------------------------------------------------------
Try to specify the kernel source directory with --with-kernel
configure option.

Also, try 1.0.7rc2.  Some improvements have been done since 1.0.6.

----------------------------------------------------------------------
 perex - 02-22-05 09:42 
----------------------------------------------------------------------
No reaction...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-09-04 10:42 eehmke         New Issue                                    
11-09-04 10:42 eehmke         Distribution              => Gentoo          
11-09-04 10:42 eehmke         Kernel Version            => 2.6.9-r1        
11-09-04 10:50 tiwai          Note Added: 0002320                          
02-22-05 09:42 perex          Status                   assigned => resolved
02-22-05 09:42 perex          Resolution               open => fixed       
02-22-05 09:42 perex          Note Added: 0003689                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
