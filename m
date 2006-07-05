From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001999]: Latest cvs won't compile
Date: Thu, 6 Jul 2006 01:05:27 +0200
Message-ID: <dbf09b97e7fcde49d11d1477fe1fa240@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AC21024D
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 01:05:27 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               
Kernel Version:             -2.6.13.2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-03-2006 21:05 CEST
Last Modified:              07-06-2006 01:05 CEST
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
 tiwai - 04-18-06 13:42 
----------------------------------------------------------------------
It's a problem of CVS server on sourceforge.  Cannot fix from here.

----------------------------------------------------------------------
 Adrian Bunk - 07-06-06 01:05 
----------------------------------------------------------------------
I don't see any part of this still present in recent versions.

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
07-06-06 01:05 Adrian Bunk    Note Added: 0010844                          
07-06-06 01:05 Adrian Bunk    Status                   assigned => resolved
07-06-06 01:05 Adrian Bunk    Resolution               open => fixed       
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
