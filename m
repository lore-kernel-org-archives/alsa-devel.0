From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001745]: too few arguments to function `snd_info_entry_ioctl_old' when compile in Kernel 2.4
Date: Sat, 14 Jan 2006 04:26:06 +0100
Message-ID: <348a397f2ada45fa8fff72345b139e34@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 92A21134
	for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2006 04:26:06 +0100 (MET)
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
Last Modified:              01-14-2006 04:26 CET
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
 Raymond - 01-14-06 04:26 
----------------------------------------------------------------------
RCS file: /cvsroot/alsa/alsa-driver/acore/info.patch,v
retrieving revision 1.6
diff -u -r1.6 info.patch
--- alsa-driver/acore/info.patch	9 Jan 2006 17:09:15 -0000	1.6
+++ alsa-driver/acore/info.patch	14 Jan 2006 03:13:44 -0000
@@ -60,7 +60,7 @@
 +{
 +	int err;
 +	unlock_kernel();
-+	err = snd_info_entry_ioctl_old(file, cmd, arg);
++	err = snd_info_entry_ioctl(file, cmd, arg);
 +	lock_kernel();
 +	return err;
 +}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-14-06 03:19 Raymond        New Issue                                    
01-14-06 03:19 Raymond        Distribution              => Fedora Core 1 (i386)
01-14-06 03:19 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
01-14-06 04:26 Raymond        Note Added: 0007652                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
