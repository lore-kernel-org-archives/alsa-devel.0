From: "thewade" <pdman@aproximation.org>
Subject: Re: Change of iomem types
Date: Fri, 17 Sep 2004 21:43:32 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409180343.i8I3hWdo007555@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I answered my own question (I thought).
I checked out the CVS version of alsa and copied the alsa-kernel contents to linux/sound but when I compiled I get this, any ideas why? Thanks!

sound/core/hwdep.c: In function `snd_hwdep_new\':
sound/core/hwdep.c:367: warning: implicit declaration of function `kcalloc\'
sound/core/hwdep.c:367: warning: assignment makes pointer from integer without a cast
  CC      sound/core/memalloc.o
sound/core/memalloc.c:334: error: conflicting types for \'snd_dma_alloc_pages\'
include/sound/memalloc.h:101: error: previous declaration of \'snd_dma_alloc_pages\' was here
sound/core/memalloc.c:334: error: conflicting types for \'snd_dma_alloc_pages\'
include/sound/memalloc.h:101: error: previous declaration of \'snd_dma_alloc_pages\' was here
sound/core/memalloc.c: In function `snd_dma_alloc_pages\':
sound/core/memalloc.c:338: error: structure has no member named `dev\'
sound/core/memalloc.c:339: error: structure has no member named `dev\'
sound/core/memalloc.c: At top level:
sound/core/memalloc.c:386: error: conflicting types for \'snd_dma_alloc_pages_fallback\'
include/sound/memalloc.h:103: error: previous declaration of \'snd_dma_alloc_pages_fallback\' was here
sound/core/memalloc.c:386: error: conflicting types for \'snd_dma_alloc_pages_fallback\'
include/sound/memalloc.h:103: error: previous declaration of \'snd_dma_alloc_pages_fallback\' was here
sound/core/memalloc.c:412: error: conflicting types for \'snd_dma_free_pages\'
include/sound/memalloc.h:104: error: previous declaration of \'snd_dma_free_pages\' was here
sound/core/memalloc.c:412: error: conflicting types for \'snd_dma_free_pages\'
include/sound/memalloc.h:104: error: previous declaration of \'snd_dma_free_pages\' was here
sound/core/memalloc.c: In function `snd_dma_free_pages\':
sound/core/memalloc.c:413: error: structure has no member named `dev\'
sound/core/memalloc.c:423: error: structure has no member named `dev\'
sound/core/memalloc.c:429: error: structure has no member named `dev\'
sound/core/memalloc.c: In function `snd_dma_get_reserved_buf\':
sound/core/memalloc.c:455: error: structure has no member named `dev\'
sound/core/memalloc.c:455: error: structure has no member named `dev\'
sound/core/memalloc.c:455: error: structure has no member named `dev\'
sound/core/memalloc.c: In function `preallocate_cards\':
sound/core/memalloc.c:584: warning: implicit declaration of function `snd_dma_pci_buf_id\'
sound/core/memalloc.c: In function `snd_mem_proc_read\':
sound/core/memalloc.c:617: error: structure has no member named `dev\'
make[2]: *** [sound/core/memalloc.o] Error 1
make[1]: *** [sound/core] Error 2
make: *** [sound] Error 2

Thanks,
-thewade


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
