From: Miles Lane <miles.lane@attbi.com>
Subject: Both cvs and 0.9.3c alsa-driver fail to compile on kernel 2.5.70!
 2.5.70 tree contains 0.9.2.
Date: Thu, 29 May 2003 08:04:47 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED6218F.5040309@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have posted these reports before and gotten no responses.

CVS
---

gcc -D__KERNEL__ -DMODULE=1 -I/home/usr/src/alsa-driver/include 
-I/usr/src/linux-2.5/include -O2 -D__powerpc__ -fsigned-char 
-fno-builtin -msoft-float -ffixed-r2 -Wno-uninitialized -mmultiple 
-mstring -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD 
-DEXPORT_SYMTAB -c pcm.c
In file included from pcm.c:1:
../alsa-kernel/core/pcm.c: In function 
`snd_pcm_substream_proc_hw_params_read':
../alsa-kernel/core/pcm.c:320: structure has no member named `lock'
../alsa-kernel/core/pcm.c:323: structure has no member named `lock'
../alsa-kernel/core/pcm.c:343: structure has no member named `lock'
In file included from pcm.c:1:
../alsa-kernel/core/pcm.c: In function 
`snd_pcm_substream_proc_sw_params_read':
../alsa-kernel/core/pcm.c:354: structure has no member named `lock'
../alsa-kernel/core/pcm.c:357: structure has no member named `lock'
../alsa-kernel/core/pcm.c:370: structure has no member named `lock'
In file included from pcm.c:1:
../alsa-kernel/core/pcm.c: In function `snd_pcm_new_stream':
../alsa-kernel/core/pcm.c:591: structure has no member named `link_next'
../alsa-kernel/core/pcm.c:592: structure has no member named `link_prev'
In file included from pcm.c:1:
../alsa-kernel/core/pcm.c: In function `snd_pcm_open_substream':
../alsa-kernel/core/pcm.c:796: structure has no member named `lock'
make[1]: *** [pcm.o] Error 1

0.9.3c
------

gcc -D__KERNEL__ -DMODULE=1 -I/home/usr/src/alsa-driver-0.9.3c/include 
-I/usr/src/linux-2.5.70/include -O2 -D__powerpc__ -fsigned-char 
-fno-builtin -msoft-float -ffixed-r2 -Wno-uninitialized -mmultiple 
-mstring -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD 
-DEXPORT_SYMTAB -c sound.c
In file included from sound.c:1:
../alsa-kernel/core/sound.c: In function `snd_register_device':
../alsa-kernel/core/sound.c:231: warning: implicit declaration of 
function `devfs_register'
../alsa-kernel/core/sound.c:231: `DEVFS_FL_DEFAULT' undeclared (first 
use in this function)
../alsa-kernel/core/sound.c:231: (Each undeclared identifier is reported 
only once
../alsa-kernel/core/sound.c:231: for each function it appears in.)
In file included from sound.c:1:
../alsa-kernel/core/sound.c: In function `alsa_sound_init':
../alsa-kernel/core/sound.c:373: `DEVFS_FL_DEFAULT' undeclared (first 
use in this function)
make[1]: *** [sound.o] Error 1



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
