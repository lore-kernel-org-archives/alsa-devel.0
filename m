From: Andrew Gaydenko <a@etver.com>
Subject: build error in pcm_native.c
Date: Thu, 15 Jul 2004 22:09:21 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407152209.21287@goldspace.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Have tried to build drivers from current CVS and have got an error shown below.
Must I supply some additional info?

Andrew

==========================
gcc -D__KERNEL__ -DMODULE=1 -I/wrk/cvs/alsa/alsa-driver/include  -I/lib/modules/2.4.26-lck1/build/include -O2 -mpreferred-stack-boundary=2 -march=i686 -D__SMP__ -DCONFIG_SMP -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix include  -DKBUILD_BASENAME=pcm_native   -c -o pcm_native.o pcm_native.c
pcm_native.c: In function `snd_pcm_mmap_data_Rsmp_c77fab7a':
pcm_native.c:3157: warning: passing arg 1 of `remap_page_range_Rsmp_69d01e73' makes integer from pointer without a cast
pcm_native.c:3157: error: incompatible type for argument 4 of `remap_page_range_Rsmp_69d01e73'
pcm_native.c:3157: error: too many arguments to function `remap_page_range_Rsmp_69d01e73'
make[1]: *** [pcm_native.o] Error 1


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
