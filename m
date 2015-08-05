From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8753: Drop wm8753_writeable function"
	to the asoc tree
Date: Wed, 05 Aug 2015 13:30:39 +0100
Message-ID: <E1ZMxqB-0005kH-FJ@finisterre>
References: <1438394692.6442.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E3872614E3
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 14:30:54 +0200 (CEST)
In-Reply-To: <1438394692.6442.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8753: Drop wm8753_writeable function

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

>From b970499878563437a43eab2dd2faa9217142fb98 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 1 Aug 2015 10:04:52 +0800
Subject: [PATCH] ASoC: wm8753: Drop wm8753_writeable function

When .max_register is set and .writeable_reg is not implement, registers
between 0 and .max_register are writeable. This is the same as current
implementation of wm8753_writeable(), so just drop implementation for
.writeable_reg callback.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8753.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index feb2997a..4c6eaeb 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -138,11 +138,6 @@ static bool wm8753_volatile(struct device *dev, unsigned int reg)
 	return reg == WM8753_RESET;
 }
 
-static bool wm8753_writeable(struct device *dev, unsigned int reg)
-{
-	return reg <= WM8753_ADCTL2;
-}
-
 /* codec private data */
 struct wm8753_priv {
 	struct regmap *regmap;
@@ -1510,7 +1505,6 @@ static const struct regmap_config wm8753_regmap = {
 	.val_bits = 9,
 
 	.max_register = WM8753_ADCTL2,
-	.writeable_reg = wm8753_writeable,
 	.volatile_reg = wm8753_volatile,
 
 	.cache_type = REGCACHE_RBTREE,
-- 
2.1.4
