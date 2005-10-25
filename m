From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001488]: alsa-driver CVS 10-21-2005 fails to build with kernel-suse-2.4.21-297
Date: Tue, 25 Oct 2005 09:33:16 +0200
Message-ID: <d9530bac197842684ad0e7e6776f7d5e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3FA2F186
	for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2005 09:33:16 +0200 (MEST)
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


The following issue has been REOPENED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1488> 
======================================================================
Reported By:                roadrunner
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1488
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               suse linux
Kernel Version:             Linux version 2.4.21-297-default (root@i386.suse.de)
(gcc version 3.3.1 (SuSE Linux)) #1 Sat Jul 23 07:47:3 UTC 20059
======================================================================
Date Submitted:             10-21-2005 13:34 CEST
Last Modified:              10-25-2005 09:33 CEST
======================================================================
Summary:                    alsa-driver CVS 10-21-2005 fails to build with
kernel-suse-2.4.21-297
Description: 
Building alsa-driver CVS 10-21-2005 fails.
command:

./cvscompile --with-cards=ca0106

output (complete output attached):
[...]
gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1
-I/home/erik/archiv/alsa-cvs/alsa-driver/include 
-I/lib/modules/2.4.21-297-default/build/include -O2  -DLINUX -DALSA_BUILD
-nostdinc -iwithprefix include  ac97_codec.c ac97_pcm.c ac97_patch.c
ac97_proc.c > .depend
make[2]: Leaving directory
`/home/erik/archiv/alsa-cvs/alsa-driver/pci/ac97'
make  -C ali5451 fastdep
make[2]: Entering directory
`/home/erik/archiv/alsa-cvs/alsa-driver/pci/ali5451'
/home/erik/archiv/alsa-cvs/alsa-driver/include/sndversions.h was not
updated
make[2]: Leaving directory
`/home/erik/archiv/alsa-cvs/alsa-driver/pci/ali5451'
make  -C asihpi fastdep
make[2]: Entering directory
`/home/erik/archiv/alsa-cvs/alsa-driver/pci/asihpi'
/home/erik/archiv/alsa-cvs/alsa-driver/include/sndversions.h was not
updated
make[2]: Leaving directory
`/home/erik/archiv/alsa-cvs/alsa-driver/pci/asihpi'
make  -C au88x0 fastdep
make[2]: Entering directory
`/home/erik/archiv/alsa-cvs/alsa-driver/pci/au88x0'
/home/erik/archiv/alsa-cvs/alsa-driver/include/sndversions.h was not
updated
make[2]: Leaving directory
`/home/erik/archiv/alsa-cvs/alsa-driver/pci/au88x0'
make  -C ca0106 fastdep
make[2]: Entering directory
`/home/erik/archiv/alsa-cvs/alsa-driver/pci/ca0106'
/home/erik/archiv/alsa-cvs/alsa-driver/include/sndversions.h was not
updated
make[2]: *** No rule to make target `ca_midi.c', needed by `fastdep'. 
Stop.
make[2]: Leaving directory
`/home/erik/archiv/alsa-cvs/alsa-driver/pci/ca0106'
make[1]: *** [_sfdep_ca0106] Error 2
make[1]: Leaving directory `/home/erik/archiv/alsa-cvs/alsa-driver/pci'
make: *** [dep] Error 1


======================================================================

----------------------------------------------------------------------
 tiwai - 10-21-05 14:53 
----------------------------------------------------------------------
Already fixed.

----------------------------------------------------------------------
 roadrunner - 10-25-05 09:33 
----------------------------------------------------------------------
Build still fails in CVS 10-25-2005:

command: ./cvscompile --with-cards=ca0106

output:
[...]
make[2]: Entering directory
`/home/erik/archiv/alsa-cvs/alsa-driver/pci/ac97'
gcc -D__KERNEL__ -DMODULE=1
-I/home/erik/archiv/alsa-cvs/alsa-driver/include 
-I/lib/modules/2.4.21-297-default/build/include -O2  -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix
include -DMODVERSIONS -include
/lib/modules/2.4.21-297-default/build/include/linux/modversions.h  
-DEXPORT_SYMTAB -c ac97_codec.c
In file included from ac97_codec.c:33:
/home/erik/archiv/alsa-cvs/alsa-driver/include/sound/ac97_codec.h:517:
error: field `dev' has incomplete type
make[2]: *** [ac97_codec.o] Fehler 1
make[2]: Leaving directory
`/home/erik/archiv/alsa-cvs/alsa-driver/pci/ac97'
make[1]: *** [_modsubdir_ac97] Fehler 2
make[1]: Leaving directory `/home/erik/archiv/alsa-cvs/alsa-driver/pci'
make: *** [compile] Fehler 1

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-05 13:34 roadrunner     New Issue                                    
10-21-05 13:34 roadrunner     File Added: compile.log                      
10-21-05 13:34 roadrunner     Distribution              => suse linux      
10-21-05 13:34 roadrunner     Kernel Version            => Linux version
2.4.21-297-default (root@i386.suse.de) (gcc version 3.3.1 (SuSE Linux)) #1 Sat
Jul 23 07:47:3 UTC 20059
10-21-05 14:53 tiwai          Status                   assigned => resolved
10-21-05 14:53 tiwai          Resolution               open => fixed       
10-21-05 14:53 tiwai          Note Added: 0006511                          
10-25-05 09:33 roadrunner     Status                   resolved => feedback
10-25-05 09:33 roadrunner     Resolution               fixed => reopened   
10-25-05 09:33 roadrunner     Note Added: 0006528                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
