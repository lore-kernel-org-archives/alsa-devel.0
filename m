From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: twl6040: Move ignore_pmdown_time to
	driver struct
Date: Wed,  8 Feb 2012 18:37:17 +0000
Message-ID: <1328726238-556-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1328726238-556-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ACB77103E96
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 19:37:23 +0100 (CET)
In-Reply-To: <1328726238-556-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It's set unconditionally.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 1a64edf..2d8c6b8 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1540,7 +1540,6 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 
 	priv->codec = codec;
 	codec->control_data = dev_get_drvdata(codec->dev->parent);
-	codec->ignore_pmdown_time = 1;
 
 	if (pdata && pdata->hs_left_step && pdata->hs_right_step) {
 		priv->hs_left_step = pdata->hs_left_step;
@@ -1626,6 +1625,7 @@ static struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
 	.reg_cache_size = ARRAY_SIZE(twl6040_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = twl6040_reg,
+	.ignore_pmdown_time = true,
 
 	.controls = twl6040_snd_controls,
 	.num_controls = ARRAY_SIZE(twl6040_snd_controls),
-- 
1.7.9.rc1
