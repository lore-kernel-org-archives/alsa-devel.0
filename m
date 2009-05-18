From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 2/3] ASoC: TWL4030: Add control for selecting
 codec operation mode
Date: Sun, 17 May 2009 20:03:00 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F69E8124@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 90FB91037F8
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 03:03:11 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Add a control for selecting the codec operation mode. TWL4030 codec
has two modes:
- Option 1. Audio only (4 audio DACs)
- Option 2. Voice/Audio (2 audio DACs and voice ADC/DAC)

Control is restricted when a stream is ongoing, since codec's
operation mode cannot be changed on-the-fly.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl4030.c |   47 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index e4d683d..671f777 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -814,6 +814,48 @@ static int snd_soc_put_volsw_r2_twl4030(struct snd_kcontrol *kcontrol,
 	return err;
 }
 
+/* Codec operation modes */
+static const char *twl4030_op_modes_texts[] = {
+	"Option 2 (voice/audio)", "Option 1 (audio)"
+};
+
+static const struct soc_enum twl4030_op_modes_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_CODEC_MODE, 0,
+			ARRAY_SIZE(twl4030_op_modes_texts),
+			twl4030_op_modes_texts);
+
+int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct twl4030_priv *twl4030 = codec->private_data;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned short val;
+	unsigned short mask, bitmask;
+
+	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
+		;
+	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+		return -EINVAL;
+
+	if (twl4030->configured) {
+		printk(KERN_ERR "twl4030 operation mode cannot be "
+			"changed on-the-fly\n");
+		return -EBUSY;
+	}
+
+	val = ucontrol->value.enumerated.item[0] << e->shift_l;
+	mask = (bitmask - 1) << e->shift_l;
+	if (e->shift_l != e->shift_r) {
+		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+			return -EINVAL;
+		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
+		mask |= (bitmask - 1) << e->shift_r;
+	}
+
+	return snd_soc_update_bits(codec, e->reg, mask, val);
+}
+
 /*
  * FGAIN volume control:
  * from -62 to 0 dB in 1 dB steps (mute instead of -63 dB)
@@ -895,6 +937,11 @@ static const struct soc_enum twl4030_vibradir_enum =
 			twl4030_vibradir_texts);
 
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
+	/* Codec operation mode control */
+	SOC_ENUM_EXT("Codec Operation Mode", twl4030_op_modes_enum,
+		snd_soc_get_enum_double,
+		snd_soc_put_twl4030_opmode_enum_double),
+
 	/* Common playback gain controls */
 	SOC_DOUBLE_R_TLV("DAC1 Digital Fine Playback Volume",
 		TWL4030_REG_ARXL1PGA, TWL4030_REG_ARXR1PGA,
-- 
1.5.4.3
