From: Valentin Corfu <corfuvalentin@gmail.com>
Subject: [PATCH] jack: Fixing a small memory leak
Date: Tue, 11 Aug 2015 09:37:14 +0300
Message-ID: <1439275034-577-1-git-send-email-corfuvalentin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id C941D2604A1
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 08:39:03 +0200 (CEST)
Received: by wijp15 with SMTP id p15so162741041wij.0
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 23:39:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Valentin Corfu <corfuvalentin@gmail.com>
List-Id: alsa-devel@alsa-project.org

A small memory leak can be observed when using alsa-plugins (jack).
Check the following valgrind log:
...
==1034== 8 bytes in 1 blocks are definitely lost in loss record 7 of 108
==1034==    at 0x4027E5A: calloc (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==1034==    by 0x4035102: snd_pcm_jack_prepare (in /usr/lib/alsa-lib/libasound_module_pcm_jack.so)
==1034==    by 0x40D07AB: snd_pcm_ioplug_prepare (pcm_ioplug.c:145)
==1034==    by 0x4084961: snd_pcm_prepare (pcm.c:1052)
==1034==    by 0x409DDB4: snd_pcm_plugin_prepare (pcm_plugin.c:162)
==1034==    by 0x4084961: snd_pcm_prepare (pcm.c:1052)
==1034==    by 0x409DDB4: snd_pcm_plugin_prepare (pcm_plugin.c:162)
==1034==    by 0x4084961: snd_pcm_prepare (pcm.c:1052)
==1034==    by 0x4084A1D: snd_pcm_hw_params (pcm.c:838)
==1034==    by 0x4090013: snd_pcm_set_params (pcm.c:8053)
==1034==    by 0x80486EB: main (in /root/pcm_min_ok)
...
==1034== LEAK SUMMARY:
==1034==    definitely lost: 8 bytes in 1 blocks
==1034==    indirectly lost: 0 bytes in 0 blocks
==1034==      possibly lost: 31,311 bytes in 1,630 blocks
==1034==    still reachable: 5,619 bytes in 24 blocks
==1034==         suppressed: 0 bytes in 0 blocks
...

Signed-off-by: Valentin Corfu <corfuvalentin@gmail.com>
---
 jack/pcm_jack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 568ec43..de9c46e 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -103,6 +103,7 @@ static void snd_pcm_jack_free(snd_pcm_jack_t *jack)
 		if (jack->io.poll_fd >= 0)
 			close(jack->io.poll_fd);
 		free(jack->areas);
+		free(jack->ports);
 		free(jack);
 	}
 }
-- 
1.9.1
