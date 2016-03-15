From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l32: avoid uninitialized variable
	access" to the asoc tree
Date: Tue, 15 Mar 2016 09:29:01 +0000
Message-ID: <E1aflHh-0005Sg-GA@debutante>
References: <1457967019-3901380-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (unknown [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0518D26568C
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:29:27 +0100 (CET)
In-Reply-To: <1457967019-3901380-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l32: avoid uninitialized variable access

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

>From dd5dc001581a7cf6f563e188c302caae1be998c2 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 14 Mar 2016 15:49:54 +0100
Subject: [PATCH] ASoC: cs35l32: avoid uninitialized variable access

gcc warns about the possibilty of accessing a property read from
devicetree in cs35l32_i2c_probe() when it has not been initialized
because CONFIG_OF is disabled:

sound/soc/codecs/cs35l32.c: In function 'cs35l32_i2c_probe':
sound/soc/codecs/cs35l32.c:278:2: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]

The code is actually correct because it checks the dev->of_node
variable first and we know this is NULL here when CONFIG_OF
is disabled, but Russell King noticed that it's broken when
we probe the device using DT, and the properties are absent.

The code already has some checking for incorrect values, and
I keep that checking unchanged here, but add an additional
check for an error returned by the property accessor functions
that now gets handled the same way as incorrect data in the
properties.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l32.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 44c30fe3e315..287d13740be4 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -274,7 +274,9 @@ static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
 	if (of_property_read_u32(np, "cirrus,sdout-share", &val) >= 0)
 		pdata->sdout_share = val;
 
-	of_property_read_u32(np, "cirrus,boost-manager", &val);
+	if (of_property_read_u32(np, "cirrus,boost-manager", &val))
+		val = -1u;
+
 	switch (val) {
 	case CS35L32_BOOST_MGR_AUTO:
 	case CS35L32_BOOST_MGR_AUTO_AUDIO:
@@ -282,13 +284,15 @@ static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
 	case CS35L32_BOOST_MGR_FIXED:
 		pdata->boost_mng = val;
 		break;
+	case -1u:
 	default:
 		dev_err(&i2c_client->dev,
 			"Wrong cirrus,boost-manager DT value %d\n", val);
 		pdata->boost_mng = CS35L32_BOOST_MGR_BYPASS;
 	}
 
-	of_property_read_u32(np, "cirrus,sdout-datacfg", &val);
+	if (of_property_read_u32(np, "cirrus,sdout-datacfg", &val))
+		val = -1u;
 	switch (val) {
 	case CS35L32_DATA_CFG_LR_VP:
 	case CS35L32_DATA_CFG_LR_STAT:
@@ -296,13 +300,15 @@ static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
 	case CS35L32_DATA_CFG_LR_VPSTAT:
 		pdata->sdout_datacfg = val;
 		break;
+	case -1u:
 	default:
 		dev_err(&i2c_client->dev,
 			"Wrong cirrus,sdout-datacfg DT value %d\n", val);
 		pdata->sdout_datacfg = CS35L32_DATA_CFG_LR;
 	}
 
-	of_property_read_u32(np, "cirrus,battery-threshold", &val);
+	if (of_property_read_u32(np, "cirrus,battery-threshold", &val))
+		val = -1u;
 	switch (val) {
 	case CS35L32_BATT_THRESH_3_1V:
 	case CS35L32_BATT_THRESH_3_2V:
@@ -310,13 +316,15 @@ static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
 	case CS35L32_BATT_THRESH_3_4V:
 		pdata->batt_thresh = val;
 		break;
+	case -1u:
 	default:
 		dev_err(&i2c_client->dev,
 			"Wrong cirrus,battery-threshold DT value %d\n", val);
 		pdata->batt_thresh = CS35L32_BATT_THRESH_3_3V;
 	}
 
-	of_property_read_u32(np, "cirrus,battery-recovery", &val);
+	if (of_property_read_u32(np, "cirrus,battery-recovery", &val))
+		val = -1u;
 	switch (val) {
 	case CS35L32_BATT_RECOV_3_1V:
 	case CS35L32_BATT_RECOV_3_2V:
@@ -326,6 +334,7 @@ static int cs35l32_handle_of_data(struct i2c_client *i2c_client,
 	case CS35L32_BATT_RECOV_3_6V:
 		pdata->batt_recov = val;
 		break;
+	case -1u:
 	default:
 		dev_err(&i2c_client->dev,
 			"Wrong cirrus,battery-recovery DT value %d\n", val);
-- 
2.7.0
