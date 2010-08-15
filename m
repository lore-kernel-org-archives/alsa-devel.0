From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: [PATCH 2/4] sound: soc: msm7k: improve buffer underrun
	issue
Date: Sun, 15 Aug 2010 20:08:11 +0200
Message-ID: <1281895691-25311-2-git-send-email-GNUtoo@no-log.org>
References: <1281895083-24953-1-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp202.alice.it (smtp202.alice.it [82.57.200.98])
	by alsa0.perex.cz (Postfix) with ESMTP id CE39F244FA
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 20:08:26 +0200 (CEST)
In-Reply-To: <1281895083-24953-1-git-send-email-GNUtoo@no-log.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
List-Id: alsa-devel@alsa-project.org

This commit is a rebase of the following patch:
 commit ac97ef246a754b9a2b4236ca08c6ade389dc206f
 Author: Pradeep Jilagam <pjilagam@qualcomm.com>
 Date:   Wed Apr 7 17:38:20 2010 +0530

     alsa: 8k: Limit period size for sample rates greater than 8KHz

     The DSP interrupts are non-periodic. ALSA expects periodic
     acknowledgement for the buffers sent. Hence, the alsa driver uses
     timer as alternate interrupt source. The min resolution is 10ms
     which results in distorted audio for some sample rates. Hence
     restricting the minimum period size for sample rates greater
     than 8KHz to 512 frames.

     Change-Id: Ic8c4180fbee7242fa3139230ddcf6a9f98e4c7ab
     CRs-fixed: 231784
     Signed-off-by: Pradeep Jilagam <pjilagam@qualcomm.com>
>From git://codeaurora.org/kernel/msm.git
Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 sound/soc/msm/file        |   61 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/msm/msm7k-pcm.c |   38 +++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/msm/file

diff --git a/sound/soc/msm/file b/sound/soc/msm/file
new file mode 100644
index 0000000..8c62299
--- /dev/null
+++ b/sound/soc/msm/file
@@ -0,0 +1,61 @@
+diff --git a/sound/soc/msm/msm7k-pcm.c b/sound/soc/msm/msm7k-pcm.c
+index 9561e91..2d90797 100644
+--- a/sound/soc/msm/msm7k-pcm.c
++++ b/sound/soc/msm/msm7k-pcm.c
+@@ -31,6 +31,7 @@
+ #include <sound/soc.h>
+ #include <sound/soc-dapm.h>
+ #include <sound/pcm.h>
++#include <sound/pcm_params.h>
+ #include <sound/initval.h>
+ #include <sound/control.h>
+ #include <asm/dma.h>
+@@ -398,6 +399,32 @@ struct  msm_audio_event_callbacks snd_msm_audio_ops = {
+ 	.capture = capture_event_handler,
+ };
+ 
++static int hw_rule_periodsize_by_rate(struct snd_pcm_hw_params *params,
++					struct snd_pcm_hw_rule *rule)
++{
++	struct snd_interval *ps = hw_param_interval(params,
++						SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
++	struct snd_interval *r = hw_param_interval(params,
++						SNDRV_PCM_HW_PARAM_RATE);
++	struct snd_interval ch;
++
++	if (!ps || !r){
++		pr_debug("REMOVE_THAT: exiting from !ps||!r\n");
++		return 0;
++	}else{
++		pr_debug("REMOVE_THAT: not exiting\n");
++	}
++	snd_interval_any(&ch);
++
++	if (r->min > 8000) {
++		ch.min = 512;
++		pr_debug("Minimum period size is adjusted to 512\n");
++		return snd_interval_refine(ps, &ch);
++	}
++	return 0;
++}
++
++
+ static int msm_pcm_open(struct snd_pcm_substream *substream)
+ {
+ 	struct snd_pcm_runtime *runtime = substream->runtime;
+@@ -431,6 +458,15 @@ static int msm_pcm_open(struct snd_pcm_substream *substream)
+ 	if (ret < 0)
+ 		goto out;
+ 
++
++	ret = snd_pcm_hw_rule_add(substream->runtime, 0,
++			SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
++			hw_rule_periodsize_by_rate, substream,
++			SNDRV_PCM_HW_PARAM_RATE, -1);
++
++	if (ret < 0)
++		goto out;
++
+ 	prtd->ops = &snd_msm_audio_ops;
+ 	prtd->out[0].used = BUF_INVALID_LEN;
+ 	prtd->out_head = 1; /* point to second buffer on startup */
diff --git a/sound/soc/msm/msm7k-pcm.c b/sound/soc/msm/msm7k-pcm.c
index 9561e91..fc6c7fc 100644
--- a/sound/soc/msm/msm7k-pcm.c
+++ b/sound/soc/msm/msm7k-pcm.c
@@ -1,6 +1,6 @@
 /* linux/sound/soc/msm/msm7k-pcm.c
  *
- * Copyright (c) 2008-2009, Code Aurora Forum. All rights reserved.
+ * Copyright (c) 2008-2010, Code Aurora Forum. All rights reserved.
  *
  * All source code in this file is licensed under the following license except
  * where indicated.
@@ -31,6 +31,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/initval.h>
 #include <sound/control.h>
 #include <asm/dma.h>
@@ -398,6 +399,32 @@ struct  msm_audio_event_callbacks snd_msm_audio_ops = {
 	.capture = capture_event_handler,
 };
 
+static int hw_rule_periodsize_by_rate(struct snd_pcm_hw_params *params,
+					struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *ps = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
+	struct snd_interval *r = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval ch;
+
+	if (!ps || !r){
+		pr_debug("REMOVE_THAT: exiting from !ps||!r\n");
+		return 0;
+	}else{
+		pr_debug("REMOVE_THAT: not exiting\n");
+	}
+	snd_interval_any(&ch);
+
+	if (r->min > 8000) {
+		ch.min = 512;
+		pr_debug("Minimum period size is adjusted to 512\n");
+		return snd_interval_refine(ps, &ch);
+	}
+	return 0;
+}
+
+
 static int msm_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -431,6 +458,15 @@ static int msm_pcm_open(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		goto out;
 
+
+	ret = snd_pcm_hw_rule_add(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+			hw_rule_periodsize_by_rate, substream,
+			SNDRV_PCM_HW_PARAM_RATE, -1);
+
+	if (ret < 0)
+		goto out;
+
 	prtd->ops = &snd_msm_audio_ops;
 	prtd->out[0].used = BUF_INVALID_LEN;
 	prtd->out_head = 1; /* point to second buffer on startup */
-- 
1.7.0.4
