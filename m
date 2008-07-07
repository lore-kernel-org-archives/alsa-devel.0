From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 01/10] asoc: core - merge structs
	snd_soc_codec_dai and	snd_soc_cpu_dai.
Date: Mon, 07 Jul 2008 16:07:17 +0100
Message-ID: <1215443237.4882.178.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 798C224612
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 17:07:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch series merges struct snd_soc_codec_dai and struct
snd_soc_cpu_dai into struct snd_soc_dai in preparation for further
ASoC v2 patches.

This merger removes duplication in both DAI structures and simplifies
the API for other users.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |   71 ++++++++++++++++---------------------------------
 sound/soc/soc-core.c |   50 +++++++++++++++++-----------------
 2 files changed, 48 insertions(+), 73 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 340223a..778e57e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -221,8 +221,7 @@ struct snd_soc_pcm_stream;
 struct snd_soc_ops;
 struct snd_soc_dai_mode;
 struct snd_soc_pcm_runtime;
-struct snd_soc_codec_dai;
-struct snd_soc_cpu_dai;
+struct snd_soc_dai;
 struct snd_soc_codec;
 struct snd_soc_machine_config;
 struct soc_enum;
@@ -317,50 +316,24 @@ struct snd_soc_ops {
 /* ASoC DAI ops */
 struct snd_soc_dai_ops {
 	/* DAI clocking configuration */
-	int (*set_sysclk)(struct snd_soc_codec_dai *codec_dai,
+	int (*set_sysclk)(struct snd_soc_dai *dai,
 		int clk_id, unsigned int freq, int dir);
-	int (*set_pll)(struct snd_soc_codec_dai *codec_dai,
+	int (*set_pll)(struct snd_soc_dai *dai,
 		int pll_id, unsigned int freq_in, unsigned int freq_out);
-	int (*set_clkdiv)(struct snd_soc_codec_dai *codec_dai,
-		int div_id, int div);
+	int (*set_clkdiv)(struct snd_soc_dai *dai, int div_id, int div);
 
 	/* DAI format configuration */
-	int (*set_fmt)(struct snd_soc_codec_dai *codec_dai,
-		unsigned int fmt);
-	int (*set_tdm_slot)(struct snd_soc_codec_dai *codec_dai,
+	int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
+	int (*set_tdm_slot)(struct snd_soc_dai *dai,
 		unsigned int mask, int slots);
-	int (*set_tristate)(struct snd_soc_codec_dai *, int tristate);
+	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
 
 	/* digital mute */
-	int (*digital_mute)(struct snd_soc_codec_dai *, int mute);
+	int (*digital_mute)(struct snd_soc_dai *dai, int mute);
 };
 
-/* SoC Codec DAI */
-struct snd_soc_codec_dai {
-	char *name;
-	int id;
-	unsigned char type;
-
-	/* DAI capabilities */
-	struct snd_soc_pcm_stream playback;
-	struct snd_soc_pcm_stream capture;
-
-	/* DAI runtime info */
-	struct snd_soc_codec *codec;
-	unsigned int active;
-	unsigned char pop_wait:1;
-
-	/* ops */
-	struct snd_soc_ops ops;
-	struct snd_soc_dai_ops dai_ops;
-
-	/* DAI private data */
-	void *private_data;
-};
-
-/* SoC CPU DAI */
-struct snd_soc_cpu_dai {
-
+/* SoC  DAI (Digital Audio Interface) */
+struct snd_soc_dai {
 	/* DAI description */
 	char *name;
 	unsigned int id;
@@ -368,13 +341,13 @@ struct snd_soc_cpu_dai {
 
 	/* DAI callbacks */
 	int (*probe)(struct platform_device *pdev,
-		     struct snd_soc_cpu_dai *dai);
+		     struct snd_soc_dai *dai);
 	void (*remove)(struct platform_device *pdev,
-		       struct snd_soc_cpu_dai *dai);
+		       struct snd_soc_dai *dai);
 	int (*suspend)(struct platform_device *pdev,
-		struct snd_soc_cpu_dai *cpu_dai);
+		struct snd_soc_dai *dai);
 	int (*resume)(struct platform_device *pdev,
-		struct snd_soc_cpu_dai *cpu_dai);
+		struct snd_soc_dai *dai);
 
 	/* ops */
 	struct snd_soc_ops ops;
@@ -386,7 +359,9 @@ struct snd_soc_cpu_dai {
 
 	/* DAI runtime info */
 	struct snd_pcm_runtime *runtime;
-	unsigned char active:1;
+	struct snd_soc_codec *codec;
+	unsigned int active;
+	unsigned char pop_wait:1;
 	void *dma_data;
 
 	/* DAI private data */
@@ -428,7 +403,7 @@ struct snd_soc_codec {
 	struct delayed_work delayed_work;
 
 	/* codec DAI's */
-	struct snd_soc_codec_dai *dai;
+	struct snd_soc_dai *dai;
 	unsigned int num_dai;
 };
 
@@ -447,12 +422,12 @@ struct snd_soc_platform {
 	int (*probe)(struct platform_device *pdev);
 	int (*remove)(struct platform_device *pdev);
 	int (*suspend)(struct platform_device *pdev,
-		struct snd_soc_cpu_dai *cpu_dai);
+		struct snd_soc_dai *dai);
 	int (*resume)(struct platform_device *pdev,
-		struct snd_soc_cpu_dai *cpu_dai);
+		struct snd_soc_dai *dai);
 
 	/* pcm creation and destruction */
-	int (*pcm_new)(struct snd_card *, struct snd_soc_codec_dai *,
+	int (*pcm_new)(struct snd_card *, struct snd_soc_dai *,
 		struct snd_pcm *);
 	void (*pcm_free)(struct snd_pcm *);
 
@@ -466,8 +441,8 @@ struct snd_soc_dai_link  {
 	char *stream_name;		/* Stream name */
 
 	/* DAI */
-	struct snd_soc_codec_dai *codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai;
 
 	/* machine stream operations */
 	struct snd_soc_ops *ops;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bdbbc6a..4d626b4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -134,8 +134,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_dai_link *machine = rtd->dai;
 	struct snd_soc_platform *platform = socdev->platform;
-	struct snd_soc_cpu_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_codec_dai *codec_dai = machine->codec_dai;
+	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
+	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	int ret = 0;
 
 	mutex_lock(&pcm_mutex);
@@ -272,7 +272,7 @@ static void close_delayed_work(struct work_struct *work)
 	struct snd_soc_device *socdev =
 		container_of(work, struct snd_soc_device, delayed_work.work);
 	struct snd_soc_codec *codec = socdev->codec;
-	struct snd_soc_codec_dai *codec_dai;
+	struct snd_soc_dai *codec_dai;
 	int i;
 
 	mutex_lock(&pcm_mutex);
@@ -323,8 +323,8 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_dai_link *machine = rtd->dai;
 	struct snd_soc_platform *platform = socdev->platform;
-	struct snd_soc_cpu_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_codec_dai *codec_dai = machine->codec_dai;
+	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
+	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	struct snd_soc_codec *codec = socdev->codec;
 
 	mutex_lock(&pcm_mutex);
@@ -384,8 +384,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_dai_link *machine = rtd->dai;
 	struct snd_soc_platform *platform = socdev->platform;
-	struct snd_soc_cpu_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_codec_dai *codec_dai = machine->codec_dai;
+	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
+	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	struct snd_soc_codec *codec = socdev->codec;
 	int ret = 0;
 
@@ -489,8 +489,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_dai_link *machine = rtd->dai;
 	struct snd_soc_platform *platform = socdev->platform;
-	struct snd_soc_cpu_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_codec_dai *codec_dai = machine->codec_dai;
+	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
+	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	int ret = 0;
 
 	mutex_lock(&pcm_mutex);
@@ -559,8 +559,8 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_dai_link *machine = rtd->dai;
 	struct snd_soc_platform *platform = socdev->platform;
-	struct snd_soc_cpu_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_codec_dai *codec_dai = machine->codec_dai;
+	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
+	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	struct snd_soc_codec *codec = socdev->codec;
 
 	mutex_lock(&pcm_mutex);
@@ -594,8 +594,8 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_dai_link *machine = rtd->dai;
 	struct snd_soc_platform *platform = socdev->platform;
-	struct snd_soc_cpu_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_codec_dai *codec_dai = machine->codec_dai;
+	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
+	struct snd_soc_dai *codec_dai = machine->codec_dai;
 	int ret;
 
 	if (codec_dai->ops.trigger) {
@@ -651,7 +651,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 
 	/* mute any active DAC's */
 	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_codec_dai *dai = machine->dai_link[i].codec_dai;
+		struct snd_soc_dai *dai = machine->dai_link[i].codec_dai;
 		if (dai->dai_ops.digital_mute && dai->playback.active)
 			dai->dai_ops.digital_mute(dai, 1);
 	}
@@ -664,7 +664,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 		machine->suspend_pre(pdev, state);
 
 	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_cpu_dai  *cpu_dai = machine->dai_link[i].cpu_dai;
+		struct snd_soc_dai  *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->suspend && cpu_dai->type != SND_SOC_DAI_AC97)
 			cpu_dai->suspend(pdev, cpu_dai);
 		if (platform->suspend)
@@ -690,7 +690,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 		codec_dev->suspend(pdev, state);
 
 	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->suspend && cpu_dai->type == SND_SOC_DAI_AC97)
 			cpu_dai->suspend(pdev, cpu_dai);
 	}
@@ -726,7 +726,7 @@ static void soc_resume_deferred(struct work_struct *work)
 		machine->resume_pre(pdev);
 
 	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->resume && cpu_dai->type == SND_SOC_DAI_AC97)
 			cpu_dai->resume(pdev, cpu_dai);
 	}
@@ -747,13 +747,13 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	/* unmute any active DACs */
 	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_codec_dai *dai = machine->dai_link[i].codec_dai;
+		struct snd_soc_dai *dai = machine->dai_link[i].codec_dai;
 		if (dai->dai_ops.digital_mute && dai->playback.active)
 			dai->dai_ops.digital_mute(dai, 0);
 	}
 
 	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->resume && cpu_dai->type != SND_SOC_DAI_AC97)
 			cpu_dai->resume(pdev, cpu_dai);
 		if (platform->resume)
@@ -803,7 +803,7 @@ static int soc_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->probe) {
 			ret = cpu_dai->probe(pdev, cpu_dai);
 			if (ret < 0)
@@ -838,7 +838,7 @@ platform_err:
 
 cpu_dai_err:
 	for (i--; i >= 0; i--) {
-		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->remove)
 			cpu_dai->remove(pdev, cpu_dai);
 	}
@@ -867,7 +867,7 @@ static int soc_remove(struct platform_device *pdev)
 		codec_dev->remove(pdev);
 
 	for (i = 0; i < machine->num_links; i++) {
-		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
+		struct snd_soc_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->remove)
 			cpu_dai->remove(pdev, cpu_dai);
 	}
@@ -895,8 +895,8 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 	struct snd_soc_dai_link *dai_link, int num)
 {
 	struct snd_soc_codec *codec = socdev->codec;
-	struct snd_soc_codec_dai *codec_dai = dai_link->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = dai_link->cpu_dai;
+	struct snd_soc_dai *codec_dai = dai_link->codec_dai;
+	struct snd_soc_dai *cpu_dai = dai_link->cpu_dai;
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_pcm *pcm;
 	char new_name[64];
@@ -1211,7 +1211,7 @@ void snd_soc_free_pcms(struct snd_soc_device *socdev)
 {
 	struct snd_soc_codec *codec = socdev->codec;
 #ifdef CONFIG_SND_SOC_AC97_BUS
-	struct snd_soc_codec_dai *codec_dai;
+	struct snd_soc_dai *codec_dai;
 	int i;
 #endif
 
-- 
1.5.4.2
