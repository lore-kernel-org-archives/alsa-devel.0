From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3] ASoC: cs35l32: avoid uninitialized variable access
Date: Mon, 14 Mar 2016 15:49:54 +0100
Message-ID: <1457967019-3901380-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

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
---
v3: Restore a line that was accidentally removed, as pointed
    out by Brian Austin.
v2: fix bug in case of CONFIG_OF and missing properties
v1: only address warning for the !CONFIG_OF case

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
