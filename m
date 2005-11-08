From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001536]: Error during compiling hpetimer.c
Date: Tue, 8 Nov 2005 18:28:27 +0100
Message-ID: <19482f4b05752e67f8959ff03b8b3ba0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 073C81BB
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 18:28:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1536> 
======================================================================
Reported By:                spm
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1536
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.14-rc3
======================================================================
Date Submitted:             11-08-2005 15:54 CET
Last Modified:              11-08-2005 18:28 CET
======================================================================
Summary:                    Error during compiling hpetimer.c
Description: 
This error occurs when trying to make 1.09b driver on my 2.6.14-rc3
kernel.

make[1]: Entering directory `/usr/src/linux-2.6.14-rc3'
  CC [M]  /usr/src/alsa/alsa-driver-1.0.9b/acore/hpetimer.o
In file included from
/usr/src/alsa/alsa-driver-1.0.9b/include/adriver.h:677,
                 from
/usr/src/alsa/alsa-driver-1.0.9b/include/sound/driver.h:42,
                 from
/usr/src/alsa/alsa-driver-1.0.9b/acore/hpetimer.c:22:
include/linux/pci.h:392: error: parse error before numeric constant
make[4]: *** [/usr/src/alsa/alsa-driver-1.0.9b/acore/hpetimer.o] Error 1
make[3]: *** [/usr/src/alsa/alsa-driver-1.0.9b/acore] Error 2


Any ideas? I have also tried on the development release
(alsa-driver-1.0.10rc2), and get the same error..


======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-08-05 18:18 
----------------------------------------------------------------------
What is line 392 in the include/linux/pci.h file in your kernel source?

----------------------------------------------------------------------
 tiwai - 11-08-05 18:28 
----------------------------------------------------------------------
It's likely pci_set_consistent_dma_mask().  That is, configure script
didn't detect it correctly.  Please upload config.log for checking.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-05 15:54 spm            New Issue                                    
11-08-05 15:54 spm            Distribution              => Debian          
11-08-05 15:54 spm            Kernel Version            => 2.6.14-rc3      
11-08-05 18:18 Clemens LadischNote Added: 0006629                          
11-08-05 18:28 tiwai          Note Added: 0006631                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
