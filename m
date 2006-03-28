From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001972]: can not be maked
Date: Tue, 28 Mar 2006 12:40:03 +0200
Message-ID: <dc3aac1deda3f7469d6e1a8a884d007a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2300C1A0
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2006 12:40:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1972> 
======================================================================
Reported By:                shadowfox
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1972
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandriva 2006
Kernel Version:             2.6.16
======================================================================
Date Submitted:             03-28-2006 12:40 CEST
Last Modified:              03-28-2006 12:40 CEST
======================================================================
Summary:                    can not be maked
Description: 
make -C /lib/modules/2.6.16/source
SUBDIRS=/usr/local/src/alsa/alsa-driver-1.0.10 O=/lib/modules/2.6.16/build
modules
make[1]: Entering directory `/usr/src/kernel-custom/linux-2.6.16'
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.10/acore/hwdep.o
In file included from
/usr/local/src/alsa/alsa-driver-1.0.10/include/adriver.h:770,
                 from
/usr/local/src/alsa/alsa-driver-1.0.10/include/sound/driver.h:42,
                 from
/usr/local/src/alsa/alsa-driver-1.0.10/acore/hwdep.c:22:
include/linux/pci.h:460: error: syntax error before numeric constant
make[4]: *** [/usr/local/src/alsa/alsa-driver-1.0.10/acore/hwdep.o] Error
1
make[3]: *** [/usr/local/src/alsa/alsa-driver-1.0.10/acore] Error 2
make[2]: *** [_module_/usr/local/src/alsa/alsa-driver-1.0.10] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/kernel-custom/linux-2.6.16'
make: *** [compile] Error 2

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-28-06 12:40 shadowfox      New Issue                                    
03-28-06 12:40 shadowfox      File Added: error.log                        
03-28-06 12:40 shadowfox      Distribution              => Mandriva 2006   
03-28-06 12:40 shadowfox      Kernel Version            => 2.6.16          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
