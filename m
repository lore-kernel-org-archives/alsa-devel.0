From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas571x: chip type detection via I2C
	name" to the asoc tree
Date: Tue, 29 Mar 2016 16:40:16 -0700
Message-ID: <E1al3FA-0005QD-Ij@finisterre>
References: <1457608960-16913-2-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 222A92669F5
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 01:40:23 +0200 (CEST)
In-Reply-To: <1457608960-16913-2-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas571x: chip type detection via I2C name

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

>From f40d5ea2f48a3ad78f80b60f209507f160aa044b Mon Sep 17 00:00:00 2001
From: Petr Kulhavy <petr@barix.com>
Date: Tue, 29 Mar 2016 09:39:35 +0200
Subject: [PATCH] ASoC: tas571x: chip type detection via I2C name

The chip selection was relying only on DT. It was not possible to use the
driver without DT.
This adds the chip type detection from the I2C name, which
allows to use the driver from the platform driver without DT.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas571x.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index d003c6ce0794..aafee9bbe01a 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -404,11 +404,10 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, priv);
 
 	of_id = of_match_device(tas571x_of_match, dev);
-	if (!of_id) {
-		dev_err(dev, "Unknown device type\n");
-		return -EINVAL;
-	}
-	priv->chip = of_id->data;
+	if (of_id)
+		priv->chip = of_id->data;
+	else
+		priv->chip = (void *) id->driver_data;
 
 	priv->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(priv->mclk) && PTR_ERR(priv->mclk) != -ENOENT) {
@@ -505,9 +504,9 @@ static const struct of_device_id tas571x_of_match[] = {
 MODULE_DEVICE_TABLE(of, tas571x_of_match);
 
 static const struct i2c_device_id tas571x_i2c_id[] = {
-	{ "tas5711", 0 },
-	{ "tas5717", 0 },
-	{ "tas5719", 0 },
+	{ "tas5711", (kernel_ulong_t) &tas5711_chip },
+	{ "tas5717", (kernel_ulong_t) &tas5717_chip },
+	{ "tas5719", (kernel_ulong_t) &tas5717_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tas571x_i2c_id);
-- 
2.8.0.rc3
