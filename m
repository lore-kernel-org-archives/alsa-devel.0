From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/core/memalloc.c: fix PROC_FS=n compilation
Date: Sat, 23 Jul 2005 19:08:11 +0200
Message-ID: <20050723170811.GH3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id D39A618A
	for <alsa-devel@alsa-project.org>; Sat, 23 Jul 2005 19:08:16 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes the following compile error with CONFIG_PROC_FS=n:

<--  snip  -->

...
  CC      sound/core/memalloc.o
sound/core/memalloc.c: In function 'snd_mem_exit':
sound/core/memalloc.c:657: error: 'snd_mem_proc' undeclared (first use in this function)
sound/core/memalloc.c:657: error: (Each undeclared identifier is reported only once
sound/core/memalloc.c:657: error: for each function it appears in.)
make[2]: *** [sound/core/memalloc.o] Error 1

<--  snip  -->


Since snd_mem_proc was needlessly global, I've also made it static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/sound/core/memalloc.c.old	2005-07-23 01:25:03.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/sound/core/memalloc.c	2005-07-23 01:30:35.000000000 +0200
@@ -505,13 +505,13 @@
 	up(&list_mutex);
 }
 
+static struct proc_dir_entry *snd_mem_proc;
 
 #ifdef CONFIG_PROC_FS
 /*
  * proc file interface
  */
 #define SND_MEM_PROC_FILE	"driver/snd-page-alloc"
-struct proc_dir_entry *snd_mem_proc;
 
 static int snd_mem_proc_read(char *page, char **start, off_t off,
 			     int count, int *eof, void *data)



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
