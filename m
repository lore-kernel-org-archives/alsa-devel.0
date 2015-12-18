From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8974: add devicetree support" to the
	asoc tree
Date: Fri, 18 Dec 2015 12:15:38 +0000
Message-ID: <E1a9twg-0006BB-72@debutante>
References: <1450270975-17955-2-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D7742266688
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:48 +0100 (CET)
In-Reply-To: <1450270975-17955-2-git-send-email-mans@mansr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mans Rullgard <mans@mansr.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8974: add devicetree support

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

>From 2005bd881d273456e26a0b2027976f75fc47701f Mon Sep 17 00:00:00 2001
From: Mans Rullgard <mans@mansr.com>
Date: Wed, 16 Dec 2015 13:02:55 +0000
Subject: [PATCH] ASoC: wm8974: add devicetree support

This adds devicetree support to the wm8974 codec driver.
With a DT-based kernel, there is no board-specific setting
to select the driver so allow it to be manually chosen.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  | 3 ++-
 sound/soc/codecs/wm8974.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cfdafc4c11ea..e36b14c5cb57 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -838,7 +838,8 @@ config SND_SOC_WM8971
 	tristate
 
 config SND_SOC_WM8974
-	tristate
+	tristate "Wolfson Microelectronics WM8974 codec"
+	depends on I2C
 
 config SND_SOC_WM8978
 	tristate "Wolfson Microelectronics WM8978 codec"
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 0a60677397b3..45ba828b19de 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -631,9 +631,16 @@ static const struct i2c_device_id wm8974_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8974_i2c_id);
 
+static const struct of_device_id wm8974_of_match[] = {
+       { .compatible = "wlf,wm8974", },
+       { }
+};
+MODULE_DEVICE_TABLE(of, wm8974_of_match);
+
 static struct i2c_driver wm8974_i2c_driver = {
 	.driver = {
 		.name = "wm8974",
+		.of_match_table = wm8974_of_match,
 	},
 	.probe =    wm8974_i2c_probe,
 	.remove =   wm8974_i2c_remove,
-- 
2.6.2
