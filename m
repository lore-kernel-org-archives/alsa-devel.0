From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001999]: Latest cvs won't compile
Date: Mon, 3 Apr 2006 21:05:41 +0200
Message-ID: <68c184a3bdd9435888fbd7df43aea2ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C0A2D15A
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2006 21:05:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1999> 
======================================================================
Reported By:                kotau
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1999
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             -2.6.13.2
======================================================================
Date Submitted:             04-03-2006 21:05 CEST
Last Modified:              04-03-2006 21:05 CEST
======================================================================
Summary:                    Latest cvs won't compile
Description: 
Here's the error message.


==============
make[1]: Entering directory `/usr/src/linux-2.6.13.2'
  CC [M]  /usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.o
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c: In function
`snd_ac97_proc_read_main':
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c:122: error:
`snd_ac97_stereo_enhancements' undeclared (first use in this function)
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c:122: error:
(Each undeclared identifier is reported only once
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c:122: error:
for each function it appears in.)
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c: In function
`snd_ac97_proc_read':
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c:294: warning:
implicit declaration of function `snd_magic_cast'
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c:294: error:
parse error before "ac97_t"
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c:296: error:
structure has no member named `semaphore'
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c:322: error:
structure has no member named `semaphore'
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c: In function
`snd_ac97_proc_regs_read':
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c:359: error:
parse error before "ac97_t"
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c:361: error:
structure has no member named `semaphore'
/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.c:377: error:
structure has no member named `semaphore'
make[5]: *** [/usr/local/src/1music/alsa/alsa-driver/pci/ac97/ac97_proc.o]
Error 1
make[4]: *** [/usr/local/src/1music/alsa/alsa-driver/pci/ac97] Error 2
make[3]: *** [/usr/local/src/1music/alsa/alsa-driver/pci] Error 2
make[2]: *** [_module_/usr/local/src/1music/alsa/alsa-driver] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.13.2'

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-06 21:05 kotau          New Issue                                    
04-03-06 21:05 kotau          Kernel Version            => -2.6.13.2       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
