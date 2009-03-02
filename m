From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Add SND_SOC_DAPM_PIN_SWITCH controls
	for exposing DAPM pins
Date: Mon,  2 Mar 2009 17:19:00 +0000
Message-ID: <1236014341-25837-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1236014341-25837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16454103810
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 18:19:03 +0100 (CET)
In-Reply-To: <1236014341-25837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On some systems it is desirable for control for DAPM pins to be provided
to user space. This is the case with things like GSM modems which are
controlled primarily from user space, for example. Provide a helper which
exposes the state of a DAPM pin to user space for use in cases like this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |   12 ++++++++
 sound/soc/soc-dapm.c     |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index bb3a863..a7def6a 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -192,6 +192,12 @@
 	.get = snd_soc_dapm_get_value_enum_double, \
 	.put = snd_soc_dapm_put_value_enum_double, \
 	.private_value = (unsigned long)&xenum }
+#define SOC_DAPM_PIN_SWITCH(xname) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname " Switch", \
+	.info = snd_soc_dapm_info_pin_switch, \
+	.get = snd_soc_dapm_get_pin_switch, \
+	.put = snd_soc_dapm_put_pin_switch, \
+	.private_value = (unsigned long)xname }
 
 /* dapm stream operations */
 #define SND_SOC_DAPM_STREAM_NOP			0x0
@@ -238,6 +244,12 @@ int snd_soc_dapm_get_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_dapm_info_pin_switch(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo);
+int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *uncontrol);
+int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *uncontrol);
 int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
 	const struct snd_soc_dapm_widget *widget);
 int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f4a8753..4b8dbbf 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1421,6 +1421,76 @@ out:
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_value_enum_double);
 
 /**
+ * snd_soc_dapm_info_pin_switch - Info for a pin switch
+ *
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Callback to provide information about a pin switch control.
+ */
+int snd_soc_dapm_info_pin_switch(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_info_pin_switch);
+
+/**
+ * snd_soc_dapm_get_pin_switch - Get information for a pin switch
+ *
+ * @kcontrol: mixer control
+ * @ucontrol: Value
+ */
+int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	const char *pin = (const char *)kcontrol->private_value;
+
+	mutex_lock(&codec->mutex);
+
+	ucontrol->value.integer.value[0] =
+		snd_soc_dapm_get_pin_status(codec, pin);
+
+	mutex_unlock(&codec->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_get_pin_switch);
+
+/**
+ * snd_soc_dapm_put_pin_switch - Set information for a pin switch
+ *
+ * @kcontrol: mixer control
+ * @ucontrol: Value
+ */
+int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	const char *pin = (const char *)kcontrol->private_value;
+
+	mutex_lock(&codec->mutex);
+
+	if (ucontrol->value.integer.value[0])
+		snd_soc_dapm_enable_pin(codec, pin);
+	else
+		snd_soc_dapm_disable_pin(codec, pin);
+
+	snd_soc_dapm_sync(codec);
+
+	mutex_unlock(&codec->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
+
+/**
  * snd_soc_dapm_new_control - create new dapm control
  * @codec: audio codec
  * @widget: widget template
-- 
1.6.1.3
