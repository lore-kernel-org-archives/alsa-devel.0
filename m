From: Florian Bomers <Florian.Bomers@Sun.COM>
Subject: Compilation warnings on amd64
Date: Tue, 08 Jun 2004 08:07:27 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C5D62F.4060609@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I updated an opteron system from SLES 8.1 to 8.1 patchlevel 3, kernel 
2.4.21-127-default, and I get the warnings below for almost every file 
to be compiled. It seems to work fine though.

Florian

gcc -D__KERNEL__ -DMODULE=1 -I/root/ALSA/alsa-driver-1.0.5a/include 
-I/lib/modules/2.4.21-127-default/build/include -O2 -mno-red-zone 
-mcmodel=kernel -fno-reorder-blocks -fno-strength-reduce 
-finline-limit=2000 -DLINUX -Wall -Wstrict-prototypes 
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -DALSA_BUILD -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=ac97_patch   -c -o ac97_patch.o ac97_patch.c
In file included from 
/root/ALSA/alsa-driver-1.0.5a/include/sound/driver.h:64,
                  from ../../alsa-kernel/pci/ac97/ac97_patch.c:26,
                  from ac97_patch.c:2:
/root/ALSA/alsa-driver-1.0.5a/include/sound/sndmagic.h:213:1: warning: 
"snd_magic_kfree" redefined
In file included from 
/lib/modules/2.4.21-127-default/build/include/linux/modversions.h:366,
                  from /root/ALSA/alsa-driver-1.0.5a/include/adriver.h:42,
                  from 
/root/ALSA/alsa-driver-1.0.5a/include/sound/driver.h:42,
                  from ../../alsa-kernel/pci/ac97/ac97_patch.c:26,
                  from ac97_patch.c:2:
/lib/modules/2.4.21-127-default/build/include/linux/modules/sound.ver:28:1: 
warning: this is the location of the previous definition


-- 
Florian Bomers
Java Sound
Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/
----------------------------------------------
Please quote this email in your reply. Thanks!



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
