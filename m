From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: Pandora: Pass SRG input clock frequency
	to the OMAP McBSP DAI
Date: Mon,  9 Nov 2009 08:44:32 +0200
Message-ID: <1257749072-3796-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id C711510380B
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 07:43:45 +0100 (CET)
Received: by fxm1 with SMTP id 1so3145345fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 08 Nov 2009 22:43:45 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

Upcoming change to omap-mcbsp.c require that machine drivers using OMAP
as a DAI master to pass sample rate generator input clock frequency to
the omap-mcbsp.c DAI driver.

Pandora is using 256*Fs output from the TWL4030 codec as an input clock to
the McBSP sample rate generator.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
---
 sound/soc/omap/omap3pandora.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index ad219aa..cace5f1 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -40,9 +40,12 @@
 
 #define PREFIX "ASoC omap3pandora: "
 
-static int omap3pandora_cmn_hw_params(struct snd_soc_dai *codec_dai,
-	struct snd_soc_dai *cpu_dai, unsigned int fmt)
+static int omap3pandora_cmn_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, unsigned int fmt)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int ret;
 
 	/* Set codec DAI configuration */
@@ -68,8 +71,9 @@ static int omap3pandora_cmn_hw_params(struct snd_soc_dai *codec_dai,
 	}
 
 	/* Set McBSP clock to external */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT, 0,
-					    SND_SOC_CLOCK_IN);
+	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT,
+				     256 * params_rate(params),
+				     SND_SOC_CLOCK_IN);
 	if (ret < 0) {
 		pr_err(PREFIX "can't set cpu system clock\n");
 		return ret;
@@ -87,11 +91,7 @@ static int omap3pandora_cmn_hw_params(struct snd_soc_dai *codec_dai,
 static int omap3pandora_out_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-
-	return omap3pandora_cmn_hw_params(codec_dai, cpu_dai,
+	return omap3pandora_cmn_hw_params(substream, params,
 					  SND_SOC_DAIFMT_I2S |
 					  SND_SOC_DAIFMT_IB_NF |
 					  SND_SOC_DAIFMT_CBS_CFS);
@@ -100,11 +100,7 @@ static int omap3pandora_out_hw_params(struct snd_pcm_substream *substream,
 static int omap3pandora_in_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-
-	return omap3pandora_cmn_hw_params(codec_dai, cpu_dai,
+	return omap3pandora_cmn_hw_params(substream, params,
 					  SND_SOC_DAIFMT_I2S |
 					  SND_SOC_DAIFMT_NB_NF |
 					  SND_SOC_DAIFMT_CBS_CFS);
-- 
1.6.5
