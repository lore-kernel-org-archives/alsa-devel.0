From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9877: Make driver global regmap
	struct local" to the asoc tree
Date: Thu, 16 Jul 2015 22:01:36 +0100
Message-ID: <E1ZFqHg-0001lR-Q6@finisterre>
References: <1437074572-3831-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CFF42266708
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:01:43 +0200 (CEST)
In-Reply-To: <1437074572-3831-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9877: Make driver global regmap struct local

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

>From df2e268226e2e3d79980a5dddfd683126f79ddb4 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 16 Jul 2015 21:22:49 +0200
Subject: [PATCH] ASoC: max9877: Make driver global regmap struct local

Use a stack local variable to handle function local state rather than a
global static variable. The later has a potential for race conditions if
the probe function runs for two devices concurrently.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9877.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index e1df06f..b469e1c8 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -20,8 +20,6 @@
 
 #include "max9877.h"
 
-static struct regmap *regmap;
-
 static const struct reg_default max9877_regs[] = {
 	{ 0, 0x40 },
 	{ 1, 0x00 },
@@ -145,6 +143,7 @@ static const struct regmap_config max9877_regmap = {
 static int max9877_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
+	struct regmap *regmap;
 	int i;
 
 	regmap = devm_regmap_init_i2c(client, &max9877_regmap);
-- 
2.1.4
