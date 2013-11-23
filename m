From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/13] bebob: Prepare for device specific
	operations
Date: Sat, 23 Nov 2013 15:09:20 +0900
Message-ID: <1385186965-8303-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id CF1D926530C
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:09:36 +0100 (CET)
In-Reply-To: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit is for some devices designed for semi-professional use. They have
some model specific functionality and quirks.

Many functionality should be implemented in user land. Then this commit adds
functionality related to stream such as sampling frequency or clock source. And
some device need cue to load firmware. This commit adds this mechanism. For
debugging, this commit adds the functionality to get metering information if
it's available.

To help these functionalities, this commit adds some AV/C commands in 'AV/C
Audio Subunit Specification (1394TA)' and 'Connection and Compatibility
Management(1394TA)'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c         |  40 ++++---
 sound/firewire/bebob/bebob.h         |  48 ++++++++-
 sound/firewire/bebob/bebob_command.c | 160 ++++++++++++++++++++++++++++
 sound/firewire/bebob/bebob_control.c | 198 +++++++++++++++++++++++++++++++++--
 sound/firewire/bebob/bebob_pcm.c     |   3 +-
 sound/firewire/bebob/bebob_proc.c    |  45 +++++++-
 sound/firewire/bebob/bebob_stream.c  |   7 +-
 7 files changed, 470 insertions(+), 31 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 219eac7..7c3f1b3 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -141,6 +141,7 @@ snd_bebob_probe(struct fw_unit *unit,
 {
 	struct snd_card *card;
 	struct snd_bebob *bebob;
+	const struct snd_bebob_spec *spec;
 	unsigned int card_index;
 	int err;
 
@@ -156,6 +157,8 @@ snd_bebob_probe(struct fw_unit *unit,
 		goto end;
 	}
 
+	spec = (const struct snd_bebob_spec *)entry->driver_data;
+
 	/* create card */
 	err = snd_card_create(index[card_index], id[card_index],
 			THIS_MODULE, sizeof(struct snd_bebob), &card);
@@ -169,6 +172,7 @@ snd_bebob_probe(struct fw_unit *unit,
 	bebob->device = fw_parent_device(unit);
 	bebob->unit = unit;
 	bebob->card_index = -1;
+	bebob->spec = spec;
 	mutex_init(&bebob->mutex);
 	spin_lock_init(&bebob->lock);
 	init_waitqueue_head(&bebob->hwdep_wait);
@@ -246,33 +250,43 @@ static void snd_bebob_remove(struct fw_unit *unit)
 	snd_card_free_when_closed(bebob->card);
 }
 
+struct snd_bebob_clock_spec normal_clk_spec = {
+	.get_freq	= &snd_bebob_stream_get_rate,
+	.set_freq	= &snd_bebob_stream_set_rate
+};
+static const struct snd_bebob_spec spec_normal = {
+	.load		= NULL,
+	.clock		= &normal_clk_spec,
+	.meter		= NULL
+};
+
 static const struct ieee1394_device_id snd_bebob_id_table[] = {
 	/* Edirol, FA-66 */
-	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010049),
+	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010049, spec_normal),
 	/* Edirol, FA-101 */
-	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010048),
+	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010048, spec_normal),
 	/* BridgeCo, RDAudio1 */
-	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010048),
+	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010048, spec_normal),
 	/* BridgeCo, Audio5 */
-	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010049),
+	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010049, spec_normal),
 	/* Mackie, OnyxFirewire */
-	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010065),
+	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010065, spec_normal),
 	/* Mackie, OnyxFirewire */
-	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010067),
+	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010067, spec_normal),
 	/* Tascam, IF-FW/DM */
-	SND_BEBOB_DEV_ENTRY(VEN_TASCOM, 0x00010067),
+	SND_BEBOB_DEV_ENTRY(VEN_TASCOM, 0x00010067, spec_normal),
 	/* Behringer, X32 */
-	SND_BEBOB_DEV_ENTRY(VEN_BEHRINGER, 0x00000006),
+	SND_BEBOB_DEV_ENTRY(VEN_BEHRINGER, 0x00000006, spec_normal),
 	/* ApogeeElectronics, Rosetta200 */
-	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00010048),
+	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00010048, spec_normal),
 	/* ESI, Quatafire610 */
-	SND_BEBOB_DEV_ENTRY(VEN_ESI, 0x00010064),
+	SND_BEBOB_DEV_ENTRY(VEN_ESI, 0x00010064, spec_normal),
 	/* AcousticReality, eARMasterOne */
-	SND_BEBOB_DEV_ENTRY(VEN_ACOUSTIC, 0x00000002),
+	SND_BEBOB_DEV_ENTRY(VEN_ACOUSTIC, 0x00000002, spec_normal),
 	/* CME, MatrixKFW */
-	SND_BEBOB_DEV_ENTRY(VEN_CME, 0x00030000),
+	SND_BEBOB_DEV_ENTRY(VEN_CME, 0x00030000, spec_normal),
 	/* Phonic, HB24U */
-	SND_BEBOB_DEV_ENTRY(VEN_PHONIC, 0x00000000),
+	SND_BEBOB_DEV_ENTRY(VEN_PHONIC, 0x00000000, spec_normal),
 	{}
 };
 MODULE_DEVICE_TABLE(ieee1394, snd_bebob_id_table);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 3950b02..b35fc52 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -58,6 +58,33 @@ struct snd_bebob_stream_formation {
 /* this is a lookup table for index of stream formations */
 extern const unsigned int snd_bebob_rate_table[SND_BEBOB_STRM_FMT_ENTRIES];
 
+/* device specific operations */
+#define SND_BEBOB_CLOCK_INTERNAL	"Internal"
+struct snd_bebob_clock_spec {
+	unsigned int num;
+	char **labels;
+	int (*get_src)(struct snd_bebob *bebob, unsigned int *id);
+	int (*set_src)(struct snd_bebob *bebob, unsigned int id);
+	int (*get_freq)(struct snd_bebob *bebob, unsigned int *rate);
+	int (*set_freq)(struct snd_bebob *bebob, unsigned int rate);
+	int (*synced)(struct snd_bebob *bebob, bool *synced);
+	/* private */
+	struct snd_ctl_elem_id *ctl_id_src;
+	struct snd_ctl_elem_id *ctl_id_freq;
+	struct snd_ctl_elem_id *ctl_id_synced;
+};
+struct snd_bebob_meter_spec {
+	unsigned int num;
+	char **labels;
+	int (*get)(struct snd_bebob *bebob, u32 *target, unsigned int size);
+};
+struct snd_bebob_spec {
+	int (*load)(struct fw_unit *unit,
+		    const struct ieee1394_device_id *entry);
+	struct snd_bebob_clock_spec *clock;
+	struct snd_bebob_meter_spec *meter;
+};
+
 struct snd_bebob {
         struct snd_card *card;
         struct fw_device *device;
@@ -67,6 +94,8 @@ struct snd_bebob {
         struct mutex mutex;
         spinlock_t lock;
 
+	const struct snd_bebob_spec *spec;
+
 	unsigned int midi_input_ports;
 	unsigned int midi_output_ports;
 
@@ -80,8 +109,6 @@ struct snd_bebob {
 	struct snd_bebob_stream_formation
 		rx_stream_formations[SND_BEBOB_STRM_FMT_ENTRIES];
 
-	struct snd_ctl_elem_id *ctl_id_freq;
-
         /* for uapi */
         int dev_lock_count;
         bool dev_lock_changed;
@@ -104,6 +131,20 @@ snd_bebob_read_quad(struct snd_bebob *bebob, u64 addr, void *buf, int size)
 				  buf, size, 0);
 }
 
+/* AV/C Audio Subunit Specification 1.0 (1394TA) */
+int avc_audio_set_selector(struct fw_unit *unit, unsigned int subunit_id,
+			   unsigned int fb_id, unsigned int num);
+int avc_audio_get_selector(struct fw_unit *unit,unsigned  int subunit_id,
+			   unsigned int fb_id, unsigned int *num);
+
+/* Connection and Compatibility Management 1.0 (1394TA) */
+int avc_ccm_get_sig_src(struct fw_unit *unit,
+	unsigned int *src_stype, unsigned int *src_sid, unsigned int *src_pid,
+	unsigned int dst_stype, unsigned int dst_sid, unsigned int dst_pid);
+int avc_ccm_set_sig_src(struct fw_unit *unit,
+	unsigned int src_stype, unsigned int src_sid, unsigned int src_pid,
+	unsigned int dst_stype, unsigned int dst_sid, unsigned int dst_pid);
+
 /* AVC command extensions, AV/C Unit and Subunit, Revision 17 (BridgeCo.) */
 enum snd_bebob_plug_dir {
 	SND_BEBOB_PLUG_DIR_IN	= 0x00,
@@ -173,12 +214,13 @@ int snd_bebob_create_pcm_devices(struct snd_bebob *bebob);
 
 int snd_bebob_create_hwdep_device(struct snd_bebob *bebob);
 
-#define SND_BEBOB_DEV_ENTRY(vendor, model) \
+#define SND_BEBOB_DEV_ENTRY(vendor, model, private_data) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
 			  IEEE1394_MATCH_MODEL_ID, \
 	.vendor_id	= vendor, \
 	.model_id	= model, \
+	.driver_data	= (kernel_ulong_t)&private_data \
 }
 
 #endif
diff --git a/sound/firewire/bebob/bebob_command.c b/sound/firewire/bebob/bebob_command.c
index 98b7668..1bf3e5e 100644
--- a/sound/firewire/bebob/bebob_command.c
+++ b/sound/firewire/bebob/bebob_command.c
@@ -20,6 +20,166 @@
 #define BEBOB_COMMAND_MAX_TRIAL	3
 #define BEBOB_COMMAND_WAIT_MSEC	100
 
+int avc_audio_set_selector(struct fw_unit *unit, unsigned int subunit_id,
+			   unsigned int fb_id, unsigned int num)
+{
+	u8 *buf;
+	int err;
+
+	buf = kzalloc(12, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0]  = 0x00;		/* AV/C CONTROL */
+	buf[1]  = 0x08 | (0x07 & subunit_id);	/* AUDIO SUBUNIT ID */
+	buf[2]  = 0xb8;		/* FUNCTION BLOCK  */
+	buf[3]  = 0x80;		/* type is 'selector'*/
+	buf[4]  = 0xff & fb_id;	/* function block id */
+	buf[5]  = 0x10;		/* control attribute is CURRENT */
+	buf[6]  = 0x02;		/* selector length is 2 */
+	buf[7]  = 0xff & num;	/* input function block plug number */
+	buf[8]  = 0x01;		/* control selector is SELECTOR_CONTROL */
+
+	/* do transaction and check buf[1-8] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 12, buf, 12,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(7) | BIT(8));
+	if (err < 0)
+		goto end;
+	if ((err < 6) || (buf[0] != 0x09)) {
+		dev_err(&unit->device,
+			"failed to set selector %d: 0x%02X\n",
+			fb_id, buf[0]);
+		err = -EIO;
+		goto end;
+	}
+
+	err = 0;
+end:
+	kfree(buf);
+	return err;
+}
+
+int avc_audio_get_selector(struct fw_unit *unit, unsigned int subunit_id,
+			   unsigned int fb_id, unsigned int *num)
+{
+	u8 *buf;
+	int err;
+
+	buf = kzalloc(12, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0]  = 0x01;		/* AV/C STATUS */
+	buf[1]  = 0x08 | (0x07 & subunit_id);	/* AUDIO SUBUNIT ID */
+	buf[2]  = 0xb8;		/* FUNCTION BLOCK */
+	buf[3]  = 0x80;		/* type is 'selector'*/
+	buf[4]  = 0xff & fb_id;	/* function block id */
+	buf[5]  = 0x10;		/* control attribute is CURRENT */
+	buf[6]  = 0x02;		/* selector length is 2 */
+	buf[7]  = 0xff;		/* input function block plug number */
+	buf[8]  = 0x01;		/* control selector is SELECTOR_CONTROL */
+
+	/* do transaction and check buf[1-6,8] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 12, buf, 12,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(8));
+	if (err < 0)
+		goto end;
+	if ((err < 6) || (buf[0] != 0x0c)) {
+		dev_err(&unit->device,
+			"failed to get selector %d: 0x%02X\n",
+			fb_id, buf[0]);
+		err = -EIO;
+		goto end;
+	}
+
+	*num = buf[7];
+	err = 0;
+end:
+	kfree(buf);
+	return err;
+}
+
+int avc_ccm_get_sig_src(struct fw_unit *unit,
+	unsigned int *src_stype, unsigned int *src_sid, unsigned int *src_pid,
+	unsigned int dst_stype, unsigned int dst_sid, unsigned int dst_pid)
+{
+	int err;
+	u8 *buf;
+
+	buf = kzalloc(8, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0] = 0x01;	/* AV/C STATUS */
+	buf[1] = 0xff;	/* UNIT */
+	buf[2] = 0x1A;	/* SIGNAL SOURCE */
+	buf[3] = 0x0f;
+	buf[4] = 0xff;
+	buf[5] = 0xfe;
+	buf[6] = (0xf8 & (dst_stype << 3)) | dst_sid;
+	buf[7] = 0xff & dst_pid;
+
+	/* do transaction and check buf[1,2,6,7] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 8, buf, 8,
+				  BIT(1) | BIT(2) | BIT(6) | BIT(7));
+	if (err < 0)
+		goto end;
+	if ((err < 0) || (buf[0] != 0x0c)) {
+		dev_err(&unit->device,
+			"failed to get signal status\n");
+		err = -EIO;
+		goto end;
+	}
+
+	*src_stype = buf[4] >> 3;
+	*src_sid = buf[4] & 0x07;
+	*src_pid = buf[5];
+end:
+	kfree(buf);
+	return err;
+}
+
+int avc_ccm_set_sig_src(struct fw_unit *unit,
+	unsigned int src_stype, unsigned int src_sid, unsigned int src_pid,
+	unsigned int dst_stype, unsigned int dst_sid, unsigned int dst_pid)
+{
+	int err;
+	u8 *buf;
+
+	buf = kzalloc(8, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0] = 0x00;	/* AV/C CONTROL */
+	buf[1] = 0xff;	/* UNIT */
+	buf[2] = 0x1A;	/* SIGNAL SOURCE */
+	buf[3] = 0x0f;
+	buf[4] = (0xf8 & (src_stype << 3)) | src_sid;
+	buf[5] = 0xff & src_pid;
+	buf[6] = (0xf8 & (dst_stype << 3)) | dst_sid;
+	buf[7] = 0xff & dst_pid;
+
+	/* do transaction and check buf[1-7] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 8, buf, 8,
+				  BIT(1) | BIT(2) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(7));
+	if (err < 0)
+		goto end;
+	if ((err < 0) || ((buf[0] != 0x09) && (buf[0] != 0x0f))) {
+		dev_err(&unit->device,
+			"failed to set signal status\n");
+		err = -EIO;
+		goto end;
+	}
+
+	err = 0;
+end:
+	kfree(buf);
+	return err;
+}
+
 int avc_bridgeco_get_plug_type(struct fw_unit *unit,
 			       enum snd_bebob_plug_dir pdir,
 			       enum snd_bebob_plug_unit punit,
diff --git a/sound/firewire/bebob/bebob_control.c b/sound/firewire/bebob/bebob_control.c
index f9a9229..3b311c3 100644
--- a/sound/firewire/bebob/bebob_control.c
+++ b/sound/firewire/bebob/bebob_control.c
@@ -17,6 +17,49 @@
 
 #include "bebob.h"
 
+/*
+ * Currently this module support any controls related to decision of channels
+ * in stream, hardware metering and digital format. Users should utilize tools
+ * which FFADO project developed.
+ */
+
+/*
+ * Physical metering:
+ *  the value in unavvailable channels is zero.
+ */
+static int
+physical_metering_info(struct snd_kcontrol *ctl,
+		       struct snd_ctl_elem_info *info)
+{
+	struct snd_bebob *bebob = ctl->private_data;
+	struct snd_bebob_meter_spec *spec = bebob->spec->meter;
+
+	info->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	info->count = 1 + spec->num * 2 * sizeof(u32);
+
+	return 0;
+}
+static int
+physical_metering_get(struct snd_kcontrol *ctl,
+		      struct snd_ctl_elem_value *value)
+{
+	struct snd_bebob *bebob = ctl->private_data;
+	struct snd_bebob_meter_spec *spec = bebob->spec->meter;
+	u32 *dst;
+
+	dst = (u32 *)value->value.bytes.data;
+	*dst = spec->num;
+
+	return spec->get(bebob, dst + 1, spec->num * 2 * sizeof(u32));
+}
+static const
+struct snd_kcontrol_new physical_metering = {
+	.iface	= SNDRV_CTL_ELEM_IFACE_CARD,
+	.name	= "Physical Metering",
+	.access	= SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info	= physical_metering_info,
+	.get	= physical_metering_get
+};
 
 /*
  * Global Control: Sampling Rate Control
@@ -64,12 +107,13 @@ control_sampling_rate_get(struct snd_kcontrol *kctl,
 			  struct snd_ctl_elem_value *uval)
 {
 	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct snd_bebob_clock_spec *spec = bebob->spec->clock;
 	unsigned int i, sampling_rate, index;
 	int err;
 
 	mutex_lock(&bebob->mutex);
 
-	err = snd_bebob_stream_get_rate(bebob, &sampling_rate);
+	err = spec->get_freq(bebob, &sampling_rate);
 	if (err < 0)
 		goto end;
 
@@ -92,6 +136,7 @@ control_sampling_rate_put(struct snd_kcontrol *kctl,
 			  struct snd_ctl_elem_value *uval)
 {
 	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct snd_bebob_clock_spec *spec = bebob->spec->clock;
 	unsigned int index, sampling_rate;
 	int value, changed = 0;
 
@@ -110,20 +155,128 @@ control_sampling_rate_put(struct snd_kcontrol *kctl,
 	sampling_rate = snd_bebob_rate_table[index];
 
 	mutex_lock(&bebob->mutex);
-	if (snd_bebob_stream_set_rate(bebob, sampling_rate) < 0)
+	if (spec->set_freq(bebob, sampling_rate) < 0)
 		goto end;
 
 	/* prevent from failure of getting command just after setting */
 	msleep(100);
 	changed = 1;
 
-	snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
-		       bebob->ctl_id_freq);
+	if (spec->ctl_id_freq)
+		snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       spec->ctl_id_freq);
 end:
 	mutex_unlock(&bebob->mutex);
 	return changed;
 }
 
+/*
+ * Global Control: Clock Source Control
+ */
+static int control_clock_source_info(struct snd_kcontrol *kctl,
+				     struct snd_ctl_elem_info *einf)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct snd_bebob_clock_spec *spec = bebob->spec->clock;
+
+	einf->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	einf->count = 1;
+	einf->value.enumerated.items = spec->num;
+
+	if (einf->value.enumerated.item >= einf->value.enumerated.items)
+		einf->value.enumerated.item = einf->value.enumerated.items - 1;
+
+	strcpy(einf->value.enumerated.name,
+	       spec->labels[einf->value.enumerated.item]);
+
+	return 0;
+}
+static int control_clock_source_get(struct snd_kcontrol *kctl,
+				    struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct snd_bebob_clock_spec *spec = bebob->spec->clock;
+	unsigned int id;
+
+	mutex_lock(&bebob->mutex);
+	if (spec->get_src(bebob, &id) >= 0)
+		uval->value.enumerated.item[0] = id;
+	mutex_unlock(&bebob->mutex);
+
+	return 0;
+}
+static int control_clock_source_put(struct snd_kcontrol *kctl,
+				    struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct snd_bebob_clock_spec *spec = bebob->spec->clock;
+	int value, changed = 0;
+
+	value = uval->value.enumerated.item[0];
+
+	if (value < spec->num) {
+		mutex_lock(&bebob->mutex);
+		if (spec->set_src(bebob, value) >= 0)
+			changed = 1;
+		mutex_unlock(&bebob->mutex);
+	}
+
+	msleep(150);
+	if (spec->ctl_id_src)
+		snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       spec->ctl_id_src);
+
+	return changed;
+}
+
+/*
+ * Global Control: Clock Sync Status
+ */
+static int control_clock_sync_status_info(struct snd_kcontrol *kctl,
+					  struct snd_ctl_elem_info *einf)
+{
+	einf->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	einf->count = 1;
+	einf->value.integer.min = 0;
+	einf->value.integer.max = 1;
+
+	return 0;
+}
+static int control_clock_sync_status_get(struct snd_kcontrol *kctl,
+					 struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct snd_bebob_clock_spec *spec = bebob->spec->clock;
+	bool synced = 0;
+
+	mutex_lock(&bebob->mutex);
+	if (spec->synced(bebob, &synced) >= 0) {
+		if (synced == false)
+			uval->value.enumerated.item[0] = 0;
+		else
+			uval->value.enumerated.item[0] = 1;
+	}
+	mutex_unlock(&bebob->mutex);
+
+	return 0;
+}
+static struct snd_kcontrol_new global_clock_source_control = {
+	.name	= "Clock Source",
+	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access	= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info	= control_clock_source_info,
+	.get	= control_clock_source_get,
+	.put	= control_clock_source_put
+};
+
+static struct snd_kcontrol_new global_clock_sync_status = {
+	.name	= "Clock Sync Status",
+	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access	= SNDRV_CTL_ELEM_ACCESS_READ,
+	.info	= control_clock_sync_status_info,
+	.get	= control_clock_sync_status_get,
+};
+
 static struct snd_kcontrol_new global_sampling_rate_control = {
 	.name	= "Sampling Rate",
 	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -137,12 +290,39 @@ int snd_bebob_create_control_devices(struct snd_bebob *bebob)
 {
 	int err = 0;
 	struct snd_kcontrol *kctl;
+	struct snd_bebob_clock_spec *clk = bebob->spec->clock;
+	struct snd_bebob_meter_spec *meter = bebob->spec->meter;
 
-	kctl = snd_ctl_new1(&global_sampling_rate_control, bebob);
-	err = snd_ctl_add(bebob->card, kctl);
-	if (err < 0)
-		goto end;
-	bebob->ctl_id_freq = &kctl->id;
+	if (clk->get_freq != NULL) {
+		kctl = snd_ctl_new1(&global_sampling_rate_control, bebob);
+		err = snd_ctl_add(bebob->card, kctl);
+		if (err < 0)
+			goto end;
+		clk->ctl_id_freq = &kctl->id;
+	}
+
+	if (clk->get_src != NULL) {
+		kctl = snd_ctl_new1(&global_clock_source_control, bebob);
+		err = snd_ctl_add(bebob->card, kctl);
+		if (err < 0)
+			goto end;
+		clk->ctl_id_src = &kctl->id;
+	}
+
+	if (clk->synced != NULL) {
+		kctl = snd_ctl_new1(&global_clock_sync_status, bebob);
+		err = snd_ctl_add(bebob->card, kctl);
+		if (err < 0)
+			goto end;
+		clk->ctl_id_synced = &kctl->id;
+	}
+
+	if (meter != NULL) {
+		kctl = snd_ctl_new1(&physical_metering, bebob);
+		err = snd_ctl_add(bebob->card, kctl);
+		if (err < 0)
+			goto end;
+	}
 end:
 	return err;
 }
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index c7cca80..b478df8 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -236,6 +236,7 @@ static int
 pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_bebob *bebob = substream->private_data;
+	struct snd_bebob_clock_spec *spec = bebob->spec->clock;
 	unsigned int sampling_rate;
 	int err;
 
@@ -249,7 +250,7 @@ pcm_open(struct snd_pcm_substream *substream)
 
 	if (amdtp_stream_pcm_running(&bebob->tx_stream) ||
 	    amdtp_stream_pcm_running(&bebob->rx_stream)) {
-		err = snd_bebob_stream_get_rate(bebob, &sampling_rate);
+		err = spec->get_freq(bebob, &sampling_rate);
 		if (err < 0)
 			goto err_locked;
 
diff --git a/sound/firewire/bebob/bebob_proc.c b/sound/firewire/bebob/bebob_proc.c
index ca7c1a7..3893e07 100644
--- a/sound/firewire/bebob/bebob_proc.c
+++ b/sound/firewire/bebob/bebob_proc.c
@@ -81,6 +81,42 @@ end:
 }
 
 static void
+proc_read_meters(struct snd_info_entry *entry,
+		 struct snd_info_buffer *buffer)
+{
+	struct snd_bebob *bebob = entry->private_data;
+	struct snd_bebob_meter_spec *spec = bebob->spec->meter;
+	u32 *buf;
+	unsigned int i, c, channels, size;
+	int err;
+
+	if (spec == NULL)
+		return;
+
+	channels = spec->num * 2;
+	size = channels * sizeof(u32);
+	buf = kmalloc(size, GFP_KERNEL);
+	if (buf == NULL)
+		return;
+
+	err = spec->get(bebob, buf, size);
+	if (err < 0)
+		goto end;
+
+	for (i = 0, c = 1; i < channels; i++) {
+		snd_iprintf(buffer, "%s %d:\t%d\n",
+			    spec->labels[i / 2], c++, buf[i]);
+		if ((i + 1 < channels - 1) &&
+		    (strcmp(spec->labels[i / 2],
+			    spec->labels[(i + 1) / 2]) != 0))
+			c = 1;
+	}
+end:
+	kfree(buf);
+	return;
+}
+
+static void
 proc_read_formation(struct snd_info_entry *entry,
 		struct snd_info_buffer *buffer)
 {
@@ -91,7 +127,7 @@ proc_read_formation(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "Output Stream from device:\n");
 	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
 	formation = bebob->tx_stream_formations;
-	for (i = 0; i < 9; i += 1) {
+	for (i = 0; i < 9; i++) {
 		snd_iprintf(buffer,
 			"\t%d\t%d\t%d\n", snd_bebob_rate_table[i],
 			formation[i].pcm, formation[i].midi);
@@ -100,7 +136,7 @@ proc_read_formation(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "Input Stream to device:\n");
 	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
 	formation = bebob->rx_stream_formations;
-	for (i = 0; i < 9; i += 1) {
+	for (i = 0; i < 9; i++) {
 		snd_iprintf(buffer,
 			"\t%d\t%d\t%d\n", snd_bebob_rate_table[i],
 			formation[i].pcm, formation[i].midi);
@@ -119,5 +155,10 @@ void snd_bebob_proc_init(struct snd_bebob *bebob)
 	if (!snd_card_proc_new(bebob->card, "#formation", &entry))
 		snd_info_set_text_ops(entry, bebob, proc_read_formation);
 
+	if (bebob->spec->meter != NULL) {
+		if (!snd_card_proc_new(bebob->card, "#meter", &entry))
+			snd_info_set_text_ops(entry, bebob, proc_read_meters);
+	}
+
 	return;
 }
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index f2527bf..faa235e 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -302,6 +302,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 				  struct amdtp_stream *request,
 				  unsigned int rate)
 {
+	struct snd_bebob_clock_spec *spec = bebob->spec->clock;
 	struct amdtp_stream *master, *slave;
 	enum cip_flags sync_mode;
 	unsigned int curr_rate;
@@ -335,7 +336,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 	}
 
 	/* get current rate */
-	err = snd_bebob_stream_get_rate(bebob, &curr_rate);
+	err = spec->get_freq(bebob, &curr_rate);
 	if (err < 0)
 		goto end;
 	if (rate == 0)
@@ -365,11 +366,11 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 		 * If establishing connections at first, Yamaha GO46 (and maybe
 		 * TerraTek X24) don't generate sound.
 		 */
-		err = snd_bebob_stream_set_rate(bebob, rate);
+		err = spec->set_freq(bebob, rate);
 		if (err < 0)
 			goto end;
 		snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       bebob->ctl_id_freq);
+			       spec->ctl_id_freq);
 
 		err = make_both_connections(bebob, rate);
 		if (err < 0)
-- 
1.8.3.2
