From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002256]: timer.h doesn't compile with
	-ansi
Date: Tue, 4 Jul 2006 07:01:59 +0200
Message-ID: <974473c134be0f3320a6698782486c11@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2AD4C18E
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Jul 2006 07:02:00 +0200 (MEST)
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
Last Modified:              07-04-2006 07:01 CEST
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
 joeljkp - 07-04-06 07:01 
----------------------------------------------------------------------
Adding the following line at the top of asoundlib.h, timer.h, or above the
#include <time.h> in global.h fixes the problem.

#define _POSIX_C_SOURCE 199506L

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-04-06 05:51 joeljkp        New Issue                                    
07-04-06 05:52 joeljkp        Issue Monitored: joeljkp                     
07-04-06 07:01 joeljkp        Note Added: 0010815                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
