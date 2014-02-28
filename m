From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 39/39] bebob: Add support for M-Audio special
	Firewire series
Date: Fri, 28 Feb 2014 12:27:52 +0900
Message-ID: <1393558072-25926-40-git-send-email-o-takashi@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DCD4265927
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 04:28:47 +0100 (CET)
In-Reply-To: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit allows this driver to support some models which M-Audio produces
with DM1000 but its firmware is special. They are:
 - Firewire 1814
 - ProjectMix I/O

They have heavily customized firmware. The usual operations can't be applied to
them. For this reason, this commit adds a model specific member in 'struct
snd_bebob' and some model specific functions. Some parameters are write-only so
this commit also adds control interface for applications.

M-Audio special firmware quirks:
 - Just after powering on, they wait to download firmware. This state is
   changed when receiving cue. Then bus reset is generated and the device is
   recognized as a different model with the uploaded firmware.
 - They don't respond against BridgeCo AV/C extension commands. So drivers
   can't get their stream formations and so on.
 - They do not start to transmit packets only by establishing connection but
   also by receiving SIGNAL FORMAT command.
 - They often handle requests without responding. In this reason, this driver
   often fail to handle them correctly.

This module don't support to upload firmware.

Here are three examples of transactions between BeBoB driver and M-Audio
Firewire 1814. An fallback at timeout in the operations for CMP was already
added by previous commit. But for isochronous resource management, no fallbacks
are added. Further works are needed for Linux Firewire Subsystem.

At releasing connections/resources for both direction:
[27200.724273] firewire_ohci 0000:0c:06.0: AT spd 2 tl 28, ffc0 -> ffc1, ack_pending , Lk req, fffff0000984 8,2
[27200.724921] firewire_ohci 0000:0c:06.0: AR spd 2 tl 28, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27200.725037] firewire_ohci 0000:0c:06.0: AT spd 0 tl 29, ffc0 -> ffc1, ack_pending , Lk req, fffff0000224 8,2
[27200.725598] firewire_ohci 0000:0c:06.0: AR spd 2 tl 29, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27200.725714] firewire_ohci 0000:0c:06.0: AT spd 0 tl 2a, ffc0 -> ffc1, ack_pending , Lk req, fffff0000220 8,2
[27202.727199] firewire_ohci 0000:0c:06.0: AT spd 0 tl 2b, ffc0 -> ffc1, ack_pending , Lk req, fffff0000220 8,2
[27202.727735] firewire_ohci 0000:0c:06.0: AR spd 2 tl 2b, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27202.727858] firewire_ohci 0000:0c:06.0: AT spd 2 tl 2c, ffc0 -> ffc1, ack_pending , Lk req, fffff0000904 8,2
[27204.750950] firewire_ohci 0000:0c:06.0: AT spd 2 tl 2d, ffc0 -> ffc1, ack_pending , Lk req, fffff0000904 8,2
[27206.777677] firewire_ohci 0000:0c:06.0: AT spd 2 tl 2e, ffc0 -> ffc1, ack_pending , Lk req, fffff0000904 8,2
[27208.779327] snd-bebob fw1.0: transaction failed: timeout
[27208.779333] snd-bebob fw1.0: oPCR0: plug is still connected
(The device handled a first operation for oPCR0 but not respond.)

At releasing connections/resources for both direction:
[27603.200092] firewire_ohci 0000:0c:06.0: AT spd 2 tl 02, ffc0 -> ffc1, ack_pending , Lk req, fffff0000904 8,2
[27603.200455] firewire_ohci 0000:0c:06.0: AR spd 2 tl 02, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27603.200629] firewire_ohci 0000:0c:06.0: AT spd 0 tl 03, ffc0 -> ffc1, ack_pending , Lk req, fffff0000224 8,2
[27605.203315] firewire_ohci 0000:0c:06.0: AT spd 0 tl 04, ffc0 -> ffc1, ack_pending , Lk req, fffff0000224 8,2
[27605.203962] firewire_ohci 0000:0c:06.0: AR spd 2 tl 04, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27605.204077] firewire_ohci 0000:0c:06.0: AT spd 0 tl 05, ffc0 -> ffc1, ack_pending , Lk req, fffff0000220 8,2
[27605.204507] firewire_ohci 0000:0c:06.0: AR spd 2 tl 05, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27605.204569] snd-bebob fw1.0: isochronous resource deallocation failed
(The device handled a first operation for CSR_CHANNELS_AVAILABLE_HI but not respond.)

At keeping resources and establising connections:
[27212.950366] firewire_ohci 0000:0c:06.0: AT spd 0 tl 35, ffc0 -> ffc1, ack_pending , Lk req, fffff0000224 8,2
[27212.950922] firewire_ohci 0000:0c:06.0: AR spd 2 tl 35, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27212.951060] firewire_ohci 0000:0c:06.0: AT spd 0 tl 36, ffc0 -> ffc1, ack_pending , Lk req, fffff0000224 8,2
[27212.951505] firewire_ohci 0000:0c:06.0: AR spd 2 tl 36, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27212.951590] firewire_ohci 0000:0c:06.0: AT spd 0 tl 37, ffc0 -> ffc1, ack_pending , Lk req, fffff0000220 8,2
[27212.952101] firewire_ohci 0000:0c:06.0: AR spd 2 tl 37, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27212.952220] firewire_ohci 0000:0c:06.0: AT spd 2 tl 38, ffc0 -> ffc1, ack_pending , Lk req, fffff0000904 8,2
[27212.952568] firewire_ohci 0000:0c:06.0: AR spd 2 tl 38, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27212.952715] firewire_ohci 0000:0c:06.0: AT spd 2 tl 39, ffc0 -> ffc1, ack_pending , Lk req, fffff0000904 8,2
[27212.953044] firewire_ohci 0000:0c:06.0: AR spd 2 tl 39, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27212.953178] firewire_ohci 0000:0c:06.0: AT spd 0 tl 3a, ffc0 -> ffc1, ack_pending , Lk req, fffff0000224 8,2
[27212.953504] firewire_ohci 0000:0c:06.0: AR spd 2 tl 3a, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27212.953588] firewire_ohci 0000:0c:06.0: AT spd 0 tl 3b, ffc0 -> ffc1, ack_pending , Lk req, fffff0000224 8,2
[27212.954017] firewire_ohci 0000:0c:06.0: AR spd 2 tl 3b, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27212.954077] firewire_ohci 0000:0c:06.0: AT spd 0 tl 3c, ffc0 -> ffc1, ack_pending , Lk req, fffff0000220 8,2
[27212.954364] firewire_ohci 0000:0c:06.0: AR spd 2 tl 3c, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27212.954429] firewire_ohci 0000:0c:06.0: AT spd 2 tl 3d, ffc0 -> ffc1, ack_pending , Lk req, fffff0000984 8,2
[27214.980602] firewire_ohci 0000:0c:06.0: AT spd 2 tl 3e, ffc0 -> ffc1, ack_pending , Lk req, fffff0000984 8,2
[27214.981135] firewire_ohci 0000:0c:06.0: AR spd 2 tl 3e, ffc1 -> ffc0, ack_complete, Lk resp 4,2
[27214.981195] snd-bebob fw1.0: iPCR0: plug is already in use
(The device handled a first operation for iPCR0 but not respond.)

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                |   1 +
 sound/firewire/bebob/bebob.c          |  21 +-
 sound/firewire/bebob/bebob.h          |  10 +-
 sound/firewire/bebob/bebob_command.c  |  16 +-
 sound/firewire/bebob/bebob_maudio.c   | 583 +++++++++++++++++++++++++++++++++-
 sound/firewire/bebob/bebob_stream.c   |  39 ++-
 sound/firewire/bebob/bebob_terratec.c |   6 +-
 sound/firewire/bebob/bebob_yamaha.c   |   2 +-
 8 files changed, 653 insertions(+), 25 deletions(-)

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
index a2104c7..862bd49 100644
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
 
@@ -274,6 +283,9 @@ static void bebob_remove(struct fw_unit *unit)
 	if (bebob == NULL)
 		return;
 
+	if (bebob->maudio_special_quirk != NULL)
+		kfree(bebob->maudio_special_quirk);
+
 	snd_bebob_stream_destroy_duplex(bebob);
 	snd_card_disconnect(bebob->card);
 	snd_card_free_when_closed(bebob->card);
@@ -380,6 +392,13 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010081, &maudio_nrv10_spec),
 	/* M-Audio, ProFireLightbridge */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x000100a1, &spec_normal),
+	/* Firewire 1814 */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010070, NULL),	/* bootloader */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_FW1814,
+			    &maudio_special_spec),
+	/* M-Audio ProjectMix */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_PROJECTMIX,
+			    &maudio_special_spec),
 	/* IDs are unknown but able to be supported */
 	/*  Apogee, Mini-ME Firewire */
 	/*  Apogee, Mini-DAC Firewire */
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index b08cbbb..394e0fb 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -101,6 +101,9 @@ struct snd_bebob {
 	int dev_lock_count;
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
+
+	/* for M-Audio special devices */
+	void *maudio_special_quirk;
 };
 
 static inline int
@@ -123,7 +126,7 @@ snd_bebob_read_quad(struct fw_unit *unit, u64 addr, u32 *buf)
 int avc_audio_set_selector(struct fw_unit *unit, unsigned int subunit_id,
 			   unsigned int fb_id, unsigned int num);
 int avc_audio_get_selector(struct fw_unit *unit, unsigned  int subunit_id,
-			   unsigned int fb_id, unsigned int *num);
+			   unsigned int fb_id, unsigned int *num, bool quiet);
 
 /*
  * AVC command extensions, AV/C Unit and Subunit, Revision 17
@@ -196,7 +199,7 @@ int avc_bridgeco_get_plug_strm_fmt(struct fw_unit *unit,
 				   unsigned int *len);
 
 int snd_bebob_get_rate(struct snd_bebob *bebob, unsigned int *rate,
-		       enum avc_general_plug_dir dir);
+		       enum avc_general_plug_dir dir, bool quiet);
 int snd_bebob_set_rate(struct snd_bebob *bebob, unsigned int rate,
 		       enum avc_general_plug_dir dir);
 
@@ -242,6 +245,9 @@ extern struct snd_bebob_spec maudio_solo_spec;
 extern struct snd_bebob_spec maudio_ozonic_spec;
 extern struct snd_bebob_spec maudio_nrv10_spec;
 
+extern struct snd_bebob_spec maudio_special_spec;
+int snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814);
+
 int snd_bebob_maudio_load_firmware(struct fw_unit *unit);
 
 #define SND_BEBOB_DEV_ENTRY(vendor, model, data) \
diff --git a/sound/firewire/bebob/bebob_command.c b/sound/firewire/bebob/bebob_command.c
index c63c6d8..ef7c21e 100644
--- a/sound/firewire/bebob/bebob_command.c
+++ b/sound/firewire/bebob/bebob_command.c
@@ -50,7 +50,7 @@ end:
 }
 
 int avc_audio_get_selector(struct fw_unit *unit, unsigned int subunit_id,
-			   unsigned int fb_id, unsigned int *num)
+			   unsigned int fb_id, unsigned int *num, bool quiet)
 {
 	u8 *buf;
 	int err;
@@ -76,9 +76,10 @@ int avc_audio_get_selector(struct fw_unit *unit, unsigned int subunit_id,
 	if (err < 0)
 		goto end;
 	if ((err < 6) || (buf[0] != 0x0c)) {
-		dev_err(&unit->device,
-			"failed to get selector %d: 0x%02X\n",
-			fb_id, buf[0]);
+		if (!quiet)
+			dev_err(&unit->device,
+				"failed to get selector %d: 0x%02X\n",
+				fb_id, buf[0]);
 		err = -EIO;
 		goto end;
 	}
@@ -314,7 +315,7 @@ end:
 }
 
 int snd_bebob_get_rate(struct snd_bebob *bebob, unsigned int *rate,
-		       enum avc_general_plug_dir dir)
+		       enum avc_general_plug_dir dir, bool quiet)
 {
 	int err;
 
@@ -324,8 +325,9 @@ int snd_bebob_get_rate(struct snd_bebob *bebob, unsigned int *rate,
 
 	/* IMPLEMENTED/STABLE is OK */
 	if (err != 0x0c) {
-		dev_err(&bebob->unit->device,
-			"failed to get sampling rate\n");
+		if (!quiet)
+			dev_err(&bebob->unit->device,
+				"failed to get sampling rate\n");
 		err = -EIO;
 	}
 end:
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index e3ab42c..82f0c7d 100644
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
@@ -31,8 +32,16 @@
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
 
+#define MAX_TRIALS	3
+
 /* Offset from information register */
 #define INFO_OFFSET_SW_DATE	0x20
 
@@ -52,6 +61,7 @@
 #define METER_OFFSET		0x00600000
 
 /* some device has sync info after metering data */
+#define METER_SIZE_SPECIAL	84	/* with sync info */
 #define METER_SIZE_FW410	76	/* with sync info */
 #define METER_SIZE_AUDIOPHILE	60	/* with sync info */
 #define METER_SIZE_SOLO		52	/* with sync info */
@@ -73,6 +83,16 @@
 /* for NRV */
 #define UNKNOWN_METER	"Unknown"
 
+struct special_params {
+	bool is1814;
+	unsigned int clk_src;
+	unsigned int dig_in_iface;
+	unsigned int dig_in_fmt;
+	unsigned int dig_out_fmt;
+	unsigned int clk_lock;
+	struct snd_ctl_elem_id *ctl_id_sync;
+};
+
 /*
  * For some M-Audio devices, this module just send cue to load firmware. After
  * loading, the device generates bus reset and newly detected.
@@ -127,7 +147,545 @@ get_meter(struct snd_bebob *bebob, void *buf, unsigned int size)
 				  buf, size, 0);
 }
 
-/* Firewire 410 specific operation */
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
+special_clk_set_params(struct snd_bebob *bebob, unsigned int clk_src,
+		       unsigned int dig_in_fmt, unsigned int dig_out_fmt,
+		       unsigned int clk_lock)
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
+	if (err < 0)
+		goto end;
+	if ((err < 6) || (buf[0] != 0x09)) {
+		dev_err(&bebob->unit->device,
+			"failed to set clock params\n");
+		err = -EIO;
+		goto end;
+	}
+
+	params->clk_src		= buf[6];
+	params->dig_in_fmt	= buf[7];
+	params->dig_out_fmt	= buf[8];
+	params->clk_lock	= buf[9];
+
+	if (params->ctl_id_sync)
+		snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       params->ctl_id_sync);
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
+static int snd_bebob_maudio_special_add_controls(struct snd_bebob *bebob);
+int
+snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814)
+{
+	unsigned int trials;
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
+	trials = 0;
+	do {
+		err = special_clk_set_params(bebob, 0x03, 0x00, 0x00, 0x00);
+		if (err >= 0)
+			break;
+	} while (++trials < MAX_TRIALS);
+	if (err < 0) {
+		dev_err(&bebob->unit->device,
+			"failed to initialize clock params\n");
+		goto end;
+	}
+
+	trials = 0;
+	do {
+		err = avc_audio_get_selector(bebob->unit, 0x00, 0x04,
+					     &params->dig_in_iface, true);
+		if (err >= 0)
+			break;
+	} while (++trials < MAX_TRIALS);
+	if (err < 0) {
+		dev_err(&bebob->unit->device,
+			"failed to get current dig iface.");
+		goto end;
+	}
+
+	err = snd_bebob_maudio_special_add_controls(bebob);
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
+	unsigned int trials;
+	int err;
+
+	trials = 0;
+	do {
+		err = snd_bebob_get_rate(bebob, rate, AVC_GENERAL_PLUG_DIR_IN,
+					 true);
+		if (err >= 0)
+			break;
+	} while (++trials < MAX_TRIALS);
+	if (err < 0)
+		dev_err(&bebob->unit->device,
+			"failed to get sampling rate\n");
+
+	return err;
+}
+static int special_set_rate(struct snd_bebob *bebob, unsigned int rate)
+{
+	struct special_params *params = bebob->maudio_special_quirk;
+	int err;
+
+	err = snd_bebob_set_rate(bebob, rate, AVC_GENERAL_PLUG_DIR_OUT);
+	if (err < 0)
+		goto end;
+
+	err = snd_bebob_set_rate(bebob, rate, AVC_GENERAL_PLUG_DIR_IN);
+	if (err < 0)
+		goto end;
+
+	if (params->ctl_id_sync)
+		snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       params->ctl_id_sync);
+end:
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
+	err = special_clk_set_params(bebob, id,
+				     params->dig_in_fmt,
+				     params->dig_out_fmt,
+				     params->clk_lock);
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
+	int val;
+
+	/* encoded id for user value */
+	val = (params->dig_in_fmt << 1) | (params->dig_in_iface & 0x01);
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
+	err = special_clk_set_params(bebob, params->clk_src, dig_in_fmt,
+				     params->dig_out_fmt, params->clk_lock);
+	if ((err < 0) || (params->dig_in_fmt > 0)) /* ADAT */
+		goto end;
+
+	err = avc_audio_set_selector(bebob->unit, 0x00, 0x04, dig_in_iface);
+	if (err < 0)
+		goto end;
+
+	params->dig_in_iface = dig_in_iface;
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
+	err = special_clk_set_params(bebob, params->clk_src, params->dig_in_fmt,
+				     id, params->clk_lock);
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
+static int snd_bebob_maudio_special_add_controls(struct snd_bebob *bebob)
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
@@ -278,6 +836,27 @@ end:
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
index 92e91a7..1939e16 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -64,11 +64,13 @@ snd_bebob_stream_get_rate(struct snd_bebob *bebob, unsigned int *curr_rate)
 	unsigned int tx_rate, rx_rate;
 	int err;
 
-	err = snd_bebob_get_rate(bebob, &tx_rate, AVC_GENERAL_PLUG_DIR_OUT);
+	err = snd_bebob_get_rate(bebob, &tx_rate, AVC_GENERAL_PLUG_DIR_OUT,
+				 false);
 	if (err < 0)
 		goto end;
 
-	err = snd_bebob_get_rate(bebob, &rx_rate, AVC_GENERAL_PLUG_DIR_IN);
+	err = snd_bebob_get_rate(bebob, &rx_rate, AVC_GENERAL_PLUG_DIR_IN,
+				 false);
 	if (err < 0)
 		goto end;
 
@@ -344,7 +346,6 @@ break_both_connections(struct snd_bebob *bebob)
 {
 	cmp_connection_break(&bebob->in_conn);
 	cmp_connection_break(&bebob->out_conn);
-	return;
 }
 
 static void
@@ -381,9 +382,11 @@ start_stream(struct snd_bebob *bebob, struct amdtp_stream *stream,
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
@@ -472,10 +475,14 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
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
@@ -489,6 +496,20 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
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
diff --git a/sound/firewire/bebob/bebob_terratec.c b/sound/firewire/bebob/bebob_terratec.c
index 9c2cebf..d5da8de 100644
--- a/sound/firewire/bebob/bebob_terratec.c
+++ b/sound/firewire/bebob/bebob_terratec.c
@@ -17,10 +17,10 @@ phase88_rack_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 	unsigned int enable_ext, enable_word;
 	int err;
 
-	err = avc_audio_get_selector(bebob->unit, 0, 0, &enable_ext);
+	err = avc_audio_get_selector(bebob->unit, 0, 0, &enable_ext, false);
 	if (err < 0)
 		goto end;
-	err = avc_audio_get_selector(bebob->unit, 0, 0, &enable_word);
+	err = avc_audio_get_selector(bebob->unit, 0, 0, &enable_word, false);
 	if (err < 0)
 		goto end;
 
@@ -35,7 +35,7 @@ static char *phase24_series_clk_src_labels[] = {
 static int
 phase24_series_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 {
-	return avc_audio_get_selector(bebob->unit, 0, 4, id);
+	return avc_audio_get_selector(bebob->unit, 0, 4, id, false);
 }
 
 struct snd_bebob_rate_spec phase_series_rate_spec = {
diff --git a/sound/firewire/bebob/bebob_yamaha.c b/sound/firewire/bebob/bebob_yamaha.c
index f71af6b..23ca489 100644
--- a/sound/firewire/bebob/bebob_yamaha.c
+++ b/sound/firewire/bebob/bebob_yamaha.c
@@ -32,7 +32,7 @@ static char *clk_src_labels[] = {SND_BEBOB_CLOCK_INTERNAL, "SPDIF"};
 static int
 clk_src_get(struct snd_bebob *bebob, unsigned int *id)
 {
-	return avc_audio_get_selector(bebob->unit, 0, 4, id);
+	return avc_audio_get_selector(bebob->unit, 0, 4, id, false);
 }
 static struct snd_bebob_clock_spec clock_spec = {
 	.num	= ARRAY_SIZE(clk_src_labels),
-- 
1.8.3.2
