From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: cs35l35: Allow user to configure IMON
	SCALE
Date: Thu, 13 Apr 2017 16:52:09 +0100
Message-ID: <1492098729-30491-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C08C52670B8
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 17:50:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, brian.austin@cirrus.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On the chip the IMON signal is a full 24-bits however normally only
some of the bits will be sent over the bus. The chip provides a field
to select which bits of the IMON will be sent back, this is the only
feedback signal that has this feature.

Add an additional entry to the cirrus,imon device tree property to
allow the IMON scale parameter to be passed.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

I realise this is changing the binding slightly, but thought
we might be able to sneak it before cs35l35 ships as it hasn't
shipped in a kernel yet.  However, it would be relatively simple
(although makes the code a little messier) to support both the 3
and 4 entry versions of the binding if people prefer?

Thanks,
Charles

 .../devicetree/bindings/sound/cs35l35.txt          |  4 ++--
 include/sound/cs35l35.h                            |  1 +
 sound/soc/codecs/cs35l35.c                         | 22 +++++++++++++++-------
 sound/soc/codecs/cs35l35.h                         |  3 +++
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cs35l35.txt b/Documentation/devicetree/bindings/sound/cs35l35.txt
index 457d176..016b768 100644
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
index 88744bb..29da899 100644
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
index 6ecb7dd..88c48e2 100644
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
index 54e9ac5..5a6e43a 100644
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
2.1.4
