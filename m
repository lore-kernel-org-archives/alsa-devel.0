From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/6] ASoC: Samsung-dma: Fix potential NULL
	pointer dereference
Date: Wed, 21 Nov 2012 14:36:56 +0530
Message-ID: <1353488819-13902-3-git-send-email-sachin.kamat@linaro.org>
References: <1353488819-13902-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 38302265CA4
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 10:13:20 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id ro12so2642606pbb.38
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 01:13:19 -0800 (PST)
In-Reply-To: <1353488819-13902-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: patches@linaro.org, tiwai@suse.de, Sangbeom Kim <sbkim73@samsung.com>, broonie@opensource.wolfsonmicro.com, sachin.kamat@linaro.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

'substream' was dereferenced before the NULL check.
Moved the check earlier to prevent NULL pointer dereference.

Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Build tested and based on linux-next 20121115.
---
 sound/soc/samsung/dma.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index b70964e..e59a4f4 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -114,17 +114,23 @@ static void dma_enqueue(struct snd_pcm_substream *substream)
 static void audio_buffdone(void *data)
 {
 	struct snd_pcm_substream *substream = data;
-	struct runtime_data *prtd = substream->runtime->private_data;
+	struct runtime_data *prtd;
 
 	pr_debug("Entered %s\n", __func__);
 
+	if (substream) {
+		prtd = substream->runtime->private_data;
+	} else {
+		pr_err("%s: Null data received\n", __func__);
+		return;
+	}
+
 	if (prtd->state & ST_RUNNING) {
 		prtd->dma_pos += prtd->dma_period;
 		if (prtd->dma_pos >= prtd->dma_end)
 			prtd->dma_pos = prtd->dma_start;
 
-		if (substream)
-			snd_pcm_period_elapsed(substream);
+		snd_pcm_period_elapsed(substream);
 
 		spin_lock(&prtd->lock);
 		if (!samsung_dma_has_circular()) {
-- 
1.7.4.1
