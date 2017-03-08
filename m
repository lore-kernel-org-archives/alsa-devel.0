From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: cs35l35: Add for configuring drive
	mode in unused slots
Date: Wed, 8 Mar 2017 16:42:49 +0000
Message-ID: <1488991371-22513-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1488991371-22513-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C0CA5266B16
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 17:41:50 +0100 (CET)
In-Reply-To: <1488991371-22513-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

Add support for setting how the I2S pins are driven in unused slots,
currently the chip will just use the default of drive 0, however this
causes issues when multiple devices are attached to the same bus.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/cs35l35.h    | 2 ++
 sound/soc/codecs/cs35l35.c | 7 +++++++
 sound/soc/codecs/cs35l35.h | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/include/sound/cs35l35.h b/include/sound/cs35l35.h
index de92e452..983c610 100644
--- a/include/sound/cs35l35.h
+++ b/include/sound/cs35l35.h
@@ -80,6 +80,8 @@ struct cs35l35_platform_data {
 	bool stereo;
 	/* serial port drive strength */
 	int sp_drv_str;
+	/* serial port drive in unused slots */
+	int sp_drv_unused;
 	/* Boost Power Down with FET */
 	bool bst_pdn_fet_on;
 	/* Boost Voltage : used if ClassH Algo Enabled */
diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 48b45dc..5a9fe5a 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -789,6 +789,11 @@ static int cs35l35_codec_probe(struct snd_soc_codec *codec)
 				CS35L35_SP_DRV_MASK,
 				cs35l35->pdata.sp_drv_str <<
 				CS35L35_SP_DRV_SHIFT);
+	if (cs35l35->pdata.sp_drv_unused)
+		regmap_update_bits(cs35l35->regmap, CS35L35_SP_FMT_CTL3,
+				   CS35L35_SP_I2S_DRV_MASK,
+				   cs35l35->pdata.sp_drv_unused <<
+				   CS35L35_SP_I2S_DRV_SHIFT);
 
 	if (classh->classh_algo_enable) {
 		if (classh->classh_bst_override)
@@ -1169,6 +1174,8 @@ static int cs35l35_handle_of_data(struct i2c_client *i2c_client,
 
 	if (of_property_read_u32(np, "cirrus,sp-drv-strength", &val32) >= 0)
 		pdata->sp_drv_str = val32;
+	if (of_property_read_u32(np, "cirrus,sp-drv-unused", &val32) >= 0)
+		pdata->sp_drv_unused = val32 | CS35L35_VALID_PDATA;
 
 	pdata->stereo = of_property_read_bool(np, "cirrus,stereo-config");
 
diff --git a/sound/soc/codecs/cs35l35.h b/sound/soc/codecs/cs35l35.h
index e27a7fe..c203081 100644
--- a/sound/soc/codecs/cs35l35.h
+++ b/sound/soc/codecs/cs35l35.h
@@ -190,6 +190,10 @@
 #define CS35L35_AMP_GAIN_ZC_MASK	0x10
 #define CS35L35_AMP_GAIN_ZC_SHIFT	4
 
+/* CS35L35_SP_FMT_CTL3 */
+#define CS35L35_SP_I2S_DRV_MASK		0x03
+#define CS35L35_SP_I2S_DRV_SHIFT	0
+
 /* Class H Algorithm Control */
 #define CS35L35_CH_STEREO_MASK		0x40
 #define CS35L35_CH_STEREO_SHIFT		6
-- 
2.1.4
