From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] ASoC: stac9766: Remove register paging
	support
Date: Fri,  4 Nov 2016 18:26:54 +0100
Message-ID: <1478280417-24832-2-git-send-email-lars@metafoo.de>
References: <1478280417-24832-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 21B012674C0
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 18:27:11 +0100 (CET)
In-Reply-To: <1478280417-24832-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The AC'97 standard defines paging support for the register range 0x60-0x6f.
Meaning registers in this window are mapped to different physical registers
depending on the setting of the page select register (0x24).

The stac9766 implements support for switching between page 0 and page 1
depending on the addressed register. But the driver never accesses any
registers from page 1, in addition page 0 is the page selected by default.

Considering the development history it is unlikely that the driver will see
any new features that require paging support. Removing the paging support
makes transitioning the driver to regmap a bit more straight forward.

The default register value table is update to contain the values from page
0, rather than page 1.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/stac9766.c | 16 ++--------------
 sound/soc/codecs/stac9766.h |  5 ++---
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 27f30d3..e54e4a4 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -47,8 +47,8 @@ static const u16 stac9766_reg[] = {
 	0x0000, 0x0000, 0x0003, 0xffff, /* 4e */
 	0x0000, 0x0000, 0x0000, 0x0000, /* 56 */
 	0x4000, 0x0000, 0x0000, 0x0000, /* 5e */
-	0x1201, 0xFFFF, 0xFFFF, 0x0000, /* 66 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 6e */
+	0x1201, 0x0000, 0x0000, 0x0000, /* 66 */
+	0x0000, 0x0000, 0x0000, 0x1000, /* 6e */
 	0x0000, 0x0000, 0x0000, 0x0006, /* 76 */
 	0x0000, 0x0000, 0x0000, 0x0000, /* 7e */
 };
@@ -145,12 +145,6 @@ static int stac9766_ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	u16 *cache = codec->reg_cache;
 
-	if (reg > AC97_STAC_PAGE0) {
-		stac9766_ac97_write(codec, AC97_INT_PAGING, 0);
-		soc_ac97_ops->write(ac97, reg, val);
-		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
-		return 0;
-	}
 	if (reg / 2 >= ARRAY_SIZE(stac9766_reg))
 		return -EIO;
 
@@ -165,12 +159,6 @@ static unsigned int stac9766_ac97_read(struct snd_soc_codec *codec,
 	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	u16 val = 0, *cache = codec->reg_cache;
 
-	if (reg > AC97_STAC_PAGE0) {
-		stac9766_ac97_write(codec, AC97_INT_PAGING, 0);
-		val = soc_ac97_ops->read(ac97, reg - AC97_STAC_PAGE0);
-		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
-		return val;
-	}
 	if (reg / 2 >= ARRAY_SIZE(stac9766_reg))
 		return -EIO;
 
diff --git a/sound/soc/codecs/stac9766.h b/sound/soc/codecs/stac9766.h
index cb0d550..e35cee8 100644
--- a/sound/soc/codecs/stac9766.h
+++ b/sound/soc/codecs/stac9766.h
@@ -5,9 +5,8 @@
 #ifndef _STAC9766_H
 #define _STAC9766_H
 
-#define AC97_STAC_PAGE0 0x1000
-#define AC97_STAC_DA_CONTROL (AC97_STAC_PAGE0 | 0x6A)
-#define AC97_STAC_ANALOG_SPECIAL (AC97_STAC_PAGE0 | 0x6E)
+#define AC97_STAC_DA_CONTROL 0x6A
+#define AC97_STAC_ANALOG_SPECIAL 0x6E
 #define AC97_STAC_STEREO_MIC 0x78
 
 #endif
-- 
2.1.4
