From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ASoC: sta350: add support for bits in
	miscellaneous registers
Date: Mon,  5 May 2014 11:49:23 +0200
Message-ID: <1399283363-16441-2-git-send-email-zonque@gmail.com>
References: <1399283363-16441-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f43.google.com (mail-ee0-f43.google.com [74.125.83.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 86ECE261B1A
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 11:49:33 +0200 (CEST)
Received: by mail-ee0-f43.google.com with SMTP id d17so521082eek.2
 for <alsa-devel@alsa-project.org>; Mon, 05 May 2014 02:49:33 -0700 (PDT)
In-Reply-To: <1399283363-16441-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add support for RPDNEN, NSHHPEN, BRIDGOFF, CPWMEN and PNDLSL, and add DT
bindings to access them.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/sound/st,sta350.txt        | 24 +++++++++++-
 include/sound/sta350.h                             |  5 +++
 sound/soc/codecs/sta350.c                          | 45 ++++++++++++++++++++++
 sound/soc/codecs/sta350.h                          | 10 +++++
 4 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/st,sta350.txt b/Documentation/devicetree/bindings/sound/st,sta350.txt
index ecd7a62..b7e71bf 100644
--- a/Documentation/devicetree/bindings/sound/st,sta350.txt
+++ b/Documentation/devicetree/bindings/sound/st,sta350.txt
@@ -86,7 +86,29 @@ Optional properties:
   -  st,invalid-input-detect-mute:
 	If present, automatic invalid input detect mute is enabled.
 
-
+  -  st,activate-mute-output:
+	If present, a mute output will be activated in ase the volume will
+	reach a value lower than -76 dBFS.
+
+  -  st,bridge-immediate-off:
+	If present, the bridge will be switched off immediately after the
+	power-down-gpio goes low. Otherwise, the bridge will wait for 13
+	million clock cycles to pass before shutting down.
+
+  -  st,noise-shape-dc-cut:
+	If present, the noise-shaping technique on the DC cutoff filter are
+	enabled.
+
+  -  st,powerdown-master-volume:
+	If present, the power-down pin and I2C power-down functions will
+	act on the master volume. Otherwise, the functions will act on the
+	mute commands.
+
+  -  st,powerdown-delay-divider:
+	If present, the bridge power-down time will be divided by the provided
+	value. If not specified, a divider of 1 will be used. Allowed values
+	are 1, 2, 4, 8, 16, 32, 64 and 128.
+	This property has to be specified as '/bits/ 8' value.
 
 Example:
 
diff --git a/include/sound/sta350.h b/include/sound/sta350.h
index 3a329810..42edceb 100644
--- a/include/sound/sta350.h
+++ b/include/sound/sta350.h
@@ -37,6 +37,7 @@ struct sta350_platform_data {
 	u8 ch3_output_mapping;
 	u8 ffx_power_output_mode;
 	u8 drop_compensation_ns;
+	u8 powerdown_delay_divider;
 	unsigned int thermal_warning_recovery:1;
 	unsigned int thermal_warning_adjustment:1;
 	unsigned int fault_detect_recovery:1;
@@ -47,6 +48,10 @@ struct sta350_platform_data {
 	unsigned int odd_pwm_speed_mode:1;
 	unsigned int distortion_compensation:1;
 	unsigned int invalid_input_detect_mute:1;
+	unsigned int activate_mute_output:1;
+	unsigned int bridge_immediate_off:1;
+	unsigned int noise_shape_dc_cut:1;
+	unsigned int powerdown_master_vol:1;
 };
 
 #endif /* __LINUX_SND__STA350_H */
diff --git a/sound/soc/codecs/sta350.c b/sound/soc/codecs/sta350.c
index 552e92a..2353a54 100644
--- a/sound/soc/codecs/sta350.c
+++ b/sound/soc/codecs/sta350.c
@@ -1020,6 +1020,29 @@ static int sta350_probe(struct snd_soc_codec *codec)
 			   pdata->ch3_output_mapping
 				<< STA350_CxCFG_OM_SHIFT);
 
+	/* miscellaneous registers */
+	regmap_update_bits(sta350->regmap, STA350_MISC1,
+			   STA350_MISC1_CPWMEN,
+			   pdata->activate_mute_output ?
+				STA350_MISC1_CPWMEN : 0);
+	regmap_update_bits(sta350->regmap, STA350_MISC1,
+			   STA350_MISC1_BRIDGOFF,
+			   pdata->bridge_immediate_off ?
+				STA350_MISC1_BRIDGOFF : 0);
+	regmap_update_bits(sta350->regmap, STA350_MISC1,
+			   STA350_MISC1_NSHHPEN,
+			   pdata->noise_shape_dc_cut ?
+				STA350_MISC1_NSHHPEN : 0);
+	regmap_update_bits(sta350->regmap, STA350_MISC1,
+			   STA350_MISC1_RPDNEN,
+			   pdata->powerdown_master_vol ?
+				STA350_MISC1_RPDNEN: 0);
+
+	regmap_update_bits(sta350->regmap, STA350_MISC2,
+			   STA350_MISC2_PNDLSL_MASK,
+			   pdata->powerdown_delay_divider
+				<< STA350_MISC2_PNDLSL_SHIFT);
+
 	/* initialize coefficient shadow RAM with reset values */
 	for (i = 4; i <= 49; i += 5)
 		sta350->coef_shadow[i] = 0x400000;
@@ -1094,6 +1117,7 @@ static int sta350_probe_dt(struct device *dev, struct sta350_priv *sta350)
 	struct sta350_platform_data *pdata;
 	const char *ffx_power_mode;
 	u16 tmp;
+	u8 tmp8;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -1158,6 +1182,27 @@ static int sta350_probe_dt(struct device *dev, struct sta350_priv *sta350)
 	if (of_get_property(np, "st,invalid-input-detect-mute", NULL))
 		pdata->invalid_input_detect_mute = 1;
 
+	/* MISC */
+	if (of_get_property(np, "st,activate-mute-output", NULL))
+		pdata->activate_mute_output = 1;
+
+	if (of_get_property(np, "st,bridge-immediate-off", NULL))
+		pdata->bridge_immediate_off = 1;
+
+	if (of_get_property(np, "st,noise-shape-dc-cut", NULL))
+		pdata->noise_shape_dc_cut = 1;
+
+	if (of_get_property(np, "st,powerdown-master-volume", NULL))
+		pdata->powerdown_master_vol = 1;
+
+	if (!of_property_read_u8(np, "st,powerdown-delay-divider", &tmp8)) {
+		if (is_power_of_2(tmp8) && tmp8 >= 1 && tmp8 <= 128)
+			pdata->powerdown_delay_divider = ilog2(tmp8);
+		else
+			dev_warn(dev, "Unsupported powerdown delay divider %d\n",
+				 tmp8);
+	}
+
 	sta350->pdata = pdata;
 
 	return 0;
diff --git a/sound/soc/codecs/sta350.h b/sound/soc/codecs/sta350.h
index c3248f0..fb72852 100644
--- a/sound/soc/codecs/sta350.h
+++ b/sound/soc/codecs/sta350.h
@@ -225,4 +225,14 @@
 #define STA350_C3_MIX1		60
 #define STA350_C3_MIX2		61
 
+/* miscellaneous register 1 */
+#define STA350_MISC1_CPWMEN	BIT(2)
+#define STA350_MISC1_BRIDGOFF	BIT(5)
+#define STA350_MISC1_NSHHPEN	BIT(6)
+#define STA350_MISC1_RPDNEN	BIT(7)
+
+/* miscellaneous register 2 */
+#define STA350_MISC2_PNDLSL_MASK	0x1c
+#define STA350_MISC2_PNDLSL_SHIFT	2
+
 #endif /* _ASOC_STA_350_H */
-- 
1.9.0
