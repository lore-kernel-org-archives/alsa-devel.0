From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/9] ALSA: oxfw: apply model-specific
	functionality framework to firewire-speakers
Date: Sun, 15 Nov 2015 18:26:00 +0900
Message-ID: <1447579565-4615-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E1BA2619EA
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:26:10 +0100 (CET)
In-Reply-To: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In former commits, ALSA oxfw driver got a framework for model-specific
functionalities. This commit applies the framework to control elements for
firewire-speakers.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-spkr.c | 84 +++++++++++++++++++++++++++++------------
 sound/firewire/oxfw/oxfw.c      | 50 +++++++++---------------
 sound/firewire/oxfw/oxfw.h      | 18 +--------
 3 files changed, 79 insertions(+), 73 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-spkr.c b/sound/firewire/oxfw/oxfw-spkr.c
index 515468a..6527a16 100644
--- a/sound/firewire/oxfw/oxfw-spkr.c
+++ b/sound/firewire/oxfw/oxfw-spkr.c
@@ -9,6 +9,18 @@
 
 #include "oxfw.h"
 
+/* Old firewire-speakers module supports some control elements. */
+struct fw_spkr {
+	unsigned int mixer_channels;
+	u8 mute_fb_id;
+	u8 volume_fb_id;
+
+	bool mute;
+	s16 volume[6];
+	s16 volume_min;
+	s16 volume_max;
+};
+
 enum control_action { CTL_READ, CTL_WRITE };
 enum control_attribute {
 	CTL_MIN		= 0x02,
@@ -19,6 +31,7 @@ enum control_attribute {
 static int spkr_mute_command(struct snd_oxfw *oxfw, bool *value,
 			     enum control_action action)
 {
+	struct fw_spkr *spkr = oxfw->spec->private_data;
 	u8 *buf;
 	u8 response_ok;
 	int err;
@@ -37,7 +50,7 @@ static int spkr_mute_command(struct snd_oxfw *oxfw, bool *value,
 	buf[1] = 0x08;			/* audio unit 0 */
 	buf[2] = 0xb8;			/* FUNCTION BLOCK */
 	buf[3] = 0x81;			/* function block type: feature */
-	buf[4] = oxfw->device_info->mute_fb_id; /* function block ID */
+	buf[4] = spkr->mute_fb_id;	/* function block ID */
 	buf[5] = 0x10;			/* control attribute: current */
 	buf[6] = 0x02;			/* selector length */
 	buf[7] = 0x00;			/* audio channel number */
@@ -77,6 +90,7 @@ static int spkr_volume_command(struct snd_oxfw *oxfw, s16 *value,
 			       enum control_attribute attribute,
 			       enum control_action action)
 {
+	struct fw_spkr *spkr = oxfw->spec->private_data;
 	u8 *buf;
 	u8 response_ok;
 	int err;
@@ -95,7 +109,7 @@ static int spkr_volume_command(struct snd_oxfw *oxfw, s16 *value,
 	buf[1] = 0x08;			/* audio unit 0 */
 	buf[2] = 0xb8;			/* FUNCTION BLOCK */
 	buf[3] = 0x81;			/* function block type: feature */
-	buf[4] = oxfw->device_info->volume_fb_id; /* function block ID */
+	buf[4] = spkr->volume_fb_id;	/* function block ID */
 	buf[5] = attribute;		/* control attribute */
 	buf[6] = 0x02;			/* selector length */
 	buf[7] = channel;		/* audio channel number */
@@ -137,8 +151,9 @@ static int spkr_mute_get(struct snd_kcontrol *control,
 			 struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
+	struct fw_spkr *spkr = oxfw->spec->private_data;
 
-	value->value.integer.value[0] = !oxfw->mute;
+	value->value.integer.value[0] = !spkr->mute;
 
 	return 0;
 }
@@ -147,18 +162,19 @@ static int spkr_mute_put(struct snd_kcontrol *control,
 			 struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
+	struct fw_spkr *spkr = oxfw->spec->private_data;
 	bool mute;
 	int err;
 
 	mute = !value->value.integer.value[0];
 
-	if (mute == oxfw->mute)
+	if (mute == spkr->mute)
 		return 0;
 
 	err = spkr_mute_command(oxfw, &mute, CTL_WRITE);
 	if (err < 0)
 		return err;
-	oxfw->mute = mute;
+	spkr->mute = mute;
 
 	return 1;
 }
@@ -167,11 +183,12 @@ static int spkr_volume_info(struct snd_kcontrol *control,
 			    struct snd_ctl_elem_info *info)
 {
 	struct snd_oxfw *oxfw = control->private_data;
+	struct fw_spkr *spkr = oxfw->spec->private_data;
 
 	info->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	info->count = oxfw->device_info->mixer_channels;
-	info->value.integer.min = oxfw->volume_min;
-	info->value.integer.max = oxfw->volume_max;
+	info->count = spkr->mixer_channels;
+	info->value.integer.min = spkr->volume_min;
+	info->value.integer.max = spkr->volume_max;
 
 	return 0;
 }
@@ -182,10 +199,11 @@ static int spkr_volume_get(struct snd_kcontrol *control,
 			   struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
+	struct fw_spkr *spkr = oxfw->spec->private_data;
 	unsigned int i;
 
-	for (i = 0; i < oxfw->device_info->mixer_channels; ++i)
-		value->value.integer.value[channel_map[i]] = oxfw->volume[i];
+	for (i = 0; i < spkr->mixer_channels; ++i)
+		value->value.integer.value[channel_map[i]] = spkr->volume[i];
 
 	return 0;
 }
@@ -194,14 +212,15 @@ static int spkr_volume_put(struct snd_kcontrol *control,
 			   struct snd_ctl_elem_value *value)
 {
 	struct snd_oxfw *oxfw = control->private_data;
+	struct fw_spkr *spkr = oxfw->spec->private_data;
 	unsigned int i, changed_channels;
 	bool equal_values = true;
 	s16 volume;
 	int err;
 
-	for (i = 0; i < oxfw->device_info->mixer_channels; ++i) {
-		if (value->value.integer.value[i] < oxfw->volume_min ||
-		    value->value.integer.value[i] > oxfw->volume_max)
+	for (i = 0; i < spkr->mixer_channels; ++i) {
+		if (value->value.integer.value[i] < spkr->volume_min ||
+		    value->value.integer.value[i] > spkr->volume_max)
 			return -EINVAL;
 		if (value->value.integer.value[i] !=
 		    value->value.integer.value[0])
@@ -209,15 +228,15 @@ static int spkr_volume_put(struct snd_kcontrol *control,
 	}
 
 	changed_channels = 0;
-	for (i = 0; i < oxfw->device_info->mixer_channels; ++i)
+	for (i = 0; i < spkr->mixer_channels; ++i)
 		if (value->value.integer.value[channel_map[i]] !=
-							oxfw->volume[i])
+							spkr->volume[i])
 			changed_channels |= 1 << (i + 1);
 
 	if (equal_values && changed_channels != 0)
 		changed_channels = 1 << 0;
 
-	for (i = 0; i <= oxfw->device_info->mixer_channels; ++i) {
+	for (i = 0; i <= spkr->mixer_channels; ++i) {
 		volume = value->value.integer.value[channel_map[i ? i - 1 : 0]];
 		if (changed_channels & (1 << i)) {
 			err = spkr_volume_command(oxfw, &volume, i,
@@ -226,13 +245,13 @@ static int spkr_volume_put(struct snd_kcontrol *control,
 				return err;
 		}
 		if (i > 0)
-			oxfw->volume[i - 1] = volume;
+			spkr->volume[i - 1] = volume;
 	}
 
 	return changed_channels != 0;
 }
 
-int snd_oxfw_create_mixer(struct snd_oxfw *oxfw)
+static int spkr_add(struct snd_oxfw *oxfw)
 {
 	static const struct snd_kcontrol_new controls[] = {
 		{
@@ -250,25 +269,37 @@ int snd_oxfw_create_mixer(struct snd_oxfw *oxfw)
 			.put = spkr_volume_put,
 		},
 	};
+	struct fw_spkr *spkr = oxfw->spec->private_data;
 	unsigned int i, first_ch;
 	int err;
 
-	err = spkr_volume_command(oxfw, &oxfw->volume_min,
+	if (strcmp(oxfw->card->driver, "FireWave") == 0) {
+		spkr->mixer_channels = 6;
+		spkr->mute_fb_id = 0x01;
+		spkr->volume_fb_id = 0x02;
+	}
+	if (strcmp(oxfw->card->driver, "FWSpeakers") == 0) {
+		spkr->mixer_channels = 1;
+		spkr->mute_fb_id = 0x01;
+		spkr->volume_fb_id = 0x01;
+	}
+
+	err = spkr_volume_command(oxfw, &spkr->volume_min,
 				   0, CTL_MIN, CTL_READ);
 	if (err < 0)
 		return err;
-	err = spkr_volume_command(oxfw, &oxfw->volume_max,
+	err = spkr_volume_command(oxfw, &spkr->volume_max,
 				   0, CTL_MAX, CTL_READ);
 	if (err < 0)
 		return err;
 
-	err = spkr_mute_command(oxfw, &oxfw->mute, CTL_READ);
+	err = spkr_mute_command(oxfw, &spkr->mute, CTL_READ);
 	if (err < 0)
 		return err;
 
-	first_ch = oxfw->device_info->mixer_channels == 1 ? 0 : 1;
-	for (i = 0; i < oxfw->device_info->mixer_channels; ++i) {
-		err = spkr_volume_command(oxfw, &oxfw->volume[i],
+	first_ch = spkr->mixer_channels == 1 ? 0 : 1;
+	for (i = 0; i < spkr->mixer_channels; ++i) {
+		err = spkr_volume_command(oxfw, &spkr->volume[i],
 					   first_ch + i, CTL_CURRENT, CTL_READ);
 		if (err < 0)
 			return err;
@@ -283,3 +314,8 @@ int snd_oxfw_create_mixer(struct snd_oxfw *oxfw)
 
 	return 0;
 }
+
+struct snd_oxfw_spec snd_oxfw_spec_spkr = {
+	.add = spkr_add,
+	.private_size = sizeof(struct fw_spkr),
+};
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index a9599ce..ee7094b 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -56,7 +56,7 @@ static bool detect_loud_models(struct fw_unit *unit)
 	return (i < ARRAY_SIZE(models));
 }
 
-static int name_card(struct snd_oxfw *oxfw)
+static int name_card(struct snd_oxfw *oxfw, const struct ieee1394_device_id *id)
 {
 	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
 	char vendor[24];
@@ -84,10 +84,14 @@ static int name_card(struct snd_oxfw *oxfw)
 	be32_to_cpus(&firmware);
 
 	/* to apply card definitions */
-	if (oxfw->device_info) {
-		d = oxfw->device_info->driver_name;
-		v = oxfw->device_info->vendor_name;
-		m = oxfw->device_info->model_name;
+	if (id->vendor_id == VENDOR_GRIFFIN) {
+		d = "FireWave";
+		v = "Griffin";
+		m = "FireWave";
+	} else if (id->vendor_id == VENDOR_LACIE) {
+		d = "FWSpeakers";
+		v = "LaCie";
+		m = "FireWire Speakers";
 	} else {
 		d = "OXFW";
 		v = vendor;
@@ -171,6 +175,13 @@ static void detect_quirks(struct snd_oxfw *oxfw)
 		oxfw->midi_input_ports++;
 		oxfw->midi_output_ports++;
 	}
+
+	/*
+	 * For compatibility that old firewire-speaker modules add ALSA control
+	 * character devices for these two models.
+	 */
+	if (vendor == VENDOR_GRIFFIN || vendor == VENDOR_LACIE)
+		oxfw->spec = &snd_oxfw_spec_spkr;
 }
 
 static int oxfw_probe(struct fw_unit *unit,
@@ -193,7 +204,6 @@ static int oxfw_probe(struct fw_unit *unit,
 	oxfw->card = card;
 	mutex_init(&oxfw->mutex);
 	oxfw->unit = fw_unit_get(unit);
-	oxfw->device_info = (const struct device_info *)id->driver_data;
 	spin_lock_init(&oxfw->lock);
 	init_waitqueue_head(&oxfw->hwdep_wait);
 
@@ -212,7 +222,7 @@ static int oxfw_probe(struct fw_unit *unit,
 		}
 	}
 
-	err = name_card(oxfw);
+	err = name_card(oxfw, id);
 	if (err < 0)
 		goto error;
 
@@ -226,12 +236,6 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	if (oxfw->device_info) {
-		err = snd_oxfw_create_mixer(oxfw);
-		if (err < 0)
-			goto error;
-	}
-
 	snd_oxfw_proc_init(oxfw);
 
 	err = snd_oxfw_create_midi(oxfw);
@@ -292,24 +296,6 @@ static void oxfw_remove(struct fw_unit *unit)
 	snd_card_free_when_closed(oxfw->card);
 }
 
-static const struct device_info griffin_firewave = {
-	.driver_name = "FireWave",
-	.vendor_name = "Griffin",
-	.model_name = "FireWave",
-	.mixer_channels = 6,
-	.mute_fb_id   = 0x01,
-	.volume_fb_id = 0x02,
-};
-
-static const struct device_info lacie_speakers = {
-	.driver_name = "FWSpeakers",
-	.vendor_name = "LaCie",
-	.model_name = "FireWire Speakers",
-	.mixer_channels = 1,
-	.mute_fb_id   = 0x01,
-	.volume_fb_id = 0x01,
-};
-
 static const struct ieee1394_device_id oxfw_id_table[] = {
 	{
 		.match_flags  = IEEE1394_MATCH_VENDOR_ID |
@@ -320,7 +306,6 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 		.model_id     = 0x00f970,
 		.specifier_id = SPECIFIER_1394TA,
 		.version      = VERSION_AVC,
-		.driver_data  = (kernel_ulong_t)&griffin_firewave,
 	},
 	{
 		.match_flags  = IEEE1394_MATCH_VENDOR_ID |
@@ -331,7 +316,6 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 		.model_id     = 0x00f970,
 		.specifier_id = SPECIFIER_1394TA,
 		.version      = VERSION_AVC,
-		.driver_data  = (kernel_ulong_t)&lacie_speakers,
 	},
 	/* Behringer,F-Control Audio 202 */
 	{
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 922e5da..473faafbb 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -31,15 +31,6 @@
 #include "../amdtp-am824.h"
 #include "../cmp.h"
 
-struct device_info {
-	const char *driver_name;
-	const char *vendor_name;
-	const char *model_name;
-	unsigned int mixer_channels;
-	u8 mute_fb_id;
-	u8 volume_fb_id;
-};
-
 struct snd_oxfw;
 struct snd_oxfw_spec {
 	int (*add)(struct snd_oxfw *oxfw);
@@ -54,7 +45,6 @@ struct snd_oxfw_spec {
 struct snd_oxfw {
 	struct snd_card *card;
 	struct fw_unit *unit;
-	const struct device_info *device_info;
 	struct mutex mutex;
 	spinlock_t lock;
 
@@ -73,10 +63,6 @@ struct snd_oxfw {
 	unsigned int midi_input_ports;
 	unsigned int midi_output_ports;
 
-	bool mute;
-	s16 volume[6];
-	s16 volume_min;
-	s16 volume_max;
 	struct snd_oxfw_spec *spec;
 
 	int dev_lock_count;
@@ -148,10 +134,10 @@ void snd_oxfw_stream_lock_release(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
 
-int snd_oxfw_create_mixer(struct snd_oxfw *oxfw);
-
 void snd_oxfw_proc_init(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_midi(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_hwdep(struct snd_oxfw *oxfw);
+
+extern struct snd_oxfw_spec snd_oxfw_spec_spkr;
-- 
2.5.0
