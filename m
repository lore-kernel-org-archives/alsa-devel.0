From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 21/21] ASoC: migor: Use static DAI format setup
Date: Thu,  1 Jan 2015 17:16:30 +0100
Message-ID: <1420128990-6872-22-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 306852605DA
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:17:03 +0100 (CET)
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
 sound/soc/sh/migor.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index c58c252..82f5823 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -63,16 +63,6 @@ static int migor_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_NB_IF |
-				  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_fmt(rtd->cpu_dai, SND_SOC_DAIFMT_NB_IF |
-				  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
 	codec_freq = rate * 512;
 	/*
 	 * This propagates the parent frequency change to children and
@@ -144,6 +134,8 @@ static struct snd_soc_dai_link migor_dai = {
 	.codec_dai_name = "wm8978-hifi",
 	.platform_name = "siu-pcm-audio",
 	.codec_name = "wm8978.0-001a",
+	.dai_fmt = SND_SOC_DAIFMT_NB_IF | SND_SOC_DAIFMT_I2S |
+		   SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &migor_dai_ops,
 };
 
-- 
1.8.0
