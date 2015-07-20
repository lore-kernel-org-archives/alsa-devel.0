From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4349: Set .writeable_reg for
	cs4349_regmap" to the asoc tree
Date: Mon, 20 Jul 2015 18:52:07 +0100
Message-ID: <E1ZHFEV-0002qM-4f@debutante>
References: <1437268463.11309.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AA722614C5
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:52:14 +0200 (CEST)
In-Reply-To: <1437268463.11309.1.camel@ingics.com>
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

   ASoC: cs4349: Set .writeable_reg for cs4349_regmap

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

>From 0443de7e7e559eab7df2566d0e46940f753db51d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 19 Jul 2015 09:14:23 +0800
Subject: [PATCH] ASoC: cs4349: Set .writeable_reg for cs4349_regmap

The first valid register index is 1 rather than 0, and the CS4349_CHIPID
is readonly. So set .writeable_reg to avoid writing to these registers.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4349.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 4885695e35a7..a6604a34db34 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -54,14 +54,17 @@ struct  cs4349_private {
 static bool cs4349_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS4349_CHIPID:
-	case CS4349_MODE:
-	case CS4349_VMI:
-	case CS4349_MUTE:
-	case CS4349_VOLA:
-	case CS4349_VOLB:
-	case CS4349_RMPFLT:
-	case CS4349_MISC:
+	case CS4349_CHIPID ... CS4349_MISC:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs4349_writeable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS4349_MODE ...  CS4349_MISC:
 		return true;
 	default:
 		return false;
@@ -270,6 +273,7 @@ static const struct regmap_config cs4349_regmap = {
 	.reg_defaults		= cs4349_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(cs4349_reg_defaults),
 	.readable_reg		= cs4349_readable_register,
+	.writeable_reg		= cs4349_writeable_register,
 	.cache_type		= REGCACHE_RBTREE,
 };
 
-- 
2.1.4
