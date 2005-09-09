From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001409]: include/linux/pci.h:819: error: syntax error before numeric constant
Date: Fri, 9 Sep 2005 21:46:08 +0200
Message-ID: <9fc014001eb6d9dd96f6a1c7012c9c0f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 76873197
	for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2005 21:46:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1409> 
======================================================================
Reported By:                Twey
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1409
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.13-homegrown
======================================================================
Date Submitted:             09-09-2005 21:46 CEST
Last Modified:              09-09-2005 21:46 CEST
======================================================================
Summary:                    include/linux/pci.h:819: error: syntax error before
numeric constant
Description: 
Compilation dies with:
make[1]: Entering directory `/usr/src/redhat/BUILD/kernel-2.6.13prep'
  CC [M]  /root/alsa/alsa-driver-1.0.10rc1/acore/sgbuf.o
In file included from
/root/alsa/alsa-driver-1.0.10rc1/include/adriver.h:737,
                 from /root/alsa/alsa-driver-1.0.10rc1/acore/sgbuf.c:12:
include/linux/pci.h:819: error: syntax error before numeric constant
make[4]: *** [/root/alsa/alsa-driver-1.0.10rc1/acore/sgbuf.o] Error 1
make[3]: *** [/root/alsa/alsa-driver-1.0.10rc1/acore] Error 2
make[2]: *** [_module_/root/alsa/alsa-driver-1.0.10rc1] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.6.13prep'
make: *** [compile] Error 2

Applies with --with-cards=all, with-cards=ca0106, and according to the
notes on report 0001377 (see Additional Information, in case someone
removes them for being fairly off-topic), also with intel-hda.  Only with
kernel 2.6.13, though.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-09-05 21:46 Twey           New Issue                                    
09-09-05 21:46 Twey           Distribution              => Fedora Core 4   
09-09-05 21:46 Twey           Kernel Version            => 2.6.13-homegrown
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
