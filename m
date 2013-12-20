From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 6/6] ASoC: fsl_sai: Sort local variable in
	general way
Date: Fri, 20 Dec 2013 16:41:05 +0800
Message-ID: <ccf261aa9dfd3d1ea2b5d5e86d2e7854e622a94f.1387528048.git.Guangyu.Chen@freescale.com>
References: <cover.1387528048.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 448192655F7
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 09:40:54 +0100 (CET)
In-Reply-To: <cover.1387528048.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, linux@arm.linux.org.uk
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, timur@tabi.org, lgirdwood@gmail.com, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

Generally we would write code for local variable like:
static new_func()
{
	struct xxx *yyy;
	...
	int ret;
}

But this driver only follows this pattern for some functions, not all.
Thus this patch sorts the local variable in the general way.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index ba59015..73a11c8 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -53,8 +53,8 @@ static inline void sai_writel(struct fsl_sai *sai,
 static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
 		int clk_id, unsigned int freq, int fsl_dir)
 {
-	u32 val_cr2, reg_cr2;
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	u32 val_cr2, reg_cr2;
 
 	if (fsl_dir == FSL_FMT_TRANSMITTER)
 		reg_cr2 = FSL_SAI_TCR2;
@@ -90,8 +90,8 @@ static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
 static int fsl_sai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	int ret;
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
 
 	if (dir == SND_SOC_CLOCK_IN)
 		return 0;
@@ -128,8 +128,8 @@ err_clk:
 static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 				unsigned int fmt, int fsl_dir)
 {
-	u32 val_cr2, val_cr3, val_cr4, reg_cr2, reg_cr3, reg_cr4;
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	u32 val_cr2, val_cr3, val_cr4, reg_cr2, reg_cr3, reg_cr4;
 
 	if (fsl_dir == FSL_FMT_TRANSMITTER) {
 		reg_cr2 = FSL_SAI_TCR2;
@@ -207,8 +207,8 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 
 static int fsl_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
-	int ret;
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
 
 	ret = clk_prepare_enable(sai->clk);
 	if (ret)
@@ -236,9 +236,9 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *cpu_dai)
 {
+	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	u32 val_cr4, val_cr5, val_mr, reg_cr4, reg_cr5, reg_mr;
 	unsigned int channels = params_channels(params);
-	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	u32 word_width = snd_pcm_format_width(params_format(params));
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -394,10 +394,10 @@ static const struct snd_soc_component_driver fsl_component = {
 
 static int fsl_sai_probe(struct platform_device *pdev)
 {
-	int ret;
+	struct device_node *np = pdev->dev.of_node;
 	struct fsl_sai *sai;
 	struct resource *res;
-	struct device_node *np = pdev->dev.of_node;
+	int ret;
 
 	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
 	if (!sai)
-- 
1.8.4
