From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 37/38] bebob: Add support for M-Audio special Firewire series
Date: Fri, 20 Dec 2013 22:14:28 +0900
Message-ID: <1387545269-3875-38-git-send-email-o-takashi@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
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
them. For this reason, this commit adds some model specific members in 'struct
snd_bebob' and model specific functions. Some parameters are write-only so this
commit also adds control interface for them.

M-Audio special firmware quirks:
 - Just after powering on, they wait to download firmware. This state is
   changed when receiving cue. Then bus reset is generated and the device is
   recognized as a different model with the uploaded firmware.
 - They don't respond against BridgeCo AV/C extension commands. So drivers
   can't get their stream formations and so on.
 - They do not start to transmit packets only by establishing connection but
   also by receiving SIGNAL FORMAT command.
 - They can't handle frequent transactions. In this reason, this driver often
   fail to handle them.

This module don't support to upload firmware.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig              |   1 +
 sound/firewire/bebob/bebob.c        |  17 +-
 sound/firewire/bebob/bebob.h        |  13 +
 sound/firewire/bebob/bebob_maudio.c | 492 +++++++++++++++++++++++++++++++++++-
 sound/firewire/bebob/bebob_stream.c |  22 +-
 5 files changed, 539 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index d71faf6..1149997 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -111,6 +111,7 @@ config SND_BEBOB
 	  * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
 	  * M-Audio Firewire410/AudioPhile/Solo
 	  * M-Audio Ozonic/NRV10/ProfireLightBridge
+	  * M-Audio Firewire 1814/ProjectMix IO
 
           To compile this driver as a module, choose M here: the module
           will be called snd-bebob.
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 65554ef..65e856e 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -60,6 +60,8 @@ static unsigned int devices_used;
 
 #define MODEL_FOCUSRITE_SAFFIRE_BOTH	0x00000000
 #define MODEL_MAUDIO_AUDIOPHILE_BOTH	0x00010060
+#define MODEL_MAUDIO_FW1814		0x00010071
+#define MODEL_MAUDIO_PROJECTMIX		0x00010091
 
 static int
 name_device(struct snd_bebob *bebob, unsigned int vendor_id)
@@ -212,7 +214,14 @@ bebob_probe(struct fw_unit *unit,
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
 
@@ -370,6 +379,12 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010081, &maudio_nrv10_spec),
 	/* M-Audio, ProFireLightbridge */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x000100a1, &spec_normal),
+	/* Firewire 1814 */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_FW1814,
+			    &maudio_special_spec),
+	/* M-Audio ProjectMix */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_PROJECTMIX,
+			    &maudio_special_spec),
 	/* Ids are unknown but able to be supported */
 	/*  Mackie, Digital X Bus x.200 */
 	/*  Mackie, Digital X Bus x.400 */
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index c67d5e5..c65e7b3 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -100,6 +100,16 @@ struct snd_bebob {
 	int dev_lock_count;
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
+
+	/* for M-Audio special devices */
+	bool maudio_special_quirk;
+	bool maudio_is1814;
+	unsigned int clk_src;
+	unsigned int dig_in_iface;
+	unsigned int dig_in_fmt;
+	unsigned int dig_out_fmt;
+	unsigned int clk_lock;
+	struct snd_ctl_elem_id *ctl_id_sync;
 };
 
 static inline int
@@ -241,6 +251,9 @@ extern struct snd_bebob_spec maudio_solo_spec;
 extern struct snd_bebob_spec maudio_ozonic_spec;
 extern struct snd_bebob_spec maudio_nrv10_spec;
 
+extern struct snd_bebob_spec maudio_special_spec;
+int snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model, data) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 715cf34..b941042 100644
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
@@ -79,7 +87,466 @@ end:
 	return err;
 }
 
-/* Firewire 410 specific operation */
+/*
+ * dig_fmt: 0x00:S/PDIF, 0x01:ADAT
+ * clk_lock: 0x00:unlock, 0x01:lock
+ */
+static int
+special_clk_set_params(struct snd_bebob *bebob, unsigned int clk_src,
+		       unsigned int dig_in_fmt, unsigned int dig_out_fmt,
+		       unsigned int clk_lock)
+{
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
+	if (err < 0)
+		goto end;
+	if ((err < 6) || (buf[0] != 0x09)) {
+		dev_err(&bebob->unit->device,
+			"failed to set clock params\n");
+		err = -EIO;
+		goto end;
+	}
+
+	bebob->clk_src		= buf[6];
+	bebob->dig_in_fmt	= buf[7];
+	bebob->dig_out_fmt	= buf[8];
+	bebob->clk_lock		= buf[9];
+
+	snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
+		       bebob->ctl_id_sync);
+end:
+	kfree(buf);
+	return err;
+}
+static void
+special_stream_formation_set(struct snd_bebob *bebob)
+{
+	unsigned int i;
+
+	/*
+	 * the stream formation is different depending on digital interface
+	 */
+	if (bebob->dig_in_fmt == 0x01) {
+		bebob->tx_stream_formations[3].pcm = 16;
+		bebob->tx_stream_formations[4].pcm = 16;
+		bebob->tx_stream_formations[5].pcm = 12;
+		bebob->tx_stream_formations[6].pcm = 12;
+		if (bebob->maudio_is1814) {
+			bebob->tx_stream_formations[7].pcm = 2;
+			bebob->tx_stream_formations[8].pcm = 2;
+		}
+	} else {
+		bebob->tx_stream_formations[3].pcm = 10;
+		bebob->tx_stream_formations[4].pcm = 10;
+		bebob->tx_stream_formations[5].pcm = 10;
+		bebob->tx_stream_formations[6].pcm = 10;
+		if (bebob->maudio_is1814) {
+			bebob->tx_stream_formations[7].pcm = 2;
+			bebob->tx_stream_formations[8].pcm = 2;
+		}
+	}
+
+	if (bebob->dig_out_fmt == 0x01) {
+		bebob->rx_stream_formations[3].pcm = 12;
+		bebob->rx_stream_formations[4].pcm = 12;
+		bebob->rx_stream_formations[5].pcm = 8;
+		bebob->rx_stream_formations[6].pcm = 8;
+		if (bebob->maudio_is1814) {
+			bebob->rx_stream_formations[7].pcm = 4;
+			bebob->rx_stream_formations[8].pcm = 4;
+		}
+	} else {
+		bebob->rx_stream_formations[3].pcm = 6;
+		bebob->rx_stream_formations[4].pcm = 6;
+		bebob->rx_stream_formations[5].pcm = 6;
+		bebob->rx_stream_formations[6].pcm = 6;
+		if (bebob->maudio_is1814) {
+			bebob->rx_stream_formations[7].pcm = 4;
+			bebob->rx_stream_formations[8].pcm = 4;
+		}
+	}
+
+	for (i = 3; i < SND_BEBOB_STRM_FMT_ENTRIES; i++) {
+		bebob->tx_stream_formations[i].midi = 1;
+		bebob->rx_stream_formations[i].midi = 1;
+		if ((i > 7) && !bebob->maudio_is1814)
+			break;
+	}
+}
+
+static int snd_bebob_maudio_special_add_controls(struct snd_bebob *bebob);
+int
+snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814)
+{
+	int err;
+
+	bebob->maudio_is1814 = is1814;
+
+	/* initialize these parameters because driver is not allowed to ask */
+	err = special_clk_set_params(bebob, 0x03, 0x00, 0x00, 0x00);
+	if (err < 0)
+		dev_err(&bebob->unit->device,
+			"failed to initialize clock params\n");
+
+	err = avc_audio_get_selector(bebob->unit, 0x00, 0x04,
+				     &bebob->dig_in_iface);
+	if (err < 0)
+		dev_err(&bebob->unit->device,
+			"failed to get current dig iface.");
+
+	err = snd_bebob_maudio_special_add_controls(bebob);
+	if (err < 0)
+		return -EIO;
+
+	special_stream_formation_set(bebob);
+
+	if (bebob->maudio_is1814) {
+		bebob->midi_input_ports = 1;
+		bebob->midi_output_ports = 1;
+	} else {
+		bebob->midi_input_ports = 2;
+		bebob->midi_output_ports = 2;
+	}
+
+	bebob->maudio_special_quirk = true;
+
+	return 0;
+}
+
+/* Input plug shows actual rate. Output plug is needless for this purpose. */
+static int special_get_rate(struct snd_bebob *bebob, unsigned int *rate)
+{
+	return snd_bebob_get_rate(bebob, rate, AVC_GENERAL_PLUG_DIR_IN);
+}
+static int special_set_rate(struct snd_bebob *bebob, unsigned int rate)
+{
+	int err = snd_bebob_set_rate(bebob, rate, AVC_GENERAL_PLUG_DIR_OUT);
+	msleep(100);
+	if (err < 0)
+		goto end;
+
+	err = snd_bebob_set_rate(bebob, rate, AVC_GENERAL_PLUG_DIR_IN);
+	msleep(100);
+	if (err >= 0)
+		snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       bebob->ctl_id_sync);
+end:
+	return err;
+}
+
+/* Clock source control for special firmware */
+static char *special_clk_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL " with Digital Mute", "Digital",
+	"Word Clock", SND_BEBOB_CLOCK_INTERNAL};
+static int special_clk_get(struct snd_bebob *bebob,
+			   unsigned int *id)
+{
+	*id = bebob->clk_src;
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
+
+	spin_lock(&bebob->lock);
+	uval->value.enumerated.item[0] = bebob->clk_src;
+	spin_unlock(&bebob->lock);
+
+	return 0;
+}
+static int special_clk_ctl_put(struct snd_kcontrol *kctl,
+			       struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	int err, id, changed = 0;
+
+	id = uval->value.enumerated.item[0];
+	if (id >= ARRAY_SIZE(special_clk_labels))
+		return 0;
+
+	spin_lock(&bebob->lock);
+	err = special_clk_set_params(bebob, id,
+				     bebob->dig_in_fmt,
+				     bebob->dig_out_fmt,
+				     bebob->clk_lock);
+	changed = (err >= 0);
+	spin_unlock(&bebob->lock);
+
+	return changed;
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
+	mutex_lock(&bebob->mutex);
+	err = check_clk_sync(bebob, METER_SIZE_SPECIAL, &synced);
+	if (err >= 0)
+		uval->value.integer.value[0] = synced;
+	mutex_unlock(&bebob->mutex);
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
+	int val;
+
+	/* encoded id for user value */
+	val = (bebob->dig_in_fmt << 1) | (bebob->dig_in_iface & 0x01);
+
+	/* for ADAT Optical */
+	if (val > 2)
+		val = 2;
+
+	uval->value.enumerated.item[0] = val;
+
+	return 0;
+}
+static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	unsigned int id, dig_in_fmt, dig_in_iface;
+	int err;
+
+	id = uval->value.enumerated.item[0];
+
+	/* decode user value */
+	dig_in_fmt = (id >> 1) & 0x01;
+	dig_in_iface = id & 0x01;
+
+	err = special_clk_set_params(bebob, bebob->clk_src, dig_in_fmt,
+				     bebob->dig_out_fmt, bebob->clk_lock);
+	if ((err < 0) || (bebob->dig_in_fmt > 0)) /* ADAT */
+		goto end;
+
+	err = avc_audio_set_selector(bebob->unit, 0x00, 0x04, dig_in_iface);
+	if (err < 0)
+		goto end;
+
+	bebob->dig_in_iface = dig_in_iface;
+end:
+	special_stream_formation_set(bebob);
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
+	uval->value.enumerated.item[0] = bebob->dig_out_fmt;
+	return 0;
+}
+static int special_dig_out_iface_ctl_set(struct snd_kcontrol *kctl,
+					 struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	unsigned int id;
+	int err;
+
+	id = uval->value.enumerated.item[0];
+
+	err = special_clk_set_params(bebob, bebob->clk_src, bebob->dig_in_fmt,
+				     id, bebob->clk_lock);
+	if (err >= 0)
+		special_stream_formation_set(bebob);
+
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
+static int snd_bebob_maudio_special_add_controls(struct snd_bebob *bebob)
+{
+	struct snd_kcontrol *kctl;
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
+	bebob->ctl_id_sync = &kctl->id;
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
+	/* some channels are not used, and format is u16 */
+	i = 0;
+	for (c = 2; c < channels + 2; c++)
+		target[i++] = be16_to_cpu(buf[c]) << 16;
+end:
+	kfree(buf);
+	return err;
+}
+
+/* Firewire 410 specific operations */
 static char *fw410_meter_labels[] = {
 	ANA_IN, DIG_IN,
 	ANA_OUT, ANA_OUT, ANA_OUT, ANA_OUT, DIG_OUT,
@@ -230,6 +697,27 @@ end:
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
index 5865fed..9a5bd58 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -361,9 +361,11 @@ start_stream(struct snd_bebob *bebob, struct amdtp_stream *stream,
 		conn = &bebob->out_conn;
 
 	/* channel mapping */
-	err = map_stream(bebob, stream);
-	if (err < 0)
-		goto end;
+	if (!bebob->maudio_special_quirk) {
+		err = map_stream(bebob, stream);
+		if (err < 0)
+			goto end;
+	}
 
 	/* start amdtp stream */
 	err = amdtp_stream_start(stream,
@@ -482,6 +484,20 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 			goto end;
 		}
 
+		/*
+		 * NOTE:
+		 * The firmware customized by M-Audio uses this cue to start
+		 * transmit stream. This is not usual way.
+		 */
+		if (bebob->maudio_special_quirk) {
+			err = rate_spec->set(bebob, rate);
+			if (err < 0) {
+				amdtp_stream_stop(master);
+				break_both_connections(bebob);
+				goto end;
+			}
+		}
+
 		/* wait first callback */
 		if (!amdtp_stream_wait_callback(master)) {
 			amdtp_stream_stop(master);
-- 
1.8.3.2


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
