From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000755]: get error when trying to build 1.0.5 drivers with kernel 2.6.10
Date: Tue, 31 May 2005 18:03:58 +0200
Message-ID: <e151bbaae5f18cf1039fef5c6b4783a4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E313D1DC
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:58 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=755> 
======================================================================
Reported By:                wschrep
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   755
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               knoppmyth r4v5
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-29-2004 00:50 CET
Last Modified:              05-31-2005 18:03 CEST
======================================================================
Summary:                    get error when trying to build 1.0.5 drivers with
kernel 2.6.10
Description: 
make -C /lib/modules/2.6.10/build
SUBDIRS=/root/alsa/alsa-driver-1.0.5/kbuild modules
make[1]: Entering directory `/usr/src/linux-2.6.10'
  CC [M]  /root/alsa/alsa-driver-1.0.5/kbuild/../acore/hwdep.o
  CC [M]  /root/alsa/alsa-driver-1.0.5/kbuild/../acore/memalloc.o
/root/alsa/alsa-driver-1.0.5/acore/memalloc.c:54: error: initializer
element is not constant
/root/alsa/alsa-driver-1.0.5/acore/memalloc.c:54: error: (near
initialization for `__param_arr_enable.num')
make[3]: *** [/root/alsa/alsa-driver-1.0.5/kbuild/../acore/memalloc.o]
Error 1
make[2]: *** [/root/alsa/alsa-driver-1.0.5/kbuild/../acore] Error 2
make[1]: *** [_module_/root/alsa/alsa-driver-1.0.5/kbuild] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.10'
make: *** [compile] Error 2
root@mythtv:~/alsa/alsa-driver-1.0.5 # uname -r
2.6.10
root@mythtv:~/alsa/alsa-driver-1.0.5 # gcc --version
gcc (GCC) 3.3.2 20030812 (Debian prerelease)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is
NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.


======================================================================

----------------------------------------------------------------------
 rlrevell - 12-29-04 00:56 
----------------------------------------------------------------------
Please don't report bugs for old ALSA versions.  Try 1.0.8-rc1.

----------------------------------------------------------------------
 perex - 02-22-05 09:46 
----------------------------------------------------------------------
No reaction.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-04 00:50 wschrep        New Issue                                    
12-29-04 00:50 wschrep        Distribution              => knoppmyth r4v5  
12-29-04 00:50 wschrep        Kernel Version            => 2.6.10          
12-29-04 00:56 rlrevell       Note Added: 0002988                          
02-22-05 09:46 perex          Status                   assigned => resolved
02-22-05 09:46 perex          Resolution               open => fixed       
02-22-05 09:46 perex          Note Added: 0003692                          
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
