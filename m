From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sta529: Remove redundant
	I2C_FUNC_SMBUS_BYTE_DATA functionality check" to the asoc tree
Date: Fri, 24 Jul 2015 12:31:14 +0100
Message-ID: <E1ZIbC6-000337-El@debutante>
References: <1437707848.12634.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A3B726059B
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 13:31:22 +0200 (CEST)
In-Reply-To: <1437707848.12634.2.camel@ingics.com>
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

   ASoC: sta529: Remove redundant I2C_FUNC_SMBUS_BYTE_DATA functionality check

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

>From 97a747117d95b54fe3ce21d43e04499a1671fff6 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 24 Jul 2015 11:17:28 +0800
Subject: [PATCH] ASoC: sta529: Remove redundant I2C_FUNC_SMBUS_BYTE_DATA
 functionality check

This checking is done by regmap_get_i2c_bus() which is called in
devm_regmap_init_i2c().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sta529.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index 4f70378b2cfb..2519c7f1cad3 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -339,9 +339,6 @@ static int sta529_i2c_probe(struct i2c_client *i2c,
 	struct sta529 *sta529;
 	int ret;
 
-	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		return -EINVAL;
-
 	sta529 = devm_kzalloc(&i2c->dev, sizeof(struct sta529), GFP_KERNEL);
 	if (!sta529)
 		return -ENOMEM;
-- 
2.1.4
