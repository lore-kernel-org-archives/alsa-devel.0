From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000605]: memalloc.c:53 build error
Date: Wed, 27 Oct 2004 15:58:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3e7874c5b308994a004af1b078b8f6dc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 832C127D
	for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2004 15:58:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=605> 
======================================================================
Reported By:                Andrew
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   605
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             10-26-2004 12:37 CEST
Last Modified:              10-27-2004 15:58 CEST
======================================================================
Summary:                    memalloc.c:53 build error
Description: 
GCC 3.3.4 is in use.
./cvscomile for current CVS tree shows:

make[1]: Entering directory `/usr/src/linux-2.6.9-gentoo-r1'
  CC [M]  /wrk/cvs/alsa/alsa-driver/kbuild/../acore/memalloc.o
/wrk/cvs/alsa/alsa-driver/acore/memalloc.c:53: error: invalid lvalue in
unary `&'
/wrk/cvs/alsa/alsa-driver/acore/memalloc.c:53: error: initializer element
is not constant
/wrk/cvs/alsa/alsa-driver/acore/memalloc.c:53: error: (near initialization
for `__param_arr_enable.num')
make[4]: *** [/wrk/cvs/alsa/alsa-driver/kbuild/../acore/memalloc.o] Error
1

======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 10-27-04 15:58 
----------------------------------------------------------------------
I get the same (compiling for vanilla 2.6.9 kernel with gcc 2.95.3).

I guess the latest module_param_array change isn't compatible with an old
kernel like this. :-)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-26-04 12:37 Andrew         New Issue                                    
10-27-04 15:58 Clemens LadischNote Added: 0002274                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
