From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001377]: tons of unknown symbols with 2.6.13 final
Date: Sun, 4 Sep 2005 22:11:43 +0200
Message-ID: <75096aea0858336022ba1d68a4184c33@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9BE5F17C
	for <alsa-devel@alsa-project.org>; Sun,  4 Sep 2005 22:11:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1377> 
======================================================================
Reported By:                spiral
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1377
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Kubuntu Hoary
Kernel Version:             2.6.13 final
======================================================================
Date Submitted:             08-30-2005 09:34 CEST
Last Modified:              09-04-2005 22:11 CEST
======================================================================
Summary:                    tons of unknown symbols with 2.6.13 final
Description: 
Hello !

I have a laptop with a hda-intel based sound card... I recently tried to
update my kernel to 2.6.13 with the official kernel.org source, with
almost the same configuration I have on my 2.6.12.5... This worked nicely
except for alsa, that I tried to build either from 1.0.10rc1 or from cvs
(1.0.9 doesn't handle my sound card so I didn't try to rebuild this one)

In both cases, I can't load snd-hda-intel and I get a lot of unknown
symbol messages in dmesg...

I don't have this problem with my 2.6.12.5, but only with the 2.6.13...
======================================================================

----------------------------------------------------------------------
 tiwai - 09-02-05 19:51 
----------------------------------------------------------------------
Please show the kernel messages wrt unknown symbols.  Otherwise hard to
guess.

----------------------------------------------------------------------
 1g0R - 09-04-05 22:11 
----------------------------------------------------------------------
I have problem too, when i try to compile alsa-driver with intel-hda.
make
...
..
make -C /lib/modules/2.6.13-git4/source
SUBDIRS=/usr/local/src/alsa/alsa-driver-1.0.10rc1
O=/lib/modules/2.6.13-git4/build modules
make[1]: Entering directory `/usr/src/linux-2.6.13'
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.10rc1/acore/memalloc.o
  CC [M]  /usr/local/src/alsa/alsa-driver-1.0.10rc1/acore/sgbuf.o
In file included from
/usr/local/src/alsa/alsa-driver-1.0.10rc1/include/adriver.h:741,
                 from
/usr/local/src/alsa/alsa-driver-1.0.10rc1/acore/sgbuf.c:12:
include/linux/pci.h:819: error: syntax error before numeric constant
make[4]: *** [/usr/local/src/alsa/alsa-driver-1.0.10rc1/acore/sgbuf.o]
Error 1
make[3]: *** [/usr/local/src/alsa/alsa-driver-1.0.10rc1/acore] Error 2
make[2]: *** [_module_/usr/local/src/alsa/alsa-driver-1.0.10rc1] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.13'
make: *** [compile] Error 2
[root@skynet-x2 alsa-driver-1.0.10rc1]#

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-30-05 09:34 spiral         New Issue                                    
08-30-05 09:34 spiral         Distribution              => Kubuntu Hoary   
08-30-05 09:34 spiral         Kernel Version            => 2.6.13 final    
09-02-05 19:51 tiwai          Note Added: 0006017                          
09-04-05 22:11 1g0R           Note Added: 0006038                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
