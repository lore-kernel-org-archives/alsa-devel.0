From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm2602: Replace reg_default_raw with reg_default" to the asoc tree
Date: Mon, 19 Mar 2018 01:27:02 +0000 (GMT)
Message-ID: <20180319012702.14CAD440079@finisterre.ee.mobilebroadband>
References: <20180314222416.95836-1-jamespeterkelly@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180314222416.95836-1-jamespeterkelly@gmail.com>
Sender: stable-owner@vger.kernel.org
To: James Kelly <jamespeterkelly@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ssm2602: Replace reg_default_raw with reg_default

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b9f6c09ae07cb7019626df0757be6b407f94261a Mon Sep 17 00:00:00 2001
From: James Kelly <jamespeterkelly@gmail.com>
Date: Thu, 15 Mar 2018 09:24:16 +1100
Subject: [PATCH] ASoC: ssm2602: Replace reg_default_raw with reg_default

SSM2602 driver is broken on recent kernels (at least
since 4.9). User space applications such as amixer or
alsamixer get EIO when attempting to access codec
controls via the relevant IOCTLs.

Root cause of these failures is the regcache_hw_init
function in drivers/base/regmap/regcache.c, which
prevents regmap cache initalization from the
reg_defaults_raw element of the regmap_config structure
when registers are write only. It also disables the
regmap cache entirely when all registers are write only
or volatile as is the case for the SSM2602 driver.

Using the reg_defaults element of the regmap_config
structure rather than the reg_defaults_raw element to
initalize the regmap cache avoids the logic in the
regcache_hw_init function entirely. It also makes this
driver consistent with other ASoC codec drivers, as
this driver was the ONLY codec driver that used the
reg_defaults_raw element to initalize the cache.

Tested on Digilent Zybo Z7 development board which has
a SSM2603 codec chip connected to a Xilinx Zynq SoC.

Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/ssm2602.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 031e0eabcc1f..501a4e73b185 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -54,10 +54,17 @@ struct ssm2602_priv {
  * using 2 wire for device control, so we cache them instead.
  * There is no point in caching the reset register
  */
-static const u16 ssm2602_reg[SSM2602_CACHEREGNUM] = {
-	0x0097, 0x0097, 0x0079, 0x0079,
-	0x000a, 0x0008, 0x009f, 0x000a,
-	0x0000, 0x0000
+static const struct reg_default ssm2602_reg[SSM2602_CACHEREGNUM] = {
+	{ .reg = 0x00, .def = 0x0097 },
+	{ .reg = 0x01, .def = 0x0097 },
+	{ .reg = 0x02, .def = 0x0079 },
+	{ .reg = 0x03, .def = 0x0079 },
+	{ .reg = 0x04, .def = 0x000a },
+	{ .reg = 0x05, .def = 0x0008 },
+	{ .reg = 0x06, .def = 0x009f },
+	{ .reg = 0x07, .def = 0x000a },
+	{ .reg = 0x08, .def = 0x0000 },
+	{ .reg = 0x09, .def = 0x0000 }
 };
 
 
@@ -621,8 +628,8 @@ const struct regmap_config ssm2602_regmap_config = {
 	.volatile_reg = ssm2602_register_volatile,
 
 	.cache_type = REGCACHE_RBTREE,
-	.reg_defaults_raw = ssm2602_reg,
-	.num_reg_defaults_raw = ARRAY_SIZE(ssm2602_reg),
+	.reg_defaults = ssm2602_reg,
+	.num_reg_defaults = ARRAY_SIZE(ssm2602_reg),
 };
 EXPORT_SYMBOL_GPL(ssm2602_regmap_config);
 
-- 
2.16.2
