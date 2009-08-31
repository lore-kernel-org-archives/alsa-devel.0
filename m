From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ALSA: allocation may fail in
	snd_pcm_oss_change_params()
Date: Mon, 31 Aug 2009 16:23:53 +0200
Message-ID: <4A9BDCF9.102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id D94691037F5
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Aug 2009 16:18:16 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 13so788044eye.16
	for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2009 07:18:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Allocation may fail, show if it did.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index dbe406b..ea91a0a 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1047,6 +1047,10 @@ static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream)
 	runtime->oss.prepare = 1;
 	vfree(runtime->oss.buffer);
 	runtime->oss.buffer = vmalloc(runtime->oss.period_bytes);
+	if (runtime->oss.buffer == NULL) {
+		err = -ENOMEM;
+		goto failure;
+	}
 	runtime->oss.buffer_used = 0;
 	if (runtime->dma_area)
 		snd_pcm_format_set_silence(runtime->format, runtime->dma_area, bytes_to_samples(runtime, runtime->dma_bytes));
