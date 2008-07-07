From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 10/10] asoc: sh - merge structs
	snd_soc_codec_dai and	snd_soc_cpu_dai.
Date: Mon, 07 Jul 2008 16:08:29 +0100
Message-ID: <1215443309.4882.187.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A959D103822
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 17:08:30 +0200 (CEST)
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
snd_soc_cpu_dai into struct snd_soc_dai for the SuperH platform.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/sh/dma-sh7760.c  |    2 +-
 sound/soc/sh/hac.c         |    2 +-
 sound/soc/sh/sh7760-ac97.c |    2 +-
 sound/soc/sh/ssi.c         |    8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 7a3ce80..9faa126 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -326,7 +326,7 @@ static void camelot_pcm_free(struct snd_pcm *pcm)
 }
 
 static int camelot_pcm_new(struct snd_card *card,
-			   struct snd_soc_codec_dai *dai,
+			   struct snd_soc_dai *dai,
 			   struct snd_pcm *pcm)
 {
 	/* dont use SNDRV_DMA_TYPE_DEV, since it will oops the SH kernel
diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index b7b676b..df7bc34 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -266,7 +266,7 @@ static int hac_hw_params(struct snd_pcm_substream *substream,
 #define AC97_FMTS	\
 	SNDRV_PCM_FMTBIT_S16_LE
 
-struct snd_soc_cpu_dai sh4_hac_dai[] = {
+struct snd_soc_dai sh4_hac_dai[] = {
 {
 	.name			= "HAC0",
 	.id			= 0,
diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
index 846d1b3..92bfaf4 100644
--- a/sound/soc/sh/sh7760-ac97.c
+++ b/sound/soc/sh/sh7760-ac97.c
@@ -20,7 +20,7 @@
 #define IPSEL 0xFE400034
 
 /* platform specific structs can be declared here */
-extern struct snd_soc_cpu_dai sh4_hac_dai[2];
+extern struct snd_soc_dai sh4_hac_dai[2];
 extern struct snd_soc_platform sh7760_soc_platform;
 
 static int machine_init(struct snd_soc_codec *codec)
diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index 3388bc3..55c3464 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -208,7 +208,7 @@ static int ssi_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int ssi_set_sysclk(struct snd_soc_cpu_dai *cpu_dai, int clk_id,
+static int ssi_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
 			  unsigned int freq, int dir)
 {
 	struct ssi_priv *ssi = &ssi_cpu_data[cpu_dai->id];
@@ -222,7 +222,7 @@ static int ssi_set_sysclk(struct snd_soc_cpu_dai *cpu_dai, int clk_id,
  * This divider is used to generate the SSI_SCK (I2S bitclock) from the
  * clock at the HAC_BIT_CLK ("oversampling clock") pin.
  */
-static int ssi_set_clkdiv(struct snd_soc_cpu_dai *dai, int did, int div)
+static int ssi_set_clkdiv(struct snd_soc_dai *dai, int did, int div)
 {
 	struct ssi_priv *ssi = &ssi_cpu_data[dai->id];
 	unsigned long ssicr;
@@ -245,7 +245,7 @@ static int ssi_set_clkdiv(struct snd_soc_cpu_dai *dai, int did, int div)
 	return 0;
 }
 
-static int ssi_set_fmt(struct snd_soc_cpu_dai *dai, unsigned int fmt)
+static int ssi_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct ssi_priv *ssi = &ssi_cpu_data[dai->id];
 	unsigned long ssicr = SSIREG(SSICR);
@@ -332,7 +332,7 @@ static int ssi_set_fmt(struct snd_soc_cpu_dai *dai, unsigned int fmt)
 	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_U24_3LE |	\
 	 SNDRV_PCM_FMTBIT_S32_LE  | SNDRV_PCM_FMTBIT_U32_LE)
 
-struct snd_soc_cpu_dai sh4_ssi_dai[] = {
+struct snd_soc_dai sh4_ssi_dai[] = {
 {
 	.name			= "SSI0",
 	.id			= 0,
-- 
1.5.4.2
