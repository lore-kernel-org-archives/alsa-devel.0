From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] ASoC: tlv320aic3x: Convert codec->hw_read to
 regmap_read
Date: Thu, 13 Oct 2011 15:24:21 +0800
Message-ID: <1318490661.2857.10.camel@phoenix>
References: <1318490575.2857.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318490575.2857.8.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

codec->hw_read is broken now, let's covert to regmap_read.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index be55b7f..8775d52 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -131,13 +131,19 @@ static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
 		      u8 *value)
 {
 	u8 *cache = codec->reg_cache;
+	unsigned int val;
+	int ret;
 
 	if (codec->cache_only)
 		return -EINVAL;
 	if (reg >= AIC3X_CACHEREGNUM)
 		return -1;
 
-	*value = codec->hw_read(codec, reg);
+	ret = regmap_read(codec->control_data, reg, &val);
+	if (ret)
+		return ret;
+
+	*value = val;
 	cache[reg] = *value;
 
 	return 0;
-- 
1.7.4.1
