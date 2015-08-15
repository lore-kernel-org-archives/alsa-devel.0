From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm2518: Add explicit device tree
	support" to the asoc tree
Date: Fri, 14 Aug 2015 19:15:08 -0700
Message-ID: <E1ZQR00-0004RK-Al@finisterre>
References: <alpine.DEB.2.02.1508131456110.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DC99266678
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:15:21 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508131456110.27635@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricardw@axis.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ssm2518: Add explicit device tree support

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

>From 4b8be271e94c872ae6e1ed2c05845002de89f71c Mon Sep 17 00:00:00 2001
From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Date: Thu, 13 Aug 2015 15:10:19 +0200
Subject: [PATCH] ASoC: ssm2518: Add explicit device tree support

Add OF match table to SSM2518 to allow direct matching without going
through I2C subsystem.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ssm2518.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index f30de76..b49f216 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -806,6 +806,14 @@ static int ssm2518_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id ssm2518_dt_ids[] = {
+	{ .compatible = "adi,ssm2518", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ssm2518_dt_ids);
+#endif
+
 static const struct i2c_device_id ssm2518_i2c_ids[] = {
 	{ "ssm2518", 0 },
 	{ }
@@ -816,6 +824,7 @@ static struct i2c_driver ssm2518_driver = {
 	.driver = {
 		.name = "ssm2518",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(ssm2518_dt_ids),
 	},
 	.probe = ssm2518_i2c_probe,
 	.remove = ssm2518_i2c_remove,
-- 
2.5.0
