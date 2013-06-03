From: Mark Brown <broonie@linaro.org>
Subject: [PATCH] ASoC: sgtl5000: Make device cache only when
	powered off
Date: Mon,  3 Jun 2013 10:22:30 +0100
Message-ID: <1370251350-4679-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ACA8261A6D
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 11:22:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

When the regulators have been disabled mark the device as cache only so
that we don't try to interact with the hardware.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/sgtl5000.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1c3b20f..85a32e6 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -911,10 +911,25 @@ static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 			if (ret)
 				return ret;
 			udelay(10);
+
+			regcache_cache_only(sgtl5000->regmap, false);
+
+			ret = regcache_sync(sgtl5000->regmap);
+			if (ret != 0) {
+				dev_err(codec->dev,
+					"Failed to restore cache: %d\n", ret);
+
+				regcache_cache_only(sgtl5000->regmap, true);
+				regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
+						       sgtl5000->supplies);
+
+				return ret;
+			}
 		}
 
 		break;
 	case SND_SOC_BIAS_OFF:
+		regcache_cache_only(sgtl5000->regmap, true);
 		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 					sgtl5000->supplies);
 		break;
-- 
1.7.10.4
