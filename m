From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tpa6130a2: Support for limiting gain
Date: Thu,  6 May 2010 10:37:18 +0300
Message-ID: <1273131438-2716-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A2BD245C4
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 09:37:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Add support for platform dependent gain limiting on the
tpa6130a2 (and tpa6140a2) Headset amplifier.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/tpa6130a2-plat.h |    1 +
 sound/soc/codecs/tpa6130a2.c   |   76 +++++++++++++++++++++++++++++++++++----
 2 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/include/sound/tpa6130a2-plat.h b/include/sound/tpa6130a2-plat.h
index e29fde6..426f627 100644
--- a/include/sound/tpa6130a2-plat.h
+++ b/include/sound/tpa6130a2-plat.h
@@ -31,6 +31,7 @@ enum tpa_model {
 struct tpa6130a2_platform_data {
 	enum tpa_model id;
 	int power_gpio;
+	int limit_gain;
 };
 
 #endif
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 0cf3e38..31f67b5 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -46,6 +46,9 @@ static const char *tpa6140a2_supply_names[TPA6130A2_NUM_SUPPLIES] = {
 	"AVdd",
 };
 
+#define TPA6130A2_GAIN_MAX	0x3f
+#define TPA6140A2_GAIN_MAX	0x1f
+
 /* This struct is used to save the context */
 struct tpa6130a2_data {
 	struct mutex mutex;
@@ -54,6 +57,7 @@ struct tpa6130a2_data {
 	int power_gpio;
 	unsigned char power_state;
 	enum tpa_model id;
+	int gain_limit;
 };
 
 static int tpa6130a2_i2c_read(int reg)
@@ -176,6 +180,40 @@ exit:
 	return ret;
 }
 
+static int tpa6130a2_info_volsw(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_info *uinfo)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct tpa6130a2_data *data;
+
+	BUG_ON(tpa6130a2_client == NULL);
+	data = i2c_get_clientdata(tpa6130a2_client);
+
+	mutex_lock(&data->mutex);
+	switch (mc->reg) {
+	case TPA6130A2_REG_VOL_MUTE:
+		if (data->gain_limit != mc->max)
+			mc->max = data->gain_limit;
+		break;
+	default:
+		dev_err(&tpa6130a2_client->dev,
+			"Invalid register: 0x02%x\n", mc->reg);
+		goto out;
+	}
+	if (unlikely(mc->max == 1))
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	else
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = mc->max;
+out:
+	mutex_unlock(&data->mutex);
+	return 0;
+}
+
 static int tpa6130a2_get_reg(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
@@ -239,6 +277,15 @@ static int tpa6130a2_set_reg(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+#define SOC_SINGLE_EXT_TLV_TPA(xname, xreg, xshift, xmax, xinvert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = tpa6130a2_info_volsw, \
+	.get = tpa6130a2_get_reg, .put = tpa6130a2_set_reg, \
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) }
+
 /*
  * TPA6130 volume. From -59.5 to 4 dB with increasing step size when going
  * down in gain.
@@ -258,10 +305,9 @@ static const unsigned int tpa6130_tlv[] = {
 };
 
 static const struct snd_kcontrol_new tpa6130a2_controls[] = {
-	SOC_SINGLE_EXT_TLV("TPA6130A2 Headphone Playback Volume",
-		       TPA6130A2_REG_VOL_MUTE, 0, 0x3f, 0,
-		       tpa6130a2_get_reg, tpa6130a2_set_reg,
-		       tpa6130_tlv),
+	SOC_SINGLE_EXT_TLV_TPA("TPA6130A2 Headphone Playback Volume",
+			TPA6130A2_REG_VOL_MUTE, 0, TPA6130A2_GAIN_MAX, 0,
+			tpa6130_tlv),
 };
 
 static const unsigned int tpa6140_tlv[] = {
@@ -272,10 +318,9 @@ static const unsigned int tpa6140_tlv[] = {
 };
 
 static const struct snd_kcontrol_new tpa6140a2_controls[] = {
-	SOC_SINGLE_EXT_TLV("TPA6140A2 Headphone Playback Volume",
-		       TPA6130A2_REG_VOL_MUTE, 1, 0x1f, 0,
-		       tpa6130a2_get_reg, tpa6130a2_set_reg,
-		       tpa6140_tlv),
+	SOC_SINGLE_EXT_TLV_TPA("TPA6140A2 Headphone Playback Volume",
+			TPA6130A2_REG_VOL_MUTE, 1, TPA6140A2_GAIN_MAX, 0,
+			tpa6140_tlv),
 };
 
 /*
@@ -454,16 +499,31 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 	case TPA6130A2:
 		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
 			data->supplies[i].supply = tpa6130a2_supply_names[i];
+		if (pdata->limit_gain > 0 &&
+		    pdata->limit_gain < TPA6130A2_GAIN_MAX)
+			data->gain_limit = pdata->limit_gain;
+		else
+			data->gain_limit = TPA6130A2_GAIN_MAX;
 		break;
 	case TPA6140A2:
 		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
 			data->supplies[i].supply = tpa6140a2_supply_names[i];;
+		if (pdata->limit_gain > 0 &&
+		    pdata->limit_gain < TPA6140A2_GAIN_MAX)
+			data->gain_limit = pdata->limit_gain;
+		else
+			data->gain_limit = TPA6140A2_GAIN_MAX;
 		break;
 	default:
 		dev_warn(dev, "Unknown TPA model (%d). Assuming 6130A2\n",
 			 pdata->id);
 		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
 			data->supplies[i].supply = tpa6130a2_supply_names[i];
+		if (pdata->limit_gain > 0 &&
+		    pdata->limit_gain < TPA6130A2_GAIN_MAX)
+			data->gain_limit = pdata->limit_gain;
+		else
+			data->gain_limit = TPA6130A2_GAIN_MAX;
 	}
 
 	ret = regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
-- 
1.7.1
