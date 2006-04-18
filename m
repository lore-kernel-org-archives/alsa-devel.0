From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001999]: Latest cvs won't compile
Date: Tue, 18 Apr 2006 13:42:48 +0200
Message-ID: <dc9af7576fe39a58cc35bb8b28145b62@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1FE02127
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 13:42:49 +0200 (MEST)
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
Last Modified:              04-18-2006 13:42 CEST
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

----------------------------------------------------------------------
 Raymond - 04-13-06 13:47 
----------------------------------------------------------------------
alsa-1.0.11rc5 tag still missing in

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/ac97/

Which tag is used to retreive the latest version ?

----------------------------------------------------------------------
 tiwai - 04-18-06 13:42 
----------------------------------------------------------------------
It's a problem of CVS server on sourceforge.  Cannot fix from here.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-06 21:05 kotau          New Issue                                    
04-03-06 21:05 kotau          Kernel Version            => -2.6.13.2       
04-04-06 09:58 Raymond        Note Added: 0009112                          
04-07-06 14:12 Raymond        Note Added: 0009139                          
04-07-06 14:16 Raymond        Note Edited: 0009139                         
04-11-06 19:17 Raymond        Note Added: 0009236                          
04-11-06 19:29 rlrevell       Note Added: 0009237                          
04-11-06 19:53 Raymond        Note Added: 0009238                          
04-13-06 13:47 Raymond        Note Added: 0009258                          
04-18-06 13:42 tiwai          Note Added: 0009332                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
