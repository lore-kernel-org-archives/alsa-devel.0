From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l35: Allow user to configure IMON
	SCALE" to the asoc tree
Date: Fri, 21 Apr 2017 18:28:24 +0100
Message-ID: <E1d1cM4-0001sg-QF@debutante>
References: <1492098729-30491-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 151AC266860
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 19:28:36 +0200 (CEST)
In-Reply-To: <1492098729-30491-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: mark.rutland@arm.com, Rob Herring <robh@kernel.org>, brian.austin@cirrus.com, devicetree@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: Allow user to configure IMON SCALE

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

>From 06bdf385f66a53b335b324e28a43788b03e6f3e3 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 13 Apr 2017 16:52:09 +0100
Subject: [PATCH] ASoC: cs35l35: Allow user to configure IMON SCALE

On the chip the IMON signal is a full 24-bits however normally only
some of the bits will be sent over the bus. The chip provides a field
to select which bits of the IMON will be sent back, this is the only
feedback signal that has this feature.

Add an additional entry to the cirrus,imon device tree property to
allow the IMON scale parameter to be passed.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/cs35l35.txt          |  4 ++--
 include/sound/cs35l35.h                            |  1 +
 sound/soc/codecs/cs35l35.c                         | 22 +++++++++++++++-------
 sound/soc/codecs/cs35l35.h                         |  3 +++
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cs35l35.txt b/Documentation/devicetree/bindings/sound/cs35l35.txt
index 457d176dcee0..016b768bc722 100644
--- a/Documentation/devicetree/bindings/sound/cs35l35.txt
+++ b/Documentation/devicetree/bindings/sound/cs35l35.txt
@@ -118,8 +118,8 @@ Optional Monitor Signal Format sub-node:
   Sections 7.44 - 7.53 lists values for the depth, location, and frame
   for each monitoring signal.
 
-  - cirrus,imon : 3 8 bit values to set the depth, location, and frame
-  of the IMON monitor signal.
+  - cirrus,imon : 4 8 bit values to set the depth, location, frame and ADC
+  scale of the IMON monitor signal.
 
   - cirrus,vmon : 3 8 bit values to set the depth, location, and frame
   of the VMON monitor signal.
diff --git a/include/sound/cs35l35.h b/include/sound/cs35l35.h
index 88744bbd6728..29da899e17e4 100644
--- a/include/sound/cs35l35.h
+++ b/include/sound/cs35l35.h
@@ -57,6 +57,7 @@ struct monitor_cfg {
 	u8 imon_dpth;
 	u8 imon_loc;
 	u8 imon_frm;
+	u8 imon_scale;
 	u8 vmon_dpth;
 	u8 vmon_loc;
 	u8 vmon_frm;
diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index dc6591adc96d..f8aef5869b03 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -918,6 +918,11 @@ static int cs35l35_codec_probe(struct snd_soc_codec *codec)
 					CS35L35_MON_FRM_MASK,
 					monitor_config->imon_frm <<
 					CS35L35_MON_FRM_SHIFT);
+			regmap_update_bits(cs35l35->regmap,
+					CS35L35_IMON_SCALE_CTL,
+					CS35L35_IMON_SCALE_MASK,
+					monitor_config->imon_scale <<
+					CS35L35_IMON_SCALE_SHIFT);
 		}
 		if (monitor_config->vpmon_specs) {
 			regmap_update_bits(cs35l35->regmap,
@@ -1161,7 +1166,9 @@ static int cs35l35_handle_of_data(struct i2c_client *i2c_client,
 	struct classh_cfg *classh_config = &pdata->classh_algo;
 	struct monitor_cfg *monitor_config = &pdata->mon_cfg;
 	unsigned int val32 = 0;
-	u8 monitor_array[3];
+	u8 monitor_array[4];
+	const int imon_array_size = ARRAY_SIZE(monitor_array);
+	const int mon_array_size = imon_array_size - 1;
 	int ret = 0;
 
 	if (!np)
@@ -1302,15 +1309,16 @@ static int cs35l35_handle_of_data(struct i2c_client *i2c_client,
 	monitor_config->is_present = signal_format ? true : false;
 	if (monitor_config->is_present) {
 		ret = of_property_read_u8_array(signal_format, "cirrus,imon",
-				   monitor_array, ARRAY_SIZE(monitor_array));
+						monitor_array, imon_array_size);
 		if (!ret) {
 			monitor_config->imon_specs = true;
 			monitor_config->imon_dpth = monitor_array[0];
 			monitor_config->imon_loc = monitor_array[1];
 			monitor_config->imon_frm = monitor_array[2];
+			monitor_config->imon_scale = monitor_array[3];
 		}
 		ret = of_property_read_u8_array(signal_format, "cirrus,vmon",
-				   monitor_array, ARRAY_SIZE(monitor_array));
+						monitor_array, mon_array_size);
 		if (!ret) {
 			monitor_config->vmon_specs = true;
 			monitor_config->vmon_dpth = monitor_array[0];
@@ -1318,7 +1326,7 @@ static int cs35l35_handle_of_data(struct i2c_client *i2c_client,
 			monitor_config->vmon_frm = monitor_array[2];
 		}
 		ret = of_property_read_u8_array(signal_format, "cirrus,vpmon",
-				   monitor_array, ARRAY_SIZE(monitor_array));
+						monitor_array, mon_array_size);
 		if (!ret) {
 			monitor_config->vpmon_specs = true;
 			monitor_config->vpmon_dpth = monitor_array[0];
@@ -1326,7 +1334,7 @@ static int cs35l35_handle_of_data(struct i2c_client *i2c_client,
 			monitor_config->vpmon_frm = monitor_array[2];
 		}
 		ret = of_property_read_u8_array(signal_format, "cirrus,vbstmon",
-				   monitor_array, ARRAY_SIZE(monitor_array));
+						monitor_array, mon_array_size);
 		if (!ret) {
 			monitor_config->vbstmon_specs = true;
 			monitor_config->vbstmon_dpth = monitor_array[0];
@@ -1334,7 +1342,7 @@ static int cs35l35_handle_of_data(struct i2c_client *i2c_client,
 			monitor_config->vbstmon_frm = monitor_array[2];
 		}
 		ret = of_property_read_u8_array(signal_format, "cirrus,vpbrstat",
-				   monitor_array, ARRAY_SIZE(monitor_array));
+						monitor_array, mon_array_size);
 		if (!ret) {
 			monitor_config->vpbrstat_specs = true;
 			monitor_config->vpbrstat_dpth = monitor_array[0];
@@ -1342,7 +1350,7 @@ static int cs35l35_handle_of_data(struct i2c_client *i2c_client,
 			monitor_config->vpbrstat_frm = monitor_array[2];
 		}
 		ret = of_property_read_u8_array(signal_format, "cirrus,zerofill",
-				   monitor_array, ARRAY_SIZE(monitor_array));
+						monitor_array, mon_array_size);
 		if (!ret) {
 			monitor_config->zerofill_specs = true;
 			monitor_config->zerofill_dpth = monitor_array[0];
diff --git a/sound/soc/codecs/cs35l35.h b/sound/soc/codecs/cs35l35.h
index 54e9ac536b20..5a6e43a87c4d 100644
--- a/sound/soc/codecs/cs35l35.h
+++ b/sound/soc/codecs/cs35l35.h
@@ -148,6 +148,9 @@
 #define CS35L35_MON_FRM_MASK		0x80
 #define CS35L35_MON_FRM_SHIFT		7
 
+#define CS35L35_IMON_SCALE_MASK		0xF8
+#define CS35L35_IMON_SCALE_SHIFT	3
+
 #define CS35L35_MS_MASK			0x80
 #define CS35L35_MS_SHIFT		7
 #define CS35L35_SPMODE_MASK		0x40
-- 
2.11.0
