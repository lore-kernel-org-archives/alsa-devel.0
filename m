From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001536]: Error during compiling hpetimer.c
Date: Wed, 9 Nov 2005 21:29:52 +0100
Message-ID: <60111786274adc46eccaea44da53fd7a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2B2741D6
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2005 21:29:53 +0100 (MET)
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
Last Modified:              11-09-2005 21:29 CET
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
 spm - 11-09-05 00:27 
----------------------------------------------------------------------
You are correct, line 392 is:

int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);

My mobo is VIA if that helps...

So what can I do?



----------------------------------------------------------------------
 spm - 11-09-05 21:29 
----------------------------------------------------------------------
So, did you review the config? What is is telling you?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-05 15:54 spm            New Issue                                    
11-08-05 15:54 spm            Distribution              => Debian          
11-08-05 15:54 spm            Kernel Version            => 2.6.14-rc3      
11-08-05 18:18 Clemens LadischNote Added: 0006629                          
11-08-05 18:28 tiwai          Note Added: 0006631                          
11-08-05 18:48 spm            File Added: config.log                       
11-08-05 18:49 spm            Note Added: 0006638                          
11-09-05 00:27 spm            Note Edited: 0006638                         
11-09-05 21:29 spm            Note Added: 0006656                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
