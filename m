From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002032]: several warnings when compile alsa-driver-1.0.11rc5
Date: Tue, 18 Apr 2006 15:36:13 +0200
Message-ID: <995a87e517431ff83ea5e8d48109955a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 88F38219
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 15:36:13 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2032> 
======================================================================
Reported By:                Raymond
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2032
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-18-2006 14:24 CEST
Last Modified:              04-18-2006 15:36 CEST
======================================================================
Summary:                    several warnings when compile alsa-driver-1.0.11rc5
Description: 
gcc32 -D__KERNEL__ -DMODULE=1 -I /alsa-driver-1.0.11rc5/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h  
-DEXPORT_SYMTAB -c sound.c
sound.c: In function `snd_open':
sound.c:175: warning: assignment discards qualifiers from pointer target
type
sound.c:180: warning: assignment discards qualifiers from pointer target
type
/alsa-driver-1.0.11rc5/include/platform_device_compat.h: At top
level:sound.c:43: warning: `device_mode' defined but not used



gcc32 -D__KERNEL__ -DMODULE=1 -I/alsa-driver-1.0.11rc5/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h 
-DKBUILD_BASENAME=sound_oss   -c -o sound_oss.o sound_oss.c
In file included from sound_oss.c:6:
../alsa-kernel/core/sound_oss.c: In function `snd_register_oss_device':
../alsa-kernel/core/sound_oss.c:137: warning: passing arg 1 of
`register_sound_special_Rbd0ae896' discards qualifiers from pointer target
type
../alsa-kernel/core/sound_oss.c:142: warning: passing arg 1 of
`register_sound_special_Rbd0ae896' discards qualifiers from pointer target
type



gcc32 -D__KERNEL__ -DMODULE=1 -I/alsa-driver-1.0.11rc5/include 
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -DALSA_BUILD -nostdinc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.2199.nptl/build/include/linux/modversions.h 
-DKBUILD_BASENAME=echo3g   -c -o echo3g.o echo3g.c
In file included from echo3g.c:117:
echoaudio.c: In function `snd_echo_free':
echoaudio.c:1751: warning: passing arg 1 of `iounmap_R5fb196d4' discards
qualifiers from pointer target type


======================================================================

----------------------------------------------------------------------
 tiwai - 04-18-06 15:36 
----------------------------------------------------------------------
They are all harmless and won't be fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-06 14:24 Raymond        New Issue                                    
04-18-06 15:36 tiwai          Status                   assigned => resolved
04-18-06 15:36 tiwai          Resolution               open => fixed       
04-18-06 15:36 tiwai          Note Added: 0009336                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
