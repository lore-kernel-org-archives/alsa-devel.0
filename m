From: Robert Vetter <vetter@bury.com>
Subject: Alsa on a embedded device with Intel PXA250
Date: Tue, 1 Aug 2006 10:42:14 +0200
Message-ID: <200608011042.14317.vetter@bury.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hello,

I'm trying to install ALSA on a embedded system based on  Intel PXA250 and 
running Linux 2.4.19 kernel. When trying to cross-compile ALSA i get this 
error:

arm-linux-gcc  -D__KERNEL__ -DMODULE=1 -I/home/robert/alsa-driver-1.0.11/include  -I/home/robert/linux-2.4.19-CC1000/include -O2 -O2 -mapcs-32 -march=armv4 -Wa,-mxscale -mtune=strongarm -mshort-load-bytes -msoft-float -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix 
include   -DEXPORT_SYMTAB -c memalloc.c
memalloc.c:123: #error "Need a bus for dma_alloc_coherent()"
memalloc.c: In function `snd_malloc_dev_pages':
memalloc.c:314: warning: implicit declaration of function `dma_alloc_coherent'
memalloc.c:314: warning: assignment makes pointer from integer without a cast
memalloc.c: In function `snd_free_dev_pages':
memalloc.c:334: warning: implicit declaration of function `dma_free_coherent'
make[1]: *** [memalloc.o] Error 1
make[1]: Leaving directory `/home/robert/alsa-driver-1.0.11/acore'
make: *** [compile] Error 1

I ran configure script with following arguments:

./configure --with-cross=arm-linux- --with-kernel=/home/robert/linux-2.4.19-CC1000 --with-cards=pxa2xx-ac97,pxa2xx-i2sound --with-sequencer=no

Kernel has no PCI support buid in. I'm using arm-linux-gcc version 2.95.3

can someone help, please?

Robert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
