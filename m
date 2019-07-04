From: Irina Patru <ioana-irina.patru@nxp.com>
Subject: [PATCH] MLK-22197 sound: asoc: add micfil dc remover
	amixer control
Date: Thu, 4 Jul 2019 12:52:02 +0000
Message-ID: <20190704125133.1463-1-ioana-irina.patru@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70080.outbound.protection.outlook.com [40.107.7.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF763F800E8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 14:52:05 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Viorel Suman <viorel.suman@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
Cc: Irina Patru <ioana-irina.patru@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LnxRevLi <LnxRevLi@nxp.com>
List-Id: alsa-devel@alsa-project.org

Add control for DC Remover Control register:
11b - DC Remover is bypassed
00b - DC Remover is cut-off at 21Hz
01b - DC Remover is cut-off at 83Hz
10b - DC Remover is cut-off at 152Hz

This control modifies DC mode for all channels. For more
information see DC Remover Block Diagram in  micfil
reference manual.

Signed-off-by: Irina Patru <ioana-irina.patru@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 59 ++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_micfil.h | 10 +++++++
 2 files changed, 69 insertions(+)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 7bb8d4cb5f71..2eaf9fda4865 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -45,6 +45,7 @@ struct fsl_micfil {
 	bool slave_mode;
 	int channel_gain[8];
 	int clk_src_id;
+	int dc_remover;
 	int vad_sound_gain;
 	int vad_noise_gain;
 	int vad_input_gain;
@@ -140,6 +141,17 @@ static const char * const micfil_clk_src_texts[] = {
 	"Auto", "AudioPLL1", "AudioPLL2", "ExtClk3",
 };
 
+/* DC Remover Control
+ * Filter Bypassed	1 1
+ * Cut-off @21Hz	0 0
+ * Cut-off @83Hz	0 1
+ * Cut-off @152HZ	1 0
+ */
+static const char * const micfil_dc_remover_texts[] = {
+	"Cut-off @21Hz", "Cut-off @83Hz",
+	"Cut-off @152Hz", "Bypass",
+};
+
 static const struct soc_enum fsl_micfil_quality_enum =
 	SOC_ENUM_SINGLE(REG_MICFIL_CTRL2,
 			MICFIL_CTRL2_QSEL_SHIFT,
@@ -168,6 +180,10 @@ static const struct soc_enum fsl_micfil_hwvad_rate_enum =
 static const struct soc_enum fsl_micfil_clk_src_enum =
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(micfil_clk_src_texts),
 			    micfil_clk_src_texts);
+static const struct soc_enum fsl_micfil_dc_remover_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(micfil_dc_remover_texts),
+				micfil_dc_remover_texts);
+
 
 static int micfil_put_clk_src(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
@@ -194,6 +210,45 @@ static int micfil_get_clk_src(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int micfil_put_dc_remover_state(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(comp);
+	unsigned int *item = ucontrol->value.enumerated.item;
+	int val = snd_soc_enum_item_to_val(e, item[0]);
+	int i = 0, ret = 0;
+	u32 reg_val = 0;
+
+	if (val < 0 || val > 3)
+		return -1;
+	micfil->dc_remover = val;
+
+	/* Calculate total value for all channels */
+	for (i = 0; i < 8; i++)
+		reg_val |= MICFIL_DC_MODE(val, i);
+
+	/* Update DC Remover mode for all channels */
+	ret = snd_soc_component_update_bits(comp,
+					REG_MICFIL_DC_CTRL,
+					MICFIL_DC_CTRL_MASK,
+					reg_val);
+	return ret;
+}
+
+static int micfil_get_dc_remover_state(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(comp);
+
+	ucontrol->value.enumerated.item[0] = micfil->dc_remover;
+
+	return 0;
+}
+
+
 static int hwvad_put_init_mode(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
@@ -676,6 +731,10 @@ static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
 	SOC_ENUM_EXT("Clock Source",
 		     fsl_micfil_clk_src_enum,
 		     micfil_get_clk_src, micfil_put_clk_src),
+	SOC_ENUM_EXT("MICFIL DC Remover Control",
+			fsl_micfil_dc_remover_enum,
+			micfil_get_dc_remover_state,
+			micfil_put_dc_remover_state),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "HWVAD Input Gain",
diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
index 792187b717f0..e47dba9b90b8 100644
--- a/sound/soc/fsl/fsl_micfil.h
+++ b/sound/soc/fsl/fsl_micfil.h
@@ -278,6 +278,16 @@
 #define MICFIL_HWVAD_HPF_102HZ		3
 #define MICFIL_HWVAD_FRAMET_DEFAULT	10
 
+/* MICFIL DC Remover Control Register -- REG_MICFIL_DC_CTRL */
+#define MICFIL_DC_CTRL_SHIFT		0
+#define MICFIL_DC_CTRL_MASK			0xFFFF
+#define MICFIL_DC_CTRL_WIDTH		2
+#define MICFIL_DC_CHX_SHIFT(v)		(2 * (v))
+#define MICFIL_DC_CHX_MASK(v)		((BIT(MICFIL_DC_CTRL_WIDTH) - 1) \
+				<< MICFIL_DC_CHX_SHIFT(v))
+#define MICFIL_DC_MODE(v1, v2)		(((v1) << MICFIL_DC_CHX_SHIFT(v2)) \
+				& MICFIL_DC_CHX_MASK(v2))
+
 /* MICFIL Output Control Register */
 #define MICFIL_OUTGAIN_CHX_SHIFT(v)	(4 * (v))
 
-- 
2.21.0
