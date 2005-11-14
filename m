From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001409]: include/linux/pci.h:819: error: syntax error before numeric constant
Date: Mon, 14 Nov 2005 10:02:08 +0100
Message-ID: <95ae29a44e933e576e187460e5158f11@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D22C619D
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 10:02:08 +0100 (MET)
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


The following issue requires your FEEDBACK.
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
Status:                     feedback
Distribution:               Fedora Core 4
Kernel Version:             2.6.13-homegrown
======================================================================
Date Submitted:             09-09-2005 21:46 CEST
Last Modified:              11-14-2005 10:02 CET
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

----------------------------------------------------------------------
 quetzyg - 09-27-05 12:03 
----------------------------------------------------------------------
I've got the same pci.h problem when compiling ALSA 1.0.10-rc1 for a
HDA-Intel soundcard, but only on 2.6.14-rc* kernels. 2.6.13.* kernels
don't give me problems.



----------------------------------------------------------------------
 perex - 11-14-05 10:02 
----------------------------------------------------------------------
Could you try with 1.0.10rc3?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-09-05 21:46 Twey           New Issue                                    
09-09-05 21:46 Twey           Distribution              => Fedora Core 4   
09-09-05 21:46 Twey           Kernel Version            => 2.6.13-homegrown
09-09-05 21:46 Twey           Issue Monitored: Twey                        
09-27-05 12:00 quetzyg        Note Added: 0006405                          
09-27-05 12:02 quetzyg        Note Edited: 0006405                         
09-27-05 12:03 quetzyg        Note Edited: 0006405                         
11-14-05 10:02 perex          Note Added: 0006701                          
11-14-05 10:02 perex          Status                   assigned => feedback
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
