From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stac9766: Remove register paging
	support" to the asoc tree
Date: Fri, 04 Nov 2016 12:16:17 -0600
Message-ID: <E1c2j2H-00086I-Qc@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 40E8B2674F7
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 19:16:27 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stac9766: Remove register paging support

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2bea8f97d4c3aded4c71d72e8702aa7dbe9894cf Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 4 Nov 2016 18:26:54 +0100
Subject: [PATCH] ASoC: stac9766: Remove register paging support

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/stac9766.c | 16 ++--------------
 sound/soc/codecs/stac9766.h |  5 ++---
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 27f30d352867..e54e4a4ce296 100644
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
index cb0d5505d571..e35cee82f416 100644
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
2.10.1
