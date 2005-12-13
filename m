From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000989]: Compilation issues with [sparc] cs4231.c and kernel 2.4.29
Date: Tue, 13 Dec 2005 12:44:47 +0100
Message-ID: <38edc76fde2ef958ddeb69adf0fc17ec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B8EC21C1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 12:44:47 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=989> 
======================================================================
Reported By:                lmartinking
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   989
Category:                   SPARC - cs4231
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo Linux
Kernel Version:             Host kernel 2.6.10, build kernel 2.4.29 (with gentoo
sparc patches)
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-14-2005 04:21 CET
Last Modified:              12-13-2005 12:44 CET
======================================================================
Summary:                    Compilation issues with [sparc] cs4231.c and kernel
2.4.29
Description: 
I sucessfully compiled linux kernel 2.4.29 using gcc 3.4.3 (on x86)
Alsa mostly compiles, but failes when compiling sparc/cs4231.c
I also tried using gcc 2.95 (on sparc), and it failed in the same way
(mangled symbols or something strange)

=== GCC ===

$ sparc-unknown-linux-gnu-gcc --version
sparc-unknown-linux-gnu-gcc (GCC) 3.4.3-20050110 (Gentoo Linux
3.4.3.20050110, ssp-3.4.3.20050110-0, pie-8.7.7)


=== Configure command ===

./configure --with-cross=sparc-unknown-linux-gnu-
--with-kernel=/usr/src/linux-2.4.29-sparc/
--with-build=/usr/src/linux-2.4.29-sparc/ --with-oss=no
--with-sequencer=yes --with-cards=sun-cs4231

=== Errors ===

make[1]: Entering directory `/tmp/alsa/alsa-driver-1.0.8/sparc'
sparc-unknown-linux-gnu-gcc  -D__KERNEL__ -DMODULE=1
-I/tmp/alsa/alsa-driver-1.0.8/include  -I/usr/src/linux-2
.4.29-sparc//include -I/usr/src/linux-2.4.29-sparc//include -O2 -m32
-mno-fpu -fcall-used-g5 -fcall-used-g7 -D
LINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe
 -DALSA_BUILD -nostdinc -iwithprefix include  -DKBUILD_BASENAME=cs4231  
-c -o cs4231.o cs4231.c
In file included from /tmp/alsa/alsa-driver-1.0.8/include/adriver.h:307,
                 from
/tmp/alsa/alsa-driver-1.0.8/include/sound/driver.h:42,
                 from ../alsa-kernel/sparc/cs4231.c:20,
                 from cs4231.c:1:   
/usr/src/linux-2.4.29-sparc//include/linux/devfs_fs_kernel.h: In function
`devfs_register_chrdev_Rb16a1c84':
/usr/src/linux-2.4.29-sparc//include/linux/devfs_fs_kernel.h:247: warning:
implicit declaration of function `r
egister_chrdev_R19f3d1f7'           
/usr/src/linux-2.4.29-sparc//include/linux/devfs_fs_kernel.h: In function
`devfs_register_blkdev_Racfe18c3':
/usr/src/linux-2.4.29-sparc//include/linux/devfs_fs_kernel.h:252: warning:
implicit declaration of function `r
egister_blkdev_Rb7bcf4d7'           
/usr/src/linux-2.4.29-sparc//include/linux/devfs_fs_kernel.h: In function
`devfs_unregister_chrdev_Rc86dd8e6':
/usr/src/linux-2.4.29-sparc//include/linux/devfs_fs_kernel.h:256: warning:
implicit declaration of function `u
nregister_chrdev_Rc192d491'         
/usr/src/linux-2.4.29-sparc//include/linux/devfs_fs_kernel.h: In function
`devfs_unregister_blkdev_Re33ec8d8':
/usr/src/linux-2.4.29-sparc//include/linux/devfs_fs_kernel.h:260: warning:
implicit declaration of function `u
nregister_blkdev_Reac1c4af'
In file included from ../alsa-kernel/sparc/cs4231.c:21,
                 from cs4231.c:1:   
/tmp/alsa/alsa-driver-1.0.8/include/sound/core.h: In function
`snd_timestamp_now':
/tmp/alsa/alsa-driver-1.0.8/include/sound/core.h:472: warning: implicit
declaration of function `do_gettimeofday_R72270e35'                      

In file included from cs4231.c:1:   
../alsa-kernel/sparc/cs4231.c: In function `snd_cs4231_outm':
../alsa-kernel/sparc/cs4231.c:402: warning: implicit declaration of
function `udelay_Ra39b4cf2'
../alsa-kernel/sparc/cs4231.c: In function `snd_cs4231_pcm_R5bb6d4c8':
../alsa-kernel/sparc/cs4231.c:1563: warning: implicit declaration of
function `strcpy_Re914e41e'
../alsa-kernel/sparc/cs4231.c: In function `snd_cs4231_sbus_free':
../alsa-kernel/sparc/cs4231.c:1936: warning: implicit declaration of
function `free_irq_Rf20dabd8'
../alsa-kernel/sparc/cs4231.c:1939: warning: passing arg 1 of
`sbus_iounmap_R2b990f27' makes integer from pointer without a cast        
         
../alsa-kernel/sparc/cs4231.c:1944: warning: implicit declaration of
function `kfree_R037a0cba'
../alsa-kernel/sparc/cs4231.c: In function `snd_cs4231_sbus_create':
../alsa-kernel/sparc/cs4231.c:1983: warning: assignment makes pointer from
integer without a cast
../alsa-kernel/sparc/cs4231.c:1989: warning: implicit declaration of
function `request_irq_Rb9ba6802'
../alsa-kernel/sparc/cs4231.c: In function `cs4231_sbus_attach':
../alsa-kernel/sparc/cs4231.c:2026: warning: implicit declaration of
function `sprintf_R1d26aa98'
../alsa-kernel/sparc/cs4231.c: In function `cs4231_init':
../alsa-kernel/sparc/cs4231.c:2194: error: `sbus_root_R4b91b1b6'
undeclared (first use in this function)
../alsa-kernel/sparc/cs4231.c:2194: error: (Each undeclared identifier is
reported only once
../alsa-kernel/sparc/cs4231.c:2194: error: for each function it appears
in.)
../alsa-kernel/sparc/cs4231.c:2195: warning: implicit declaration of
function `strcmp_Re2d5255a'
make[1]: *** [cs4231.o] Error 1     
make[1]: Leaving directory `/tmp/alsa/alsa-driver-1.0.8/sparc'
make: *** [compile] Error 1

=== End ===
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 10:04 
----------------------------------------------------------------------
Can you supply a patch to fix the problem?

----------------------------------------------------------------------
 jdthood - 12-13-05 12:44 
----------------------------------------------------------------------
Local kernel symbol version mismatch problem

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-05 04:21 lmartinking    New Issue                                    
03-14-05 04:21 lmartinking    Distribution              => Gentoo Linux    
03-14-05 04:21 lmartinking    Kernel Version            => Host kernel 2.6.10,
build kernel 2.4.29 (with gentoo sparc patches)
03-19-05 10:04 jdthood        Note Added: 0004030                          
12-13-05 12:44 jdthood        Status                   new => closed       
12-13-05 12:44 jdthood        Note Added: 0006999                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
