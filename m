From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] core/pcm.c: fixes for runtime->status
Date: Mon, 22 Jul 2002 10:30:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3BC2A8.9C6D8089@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


runtime->status is initialized with the wrong size (not really, because it's
one page anyway), and an error handler uses the wrong function to free it.

The snd_pcm_notify function already checks that n_register and
n_unregister are set, so we don't need the extra checks in
snd_pcm_dev_(un)register.


Index: core/pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/pcm.c,v
retrieving revision 1.14
diff -u -r1.14 pcm.c
--- core/pcm.c	26 Jun 2002 02:02:49 -0000	1.14
+++ core/pcm.c	22 Jul 2002 08:14:46 -0000
@@ -753,16 +753,15 @@
 		kfree(runtime);
 		return -ENOMEM;
 	}
+	memset((void*)runtime->status, 0, size);
 
 	size = PAGE_ALIGN(sizeof(snd_pcm_mmap_control_t));
 	runtime->control = snd_malloc_pages(size, GFP_KERNEL);
 	if (runtime->control == NULL) {
-		kfree((void *)runtime->status);
+		snd_free_pages((void*)runtime->status, PAGE_ALIGN(sizeof(snd_pcm_mmap_status_t)));
 		kfree(runtime);
 		return -ENOMEM;
 	}
-
-	memset((void*)runtime->status, 0, size);
 	memset((void*)runtime->control, 0, size);
 
 	init_waitqueue_head(&runtime->sleep);
@@ -840,8 +839,7 @@
 	list_for_each(list, &snd_pcm_notify_list) {
 		snd_pcm_notify_t *notify;
 		notify = list_entry(list, snd_pcm_notify_t, list);
-		if (notify->n_register)
-			notify->n_register(-1 /* idx + SNDRV_MINOR_PCM */, pcm);
+		notify->n_register(-1 /* idx + SNDRV_MINOR_PCM */, pcm);
 	}
 	snd_pcm_lock(1);
 	return 0;
@@ -878,8 +876,7 @@
 	list_for_each(list, &snd_pcm_notify_list) {
 		snd_pcm_notify_t *notify;
 		notify = list_entry(list, snd_pcm_notify_t, list);
-		if (notify->n_unregister)
-			notify->n_unregister(-1 /* SNDRV_MINOR_PCM + idx */, pcm);
+		notify->n_unregister(-1 /* SNDRV_MINOR_PCM + idx */, pcm);
 	}
 	snd_pcm_devices[idx] = NULL;
 	snd_pcm_lock(1);


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
