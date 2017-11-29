From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 02/19] ASoC: tlv320aic31xx: Change
	aic31xx_power_off return type to void
Date: Wed, 29 Nov 2017 15:32:43 -0600
Message-ID: <20171129213300.20021-3-afd@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id DDD23267960
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 22:33:03 +0100 (CET)
In-Reply-To: <20171129213300.20021-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The return value is not checked, and even if it was there is nothing
we could do about it and messages are already printed.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index b98d9b1f216f..0563a49cc5e4 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1081,16 +1081,13 @@ static int aic31xx_power_on(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int aic31xx_power_off(struct snd_soc_codec *codec)
+static void aic31xx_power_off(struct snd_soc_codec *codec)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
-	int ret = 0;
 
 	regcache_cache_only(aic31xx->regmap, true);
-	ret = regulator_bulk_disable(ARRAY_SIZE(aic31xx->supplies),
-				     aic31xx->supplies);
-
-	return ret;
+	regulator_bulk_disable(ARRAY_SIZE(aic31xx->supplies),
+			       aic31xx->supplies);
 }
 
 static int aic31xx_set_bias_level(struct snd_soc_codec *codec,
-- 
2.15.0
