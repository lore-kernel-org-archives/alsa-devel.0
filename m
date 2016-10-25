From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l56: Make ID registers volatile and
	remove cache bypass" to the asoc tree
Date: Tue, 25 Oct 2016 20:23:33 +0100
Message-ID: <E1bz7Jt-0004l2-B2@debutante>
References: <1477410151-17515-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 34263265142
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 21:23:40 +0200 (CEST)
In-Reply-To: <1477410151-17515-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: brian.austin@cirrus.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l56: Make ID registers volatile and remove cache bypass

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

>From da5eb41763c750d1660ca0a962f15f268821b3e6 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 25 Oct 2016 16:42:30 +0100
Subject: [PATCH] ASoC: cs42l56: Make ID registers volatile and remove cache
 bypass

Rather than manually enabling cache bypass when reading the ID registers
simply remove the default which will cause the first read to go to the
hardware. The old code worked this is simply the more standard way to
implement this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l56.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 54c1768bc818..3e2c04642f1e 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -64,8 +64,6 @@ struct  cs42l56_private {
 };
 
 static const struct reg_default cs42l56_reg_defaults[] = {
-	{ 1, 0x56 },	/* r01	- ID 1 */
-	{ 2, 0x04 },	/* r02	- ID 2 */
 	{ 3, 0x7f },	/* r03	- Power Ctl 1 */
 	{ 4, 0xff },	/* r04	- Power Ctl 2 */
 	{ 5, 0x00 },	/* ro5	- Clocking Ctl 1 */
@@ -1262,8 +1260,6 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
-	regcache_cache_bypass(cs42l56->regmap, true);
-
 	ret = regmap_read(cs42l56->regmap, CS42L56_CHIP_ID_1, &reg);
 	devid = reg & CS42L56_CHIP_ID_MASK;
 	if (devid != CS42L56_DEVID) {
@@ -1279,8 +1275,6 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 	dev_info(&i2c_client->dev, "Alpha Rev %X Metal Rev %X\n",
 		 alpha_rev, metal_rev);
 
-	regcache_cache_bypass(cs42l56->regmap, false);
-
 	if (cs42l56->pdata.ain1a_ref_cfg)
 		regmap_update_bits(cs42l56->regmap, CS42L56_AIN_REFCFG_ADC_MUX,
 				   CS42L56_AIN1A_REF_MASK, 1);
-- 
2.8.1
