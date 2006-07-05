From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002138]: Getting Compilation Error
	compiling for hda-intel driver
Date: Thu, 6 Jul 2006 00:37:19 +0200
Message-ID: <563bc642a03b3877222ee79dc9248c45@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4BCD0236
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 00:37:19 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2138> 
======================================================================
Reported By:                millerdp
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2138
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2111-FC5
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             05-22-2006 00:38 CEST
Last Modified:              07-06-2006 00:37 CEST
======================================================================
Summary:                    Getting Compilation Error compiling for hda-intel
driver
Description: 
While trying to compile the ALSA drivers for the hda-intel module following
the directions on the web site I get the following error

make[1]: Entering directory `/usr/src/kernels/2.6.16-1.2111_FC5-i686'
  CC [M]  /usr/src/alsa/alsa-driver-1.0.9rc4a/acore/hpetimer.o
In file included from
/usr/src/alsa/alsa-driver-1.0.9rc4a/include/adriver.h:674,                
from /usr/src/alsa/alsa-driver-1.0.9rc4a/include/sound/driver.h:42,
                 from
/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/hpetimer.c:22:
include/linux/pci.h:460: error: expected identifier or &#8216;(&#8217;
before numeric constant
make[4]: *** [/usr/src/alsa/alsa-driver-1.0.9rc4a/acore/hpetimer.o] Error
1
make[3]: *** [/usr/src/alsa/alsa-driver-1.0.9rc4a/acore] Error 2
make[2]: *** [_module_/usr/src/alsa/alsa-driver-1.0.9rc4a] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.16-1.2111_FC5-i686'

======================================================================

----------------------------------------------------------------------
 rlrevell - 05-22-06 04:40 
----------------------------------------------------------------------
You cannot compile an old ALSA against a kernel that contains a newer
ALSA.

What problem are you trying to solve?

----------------------------------------------------------------------
 Raymond - 05-22-06 04:48 
----------------------------------------------------------------------
It seem that you are upgrade from FC3/FC4 to FC5, FC5 bundled with ALSA
1.0.11rc2.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-06 00:38 millerdp       New Issue                                    
05-22-06 00:38 millerdp       File Added: config.status                    
05-22-06 00:38 millerdp       Distribution              => Fedora Core 5   
05-22-06 00:38 millerdp       Kernel Version            => 2.6.16-1.2111-FC5
05-22-06 04:40 rlrevell       Note Added: 0009903                          
05-22-06 04:48 Raymond        Note Added: 0009904                          
07-06-06 00:37 Adrian Bunk    Status                   assigned => closed  
07-06-06 00:37 Adrian Bunk    Resolution               open => not an issue
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
