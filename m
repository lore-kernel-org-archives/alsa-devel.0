From: Miles Lane <miles.lane@attbi.com>
Subject: cvs HEAD -- gcc: info.c: No such file or directory
Date: Fri, 30 May 2003 06:47:58 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED7610E.2010309@attbi.com>
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

A freshly checked out tree gives me:

./cvscompile --with-cards=powermac --with-isapnp=no --with-pcmcia=kernel 
--with-kernel=/home/usr/src/linux-2.5 --with-oss=yes 
--with-sequencer=yes --with-debug=1

gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1 
-I/home/usr/src/alsa-driver/include  -I/home/usr/src/linux-2.5/include 
-O2 -D__powerpc__ -fsigned-char -fno-builtin -msoft-float -ffixed-r2 
-Wno-uninitialized -mmultiple -mstring -DLINUX -Wall -Wstrict-prototypes 
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -DALSA_BUILD  memalloc.c sgbuf.c memory_wrapper.c pcm.c 
pcm_native.c pcm_lib.c pcm_timer.c pcm_misc.c pcm_memory.c timer.c 
sound.c init.c memory.c info.c control.c misc.c device.c wrappers.c 
sound_oss.c info_oss.c > .depend
gcc: info.c: No such file or directory
make[1]: *** [fastdep] Error 1



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
