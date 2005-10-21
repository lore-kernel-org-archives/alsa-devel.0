From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001488]: alsa-driver CVS 10-21-2005 fails to build with kernel-suse-2.4.21-297
Date: Fri, 21 Oct 2005 13:34:52 +0200
Message-ID: <5f107c5a3391e17bec57f82fe8e7387b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 114F9170
	for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2005 13:34:52 +0200 (MEST)
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
Status:                     assigned
Distribution:               suse linux
Kernel Version:             Linux version 2.4.21-297-default (root@i386.suse.de)
(gcc version 3.3.1 (SuSE Linux)) #1 Sat Jul 23 07:47:3 UTC 20059
======================================================================
Date Submitted:             10-21-2005 13:34 CEST
Last Modified:              10-21-2005 13:34 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-05 13:34 roadrunner     New Issue                                    
10-21-05 13:34 roadrunner     File Added: compile.log                      
10-21-05 13:34 roadrunner     Distribution              => suse linux      
10-21-05 13:34 roadrunner     Kernel Version            => Linux version
2.4.21-297-default (root@i386.suse.de) (gcc version 3.3.1 (SuSE Linux)) #1 Sat
Jul 23 07:47:3 UTC 20059
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
