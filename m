From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 41/44] bebob: Add support for M-Audio special Firewire series
Date: Fri, 21 Mar 2014 20:10:26 +0900
Message-ID: <1395400229-22957-42-git-send-email-o-takashi@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit allows this driver to support some models which M-Audio produces
with DM1000 but its firmware is special. They are:
 - Firewire 1814
 - ProjectMix I/O

They have heavily customized firmware. The usual operations can't be applied to
them. For this reason, this commit adds a model specific member in 'struct
snd_bebob' and some model specific functions. Some parameters are write-only so
this commit also adds control interface for applications to set them.

M-Audio special firmware quirks:
 - Just after powering on, they wait to download firmware. This state is
   changed when receiving cue. Then bus reset is generated and the device is
   recognized as a different model with the uploaded firmware.
 - They don't respond against BridgeCo AV/C extension commands. So drivers
   can't get their stream formations and so on.
 - They do not start to transmit packets only by establishing connection but
   also by receiving SIGNAL FORMAT command.
 - After booting up, they often fail to send response against driver's request
   due to mismatch of gap_count.

This module don't support to upload firmware.

Tested-by: Darren Anderson <darrena092@gmail.com> (ProjectMix I/O)
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig               |   1 +
 sound/firewire/bebob/bebob.c         |  19 +-
 sound/firewire/bebob/bebob.h         |   5 +
 sound/firewire/bebob/bebob_command.c |   2 +-
 sound/firewire/bebob/bebob_maudio.c  | 585 ++++++++++++++++++++++++++++++++++-
 sound/firewire/bebob/bebob_stream.c  |  32 +-
 6 files changed, 635 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index f9aa176..b719ecf 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -115,6 +115,7 @@ config SND_BEBOB
 	  * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
 	  * M-Audio Firewire410/AudioPhile/Solo
 	  * M-Audio Ozonic/NRV10/ProfireLightBridge
+	  * M-Audio Firewire 1814/ProjectMix IO
 
           To compile this driver as a module, choose M here: the module
           will be called snd-bebob.
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index c4eb7b1..b745ddc 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -60,6 +60,8 @@ static DECLARE_BITMAP(devices_used, SNDRV_CARDS);
 
 #define MODEL_FOCUSRITE_SAFFIRE_BOTH	0x00000000
 #define MODEL_MAUDIO_AUDIOPHILE_BOTH	0x00010060
+#define MODEL_MAUDIO_FW1814		0x00010071
+#define MODEL_MAUDIO_PROJECTMIX		0x00010091
 
 static int
 name_device(struct snd_bebob *bebob, unsigned int vendor_id)
@@ -211,7 +213,14 @@ bebob_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	err = snd_bebob_stream_discover(bebob);
+	if ((entry->vendor_id == VEN_MAUDIO1) &&
+	    (entry->model_id == MODEL_MAUDIO_FW1814))
+		err = snd_bebob_maudio_special_discover(bebob, true);
+	else if ((entry->vendor_id == VEN_MAUDIO1) &&
+		 (entry->model_id == MODEL_MAUDIO_PROJECTMIX))
+		err = snd_bebob_maudio_special_discover(bebob, false);
+	else
+		err = snd_bebob_stream_discover(bebob);
 	if (err < 0)
 		goto error;
 
@@ -269,6 +278,8 @@ static void bebob_remove(struct fw_unit *unit)
 	if (bebob == NULL)
 		return;
 
+	kfree(bebob->maudio_special_quirk);
+
 	snd_bebob_stream_destroy_duplex(bebob);
 	snd_card_disconnect(bebob->card);
 	snd_card_free_when_closed(bebob->card);
@@ -374,6 +385,12 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010081, &maudio_nrv10_spec),
 	/* M-Audio, ProFireLightbridge */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x000100a1, &spec_normal),
+	/* Firewire 1814 */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_FW1814,
+			    &maudio_special_spec),
+	/* M-Audio ProjectMix */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_PROJECTMIX,
+			    &maudio_special_spec),
 	/* IDs are unknown but able to be supported */
 	/*  Apogee, Mini-ME Firewire */
 	/*  Apogee, Mini-DAC Firewire */
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 2e99baf..057c9d4 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -102,6 +102,9 @@ struct snd_bebob {
 	int dev_lock_count;
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
+
+	/* for M-Audio special devices */
+	void *maudio_special_quirk;
 };
 
 static inline int
@@ -237,6 +240,8 @@ extern struct snd_bebob_spec maudio_audiophile_spec;
 extern struct snd_bebob_spec maudio_solo_spec;
 extern struct snd_bebob_spec maudio_ozonic_spec;
 extern struct snd_bebob_spec maudio_nrv10_spec;
+extern struct snd_bebob_spec maudio_special_spec;
+int snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814);
 
 #define SND_BEBOB_DEV_ENTRY(vendor, model, data) \
 { \
diff --git a/sound/firewire/bebob/bebob_command.c b/sound/firewire/bebob/bebob_command.c
index 88c1ac7..0216d50 100644
--- a/sound/firewire/bebob/bebob_command.c
+++ b/sound/firewire/bebob/bebob_command.c
@@ -46,7 +46,7 @@ int avc_audio_set_selector(struct fw_unit *unit, unsigned int subunit_id,
 }
 
 int avc_audio_get_selector(struct fw_unit *unit, unsigned int subunit_id,
-			   unsigned int fb_id, unsigned int *num, bool quiet)
+			   unsigned int fb_id, unsigned int *num)
 {
 	u8 *buf;
 	int err;
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index fbbe8d4..56d4f17 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -7,9 +7,10 @@
  */
 
 #include "./bebob.h"
+#include <sound/control.h>
 
 /*
- * Just powering on, Firewire 410/Audiophile wait to
+ * Just powering on, Firewire 410/Audiophile/1814 and ProjectMix I/O wait to
  * download firmware blob. To enable these devices, drivers should upload
  * firmware blob and send a command to initialize configuration to factory
  * settings when completing uploading. Then these devices generate bus reset
@@ -22,6 +23,12 @@
  * Without streaming, the devices except for Firewire Audiophile can mix any
  * input and output. For this reason, Audiophile cannot be used as standalone
  * mixer.
+ *
+ * Firewire 1814 and ProjectMix I/O uses special firmware. It will be freezed
+ * when receiving any commands which the firmware can't understand. These
+ * devices utilize completely different system to control. It is some
+ * write-transaction directly into a certain address. All of addresses for mixer
+ * functionality is between 0xffc700700000 to 0xffc70070009c.
  */
 
 #define MAUDIO_SPECIFIC_ADDRESS	0xffc700000000
@@ -29,6 +36,7 @@
 #define METER_OFFSET		0x00600000
 
 /* some device has sync info after metering data */
+#define METER_SIZE_SPECIAL	84	/* with sync info */
 #define METER_SIZE_FW410	76	/* with sync info */
 #define METER_SIZE_AUDIOPHILE	60	/* with sync info */
 #define METER_SIZE_SOLO		52	/* with sync info */
@@ -50,6 +58,15 @@
 /* for NRV */
 #define UNKNOWN_METER	"Unknown"
 
+struct special_params {
+	bool is1814;
+	unsigned int clk_src;
+	unsigned int dig_in_fmt;
+	unsigned int dig_out_fmt;
+	unsigned int clk_lock;
+	struct snd_ctl_elem_id *ctl_id_sync;
+};
+
 static inline int
 get_meter(struct snd_bebob *bebob, void *buf, unsigned int size)
 {
@@ -58,6 +75,551 @@ get_meter(struct snd_bebob *bebob, void *buf, unsigned int size)
 				  buf, size, 0);
 }
 
+static int
+check_clk_sync(struct snd_bebob *bebob, unsigned int size, bool *sync)
+{
+	int err;
+	u8 *buf;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	err = get_meter(bebob, buf, size);
+	if (err < 0)
+		goto end;
+
+	/* if synced, this value is the same of SFC of FDF in CIP header */
+	*sync = (buf[size - 2] != 0xff);
+end:
+	kfree(buf);
+	return err;
+}
+
+/*
+ * dig_fmt: 0x00:S/PDIF, 0x01:ADAT
+ * clk_lock: 0x00:unlock, 0x01:lock
+ */
+static int
+avc_maudio_set_special_clk(struct snd_bebob *bebob, unsigned int clk_src,
+			   unsigned int dig_in_fmt, unsigned int dig_out_fmt,
+			   unsigned int clk_lock)
+{
+	struct special_params *params = bebob->maudio_special_quirk;
+	int err;
+	u8 *buf;
+
+	if (amdtp_stream_running(&bebob->rx_stream) ||
+	    amdtp_stream_running(&bebob->tx_stream))
+		return -EBUSY;
+
+	buf = kmalloc(12, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0]  = 0x00;		/* CONTROL */
+	buf[1]  = 0xff;		/* UNIT */
+	buf[2]  = 0x00;		/* vendor dependent */
+	buf[3]  = 0x04;		/* company ID high */
+	buf[4]  = 0x00;		/* company ID middle */
+	buf[5]  = 0x04;		/* company ID low */
+	buf[6]  = 0xff & clk_src;	/* clock source */
+	buf[7]  = 0xff & dig_in_fmt;	/* input digital format */
+	buf[8]  = 0xff & dig_out_fmt;	/* output digital format */
+	buf[9]  = 0xff & clk_lock;	/* lock these settings */
+	buf[10] = 0x00;		/* padding  */
+	buf[11] = 0x00;		/* padding */
+
+	/* do transaction and check buf[1-9] are the same against command */
+	err = fcp_avc_transaction(bebob->unit, buf, 12, buf, 12,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) |
+				  BIT(5) | BIT(6) | BIT(7) | BIT(8) |
+				  BIT(9));
+	if ((err > 0) && (err < 10))
+		err = -EIO;
+	else if (buf[0] == 0x08) /* NOT IMPLEMENTED */
+		err = -ENOSYS;
+	else if (buf[0] == 0x0a) /* REJECTED */
+		err = -EINVAL;
+	if (err < 0)
+		goto end;
+
+	params->clk_src		= buf[6];
+	params->dig_in_fmt	= buf[7];
+	params->dig_out_fmt	= buf[8];
+	params->clk_lock	= buf[9];
+
+	if (params->ctl_id_sync)
+		snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       params->ctl_id_sync);
+
+	err = 0;
+end:
+	kfree(buf);
+	return err;
+}
+static void
+special_stream_formation_set(struct snd_bebob *bebob)
+{
+	struct special_params *params = bebob->maudio_special_quirk;
+	unsigned int i;
+
+	/*
+	 * the stream formation is different depending on digital interface
+	 */
+	if (params->dig_in_fmt == 0x01) {
+		bebob->tx_stream_formations[1].pcm = 16;
+		bebob->tx_stream_formations[2].pcm = 16;
+		bebob->tx_stream_formations[3].pcm = 12;
+		bebob->tx_stream_formations[4].pcm = 12;
+		if (params->is1814) {
+			bebob->tx_stream_formations[5].pcm = 2;
+			bebob->tx_stream_formations[6].pcm = 2;
+		}
+	} else {
+		bebob->tx_stream_formations[1].pcm = 10;
+		bebob->tx_stream_formations[2].pcm = 10;
+		bebob->tx_stream_formations[3].pcm = 10;
+		bebob->tx_stream_formations[4].pcm = 10;
+		if (params->is1814) {
+			bebob->tx_stream_formations[5].pcm = 2;
+			bebob->tx_stream_formations[6].pcm = 2;
+		}
+	}
+
+	if (params->dig_out_fmt == 0x01) {
+		bebob->rx_stream_formations[1].pcm = 12;
+		bebob->rx_stream_formations[2].pcm = 12;
+		bebob->rx_stream_formations[3].pcm = 8;
+		bebob->rx_stream_formations[4].pcm = 8;
+		if (params->is1814) {
+			bebob->rx_stream_formations[5].pcm = 4;
+			bebob->rx_stream_formations[6].pcm = 4;
+		}
+	} else {
+		bebob->rx_stream_formations[1].pcm = 6;
+		bebob->rx_stream_formations[2].pcm = 6;
+		bebob->rx_stream_formations[3].pcm = 6;
+		bebob->rx_stream_formations[4].pcm = 6;
+		if (params->is1814) {
+			bebob->rx_stream_formations[5].pcm = 4;
+			bebob->rx_stream_formations[6].pcm = 4;
+		}
+	}
+
+	for (i = 0; i < SND_BEBOB_STRM_FMT_ENTRIES; i++) {
+		bebob->tx_stream_formations[i].midi = 1;
+		bebob->rx_stream_formations[i].midi = 1;
+		if ((i > 4) && !params->is1814)
+			break;
+	}
+}
+
+static int add_special_controls(struct snd_bebob *bebob);
+int
+snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814)
+{
+	struct special_params *params;
+	int err;
+
+	params = kmalloc(sizeof(struct special_params), GFP_KERNEL);
+	if (params == NULL)
+		return -ENOMEM;
+
+	mutex_lock(&bebob->mutex);
+
+	bebob->maudio_special_quirk = (void *)params;
+	params->is1814 = is1814;
+
+	/* initialize these parameters because driver is not allowed to ask */
+	bebob->rx_stream.context = ERR_PTR(-1);
+	bebob->tx_stream.context = ERR_PTR(-1);
+	err = avc_maudio_set_special_clk(bebob, 0x03, 0x00, 0x00, 0x00);
+	if (err < 0) {
+		dev_err(&bebob->unit->device,
+			"failed to initialize clock params: %d\n", err);
+		goto end;
+	}
+
+	err = add_special_controls(bebob);
+	if (err < 0)
+		goto end;
+
+	special_stream_formation_set(bebob);
+
+	if (params->is1814) {
+		bebob->midi_input_ports = 1;
+		bebob->midi_output_ports = 1;
+	} else {
+		bebob->midi_input_ports = 2;
+		bebob->midi_output_ports = 2;
+	}
+end:
+	if (err < 0) {
+		kfree(params);
+		bebob->maudio_special_quirk = NULL;
+	}
+	mutex_unlock(&bebob->mutex);
+	return err;
+}
+
+/* Input plug shows actual rate. Output plug is needless for this purpose. */
+static int special_get_rate(struct snd_bebob *bebob, unsigned int *rate)
+{
+	int err, trials;
+
+	trials = 0;
+	do {
+		err = avc_general_get_sig_fmt(bebob->unit, rate,
+					      AVC_GENERAL_PLUG_DIR_IN, 0);
+	} while (err == -EAGAIN && ++trials < 3);
+	if (err < 0)
+		dev_err(&bebob->unit->device,
+			"failed to get sampling rate: %d\n", err);
+
+	return err;
+}
+static int special_set_rate(struct snd_bebob *bebob, unsigned int rate)
+{
+	struct special_params *params = bebob->maudio_special_quirk;
+	int err;
+
+	err = avc_general_set_sig_fmt(bebob->unit, rate,
+				      AVC_GENERAL_PLUG_DIR_OUT, 0);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * Just after changing sampling rate for output, a followed command
+	 * for input is easy to fail. This is a workaround fot this issue.
+	 */
+	msleep(100);
+
+	err = avc_general_set_sig_fmt(bebob->unit, rate,
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	if (err < 0)
+		goto end;
+
+	if (params->ctl_id_sync)
+		snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       params->ctl_id_sync);
+end:
+	if (err < 0)
+		dev_err(&bebob->unit->device,
+			"failed to set sampling rate: %d\n", err);
+	return err;
+}
+
+/* Clock source control for special firmware */
+static char *special_clk_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL " with Digital Mute", "Digital",
+	"Word Clock", SND_BEBOB_CLOCK_INTERNAL};
+static int special_clk_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	struct special_params *params = bebob->maudio_special_quirk;
+	*id = params->clk_src;
+	return 0;
+}
+static int special_clk_ctl_info(struct snd_kcontrol *kctl,
+				struct snd_ctl_elem_info *einf)
+{
+	einf->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	einf->count = 1;
+	einf->value.enumerated.items = ARRAY_SIZE(special_clk_labels);
+
+	if (einf->value.enumerated.item >= einf->value.enumerated.items)
+		einf->value.enumerated.item = einf->value.enumerated.items - 1;
+
+	strcpy(einf->value.enumerated.name,
+	       special_clk_labels[einf->value.enumerated.item]);
+
+	return 0;
+}
+static int special_clk_ctl_get(struct snd_kcontrol *kctl,
+			       struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct special_params *params = bebob->maudio_special_quirk;
+	uval->value.enumerated.item[0] = params->clk_src;
+	return 0;
+}
+static int special_clk_ctl_put(struct snd_kcontrol *kctl,
+			       struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct special_params *params = bebob->maudio_special_quirk;
+	int err, id;
+
+	mutex_lock(&bebob->mutex);
+
+	id = uval->value.enumerated.item[0];
+	if (id >= ARRAY_SIZE(special_clk_labels))
+		return 0;
+
+	err = avc_maudio_set_special_clk(bebob, id,
+					 params->dig_in_fmt,
+					 params->dig_out_fmt,
+					 params->clk_lock);
+	mutex_unlock(&bebob->mutex);
+
+	return err >= 0;
+}
+static struct snd_kcontrol_new special_clk_ctl = {
+	.name	= "Clock Source",
+	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access	= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info	= special_clk_ctl_info,
+	.get	= special_clk_ctl_get,
+	.put	= special_clk_ctl_put
+};
+
+/* Clock synchronization control for special firmware */
+static int special_sync_ctl_info(struct snd_kcontrol *kctl,
+				 struct snd_ctl_elem_info *einf)
+{
+	einf->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	einf->count = 1;
+	einf->value.integer.min = 0;
+	einf->value.integer.max = 1;
+
+	return 0;
+}
+static int special_sync_ctl_get(struct snd_kcontrol *kctl,
+				struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	int err;
+	bool synced = 0;
+
+	err = check_clk_sync(bebob, METER_SIZE_SPECIAL, &synced);
+	if (err >= 0)
+		uval->value.integer.value[0] = synced;
+
+	return 0;
+}
+static struct snd_kcontrol_new special_sync_ctl = {
+	.name	= "Sync Status",
+	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access	= SNDRV_CTL_ELEM_ACCESS_READ,
+	.info	= special_sync_ctl_info,
+	.get	= special_sync_ctl_get,
+};
+
+/* Digital interface control for special firmware */
+static char *special_dig_iface_labels[] = {
+	"S/PDIF Optical", "S/PDIF Coaxial", "ADAT Optical"
+};
+static int special_dig_in_iface_ctl_info(struct snd_kcontrol *kctl,
+					 struct snd_ctl_elem_info *einf)
+{
+	einf->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	einf->count = 1;
+	einf->value.enumerated.items = ARRAY_SIZE(special_dig_iface_labels);
+
+	if (einf->value.enumerated.item >= einf->value.enumerated.items)
+		einf->value.enumerated.item = einf->value.enumerated.items - 1;
+
+	strcpy(einf->value.enumerated.name,
+	       special_dig_iface_labels[einf->value.enumerated.item]);
+
+	return 0;
+}
+static int special_dig_in_iface_ctl_get(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct special_params *params = bebob->maudio_special_quirk;
+	unsigned int dig_in_iface;
+	int err, val;
+
+	mutex_lock(&bebob->mutex);
+
+	err = avc_audio_get_selector(bebob->unit, 0x00, 0x04,
+				     &dig_in_iface);
+	if (err < 0) {
+		dev_err(&bebob->unit->device,
+			"failed to get digital input interface: %d\n", err);
+		goto end;
+	}
+
+	/* encoded id for user value */
+	val = (params->dig_in_fmt << 1) | (dig_in_iface & 0x01);
+
+	/* for ADAT Optical */
+	if (val > 2)
+		val = 2;
+
+	uval->value.enumerated.item[0] = val;
+end:
+	mutex_unlock(&bebob->mutex);
+	return err;
+}
+static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct special_params *params = bebob->maudio_special_quirk;
+	unsigned int id, dig_in_fmt, dig_in_iface;
+	int err;
+
+	mutex_lock(&bebob->mutex);
+
+	id = uval->value.enumerated.item[0];
+
+	/* decode user value */
+	dig_in_fmt = (id >> 1) & 0x01;
+	dig_in_iface = id & 0x01;
+
+	err = avc_maudio_set_special_clk(bebob,
+					 params->clk_src,
+					 dig_in_fmt,
+					 params->dig_out_fmt,
+					 params->clk_lock);
+	if ((err < 0) || (params->dig_in_fmt > 0)) /* ADAT */
+		goto end;
+
+	err = avc_audio_set_selector(bebob->unit, 0x00, 0x04, dig_in_iface);
+	if (err < 0)
+		dev_err(&bebob->unit->device,
+			"failed to set digital input interface: %d\n", err);
+end:
+	special_stream_formation_set(bebob);
+	mutex_unlock(&bebob->mutex);
+	return err;
+}
+static struct snd_kcontrol_new special_dig_in_iface_ctl = {
+	.name	= "Digital Input Interface",
+	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access	= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info	= special_dig_in_iface_ctl_info,
+	.get	= special_dig_in_iface_ctl_get,
+	.put	= special_dig_in_iface_ctl_set
+};
+
+static int special_dig_out_iface_ctl_info(struct snd_kcontrol *kctl,
+					  struct snd_ctl_elem_info *einf)
+{
+	einf->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	einf->count = 1;
+	einf->value.enumerated.items = ARRAY_SIZE(special_dig_iface_labels) - 1;
+
+	if (einf->value.enumerated.item >= einf->value.enumerated.items)
+		einf->value.enumerated.item = einf->value.enumerated.items - 1;
+
+	strcpy(einf->value.enumerated.name,
+	       special_dig_iface_labels[einf->value.enumerated.item + 1]);
+
+	return 0;
+}
+static int special_dig_out_iface_ctl_get(struct snd_kcontrol *kctl,
+					 struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct special_params *params = bebob->maudio_special_quirk;
+	mutex_lock(&bebob->mutex);
+	uval->value.enumerated.item[0] = params->dig_out_fmt;
+	mutex_unlock(&bebob->mutex);
+	return 0;
+}
+static int special_dig_out_iface_ctl_set(struct snd_kcontrol *kctl,
+					 struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	struct special_params *params = bebob->maudio_special_quirk;
+	unsigned int id;
+	int err;
+
+	mutex_lock(&bebob->mutex);
+
+	id = uval->value.enumerated.item[0];
+
+	err = avc_maudio_set_special_clk(bebob,
+					 params->clk_src,
+					 params->dig_in_fmt,
+					 id, params->clk_lock);
+	if (err >= 0)
+		special_stream_formation_set(bebob);
+
+	mutex_unlock(&bebob->mutex);
+	return err;
+}
+static struct snd_kcontrol_new special_dig_out_iface_ctl = {
+	.name	= "Digital Output Interface",
+	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access	= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info	= special_dig_out_iface_ctl_info,
+	.get	= special_dig_out_iface_ctl_get,
+	.put	= special_dig_out_iface_ctl_set
+};
+
+static int add_special_controls(struct snd_bebob *bebob)
+{
+	struct snd_kcontrol *kctl;
+	struct special_params *params = bebob->maudio_special_quirk;
+	int err;
+
+	kctl = snd_ctl_new1(&special_clk_ctl, bebob);
+	err = snd_ctl_add(bebob->card, kctl);
+	if (err < 0)
+		goto end;
+
+	kctl = snd_ctl_new1(&special_sync_ctl, bebob);
+	err = snd_ctl_add(bebob->card, kctl);
+	if (err < 0)
+		goto end;
+	params->ctl_id_sync = &kctl->id;
+
+	kctl = snd_ctl_new1(&special_dig_in_iface_ctl, bebob);
+	err = snd_ctl_add(bebob->card, kctl);
+	if (err < 0)
+		goto end;
+
+	kctl = snd_ctl_new1(&special_dig_out_iface_ctl, bebob);
+	err = snd_ctl_add(bebob->card, kctl);
+end:
+	return err;
+}
+
+/* Hardware metering for special firmware */
+static char *special_meter_labels[] = {
+	ANA_IN, ANA_IN, ANA_IN, ANA_IN,
+	SPDIF_IN,
+	ADAT_IN, ADAT_IN, ADAT_IN, ADAT_IN,
+	ANA_OUT, ANA_OUT,
+	SPDIF_OUT,
+	ADAT_OUT, ADAT_OUT, ADAT_OUT, ADAT_OUT,
+	HP_OUT, HP_OUT,
+	AUX_OUT
+};
+static int
+special_meter_get(struct snd_bebob *bebob, u32 *target, unsigned int size)
+{
+	u16 *buf;
+	unsigned int i, c, channels;
+	int err;
+
+	channels = ARRAY_SIZE(special_meter_labels) * 2;
+	if (size < channels * sizeof(u32))
+		return -EINVAL;
+
+	/* omit last 4 bytes because it's clock info. */
+	buf = kmalloc(METER_SIZE_SPECIAL - 4, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	err = get_meter(bebob, (void *)buf, METER_SIZE_SPECIAL - 4);
+	if (err < 0)
+		goto end;
+
+	/* Its format is u16 and some channels are unknown. */
+	i = 0;
+	for (c = 2; c < channels + 2; c++)
+		target[i++] = be16_to_cpu(buf[c]) << 16;
+end:
+	kfree(buf);
+	return err;
+}
+
 /* last 4 bytes are omitted because it's clock info. */
 static char *fw410_meter_labels[] = {
 	ANA_IN, DIG_IN,
@@ -115,6 +677,27 @@ end:
 	return err;
 }
 
+/* for special customized devices */
+static struct snd_bebob_rate_spec special_rate_spec = {
+	.get	= &special_get_rate,
+	.set	= &special_set_rate,
+};
+static struct snd_bebob_clock_spec special_clk_spec = {
+	.num	= ARRAY_SIZE(special_clk_labels),
+	.labels	= special_clk_labels,
+	.get	= &special_clk_get,
+};
+static struct snd_bebob_meter_spec special_meter_spec = {
+	.num	= ARRAY_SIZE(special_meter_labels),
+	.labels	= special_meter_labels,
+	.get	= &special_meter_get
+};
+struct snd_bebob_spec maudio_special_spec = {
+	.clock	= &special_clk_spec,
+	.rate	= &special_rate_spec,
+	.meter	= &special_meter_spec
+};
+
 /* Firewire 410 specification */
 static struct snd_bebob_rate_spec usual_rate_spec = {
 	.get	= &snd_bebob_stream_get_rate,
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index b64f65e..95d82f4 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -406,9 +406,11 @@ start_stream(struct snd_bebob *bebob, struct amdtp_stream *stream,
 		conn = &bebob->out_conn;
 
 	/* channel mapping */
-	err = map_data_channels(bebob, stream);
-	if (err < 0)
-		goto end;
+	if (bebob->maudio_special_quirk == NULL) {
+		err = map_data_channels(bebob, stream);
+		if (err < 0)
+			goto end;
+	}
 
 	/* start amdtp stream */
 	err = amdtp_stream_start(stream,
@@ -523,10 +525,14 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 		 * NOTE:
 		 * If establishing connections at first, Yamaha GO46
 		 * (and maybe Terratec X24) don't generate sound.
+		 *
+		 * For firmware customized by M-Audio, refer to next NOTE.
 		 */
-		err = rate_spec->set(bebob, rate);
-		if (err < 0)
-			goto end;
+		if (bebob->maudio_special_quirk == NULL) {
+			err = rate_spec->set(bebob, rate);
+			if (err < 0)
+				goto end;
+		}
 
 		err = make_both_connections(bebob, rate);
 		if (err < 0)
@@ -540,6 +546,20 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 			goto end;
 		}
 
+		/*
+		 * NOTE:
+		 * The firmware customized by M-Audio uses these commands to
+		 * start transmitting stream. This is not usual way.
+		 */
+		if (bebob->maudio_special_quirk != NULL) {
+			err = rate_spec->set(bebob, rate);
+			if (err < 0) {
+				amdtp_stream_stop(master);
+				break_both_connections(bebob);
+				goto end;
+			}
+		}
+
 		/* wait first callback */
 		if (!amdtp_stream_wait_callback(master, CALLBACK_TIMEOUT)) {
 			amdtp_stream_stop(master);
-- 
1.8.3.2


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
