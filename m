From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: rt5640: Power down LDO while
	suspended
Date: Wed, 16 Oct 2013 17:33:34 +0100
Message-ID: <1381941215-29031-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E37C5261A49
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 18:35:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

If we have control over the LDO then disable it during suspend; the device
is already being put into reset so will be non-functional over suspend
anyway and this will save a small amount of power.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/rt5640.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 641eeeb..b0cde92 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1979,12 +1979,20 @@ static int rt5640_suspend(struct snd_soc_codec *codec)
 	rt5640_reset(codec);
 	regcache_cache_only(rt5640->regmap, true);
 	regcache_mark_dirty(rt5640->regmap);
+	if (gpio_is_valid(rt5640->pdata.ldo1_en))
+		gpio_set_value_cansleep(rt5640->pdata.ldo1_en, 0);
 
 	return 0;
 }
 
 static int rt5640_resume(struct snd_soc_codec *codec)
 {
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+
+	if (gpio_is_valid(rt5640->pdata.ldo1_en)) {
+		gpio_set_value_cansleep(rt5640->pdata.ldo1_en, 1);
+		msleep(400);
+	}
 	rt5640_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
-- 
1.8.4.rc3
