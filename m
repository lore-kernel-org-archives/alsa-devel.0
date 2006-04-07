From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001999]: Latest cvs won't compile
Date: Fri, 7 Apr 2006 14:12:19 +0200
Message-ID: <36c28a24eebaddc50f575c88e76201ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0DC88155
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2006 14:12:20 +0200 (MEST)
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
Last Modified:              04-07-2006 14:12 CEST
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
 Raymond - 04-04-06 09:58 
----------------------------------------------------------------------
snd_ac97_stereo_enhancements still exist in rev 1.17

http://cvs.sourceforge.net/viewcvs.py/*checkout*/alsa/alsa-kernel/pci/ac97/ac97_proc.c?rev=1.17

snd_magic_cast() had been removed

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/ac97/ac97_proc.c?r1=1.8&r2=1.9

Make sure your cvs is up-to-date

----------------------------------------------------------------------
 Raymond - 04-07-06 14:12 
----------------------------------------------------------------------
It seem to me that there is a problem on cvs 

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-utils/speaker-test/

speaker-test.c 	 1.25 	 8 days 	 tiwai 	 Summary: Remove loops after
errors Don't retry after fatal errors.

http://sourceforge.net/mailarchive/forum.php?thread_id=10120162&forum_id=33141

cvs -z3 update -P -d

cannot retrieve rev 1.26 of speaker-test

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-06 21:05 kotau          New Issue                                    
04-03-06 21:05 kotau          Kernel Version            => -2.6.13.2       
04-04-06 09:58 Raymond        Note Added: 0009112                          
04-07-06 14:12 Raymond        Note Added: 0009139                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
