From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: Blackfin: add ad193x sysclk configuration
Date: Sun, 27 Mar 2011 05:33:04 -0400
Message-ID: <1301218384-28917-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id F2CD710381A
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 11:32:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Scott Jiang <scott.jiang@analog.com>

Signed-off-by: Scott Jiang <scott.jiang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-ad193x.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index d3ccb92..3367882 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -60,8 +60,16 @@ static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	unsigned int clk = 0;
 	unsigned int channel_map[] = {0, 1, 2, 3, 4, 5, 6, 7};
 	int ret = 0;
+
+	switch (params_rate(params)) {
+	case 48000:
+		clk = 12288000;
+		break;
+	}
+
 	/* set cpu DAI configuration */
 	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
 		SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
@@ -74,6 +82,12 @@ static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/* set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
 	/* set codec DAI slots, 8 channels, all channels are enabled */
 	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xFF, 0xFF, 8, 32);
 	if (ret < 0)
-- 
1.7.4.1
