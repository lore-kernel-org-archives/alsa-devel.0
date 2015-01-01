From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/21] ASoC: s3c24xx_simtec: Use static DAI
	format setup
Date: Thu,  1 Jan 2015 17:16:24 +0100
Message-ID: <1420128990-6872-16-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CF1226059A
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:54 +0100 (CET)
In-Reply-To: <1420128990-6872-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Sangbeom Kim <sbkim73@samsung.com>, Denis Carikli <denis@eukrea.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Bo Shen <voice.shen@atmel.com>, Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Set the dai_fmt field in the dai_link struct instead of manually calling
snd_soc_dai_fmt(). This makes the code cleaner and shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/s3c24xx_simtec.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index 2c015f6..dcc008d 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -169,24 +169,6 @@ static int simtec_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
-	/* Set the CODEC as the bus clock master, I2S */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret) {
-		pr_err("%s: failed set cpu dai format\n", __func__);
-		return ret;
-	}
-
-	/* Set the CODEC as the bus clock master */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret) {
-		pr_err("%s: failed set codec dai format\n", __func__);
-		return ret;
-	}
-
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
 				     CODEC_CLOCK, SND_SOC_CLOCK_IN);
 	if (ret) {
@@ -320,6 +302,8 @@ int simtec_audio_core_probe(struct platform_device *pdev,
 	int ret;
 
 	card->dai_link->ops = &simtec_snd_ops;
+	card->dai_link->dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM;
 
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
-- 
1.8.0
