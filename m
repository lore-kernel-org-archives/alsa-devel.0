From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: tlv320aic26: Convert to table based
	control init
Date: Wed, 25 Sep 2013 13:30:37 +0100
Message-ID: <1380112239-11149-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D418F2625E2
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 14:30:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic26.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 7b8f3d9..32c6b07 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -377,7 +377,7 @@ static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
 static int aic26_probe(struct snd_soc_codec *codec)
 {
 	struct aic26 *aic26 = dev_get_drvdata(codec->dev);
-	int ret, err, i, reg;
+	int ret, i, reg;
 
 	aic26->codec = codec;
 
@@ -403,12 +403,6 @@ static int aic26_probe(struct snd_soc_codec *codec)
 	if (ret)
 		dev_info(codec->dev, "error creating sysfs files\n");
 
-	/* register controls */
-	dev_dbg(codec->dev, "Registering controls\n");
-	err = snd_soc_add_codec_controls(codec, aic26_snd_controls,
-			ARRAY_SIZE(aic26_snd_controls));
-	WARN_ON(err < 0);
-
 	return 0;
 }
 
@@ -418,6 +412,8 @@ static struct snd_soc_codec_driver aic26_soc_codec_dev = {
 	.write = aic26_reg_write,
 	.reg_cache_size = AIC26_NUM_REGS,
 	.reg_word_size = sizeof(u16),
+	.controls = aic26_snd_controls,
+	.num_controls = ARRAY_SIZE(aic26_snd_controls),
 	.dapm_widgets = tlv320aic26_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(tlv320aic26_dapm_widgets),
 	.dapm_routes = tlv320aic26_dapm_routes,
-- 
1.8.4.rc3
