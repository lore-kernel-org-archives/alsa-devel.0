From: Shrikant Dharwadkar <shrikant.dharwadkar@intel.com>
Subject: [PATCH] ALSA: hda - Enable additional HD-Audio codec
	information
Date: Tue,  8 May 2018 11:12:55 +0530
Message-ID: <1525758175-31387-1-git-send-email-shrikant.dharwadkar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 734F6266F0F
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 07:43:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: Patches Audio <patches.audio@intel.com>, Shrikant Dharwadkar <shrikant.dharwadkar@intel.com>
List-Id: alsa-devel@alsa-project.org

Enable additional HD-Audio codec information to be parsed
using alsa-info script to generate codec information
with CONFIG_SND_SOC enabled

Function group nodes
-Add power state controls
-Add subordinate node count parameters
-Add function group type information
-Add function group capabilities
-Add unsolicited response controls
-Add input converter SDI select information
-Add GPIO enable control
-Add GPIO direction information
-Add GPIO wake enable information
-Add GPIO unsolicited control information
-Add GPIO sticky mask data
-Add GPIO data sets associated with GPIO signals

Widget nodes
-Add pin widget controls
-Add power state controls
-Add converter stream and channel controls
-Add processing state information
-Add processing capabilities
-Add volume knob capabilities
-Add volume knob control information
-Add digital converter control information
-Add pin sense control information
-Add EAPD/BTL enable controls
-Add unsolicited response controls

Signed-off-by: Shrikant Dharwadkar <shrikant.dharwadkar@intel.com>
---
 sound/hda/hdac_sysfs.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index fb2aa34..b1acff2 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -37,6 +37,9 @@ static ssize_t type##_show(struct device *dev,			\
 } \
 static DEVICE_ATTR_RO(type)
 
+#define CODEC_PRINT(verb) sprintf(buf, "0x%08x\n",		\
+		snd_hdac_read_parm(codec, nid, verb))
+
 CODEC_ATTR(type);
 CODEC_ATTR(vendor_id);
 CODEC_ATTR(subsystem_id);
@@ -173,6 +176,12 @@ static ssize_t pin_caps_show(struct hdac_device *codec, hda_nid_t nid,
 		       snd_hdac_read_parm(codec, nid, AC_PAR_PIN_CAP));
 }
 
+static ssize_t pin_widget_ctl_show(struct hdac_device *codec, hda_nid_t nid,
+			     struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_PIN_WIDGET_CONTROL);
+}
+
 static ssize_t pin_cfg_show(struct hdac_device *codec, hda_nid_t nid,
 			    struct widget_attribute *attr, char *buf)
 {
@@ -243,6 +252,14 @@ static ssize_t power_caps_show(struct hdac_device *codec, hda_nid_t nid,
 		       snd_hdac_read_parm(codec, nid, AC_PAR_POWER_STATE));
 }
 
+static ssize_t power_states_show(struct hdac_device *codec, hda_nid_t nid,
+			       struct widget_attribute *attr, char *buf)
+{
+	if (nid != codec->afg && !(get_wcaps(codec, nid) & AC_WCAP_POWER))
+		return 0;
+	return CODEC_PRINT(AC_VERB_GET_POWER_STATE);
+}
+
 static ssize_t gpio_caps_show(struct hdac_device *codec, hda_nid_t nid,
 			      struct widget_attribute *attr, char *buf)
 {
@@ -266,27 +283,166 @@ static ssize_t connections_show(struct hdac_device *codec, hda_nid_t nid,
 	return ret;
 }
 
+static ssize_t converter_stream_channel_show(struct hdac_device *codec,
+			hda_nid_t nid, struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_CONV);
+}
+
+static ssize_t processing_states_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_PROC_STATE);
+}
+
+static ssize_t subordinate_node_count_show(struct hdac_device *codec,
+			hda_nid_t nid, struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_PAR_NODE_COUNT);
+}
+
+static ssize_t function_group_type_show(struct hdac_device *codec,
+			hda_nid_t nid, struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_PAR_FUNCTION_TYPE);
+}
+
+static ssize_t processing_caps_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_PAR_PROC_CAP);
+}
+
+static ssize_t volume_knob_caps_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_PAR_VOL_KNB_CAP);
+}
+
+static ssize_t volume_knob_ctl_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_VOLUME_KNOB_CONTROL);
+}
+
+static ssize_t digital_converter_ctl_show(struct hdac_device *codec,
+			hda_nid_t nid, struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_DIGI_CONVERT_1);
+}
+
+static ssize_t pin_sense_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_PIN_SENSE);
+}
+
+static ssize_t EAPD_BTL_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_EAPD_BTLENABLE);
+}
+
+static ssize_t unsol_caps_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_UNSOLICITED_RESPONSE);
+}
+
+static ssize_t sdi_select_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_SDI_SELECT);
+}
+
+static ssize_t gpio_enable_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_GPIO_MASK);
+}
+
+static ssize_t gpio_direction_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_GPIO_DIRECTION);
+}
+
+static ssize_t gpio_wake_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_GPIO_WAKE_MASK);
+}
+
+static ssize_t gpio_unsol_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_GPIO_UNSOLICITED_RSP_MASK);
+}
+
+static ssize_t gpio_sticky_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_GPIO_STICKY_MASK);
+}
+
+static ssize_t gpio_data_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return CODEC_PRINT(AC_VERB_GET_GPIO_DATA);
+}
+
 static WIDGET_ATTR_RO(caps);
 static WIDGET_ATTR_RO(pin_caps);
 static WIDGET_ATTR_RO(pin_cfg);
+static WIDGET_ATTR_RO(pin_widget_ctl);
 static WIDGET_ATTR_RO(pcm_caps);
 static WIDGET_ATTR_RO(pcm_formats);
 static WIDGET_ATTR_RO(amp_in_caps);
 static WIDGET_ATTR_RO(amp_out_caps);
 static WIDGET_ATTR_RO(power_caps);
+static WIDGET_ATTR_RO(power_states);
 static WIDGET_ATTR_RO(gpio_caps);
 static WIDGET_ATTR_RO(connections);
+static WIDGET_ATTR_RO(converter_stream_channel);
+static WIDGET_ATTR_RO(processing_states);
+static WIDGET_ATTR_RO(subordinate_node_count);
+static WIDGET_ATTR_RO(function_group_type);
+static WIDGET_ATTR_RO(processing_caps);
+static WIDGET_ATTR_RO(volume_knob_caps);
+static WIDGET_ATTR_RO(volume_knob_ctl);
+static WIDGET_ATTR_RO(digital_converter_ctl);
+static WIDGET_ATTR_RO(pin_sense);
+static WIDGET_ATTR_RO(EAPD_BTL);
+static WIDGET_ATTR_RO(unsol_caps);
+static WIDGET_ATTR_RO(sdi_select);
+static WIDGET_ATTR_RO(gpio_enable);
+static WIDGET_ATTR_RO(gpio_direction);
+static WIDGET_ATTR_RO(gpio_wake);
+static WIDGET_ATTR_RO(gpio_unsol);
+static WIDGET_ATTR_RO(gpio_sticky);
+static WIDGET_ATTR_RO(gpio_data);
 
 static struct attribute *widget_node_attrs[] = {
 	&wid_attr_caps.attr,
 	&wid_attr_pin_caps.attr,
+	&wid_attr_pin_widget_ctl.attr,
 	&wid_attr_pin_cfg.attr,
 	&wid_attr_pcm_caps.attr,
 	&wid_attr_pcm_formats.attr,
 	&wid_attr_amp_in_caps.attr,
 	&wid_attr_amp_out_caps.attr,
 	&wid_attr_power_caps.attr,
+	&wid_attr_power_states.attr,
 	&wid_attr_connections.attr,
+	&wid_attr_converter_stream_channel.attr,
+	&wid_attr_processing_states.attr,
+	&wid_attr_processing_caps.attr,
+	&wid_attr_volume_knob_caps.attr,
+	&wid_attr_volume_knob_ctl.attr,
+	&wid_attr_digital_converter_ctl.attr,
+	&wid_attr_pin_sense.attr,
+	&wid_attr_EAPD_BTL.attr,
+	&wid_attr_unsol_caps.attr,
 	NULL,
 };
 
@@ -296,7 +452,18 @@ static struct attribute *widget_afg_attrs[] = {
 	&wid_attr_amp_in_caps.attr,
 	&wid_attr_amp_out_caps.attr,
 	&wid_attr_power_caps.attr,
+	&wid_attr_power_states.attr,
 	&wid_attr_gpio_caps.attr,
+	&wid_attr_subordinate_node_count.attr,
+	&wid_attr_function_group_type.attr,
+	&wid_attr_unsol_caps.attr,
+	&wid_attr_sdi_select.attr,
+	&wid_attr_gpio_enable.attr,
+	&wid_attr_gpio_direction.attr,
+	&wid_attr_gpio_wake.attr,
+	&wid_attr_gpio_unsol.attr,
+	&wid_attr_gpio_sticky.attr,
+	&wid_attr_gpio_data.attr,
 	NULL,
 };
 
-- 
2.7.4
