From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8741: Drop misleading readable_reg
	callback implementation" to the asoc tree
Date: Tue, 18 Aug 2015 09:33:50 -0700
Message-ID: <E1ZRjpe-0002kX-B8@finisterre>
References: <1439546281.5150.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CC812618ED
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 18:33:53 +0200 (CEST)
In-Reply-To: <1439546281.5150.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8741: Drop misleading readable_reg callback implementation

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

>From 84eac6196c4b3930fc81f9bcd76c4a1a2161fd34 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 14 Aug 2015 17:58:01 +0800
Subject: [PATCH] ASoC: wm8741: Drop misleading readable_reg callback
 implementation

regmap_readable() returns false if map->format.format_write is set.
For .reg_bits = 7, .val_bits = 9, setting,
  map->format.format_write = regmap_format_7_9_write;

Even current code has implemented map->readable_reg, regmap_readable()
still returns false anyway. Thus drop the misleading readable_reg callback
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8741.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 506792b..c24c1a3 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -61,25 +61,6 @@ static const struct reg_default wm8741_reg_defaults[] = {
 	{ 32, 0x0002 },     /* R32 - ADDITONAL_CONTROL_1 */
 };
 
-static bool wm8741_readable(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case WM8741_DACLLSB_ATTENUATION:
-	case WM8741_DACLMSB_ATTENUATION:
-	case WM8741_DACRLSB_ATTENUATION:
-	case WM8741_DACRMSB_ATTENUATION:
-	case WM8741_VOLUME_CONTROL:
-	case WM8741_FORMAT_CONTROL:
-	case WM8741_FILTER_CONTROL:
-	case WM8741_MODE_CONTROL_1:
-	case WM8741_MODE_CONTROL_2:
-	case WM8741_ADDITIONAL_CONTROL_1:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static int wm8741_reset(struct snd_soc_codec *codec)
 {
 	return snd_soc_write(codec, WM8741_RESET, 0);
@@ -541,8 +522,6 @@ static const struct regmap_config wm8741_regmap = {
 	.reg_defaults = wm8741_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm8741_reg_defaults),
 	.cache_type = REGCACHE_RBTREE,
-
-	.readable_reg = wm8741_readable,
 };
 
 static int wm8741_set_pdata(struct device *dev, struct wm8741_priv *wm8741)
-- 
2.5.0
