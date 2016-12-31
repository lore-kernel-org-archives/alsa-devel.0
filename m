From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic3x: Mark the RESET register as
	volatile" to the asoc tree
Date: Sat, 31 Dec 2016 19:19:13 +0000
Message-ID: <E1cNPBR-0003ut-Fq@debutante>
References: <20161223092112.7992-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 115032670BE
 for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2016 20:19:21 +0100 (CET)
In-Reply-To: <20161223092112.7992-2-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, jsarha@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic3x: Mark the RESET register as volatile

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

>From 63c3194b82530bd71fd49db84eb7ab656b8d404a Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 23 Dec 2016 11:21:10 +0200
Subject: [PATCH] ASoC: tlv320aic3x: Mark the RESET register as volatile

The RESET register only have one self clearing bit and it should not be
cached. If it is cached, when we sync the registers back to the chip we
will initiate a software reset as well, which is not desirable.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic3x.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 8877b74b0510..bb94d50052d7 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -126,6 +126,16 @@ static const struct reg_default aic3x_reg[] = {
 	{ 108, 0x00 }, { 109, 0x00 },
 };
 
+static bool aic3x_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AIC3X_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct regmap_config aic3x_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -133,6 +143,9 @@ static const struct regmap_config aic3x_regmap = {
 	.max_register = DAC_ICC_ADJ,
 	.reg_defaults = aic3x_reg,
 	.num_reg_defaults = ARRAY_SIZE(aic3x_reg),
+
+	.volatile_reg = aic3x_volatile_reg,
+
 	.cache_type = REGCACHE_RBTREE,
 };
 
-- 
2.11.0
