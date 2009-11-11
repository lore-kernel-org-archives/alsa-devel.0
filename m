From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] add support to reorder CPU and Codec DAI
	suspend/resume
Date: Wed, 11 Nov 2009 15:10:57 +0800
Message-ID: <1257923457-31470-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 35DDF10391F
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 08:21:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Due to some hardware dependence issues, some devices maybe require
different suspend/resume execution order for CPU and Codec DAI to
make sure the hardware can work normally after executing sleep and
wakeup.

In old ALSA driver, people include all suspend/resume operations of
both CPU and Codec in same entries. Then they change order according
to actual require. But in ASoC, we should give a chance to users to
reorder CPU/Codec DAI suspend/resume instead of defining the fixed
order if there are some strange hardware dependence problems.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 include/sound/soc.h  |    4 ++++
 sound/soc/soc-core.c |   48 ++++++++++++++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b1245e3..701c362 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -494,6 +494,10 @@ struct snd_soc_card {
 	struct snd_soc_dai_link *dai_link;
 	int num_links;
 
+	/* CPU <--> Codec DAI suspend/resume order */
+	int cpu_suspend_earlier; /* CPU DAI and platform suspend will be called earlier than Codec */
+	int cpu_resume_earlier;  /* CPU DAI and platform resume will be called earlier than Codec */
+
 	struct snd_soc_device *socdev;
 
 	struct snd_soc_codec *codec;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2d190df..a1cc855 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -660,12 +660,14 @@ static int soc_suspend(struct device *dev)
 	if (card->suspend_pre)
 		card->suspend_pre(pdev, PMSG_SUSPEND);
 
-	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_dai  *cpu_dai = card->dai_link[i].cpu_dai;
-		if (cpu_dai->suspend && !cpu_dai->ac97_control)
-			cpu_dai->suspend(cpu_dai);
-		if (platform->suspend)
-			platform->suspend(cpu_dai);
+	if (card->cpu_suspend_earlier) {
+		for (i = 0; i < card->num_links; i++) {
+			struct snd_soc_dai  *cpu_dai = card->dai_link[i].cpu_dai;
+			if (cpu_dai->suspend && !cpu_dai->ac97_control)
+				cpu_dai->suspend(cpu_dai);
+			if (platform->suspend)
+				platform->suspend(cpu_dai);
+		}
 	}
 
 	/* close any waiting streams and save state */
@@ -692,6 +694,16 @@ static int soc_suspend(struct device *dev)
 			cpu_dai->suspend(cpu_dai);
 	}
 
+	if (!card->cpu_suspend_earlier) {
+		for (i = 0; i < card->num_links; i++) {
+			struct snd_soc_dai  *cpu_dai = card->dai_link[i].cpu_dai;
+			if (cpu_dai->suspend && !cpu_dai->ac97_control)
+				cpu_dai->suspend(cpu_dai);
+			if (platform->suspend)
+				platform->suspend(cpu_dai);
+		}
+	}
+
 	if (card->suspend_post)
 		card->suspend_post(pdev, PMSG_SUSPEND);
 
@@ -728,6 +740,16 @@ static void soc_resume_deferred(struct work_struct *work)
 			cpu_dai->resume(cpu_dai);
 	}
 
+	if (card->cpu_resume_earlier) {
+		for (i = 0; i < card->num_links; i++) {
+			struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
+			if (cpu_dai->resume && !cpu_dai->ac97_control)
+				cpu_dai->resume(cpu_dai);
+			if (platform->resume)
+				platform->resume(cpu_dai);
+		}
+	}
+
 	if (codec_dev->resume)
 		codec_dev->resume(pdev);
 
@@ -749,12 +771,14 @@ static void soc_resume_deferred(struct work_struct *work)
 			dai->ops->digital_mute(dai, 0);
 	}
 
-	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
-		if (cpu_dai->resume && !cpu_dai->ac97_control)
-			cpu_dai->resume(cpu_dai);
-		if (platform->resume)
-			platform->resume(cpu_dai);
+	if (!card->cpu_resume_earlier) {
+		for (i = 0; i < card->num_links; i++) {
+			struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
+			if (cpu_dai->resume && !cpu_dai->ac97_control)
+				cpu_dai->resume(cpu_dai);
+			if (platform->resume)
+				platform->resume(cpu_dai);
+		}
 	}
 
 	if (card->resume_post)
-- 
1.5.6.3
