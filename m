From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001999]: Latest cvs won't compile
Date: Tue, 11 Apr 2006 19:29:28 +0200
Message-ID: <5cca83576518e3de548f36ae6fd95106@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4D691125
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2006 19:29:28 +0200 (MEST)
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
Last Modified:              04-11-2006 19:29 CEST
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
 Raymond - 04-11-06 19:17 
----------------------------------------------------------------------
Even copy whole tree once don't seem to obtain latest version of
speaker-test rev 1.26

cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa login

cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co .



acore         doc         kbuild            pcmcia             synth
arm           drivers     kernel            ppc                test
cards         FAQ         lowlevel          README             TODO
CARDS-STATUS  hal2        Makefile          Rules.make         usb
configure.in  i2c         Makefile.conf.in  Rules.make1        utils
COPYING       include     mips              snddevices.in      version.in
CVS           INSTALL     modules           sparc              WARNING
cvscompile    install-sh  parisc            support
detect        isa         pci               SUPPORTED_KERNELS

The directories in alsa-driver seem different from the previous

acinclude.m4    COPYING     isa               Rules.make    
toplevel.config
aclocal.m4      CVS         Makefile          Rules.make1   
toplevel.config.in
acore           cvscompile  Makefile.conf     scripts        usb
alsa-kernel     doc         Makefile.conf.in  snddevices     utils
arm             drivers     mips              snddevices.in  version
autom4te.cache  FAQ         modules           sound          version.in
CARDS-STATUS    hal2        parisc            sparc          WARNING
config.log      i2c         pci               support
config.status   include     pcmcia            synth
configure       INSTALL     ppc               test
configure.in    install-sh  README            TODO

----------------------------------------------------------------------
 rlrevell - 04-11-06 19:29 
----------------------------------------------------------------------
The directories are different because the build process creates them, so an
alsa-driver tree that has been compiled will appear different from a fresh
checkout.

The rev 1.26 issue seems to be that ALSA CVS has not updated yet

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
