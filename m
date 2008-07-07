From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 07/10] asoc: omap - merge structs
	snd_soc_codec_dai and	snd_soc_cpu_dai.
Date: Mon, 07 Jul 2008 16:08:07 +0100
Message-ID: <1215443287.4882.184.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1906510381D
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 17:08:08 +0200 (CEST)
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


This patch merges struct snd_soc_codec_dai and struct
snd_soc_cpu_dai into struct snd_soc_dai for the Omap platform.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/omap/n810.c       |    4 ++--
 sound/soc/omap/omap-mcbsp.c |   16 ++++++++--------
 sound/soc/omap/omap-mcbsp.h |    2 +-
 sound/soc/omap/omap-pcm.c   |    2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 74f4599..d1233c0 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -86,8 +86,8 @@ static int n810_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int err;
 
 	/* Set codec DAI configuration */
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 40d87e6..00b0c9d 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -103,7 +103,7 @@ static const unsigned long omap2420_mcbsp_port[][2] = {};
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	int err = 0;
 
@@ -116,7 +116,7 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream)
 static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 
 	if (!cpu_dai->active) {
@@ -128,7 +128,7 @@ static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream)
 static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	int err = 0;
 
@@ -157,7 +157,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	int dma, bus_id = mcbsp_data->bus_id, id = cpu_dai->id;
@@ -223,7 +223,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
  * This must be called before _set_clkdiv and _set_sysclk since McBSP register
  * cache is initialized here
  */
-static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
+static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 				      unsigned int fmt)
 {
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
@@ -292,7 +292,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
 	return 0;
 }
 
-static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
+static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
 				     int div_id, int div)
 {
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
@@ -347,7 +347,7 @@ static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
 	return 0;
 }
 
-static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 					 int clk_id, unsigned int freq,
 					 int dir)
 {
@@ -376,7 +376,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
 	return err;
 }
 
-struct snd_soc_cpu_dai omap_mcbsp_dai[NUM_LINKS] = {
+struct snd_soc_dai omap_mcbsp_dai[NUM_LINKS] = {
 {
 	.name = "omap-mcbsp-dai",
 	.id = 0,
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index 9965fd4..ed8afb5 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -44,6 +44,6 @@ enum omap_mcbsp_div {
  */
 #define NUM_LINKS	1
 
-extern struct snd_soc_cpu_dai omap_mcbsp_dai[NUM_LINKS];
+extern struct snd_soc_dai omap_mcbsp_dai[NUM_LINKS];
 
 #endif
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 6237020..e092f3d 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -316,7 +316,7 @@ static void omap_pcm_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-int omap_pcm_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
+int omap_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 		 struct snd_pcm *pcm)
 {
 	int ret = 0;
-- 
1.5.4.2
