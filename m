From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002232]: Compilation fails of
	alsa-driver
Date: Thu, 29 Jun 2006 17:42:03 +0200
Message-ID: <b2e8f635ebd6cc18c832a85775fffa1c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DBF4429A
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 17:42:03 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2232> 
======================================================================
Reported By:                bNedjar
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2232
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.15-25-686
======================================================================
Date Submitted:             06-25-2006 17:36 CEST
Last Modified:              06-29-2006 17:42 CEST
======================================================================
Summary:                    Compilation fails of alsa-driver
Description: 
I would like to compile alsa-driver 1.0.11 ... I hope this can take into
account my sound chipset (intel ICH7 / Realtek ALC882).

I followed the description in alsa projet site .. and also here :
https://help.ubuntu.com/community/HdaIntelSoundHowto

But always the same problem ... after ./configure, the make compilation
fails ... here is what I get : 

In file included from
/home/nedjar/tempo/alsa-driver-1.0.11/acore/memalloc.inc:1
3,
                 from
/home/nedjar/tempo/alsa-driver-1.0.11/acore/memalloc.c:1:
/home/nedjar/tempo/alsa-driver-1.0.11/include/adriver.h:697: error:
redefinition
 of 'jiffies_to_msecs'
include/linux/jiffies.h:256: error: previous definition of
'jiffies_to_msecs' wa
s here
/home/nedjar/tempo/alsa-driver-1.0.11/include/adriver.h:716: error:
redefinition
 of 'msecs_to_jiffies'
include/linux/jiffies.h:278: error: previous definition of
'msecs_to_jiffies' wa
s here
In file included from
/home/nedjar/tempo/alsa-driver-1.0.11/acore/memalloc.inc:1
3,
                 from
/home/nedjar/tempo/alsa-driver-1.0.11/acore/memalloc.c:1:
/home/nedjar/tempo/alsa-driver-1.0.11/include/adriver.h: In function
'snd_pci_or
ig_save_state':
/home/nedjar/tempo/alsa-driver-1.0.11/include/adriver.h:1048: error: too
many ar
guments to function 'pci_save_state'
/home/nedjar/tempo/alsa-driver-1.0.11/include/adriver.h: In function
'snd_pci_or
ig_restore_state':
/home/nedjar/tempo/alsa-driver-1.0.11/include/adriver.h:1052: error: too
many ar
guments to function 'pci_restore_state'
make[3]: *** [/home/nedjar/tempo/alsa-driver-1.0.11/acore/memalloc.o]
Error 1
make[2]: *** [/home/nedjar/tempo/alsa-driver-1.0.11/acore] Error 2
make[1]: *** [_module_/home/nedjar/tempo/alsa-driver-1.0.11] Error 2
make: *** [compile] Error 2



======================================================================

----------------------------------------------------------------------
 tiwai - 06-29-06 17:42 
----------------------------------------------------------------------
The detection of most kernel functions failed.  Upload config.log.

It's most likely because of a modified kernel by Ubuntu.  Better to ask
Ubunto guys about the incompatibility...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-25-06 17:36 bNedjar        New Issue                                    
06-25-06 17:36 bNedjar        File Added: config-and-make-results               
    
06-25-06 17:36 bNedjar        Distribution              => Ubuntu          
06-25-06 17:36 bNedjar        Kernel Version            => 2.6.15-25-686   
06-29-06 17:42 tiwai          Note Added: 0010674                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
