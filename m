From: Andrey Mazo <mazo@telum.ru>
Subject: [PATCH 2/3] pcm_file: fixed memory leak.
Date: Sun, 17 Nov 2013 01:11:55 +0400
Message-ID: <1384636316-26706-3-git-send-email-mazo@telum.ru>
References: <1384636316-26706-1-git-send-email-mazo@telum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.telum.ru (mail.telum.ru [62.141.76.179])
 by alsa0.perex.cz (Postfix) with ESMTP id C5CBD2615BF
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2013 22:13:16 +0100 (CET)
In-Reply-To: <1384636316-26706-1-git-send-email-mazo@telum.ru>
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
List-Id: alsa-devel@alsa-project.org

Valgrind report for this leak was:

Command: aplay -Dfile:'/tmp/qqq',raw qqq.wav

14 bytes in 1 blocks are definitely lost in loss record 1 of 2
   at 0x402BF5C: malloc (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
   by 0x40D7557: snd_pcm_file_hw_params (in /usr/lib/libasound.so.2.0.0)
   by 0x40BA093: _snd_pcm_hw_params_internal (in /usr/lib/libasound.so.2.0.0)
   by 0x40AB831: snd_pcm_hw_params (in /usr/lib/libasound.so.2.0.0)
   by 0x804C523: ??? (in /usr/bin/aplay)
   by 0x804E5B7: ??? (in /usr/bin/aplay)
   by 0x804FC8C: ??? (in /usr/bin/aplay)
   by 0x80520FB: ??? (in /usr/bin/aplay)
   by 0x4184942: (below main) (libc-start.c:226)

Signed-off-by: Andrey Mazo <mazo@telum.ru>
---
 src/pcm/pcm_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 3d14090..c3e67b2 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -592,8 +592,10 @@ static int snd_pcm_file_hw_free(snd_pcm_t *pcm)
 	snd_pcm_file_t *file = pcm->private_data;
 	free(file->wbuf);
 	free(file->wbuf_areas);
+	free(file->final_fname);
 	file->wbuf = NULL;
 	file->wbuf_areas = NULL;
+	file->final_fname = NULL;
 	return snd_pcm_hw_free(file->gen.slave);
 }
 
-- 
1.8.4
