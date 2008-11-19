From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/6] ASoC: Convert blackfin machines to use DAI
	accessor functions
Date: Wed, 19 Nov 2008 13:36:33 +0000
Message-ID: <1227101793-3768-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081119133427.GA3687@rakim.wolfsonmicro.main>
	<1227101793-3768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227101793-3768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227101793-3768-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227101793-3768-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227101793-3768-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0ADE103806
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 14:36:34 +0100 (CET)
In-Reply-To: <1227101793-3768-5-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/blackfin/bf5xx-ad73311.c |    2 +-
 sound/soc/blackfin/bf5xx-ssm2602.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 622c9b9..47da49b 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -168,7 +168,7 @@ static int bf5xx_ad73311_hw_params(struct snd_pcm_substream *substream,
 		params_format(params));
 
 	/* set cpu DAI configuration */
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index e15f67f..744a90e 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -92,17 +92,17 @@ static int bf5xx_ssm2602_hw_params(struct snd_pcm_substream *substream,
 	 */
 
 	/* set codec DAI configuration */
-	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
 	if (ret < 0)
 		return ret;
 	/* set cpu DAI configuration */
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
 	if (ret < 0)
 		return ret;
 
-	ret = codec_dai->dai_ops.set_sysclk(codec_dai, SSM2602_SYSCLK, clk,
+	ret = snd_soc_dai_set_sysclk(codec_dai, SSM2602_SYSCLK, clk,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
-- 
1.5.6.5
