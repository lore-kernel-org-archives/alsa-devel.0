From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: sound/core/pcm_timer.c: include pcm_local.h and remove some extraneous tabs
Date: Tue, 30 May 2017 10:58:30 +0100
Message-ID: <20170530095830.31534-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

We need to include pcm_local.h to clean up some smatch warnings:

symbol 'snd_pcm_timer_done' was not declared. Should it be static?
symbol 'snd_pcm_timer_init' was not declared. Should it be static?
symbol 'snd_pcm_timer_resolution_change' was not declared. Should
  it be static?

Also remove some extraneous tabs on empty lines.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/core/pcm_timer.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm_timer.c b/sound/core/pcm_timer.c
index 20ecd8f18080..b182cac00dd8 100644
--- a/sound/core/pcm_timer.c
+++ b/sound/core/pcm_timer.c
@@ -25,6 +25,8 @@
 #include <sound/pcm.h>
 #include <sound/timer.h>
 
+#include "pcm_local.h"
+
 /*
  *  Timer functions
  */
@@ -33,7 +35,7 @@ void snd_pcm_timer_resolution_change(struct snd_pcm_substream *substream)
 {
 	unsigned long rate, mult, fsize, l, post;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	
+
         mult = 1000000000;
 	rate = runtime->rate;
 	if (snd_BUG_ON(!rate))
@@ -65,7 +67,7 @@ void snd_pcm_timer_resolution_change(struct snd_pcm_substream *substream)
 static unsigned long snd_pcm_timer_resolution(struct snd_timer * timer)
 {
 	struct snd_pcm_substream *substream;
-	
+
 	substream = timer->private_data;
 	return substream->runtime ? substream->runtime->timer_resolution : 0;
 }
@@ -73,7 +75,7 @@ static unsigned long snd_pcm_timer_resolution(struct snd_timer * timer)
 static int snd_pcm_timer_start(struct snd_timer * timer)
 {
 	struct snd_pcm_substream *substream;
-	
+
 	substream = snd_timer_chip(timer);
 	substream->timer_running = 1;
 	return 0;
@@ -82,7 +84,7 @@ static int snd_pcm_timer_start(struct snd_timer * timer)
 static int snd_pcm_timer_stop(struct snd_timer * timer)
 {
 	struct snd_pcm_substream *substream;
-	
+
 	substream = snd_timer_chip(timer);
 	substream->timer_running = 0;
 	return 0;
@@ -112,7 +114,7 @@ void snd_pcm_timer_init(struct snd_pcm_substream *substream)
 {
 	struct snd_timer_id tid;
 	struct snd_timer *timer;
-	
+
 	tid.dev_sclass = SNDRV_TIMER_SCLASS_NONE;
 	tid.dev_class = SNDRV_TIMER_CLASS_PCM;
 	tid.card = substream->pcm->card->number;
-- 
2.11.0

