From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Make CPU and codec DAI operations have
	same type
Date: Mon, 19 May 2008 11:20:40 +0100
Message-ID: <1211192441-28912-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1211192441-28912-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2819A245F8
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 12:20:43 +0200 (CEST)
In-Reply-To: <1211192441-28912-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The CPU and codec DAI operations differ only in the presence of the
digital mute operation for the codec so they may as well be the same
type.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |   30 ++++++------------------------
 1 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 727c0ba..bca9538 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -290,9 +290,9 @@ struct snd_soc_ops {
 	int (*trigger)(struct snd_pcm_substream *, int);
 };
 
-/* ASoC codec DAI ops */
-struct snd_soc_codec_ops {
-	/* codec DAI clocking configuration */
+/* ASoC DAI ops */
+struct snd_soc_dai_ops {
+	/* DAI clocking configuration */
 	int (*set_sysclk)(struct snd_soc_codec_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir);
 	int (*set_pll)(struct snd_soc_codec_dai *codec_dai,
@@ -300,7 +300,7 @@ struct snd_soc_codec_ops {
 	int (*set_clkdiv)(struct snd_soc_codec_dai *codec_dai,
 		int div_id, int div);
 
-	/* CPU DAI format configuration */
+	/* DAI format configuration */
 	int (*set_fmt)(struct snd_soc_codec_dai *codec_dai,
 		unsigned int fmt);
 	int (*set_tdm_slot)(struct snd_soc_codec_dai *codec_dai,
@@ -311,24 +311,6 @@ struct snd_soc_codec_ops {
 	int (*digital_mute)(struct snd_soc_codec_dai *, int mute);
 };
 
-/* ASoC cpu DAI ops */
-struct snd_soc_cpu_ops {
-	/* CPU DAI clocking configuration */
-	int (*set_sysclk)(struct snd_soc_cpu_dai *cpu_dai,
-		int clk_id, unsigned int freq, int dir);
-	int (*set_clkdiv)(struct snd_soc_cpu_dai *cpu_dai,
-		int div_id, int div);
-	int (*set_pll)(struct snd_soc_cpu_dai *cpu_dai,
-		int pll_id, unsigned int freq_in, unsigned int freq_out);
-
-	/* CPU DAI format configuration */
-	int (*set_fmt)(struct snd_soc_cpu_dai *cpu_dai,
-		unsigned int fmt);
-	int (*set_tdm_slot)(struct snd_soc_cpu_dai *cpu_dai,
-		unsigned int mask, int slots);
-	int (*set_tristate)(struct snd_soc_cpu_dai *, int tristate);
-};
-
 /* SoC Codec DAI */
 struct snd_soc_codec_dai {
 	char *name;
@@ -346,7 +328,7 @@ struct snd_soc_codec_dai {
 
 	/* ops */
 	struct snd_soc_ops ops;
-	struct snd_soc_codec_ops dai_ops;
+	struct snd_soc_dai_ops dai_ops;
 
 	/* DAI private data */
 	void *private_data;
@@ -370,7 +352,7 @@ struct snd_soc_cpu_dai {
 
 	/* ops */
 	struct snd_soc_ops ops;
-	struct snd_soc_cpu_ops dai_ops;
+	struct snd_soc_dai_ops dai_ops;
 
 	/* DAI capabilities */
 	struct snd_soc_pcm_stream capture;
-- 
1.5.5.1
