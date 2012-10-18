From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: jack: remove unused variable in snd_soc_jack_report()
Date: Thu, 18 Oct 2012 22:49:19 +0800
Message-ID: <CAPgLHd-DCVsDnKG6uH=Pq7hABRmyEfJ30GxczD99cmjSQQiWDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The variable oldstatus is initialized but never used
otherwise, so remove the unused variable.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/soc-jack.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index fa0fd8d..933eb25 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -66,7 +66,6 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 	struct snd_soc_dapm_context *dapm;
 	struct snd_soc_jack_pin *pin;
 	int enable;
-	int oldstatus;
 
 	trace_snd_soc_jack_report(jack, mask, status);
 
@@ -78,8 +77,6 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 
 	mutex_lock(&jack->mutex);
 
-	oldstatus = jack->status;
-
 	jack->status &= ~mask;
 	jack->status |= status & mask;
 
