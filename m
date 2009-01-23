From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/9] ASoC: Configure SSP port PLL for Zylonite
Date: Fri, 23 Jan 2009 17:18:36 +0000
Message-ID: <1232731120-6144-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090123171619.GB6003@rakim.wolfsonmicro.main>
	<1232731120-6144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 696522448F
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 18:18:42 +0100 (CET)
In-Reply-To: <1232731120-6144-4-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/pxa/zylonite.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index 8541b67..ec2fb76 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -95,6 +95,7 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int pll_out = 0;
 	unsigned int acds = 0;
 	unsigned int wm9713_div = 0;
 	int ret = 0;
@@ -102,13 +103,16 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
 	switch (params_rate(params)) {
 	case 8000:
 		wm9713_div = 12;
+		pll_out = 2048000;
 		break;
 	case 16000:
 		wm9713_div = 6;
+		pll_out = 4096000;
 		break;
 	case 48000:
 	default:
 		wm9713_div = 2;
+		pll_out = 12288000;
 		acds = 1;
 		break;
 	}
@@ -129,6 +133,10 @@ static int zylonite_voice_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, pll_out);
+	if (ret < 0)
+		return ret;
+
 	ret = snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_AUDIO_DIV_ACDS, acds);
 	if (ret < 0)
 		return ret;
-- 
1.5.6.5
