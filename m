From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/3] ASoC: Use dai_fmt in kirkwood-openrd
	machine driver
Date: Wed, 28 Dec 2011 18:58:17 +0800
Message-ID: <1325069897.2497.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A43012441F
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 11:58:30 +0100 (CET)
Received: by iaae16 with SMTP id e16so21168453iaa.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 02:58:27 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/kirkwood/kirkwood-openrd.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index 8a5a3dd..55d2ed3 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -26,18 +26,7 @@ static int openrd_client_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret;
-	unsigned int freq, fmt;
-
-	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS;
-	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
-	if (ret < 0)
-		return ret;
+	unsigned int freq;
 
 	switch (params_rate(params)) {
 	default:
@@ -69,6 +58,7 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
 	.platform_name = "kirkwood-pcm-audio",
 	.codec_dai_name = "cs42l51-hifi",
 	.codec_name = "cs42l51-codec.0-004a",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &openrd_client_ops,
 },
 };
-- 
1.7.5.4
