From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001745]: too few arguments to function `snd_info_entry_ioctl_old' when compile in Kernel 2.4
Date: Tue, 17 Jan 2006 14:07:53 +0100
Message-ID: <eceed5d4451489366483bd7f42ca1808@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 69303160
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2006 14:07:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1745> 
======================================================================
Reported By:                Raymond
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1745
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1 (i386)
Kernel Version:             2.4.22-1.2199.nptl
======================================================================
Date Submitted:             01-14-2006 03:19 CET
Last Modified:              01-17-2006 14:07 CET
======================================================================
Summary:                    too few arguments to function
`snd_info_entry_ioctl_old' when compile in Kernel 2.4
Description: 
gcc32 -D__KERNEL__ -DMODULE=1 -I/alsa/cvs/alsa-driver/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h 
-DKBUILD_BASENAME=info   -c -o info.o info.c
info.c: In function `snd_info_entry_ioctl_old':
info.c:483: warning: passing arg 1 of `snd_info_entry_ioctl_old' from
incompatible pointer type
info.c:483: warning: passing arg 2 of `snd_info_entry_ioctl_old' makes
pointer from integer without a cast
info.c:483: too few arguments to function `snd_info_entry_ioctl_old'
info.c: At top level:
info.c:457: warning: `snd_info_entry_ioctl' defined but not used
make[1]: *** [info.o] Error 1
make[1]: Leaving directory `/alsa/cvs/alsa-driver/acore'
make: *** [compile] Error 1

======================================================================

----------------------------------------------------------------------
 tiwai - 01-17-06 13:08 
----------------------------------------------------------------------
They are all just warnings, right?

----------------------------------------------------------------------
 Raymond - 01-17-06 14:07 
----------------------------------------------------------------------
make will re-compile the whole alsa-driver tree instead of those modified
programs since all programs contain #include <sound/driver.h>

Is it possible to fix the automake issue of alsa/lib in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1641 ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-14-06 03:19 Raymond        New Issue                                    
01-14-06 03:19 Raymond        Distribution              => Fedora Core 1 (i386)
01-14-06 03:19 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
01-14-06 04:26 Raymond        Note Added: 0007652                          
01-16-06 18:10 Raymond        Note Added: 0007690                          
01-17-06 13:08 tiwai          Note Added: 0007699                          
01-17-06 14:07 Raymond        Note Added: 0007700                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
