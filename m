From: Miles Lane <miles.lane@attbi.com>
Subject: 2.5.70 + alsa-driver cvs -- ../alsa-kernel/core/pcm.c:320: structure
 has no member named `lock'
Date: Wed, 28 May 2003 11:11:33 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED4FBD5.3010208@attbi.com>
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

./configure --with-cards=powermac --with-pcmcia=kernel --with-oss=yes 
--with-sequencer=yes --with-isapnp=no --with-debug=1 --enable-v
erbose-printk --with-kernel=/usr/src/linux-2.5

make[1]: Entering directory `/home/usr/src/alsa-driver/acore'
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



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
