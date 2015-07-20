From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4349: Drop platform data support" to
	the asoc tree
Date: Mon, 20 Jul 2015 18:52:06 +0100
Message-ID: <E1ZHFEU-0002pt-4p@debutante>
References: <1437268538.11309.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DBB82614A1
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:52:13 +0200 (CEST)
In-Reply-To: <1437268538.11309.3.camel@ingics.com>
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

   ASoC: cs4349: Drop platform data support

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

>From 44251551dfca2117e42349136b871b33c8419a59 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 19 Jul 2015 09:15:38 +0800
Subject: [PATCH] ASoC: cs4349: Drop platform data support

The struct cs4349_platform_data should be defined in a public header in
include/sound/ rather than in sound/soc/codecs folder.
In additional, the platform data support is not properly handled in this
driver so remove it now.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4349.c | 7 +------
 sound/soc/codecs/cs4349.h | 7 -------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index a6604a34db34..2569010ee396 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -45,7 +45,6 @@ static const struct reg_default cs4349_reg_defaults[] = {
 /* Private data for the CS4349 */
 struct  cs4349_private {
 	struct regmap			*regmap;
-	struct cs4349_platform_data	pdata;
 	struct gpio_desc		*reset_gpio;
 	unsigned int			mode;
 	int				rate;
@@ -281,8 +280,7 @@ static int cs4349_i2c_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
 	struct cs4349_private *cs4349;
-	struct cs4349_platform_data *pdata = dev_get_platdata(&client->dev);
-	int ret = 0;
+	int ret;
 
 	cs4349 = devm_kzalloc(&client->dev, sizeof(*cs4349), GFP_KERNEL);
 	if (!cs4349)
@@ -295,9 +293,6 @@ static int cs4349_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (pdata)
-		cs4349->pdata = *pdata;
-
 	/* Reset the Device */
 	cs4349->reset_gpio = devm_gpiod_get_optional(&client->dev,
 		"reset", GPIOD_OUT_LOW);
diff --git a/sound/soc/codecs/cs4349.h b/sound/soc/codecs/cs4349.h
index 7effa0acec28..d58c06a25358 100644
--- a/sound/soc/codecs/cs4349.h
+++ b/sound/soc/codecs/cs4349.h
@@ -19,13 +19,6 @@
 #ifndef __CS4349_H__
 #define __CS4349_H__
 
-struct cs4349_platform_data {
-
-	/* GPIO for Reset */
-	unsigned int gpio_nreset;
-
-};
-
 /* CS4349 registers addresses */
 #define CS4349_CHIPID		0x01	/* Device and Rev ID, Read Only */
 #define CS4349_MODE		0x02	/* Mode Control */
-- 
2.1.4
