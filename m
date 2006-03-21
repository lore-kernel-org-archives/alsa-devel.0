From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001934]: make problem
Date: Tue, 21 Mar 2006 17:33:58 +0100
Message-ID: <ae33599e31a15c2a32c839d45c34d2be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BE5E31EF
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2006 17:33:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1934> 
======================================================================
Reported By:                kvo
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1934
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               RHEL4 Update 3
Kernel Version:             2.6.9-34.EL
======================================================================
Date Submitted:             03-17-2006 12:19 CET
Last Modified:              03-21-2006 17:33 CET
======================================================================
Summary:                    make problem
Description: 
./configure works OK. running make give error during compilation: module
'include/asound.h' (line 210) has some 'typedef' that doesn't match with
(probably) OS include. As a result, compilation stops and driver can not
be produced.
======================================================================

----------------------------------------------------------------------
 kvo - 03-19-06 22:26 
----------------------------------------------------------------------
I did the build attempt with the latest CVS, please see results (extract)
below:

make[2]: Entering directory `/usr/src/kernels/2.6.9-34.EL-i686'
  CC [M]  /home/tt/t/alsa-driver/acore/hwdep.o
In file included from /home/tt/t/alsa-driver/include/sound/driver.h:47,
                 from /home/tt/t/alsa-driver/acore/hwdep.c:22:
/home/tt/t/alsa-driver/include/adriver.h:219: error: conflicting types for
'gfp_t'
include/linux/gfp.h:134: error: previous declaration of 'gfp_t' was here
make[5]: *** [/home/tt/t/alsa-driver/acore/hwdep.o] Error 1
make[4]: *** [/home/tt/t/alsa-driver/acore] Error 2
make[3]: *** [_module_/home/tt/t/alsa-driver] Error 2
make[2]: *** [modules] Error 2
make[2]: Leaving directory `/usr/src/kernels/2.6.9-34.EL-i686'
make[1]: *** [compile] Error 2

As a result, the whole build fails.

----------------------------------------------------------------------
 tiwai - 03-21-06 17:33 
----------------------------------------------------------------------
The detection in configure script didn't work by some reason.  Maybe due to
a packed RHEL kernel.  Check config.log.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-06 12:19 kvo            New Issue                                    
03-17-06 12:19 kvo            Distribution              => RHEL4 Update 3  
03-17-06 12:19 kvo            Kernel Version            => 2.6.9-34.EL     
03-17-06 12:25 tiwai          Note Added: 0008643                          
03-19-06 22:26 kvo            Note Added: 0008697                          
03-21-06 17:33 tiwai          Note Added: 0008749                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
