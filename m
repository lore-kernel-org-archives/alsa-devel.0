From: JongHo Kim <furmuwon@gmail.com>
Subject: [PATCH] ALSA: Remove the runtime local variable in
 snd_pcm_period_elapsed
Date: Sat, 28 Jun 2014 03:13:07 +0900 (KST)
Message-ID: <alpine.DEB.2.02.1406280257470.6133@homeuser>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id E3969265350
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 20:13:13 +0200 (CEST)
Received: by mail-pa0-f45.google.com with SMTP id rd3so4873931pab.18
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 11:13:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Tim Gardner <tim.gardner@canonical.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

>From a46df32a4fc184364be45ffe8957d5a20818d979 Mon Sep 17 00:00:00 2001
From: JongHo Kim <furmuwon@gmail.com>
Date: Sat, 28 Jun 2014 02:49:13 +0900
Subject: [PATCH] ALSA: Remove the runtime local variable in
  snd_pcm_period_elapsed

The local runtime variable in snd_pcm_period_elapsed has the value
of substream->runtime. If the substream->runtime memory was freed,
The local runtime variable can point the invalid memory.
If do not fix this, can refer to freed memory.
This patch remove local runtime variable and check the NULL directly.

Signed-off-by: JongHo Kim <furmuwon@gmail.com>
---
  sound/core/pcm_lib.c | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 9acc77e..c3de2d3 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1836,15 +1836,13 @@ EXPORT_SYMBOL(snd_pcm_lib_ioctl);
   */
  void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
  {
-	struct snd_pcm_runtime *runtime;
  	unsigned long flags;

  	if (PCM_RUNTIME_CHECK(substream))
  		return;
-	runtime = substream->runtime;

-	if (runtime->transfer_ack_begin)
-		runtime->transfer_ack_begin(substream);
+	if (substream->runtime && substream->runtime->transfer_ack_begin)
+		substream->runtime->transfer_ack_begin(substream);

  	snd_pcm_stream_lock_irqsave(substream, flags);
  	if (!snd_pcm_running(substream) ||
@@ -1855,9 +1853,11 @@ void snd_pcm_period_elapsed(struct 
snd_pcm_substream *substream)
  		snd_timer_interrupt(substream->timer, 1);
   _end:
  	snd_pcm_stream_unlock_irqrestore(substream, flags);
-	if (runtime->transfer_ack_end)
-		runtime->transfer_ack_end(substream);
-	kill_fasync(&runtime->fasync, SIGIO, POLL_IN);
+	if (substream->runtime && substream->runtime->transfer_ack_end)
+		substream->runtime->transfer_ack_end(substream);
+
+	if (substream->runtime)
+		kill_fasync(&substream->runtime->fasync, SIGIO, POLL_IN);
  }

  EXPORT_SYMBOL(snd_pcm_period_elapsed);
-- 
1.8.1.2
