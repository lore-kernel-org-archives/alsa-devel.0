From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] ASoC: Use dai_fmt in kirkwood-t5325
	machine driver
Date: Wed, 28 Dec 2011 18:59:30 +0800
Message-ID: <1325069970.2497.2.camel@phoenix>
References: <1325069897.2497.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 964A52441F
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 11:59:37 +0100 (CET)
Received: by iaae16 with SMTP id e16so21169886iaa.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 02:59:36 -0800 (PST)
In-Reply-To: <1325069897.2497.1.camel@phoenix>
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
 sound/soc/kirkwood/kirkwood-t5325.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index a8930c7..6e99230 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -25,18 +25,7 @@ static int t5325_hw_params(struct snd_pcm_substream *substream,
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
 
 	freq = params_rate(params) * 256;
 
@@ -90,6 +79,7 @@ static struct snd_soc_dai_link t5325_dai[] = {
 	.platform_name = "kirkwood-pcm-audio",
 	.codec_dai_name = "alc5621-hifi",
 	.codec_name = "alc562x-codec.0-001a",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &t5325_ops,
 	.init = t5325_dai_init,
 },
-- 
1.7.5.4
