From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002256]: timer.h doesn't compile with
	-ansi
Date: Thu, 6 Jul 2006 05:06:50 +0200
Message-ID: <a0f6cce3d6e13c458340db9e7faf9db9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A9593259
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 05:06:50 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2256> 
======================================================================
Reported By:                joeljkp
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2256
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-04-2006 05:51 CEST
Last Modified:              07-06-2006 05:06 CEST
======================================================================
Summary:                    timer.h doesn't compile with -ansi
Description: 
timer.h causes programs not to compile with gcc 4.0.3 and -ansi:

$ cat test.c
#include <alsa/asoundlib.h>
$ cc -c -ansi test.c
In file included from /usr/include/alsa/asoundlib.h:51,
                 from test.c:1:
/usr/include/alsa/timer.h:108: error: field &#8216;tstamp&#8217; has
incomplete type
$
======================================================================

----------------------------------------------------------------------
 tiwai - 07-05-06 15:31 
----------------------------------------------------------------------
The patch results in compile warnings of alsa-lib itself.
I'm also a bit concerned to define it in that place, too...

----------------------------------------------------------------------
 joeljkp - 07-06-06 05:06 
----------------------------------------------------------------------
Ok, a new patch is uploaded.

When -ansi is not specified, glibc defines _POSIX_C_SOURCE, but when -ansi
is specified, is does not. Therefore, ALSA should define it explicitly at
the very beginning if it intends to use POSIX features like timespec.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-04-06 05:51 joeljkp        New Issue                                    
07-04-06 05:52 joeljkp        Issue Monitored: joeljkp                     
07-04-06 07:01 joeljkp        Note Added: 0010815                          
07-04-06 18:43 joeljkp        File Added: bug2256.patch                    
07-05-06 15:31 tiwai          Note Added: 0010840                          
07-06-06 05:04 joeljkp        File Added: bug2256-1.patch                    
07-06-06 05:06 joeljkp        Note Added: 0010852                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
