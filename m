From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: cvs HEAD -- gcc: info.c: No such file or directory
Date: Fri, 30 May 2003 16:07:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305301607360.28435-100000@pnote.perex-int.cz>
References: <3ED7610E.2010309@attbi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3ED7610E.2010309@attbi.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Miles Lane <miles.lane@attbi.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 30 May 2003, Miles Lane wrote:

> A freshly checked out tree gives me:
> 
> ./cvscompile --with-cards=powermac --with-isapnp=no --with-pcmcia=kernel 
> --with-kernel=/home/usr/src/linux-2.5 --with-oss=yes 
> --with-sequencer=yes --with-debug=1
> 
> gcc -M -D__KERNEL__ -D__isapnp_now__ -DMODULE=1 
> -I/home/usr/src/alsa-driver/include  -I/home/usr/src/linux-2.5/include 
> -O2 -D__powerpc__ -fsigned-char -fno-builtin -msoft-float -ffixed-r2 
> -Wno-uninitialized -mmultiple -mstring -DLINUX -Wall -Wstrict-prototypes 
> -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -pipe -DALSA_BUILD  memalloc.c sgbuf.c memory_wrapper.c pcm.c 
> pcm_native.c pcm_lib.c pcm_timer.c pcm_misc.c pcm_memory.c timer.c 
> sound.c init.c memory.c info.c control.c misc.c device.c wrappers.c 
> sound_oss.c info_oss.c > .depend
> gcc: info.c: No such file or directory
> make[1]: *** [fastdep] Error 1

Work in progress. Just fixed.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
