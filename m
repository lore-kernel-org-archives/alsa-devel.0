From: Ivica Bukvic <ico@fuse.net>
Subject: Failed to compile HDSP driver from the CVS
Date: 14 May 2002 02:51:34 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1021359094.22878.8.camel@badass-bukvic.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mta03.fuse.net (mx3.fuse.net [216.68.1.123])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA20797
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 08:51:56 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: pbd@op.net, ico@fuse.net
List-Id: alsa-devel@alsa-project.org

Hi all!

First off, thank you very much for the awesome news Paul, I am extatic
to hear that HDSP driver is ready! :-)

However, I've been trying to compile it from the CVS and no matter what
I try I get the same error:

<snip>

make  -C rme9652 fastdep
make[2]: Entering directory
`/LocalDump/Install/Alsa/CVS/alsa-driver/pci/rme9652'
/LocalDump/Install/Alsa/CVS/alsa-driver/include/sndversions.h was not
updated
gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1
-I/LocalDump/Install/Alsa/CVS/alsa-driver/include
-I/lib/modules/2.4.8-26mdk/build/include -O2
-mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -pipe  -E -D__GENKSYMS__
hammerfall_mem.c
| /sbin/genksyms -k 2.4.8  >
/LocalDump/Install/Alsa/CVS/alsa-driver/include/modules/pci-rme9652__hammerfall_mem.ver.tmp
mv
/LocalDump/Install/Alsa/CVS/alsa-driver/include/modules/pci-rme9652__hammerfall_mem.ver.tmp /LocalDump/Install/Alsa/CVS/alsa-driver/include/modules/pci-rme9652__hammerfall_mem.ver
gcc -E -M -DALSA_BUILD -D__KERNEL__ -DMODULE=1
-I/LocalDump/Install/Alsa/CVS/alsa-driver/include
-I/lib/modules/2.4.8-26mdk/build/include -O2
-mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -pipe  hammerfall_mem.c hdsp.c
rme9652.c rme9652_mem.c > .depend
In file included from ../../alsa-kernel/pci/rme9652/hdsp.c:38,
                 from hdsp.c:1:
../../alsa-kernel/pci/rme9652/digiface_firmware.dat:4884:26: warning: no
newline at end of file
rme9652_mem.c:45:55: ../../alsa-kernel/pci/rme9652/rme9652_mem.c: No
such file or directory make[2]: *** [fastdep] Error 1
make[2]: Leaving directory
`/LocalDump/Install/Alsa/CVS/alsa-driver/pci/rme9652'
make[1]: *** [_sfdep_rme9652] Error 2
make[1]: Leaving directory `/LocalDump/Install/Alsa/CVS/alsa-driver/pci'
make: *** [dep] Error 1

I am not sure what this means, since there is no rme9652_mem.c file at
all in the alsa-kernel/pci/rme9652/ folder. Is this the way it's
supposed to be?

I tried soft-linking the rme9652_mem.c to hammerfall_mem.c without
success. I also tried copying the older driver's rme9652_mem.c into the
same folder. But, that gives me a different error:

make  -C rme9652 modules
make[3]: Entering directory
`/LocalDump/Install/Alsa/CVS/alsa-driver/pci/rme9652'
gcc -DALSA_BUILD -D__KERNEL__ -DMODULE=1
-I/LocalDump/Install/Alsa/CVS/alsa-driver/include
-I/lib/modules/2.4.8-26mdk/build/include -O2
-mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -pipe   -DEXPORT_SYMTAB -c
hammerfall_mem.c In file included from hammerfall_mem.c:1:
../../alsa-kernel/pci/rme9652/hammerfall_mem.c:58: parse error before
string constant
../../alsa-kernel/pci/rme9652/hammerfall_mem.c:58: warning: type
defaults to `int' in declaration of `MODULE_LICENSE'
../../alsa-kernel/pci/rme9652/hammerfall_mem.c:58: warning: function
declaration isn't a prototype
../../alsa-kernel/pci/rme9652/hammerfall_mem.c:58: warning: data
definition has no type or storage class
make[3]: *** [hammerfall_mem.o] Error 1
make[3]: Leaving directory
`/LocalDump/Install/Alsa/CVS/alsa-driver/pci/rme9652'
make[2]: *** [_modsubdir_rme9652] Error 2
make[2]: Leaving directory `/LocalDump/Install/Alsa/CVS/alsa-driver/pci'
make[1]: *** [compile] Error 1
make[1]: Leaving directory `/LocalDump/Install/Alsa/CVS/alsa-driver'
make: *** [build] Error 2

Any insight into this one would be utmostly appreciated.

BTW, I am using MDK 8.1 (modified somewhat) and I just noticed that
there is still some rpm junk lingering around from the 0.5.11 version
that shipped with the MDK (even though I've been using the 0.9 version
for a while now and 0.5 seemed not to bother 0.9).

Finally, the question regarding the CVS compiling:

Do I still need to specify the --have-sequencer=yes flag or is this now
being done automatically?

Thank you for your help! Sincerely,

Ico




_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
