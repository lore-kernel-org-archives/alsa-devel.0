From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs42l52: Fix mask for REVID
Date: Sun, 06 Apr 2014 00:04:35 +0800
Message-ID: <1396713875.9878.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8550C26513C
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 18:58:26 +0200 (CEST)
Received: by mail-pd0-f179.google.com with SMTP id w10so4686157pde.38
 for <alsa-devel@alsa-project.org>; Sat, 05 Apr 2014 09:58:25 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

BIT[0:2] of register 01h is REVID, so the mask for REVID should be 0x7.
Also updates the code to use CS42L52_CHIP_REV_MASK.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l52.c | 2 +-
 sound/soc/codecs/cs42l52.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index f0ca6be..460d355 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1259,7 +1259,7 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 	}
 
 	dev_info(&i2c_client->dev, "Cirrus Logic CS42L52, Revision: %02X\n",
-			reg & 0xFF);
+		 reg & CS42L52_CHIP_REV_MASK);
 
 	/* Set Platform Data */
 	if (cs42l52->pdata.mica_diff_cfg)
diff --git a/sound/soc/codecs/cs42l52.h b/sound/soc/codecs/cs42l52.h
index 6fb8f00..ac445993 100644
--- a/sound/soc/codecs/cs42l52.h
+++ b/sound/soc/codecs/cs42l52.h
@@ -37,7 +37,7 @@
 #define CS42L52_CHIP_REV_A0			0x00
 #define CS42L52_CHIP_REV_A1			0x01
 #define CS42L52_CHIP_REV_B0			0x02
-#define CS42L52_CHIP_REV_MASK			0x03
+#define CS42L52_CHIP_REV_MASK			0x07
 
 #define CS42L52_PWRCTL1				0x02
 #define CS42L52_PWRCTL1_PDN_ALL			0x9F
-- 
1.8.3.2
