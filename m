From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs42l51: Fix mask for REVID
Date: Thu, 17 Apr 2014 16:35:43 +0800
Message-ID: <1397723743.601.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f174.google.com (mail-vc0-f174.google.com
 [209.85.220.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 665D2265057
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 10:42:33 +0200 (CEST)
Received: by mail-vc0-f174.google.com with SMTP id ld13so153835vcb.33
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 01:42:31 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The REVID mask was changed by commit a1253ef6d3fa
"ASoC: cs42l51: split i2c from codec driver". Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l51.c | 3 ++-
 sound/soc/codecs/cs42l51.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index dadc20d..09488d9 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -548,7 +548,8 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 		ret = -ENODEV;
 		goto error;
 	}
-	dev_info(dev, "Cirrus Logic CS42L51, Revision: %02X\n", val & 0xFF);
+	dev_info(dev, "Cirrus Logic CS42L51, Revision: %02X\n",
+		 val & CS42L51_CHIP_REV_MASK);
 
 	ret =  snd_soc_register_codec(dev,
 			&soc_codec_device_cs42l51, &cs42l51_dai, 1);
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index 641ef18..8c55bf3 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -26,6 +26,7 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap);
 #define CS42L51_CHIP_ID			0x1B
 #define CS42L51_CHIP_REV_A		0x00
 #define CS42L51_CHIP_REV_B		0x01
+#define CS42L51_CHIP_REV_MASK		0x07
 
 #define CS42L51_CHIP_REV_ID		0x01
 #define CS42L51_MK_CHIP_REV(a, b)	((a)<<3|(b))
-- 
1.8.3.2
