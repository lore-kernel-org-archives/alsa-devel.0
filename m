From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/13] bebob: add support for M-Audio Firewire
	series
Date: Sat, 23 Nov 2013 15:09:21 +0900
Message-ID: <1385186965-8303-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 2847B265310
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:09:37 +0100 (CET)
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

This commit allows this driver to support all of models which M-Audio produces
with BeBoB chipset. They are:
 - Firewire Solo
 - Firewire AudioPhile
 - Firewire 410
 - Firewire 1814
 - Ozonic
 - NRV10
 - ProjectMix I/O
 - FirewireLightBridge

This commit adds M-Audio specific operations, quirks and functionalities. They
are categorized to three parts.

1. send cue to load firmware
This is for 'Firewire Audiophile', 'Firewire410', 'Firewire1814' and
'ProjectMix I/O'. With firmware version 5058 or later, they wait to receive a
cue to load firmware just after powering on. With less firmware version, they
wait to upload firmware binary blob so this driver can't handle this versions.
This functionality can be implemented in user land but currently in kernel land
for my convinience.

2. switching source of clock
This if for 'Firewire Solo', 'Firewire Audiophile', 'Firewire410',
'Firewire1814' and'ProjectMix I/O'. They can switch source of clock with signal
source command but the value of parameters is a bit different.

3. handling metering information
This is all of models, mainly for my debugging. This information includes
information for clock synchronization.

Firewire1814 and ProjectMix I/O has heavily customized BeBoB chipset. The usual
operation to handle BeBoB chipset cannot be applied for them. For this reason,
this commit add some model specific members in 'struct snd_bebob' and model
specific functions.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig               |   2 +
 sound/firewire/bebob/Makefile        |   1 +
 sound/firewire/bebob/bebob.c         |  75 +++
 sound/firewire/bebob/bebob.h         |  21 +
 sound/firewire/bebob/bebob_control.c |   3 +
 sound/firewire/bebob/bebob_maudio.c  | 910 +++++++++++++++++++++++++++++++++++
 sound/firewire/bebob/bebob_stream.c  |  22 +-
 7 files changed, 1031 insertions(+), 3 deletions(-)
 create mode 100644 sound/firewire/bebob/bebob_maudio.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index c46578e..427def7 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -80,6 +80,8 @@ config SND_BEBOB
 	  * CME MatrixKFW
 	  * Phonic HB24U
 	  * BridgeCo RDAudio1/Audio5
+	  * M-Audio Firewire410/AudioPhile/Solo/Ozonic/NRV10
+	  * M-Audio Firewire1814/ProjectMix IO/ProfireLightBridge
 
           To compile this driver as a module, choose M here: the module
           will be called snd-fireworks.
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 81e14fa..2e87d02 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,4 +1,5 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_control.o \
 		  bebob_midi.o bebob_pcm.o bebob_hwdep.o \
+		  bebob_maudio.o \
 		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 7c3f1b3..576d801 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -50,6 +50,12 @@ static unsigned int devices_used;
 #define VEN_ACOUSTIC	0x00000002
 #define VEN_CME		0x0000000a
 #define VEN_PHONIC	0x00001496
+#define VEN_MAUDIO1	0x00000d6c
+#define VEN_MAUDIO2	0x000007f5
+
+#define MODEL_MAUDIO_AUDIOPHILE_BOTH	0x00010060
+#define MODEL_MAUDIO_FW1814		0x00010071
+#define MODEL_MAUDIO_PROJECTMIX		0x00010091
 
 static int
 name_device(struct snd_bebob *bebob, unsigned int vendor_id)
@@ -82,6 +88,8 @@ name_device(struct snd_bebob *bebob, unsigned int vendor_id)
 		strcpy(vendor, "CME");
 	else if (vendor_id == VEN_PHONIC)
 		strcpy(vendor, "Phonic");
+	else if ((vendor_id == VEN_MAUDIO1) || (vendor_id == VEN_MAUDIO2))
+		strcpy(vendor, "M-Audio");
 
 	/* get model name */
 	err = fw_csr_string(bebob->unit->directory, CSR_MODEL,
@@ -135,6 +143,20 @@ snd_bebob_card_free(struct snd_card *card)
 	return;
 }
 
+static bool
+check_audiophile_booted(struct fw_unit *unit)
+{
+	char name[24] = {0};
+
+	if (fw_csr_string(unit->directory, CSR_MODEL, name, sizeof(name)) < 0)
+		return false;
+
+	if (strncmp(name, "FW Audiophile Bootloader", 15) == 0)
+		return false;
+	else
+		return true;
+}
+
 static int
 snd_bebob_probe(struct fw_unit *unit,
 		const struct ieee1394_device_id *entry)
@@ -159,6 +181,18 @@ snd_bebob_probe(struct fw_unit *unit,
 
 	spec = (const struct snd_bebob_spec *)entry->driver_data;
 
+	/* if needed, load firmware and exit */
+	if ((spec->load) &&
+	    ((entry->model_id != MODEL_MAUDIO_AUDIOPHILE_BOTH) ||
+	     (!check_audiophile_booted(unit)))) {
+		spec->load(unit, entry);
+		dev_info(&unit->device,
+			 "loading firmware for 0x%08X:0x%08X\n",
+			 entry->vendor_id, entry->model_id);
+		err = 0;
+		goto end;
+	}
+
 	/* create card */
 	err = snd_card_create(index[card_index], id[card_index],
 			THIS_MODULE, sizeof(struct snd_bebob), &card);
@@ -177,6 +211,16 @@ snd_bebob_probe(struct fw_unit *unit,
 	spin_lock_init(&bebob->lock);
 	init_waitqueue_head(&bebob->hwdep_wait);
 
+	/* discover */
+	if (entry->model_id == MODEL_MAUDIO_FW1814)
+		err = snd_bebob_maudio_special_discover(bebob, true);
+	else if (entry->model_id == MODEL_MAUDIO_PROJECTMIX)
+		err = snd_bebob_maudio_special_discover(bebob, false);
+	else
+		err = snd_bebob_stream_discover(bebob);
+	if (err < 0)
+		goto error;
+
 	/* name device with communication */
 	err = name_device(bebob, entry->vendor_id);
 	if (err < 0)
@@ -237,6 +281,11 @@ static void
 snd_bebob_update(struct fw_unit *unit)
 {
 	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
+
+	/* this is for firmware bootloader */
+	if (bebob == NULL)
+		return;
+
 	fcp_bus_reset(bebob->unit);
 	snd_bebob_stream_update_duplex(bebob);
 }
@@ -245,6 +294,11 @@ snd_bebob_update(struct fw_unit *unit)
 static void snd_bebob_remove(struct fw_unit *unit)
 {
 	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
+
+	/* this is for firmware bootloader */
+	if (bebob == NULL)
+		return;
+
 	snd_bebob_stream_destroy_duplex(bebob);
 	snd_card_disconnect(bebob->card);
 	snd_card_free_when_closed(bebob->card);
@@ -287,6 +341,27 @@ static const struct ieee1394_device_id snd_bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_CME, 0x00030000, spec_normal),
 	/* Phonic, HB24U */
 	SND_BEBOB_DEV_ENTRY(VEN_PHONIC, 0x00000000, spec_normal),
+	/* M-Audio, Ozonic */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x0000000a, maudio_ozonic_spec),
+	/* M-Audio, Firewire 410.  */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO2, 0x00010058, maudio_bootloader_spec),
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO2, 0x00010046, maudio_fw410_spec),
+	/* M-Audio, Firewire Audiophile, both of bootloader and firmware */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_AUDIOPHILE_BOTH,
+						maudio_audiophile_spec),
+	/* M-Audio, Firewire Solo */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010062, maudio_solo_spec),
+	/* M-Audio NRV10 */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010081, maudio_nrv10_spec),
+	/* Firewire 1814 */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010070, maudio_bootloader_spec),
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_FW1814,
+						maudio_special_spec),
+	/* M-Audio ProjectMix */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_PROJECTMIX,
+						maudio_special_spec),
+	/* M-Audio, ProFireLightbridge */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x000100a1, spec_normal),
 	{}
 };
 MODULE_DEVICE_TABLE(ieee1394, snd_bebob_id_table);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index b35fc52..fb9d99d 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -113,6 +113,15 @@ struct snd_bebob {
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
 };
 
 static inline int
@@ -214,6 +223,18 @@ int snd_bebob_create_pcm_devices(struct snd_bebob *bebob);
 
 int snd_bebob_create_hwdep_device(struct snd_bebob *bebob);
 
+/* device specific operations */
+int snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814);
+int snd_bebob_maudio_special_add_controls(struct snd_bebob *bebob);
+
+extern struct snd_bebob_spec maudio_bootloader_spec;
+extern struct snd_bebob_spec maudio_special_spec;
+extern struct snd_bebob_spec maudio_nrv10_spec;
+extern struct snd_bebob_spec maudio_fw410_spec;
+extern struct snd_bebob_spec maudio_audiophile_spec;
+extern struct snd_bebob_spec maudio_solo_spec;
+extern struct snd_bebob_spec maudio_ozonic_spec;
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model, private_data) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_control.c b/sound/firewire/bebob/bebob_control.c
index 3b311c3..87c50a37 100644
--- a/sound/firewire/bebob/bebob_control.c
+++ b/sound/firewire/bebob/bebob_control.c
@@ -323,6 +323,9 @@ int snd_bebob_create_control_devices(struct snd_bebob *bebob)
 		if (err < 0)
 			goto end;
 	}
+
+	if (bebob->maudio_special_quirk)
+		err = snd_bebob_maudio_special_add_controls(bebob);
 end:
 	return err;
 }
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
new file mode 100644
index 0000000..8afc835
--- /dev/null
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -0,0 +1,910 @@
+/*
+ * bebob_maudio.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * This driver is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2.
+ *
+ * This driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "./bebob.h"
+
+/*
+ * NOTE:
+ * For Firewire 410 and Firewire Audiophile, this module requests firmware
+ * version 5058 or later. With former version, BeBoB chipset needs downloading
+ * firmware and the driver should do this. To do this with ALSA, I need to
+ * examinate whether it's OK or not to include firmware binary blob to
+ * alsa-firmware package. With later version, the firmware is in ROM of chipset
+ * and the driver just send a cue to load it when probing the device. This cue
+ * is sent just once.
+ *
+ * For streaming, both of output and input streams are needed for Firewire 410
+ * and Ozonic. The single stream is OK for the other devices even if the clock
+ * source is not SYT-Match (I note no devices use SYT-Match).
+ *
+ * Without streaming, the devices except for Firewire Audiophile can mix any
+ * input and output. For this purpose, use ffado-mixer. Audiophile need to
+ * any stream for this purpose.
+ *
+ * Firewire 1814 and ProjectMix I/O uses special firmware. It will be freezed
+ * if receiving any commands which the firmware can't understand. These devices
+ * utilize completely different system to control. It is write transaction
+ * directly into a certain address. All of addresses for mixer functionality is
+ * between 0xffc700700000 to 0xffc70070009c.
+ */
+
+#define MAUDIO_BOOTLOADER_CUE1	0x01000000
+#define MAUDIO_BOOTLOADER_CUE2	0x00001101
+#define MAUDIO_BOOTLOADER_CUE3	0x00000000
+
+#define MAUDIO_SPECIFIC_ADDRESS	0xffc700000000
+
+#define METER_OFFSET		0x00600000
+
+/* some device has sync info after metering data */
+#define METER_SIZE_SPECIAL	84	/* with sync info */
+#define METER_SIZE_FW410	76	/* with sync info */
+#define METER_SIZE_AUDIOPHILE	60	/* with sync info */
+#define METER_SIZE_SOLO		52	/* with sync info */
+#define METER_SIZE_OZONIC	48
+#define METER_SIZE_NRV10	80
+
+/* labels for metering */
+#define ANA_IN		"Analog In"
+#define ANA_OUT		"Analog Out"
+#define DIG_IN		"Digital In"
+#define SPDIF_IN	"S/PDIF In"
+#define ADAT_IN		"ADAT In"
+#define DIG_OUT		"Digital Out"
+#define SPDIF_OUT	"S/PDIF Out"
+#define ADAT_OUT	"ADAT Out"
+#define STRM_IN		"Stream In"
+#define AUX_OUT		"Aux Out"
+#define HP_OUT		"HP Out"
+/* for NRV */
+#define UNKNOWN_METER	"Unknown"
+
+/*
+ * FW1814/ProjectMix don't use AVC for control. The driver cannot refer to
+ * current parameters by asynchronous transaction. The driver is allowed to
+ * write transaction so MUST remember the current values.
+ */
+#define	MAUDIO_CONTROL_OFFSET	0x00700000
+
+/* If we make any transaction to load firmware, the operation may failed. */
+/* TODO: change snd-firewire-lib and use it */
+static int
+run_a_transaction(struct fw_unit *unit, int tcode,
+		  u64 offset, void *buffer, size_t length)
+{
+	struct fw_device *device = fw_parent_device(unit);
+	int generation, rcode;
+
+	generation = device->generation;
+	smp_rmb();	/* node id vs. generation*/
+	rcode = fw_run_transaction(device->card, tcode,
+				   device->node_id, generation,
+				   device->max_speed, offset,
+				   buffer, length);
+	if (rcode == RCODE_COMPLETE)
+		return 0;
+
+	dev_err(&unit->device, "Failed to send a queue to load firmware\n");
+	return -EIO;
+}
+
+/*
+ * For some M-Audio devices, this module just send cue to load
+ * firmware. After loading, the device generates bus reset and
+ * newly detected.
+ */
+static int
+firmware_load(struct fw_unit *unit, const struct ieee1394_device_id *entry)
+{
+	__be32 cues[3];
+
+	cues[0] = cpu_to_be32(MAUDIO_BOOTLOADER_CUE1);
+	cues[1] = cpu_to_be32(MAUDIO_BOOTLOADER_CUE2);
+	cues[2] = cpu_to_be32(MAUDIO_BOOTLOADER_CUE3);
+
+	return run_a_transaction(unit, TCODE_WRITE_BLOCK_REQUEST,
+				 BEBOB_ADDR_REG_REQ, cues, sizeof(cues));
+}
+
+static inline int
+get_meter(struct snd_bebob *bebob, void *buf, unsigned int size)
+{
+	return snd_fw_transaction(bebob->unit, TCODE_READ_BLOCK_REQUEST,
+				  MAUDIO_SPECIFIC_ADDRESS + METER_OFFSET,
+				  buf, size, 0);
+}
+
+/*
+ * BeBoB don't tell drivers to detect digital input, just show clock sync or not.
+ */
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
+	err = 0;
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
+	int err;
+	u8 *buf;
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
+	/* handle both of input and output in this member */
+	bebob->dig_in_fmt	= buf[7];
+	bebob->dig_out_fmt	= buf[8];
+	bebob->clk_lock		= buf[9];
+
+	err = 0;
+end:
+	kfree(buf);
+	return err;
+}
+/*
+ * For special customized devices.
+ * The driver can't receive response from this firmware frequently.
+ * So need to reduce execution of command.
+ */
+static void
+special_stream_formation_set(struct snd_bebob *bebob)
+{
+	unsigned int i;
+
+	/*
+	 * the stream formation is different depending on digital interface
+	 */
+	if (bebob->dig_in_fmt== 0x01) {
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
+		if ((i > 7) && (bebob->maudio_is1814))
+			break;
+	}
+}
+
+int
+snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814)
+{
+	int err;
+
+	bebob->maudio_is1814 = is1814;
+
+	/* initialize these parameters because doesn't allow driver to ask */
+	err = special_clk_set_params(bebob, 0x03, 0x00, 0x00, 0x00);
+	if (err < 0) {
+		dev_err(&bebob->unit->device,
+			"failed to initialize clock params\n");
+	}
+
+	err = avc_audio_get_selector(bebob->unit, 0x00, 0x04,
+				     &bebob->dig_in_iface);
+	if (err < 0) {
+		dev_err(&bebob->unit->device,
+			"failed to get current dig iface.");
+	}
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
+/*
+ * Input plug shows actual rate. Output plug is needless for this purpose.
+ */
+static int special_clk_get_freq(struct snd_bebob *bebob, unsigned int *rate)
+{
+	return snd_bebob_get_rate(bebob, rate, AVC_GENERAL_PLUG_DIR_IN);
+}
+static char *special_clk_src_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL " with Digital Mute", "Digital",
+	"Word Clock", SND_BEBOB_CLOCK_INTERNAL};
+static int
+special_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	*id = bebob->clk_src;
+	return 0;
+}
+static int
+special_clk_src_set(struct snd_bebob *bebob, unsigned int id)
+{
+	return special_clk_set_params(bebob, id,
+				      bebob->dig_in_fmt, bebob->dig_out_fmt,
+				      bebob->clk_lock);
+}
+static int
+special_clk_synced(struct snd_bebob *bebob, bool *synced)
+{
+	return check_clk_sync(bebob, METER_SIZE_SPECIAL, synced);
+}
+
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
+	/* omit last 5 bytes because it's clock info. */
+	buf = kmalloc(METER_SIZE_SPECIAL - 4, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	err = get_meter(bebob, (void *)buf, METER_SIZE_SPECIAL - 4);
+	if (err < 0)
+		goto end;
+
+	/* some channels are not used and convert u16 to u32 */
+	for (i = 0, c = 2; c < channels + 2; c++)
+		target[i++] = be16_to_cpu(buf[c]) << 8;
+end:
+	kfree(buf);
+	return err;
+}
+
+static char *special_dig_iface_labels[] = {
+	"""S/PDIF Optical", "S/PDIF Coaxial", "ADAT Optical" 
+};
+static int special_dig_in_iface_info(struct snd_kcontrol *kctl,
+				      struct snd_ctl_elem_info *einf)
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
+static int special_dig_in_iface_get(struct snd_kcontrol *kctl,
+				     struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+
+	/* encoded id for user value */
+	uval->value.enumerated.item[0] =
+		(bebob->dig_in_fmt << 1) | (bebob->dig_in_iface & 0x01);
+
+	return 0;
+}
+static int special_dig_in_iface_set(struct snd_kcontrol *kctl,
+				     struct snd_ctl_elem_value *uval)
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
+static struct snd_kcontrol_new special_dig_in_iface = {
+	.name	= "Digital Input Interface",
+	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access	= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info	= special_dig_in_iface_info,
+	.get	= special_dig_in_iface_get,
+	.put	= special_dig_in_iface_set
+};
+
+static int special_dig_out_iface_info(struct snd_kcontrol *kctl,
+				      struct snd_ctl_elem_info *einf)
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
+static int special_dig_out_iface_get(struct snd_kcontrol *kctl,
+				     struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	uval->value.enumerated.item[0] = bebob->dig_out_fmt;
+	return 0;
+}
+static int special_dig_out_iface_set(struct snd_kcontrol *kctl,
+				     struct snd_ctl_elem_value *uval)
+{
+	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
+	unsigned int id;
+	int err;
+
+	id = uval->value.enumerated.item[0];
+
+	err = special_clk_set_params(bebob, bebob->clk_src, bebob->dig_in_fmt,
+				     id, bebob->clk_lock);
+	if (err < 0)
+		goto end;
+
+	special_stream_formation_set(bebob);
+end:
+	return err;
+}
+static struct snd_kcontrol_new special_dig_out_iface = {
+	.name	= "Digital Output Interface",
+	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access	= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info	= special_dig_out_iface_info,
+	.get	= special_dig_out_iface_get,
+	.put	= special_dig_out_iface_set
+};
+
+int snd_bebob_maudio_special_add_controls(struct snd_bebob *bebob)
+{
+	struct snd_kcontrol *kctl;
+	int err;
+
+	kctl = snd_ctl_new1(&special_dig_in_iface, bebob);
+	err = snd_ctl_add(bebob->card, kctl);
+	if (err < 0)
+		goto end;
+
+	kctl = snd_ctl_new1(&special_dig_out_iface, bebob);
+	err = snd_ctl_add(bebob->card, kctl);
+end:
+	return err;
+}
+
+/* Firewire 410 specific controls */
+static char *fw410_clk_src_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL, "Digital Optical", "Digital Coaxial"
+};
+static int
+fw410_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	int err;
+	unsigned int stype, sid, pid;
+
+	err = avc_ccm_get_sig_src(bebob->unit,
+				  &stype, &sid, &pid, 0x0c, 0x00, 0x01);
+	if (err < 0)
+		goto end;
+
+	*id = 0;
+	if ((stype == 0x1f) && (sid == 0x07)) {
+		if (pid == 0x82)
+			*id = 2;
+		else if (pid == 0x83)
+			*id = 1;
+	}
+end:
+	return err;
+}
+static int
+fw410_clk_src_set(struct snd_bebob *bebob, unsigned int id)
+{
+	unsigned int stype, sid, pid;
+
+	if (id == 0) {
+		stype = 0x0c;
+		sid = 0x00;
+		pid = 0x01;
+	} else if (id == 1) {
+		stype = 0x1f;
+		sid = 0x07;
+		pid = 0x83;
+	} else {
+		stype = 0x1f;
+		sid = 0x07;
+		pid = 0x82;
+	}
+
+	return avc_ccm_set_sig_src(bebob->unit,
+				   stype, sid, pid, 0x0c, 0x00, 0x01);
+}
+static int
+fw410_clk_synced(struct snd_bebob *bebob, bool *synced)
+{
+	return check_clk_sync(bebob, METER_SIZE_FW410, synced);
+}
+static char *fw410_meter_labels[] = {
+	ANA_IN, DIG_IN,
+	ANA_OUT, ANA_OUT, ANA_OUT, ANA_OUT, DIG_OUT,
+	HP_OUT
+};
+static int
+fw410_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+
+	unsigned int c, channels;
+	int err;
+
+	channels = ARRAY_SIZE(fw410_meter_labels) * 2;
+	if (size < channels * sizeof(u32))
+		return -EINVAL;
+
+	/* omit last 4 bytes because it's clock info. */
+	err = get_meter(bebob, (void *)buf, size);
+	if (err < 0)
+		goto end;
+
+	for (c = 0; c < channels; c++)
+		buf[c] = be32_to_cpu(buf[c]);
+end:
+	return err;
+}
+
+/* Firewire Audiophile specific controls */
+static char *audiophile_clk_src_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL, "Digital Coaxial"
+};
+static int
+audiophile_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	unsigned int stype, sid, pid;
+	int err;
+
+	err = avc_ccm_get_sig_src(bebob->unit,
+				  &stype, &sid, &pid, 0x0c, 0x00, 0x01);
+	if (err < 0)
+		goto end;
+
+	if ((stype == 0x1f) && (sid == 0x07) && (pid == 0x82))
+		*id = 1;
+	else
+		*id = 0;
+end:
+	return err;
+}
+static int
+audiophile_clk_src_set(struct snd_bebob *bebob, unsigned int id)
+{
+	unsigned int stype, sid, pid;
+
+	if (id == 0) {
+		stype = 0x0c;
+		sid = 0x00;
+		pid = 0x01;
+	} else {
+		stype = 0x1f;
+		sid = 0x07;
+		pid = 0x82;
+	}
+
+	return avc_ccm_set_sig_src(bebob->unit,
+				   stype, sid, pid, 0x0c, 0x00, 0x01);
+}
+static int
+audiophile_clk_synced(struct snd_bebob *bebob, bool *synced)
+{
+	return check_clk_sync(bebob, METER_SIZE_AUDIOPHILE, synced);
+}
+static char *audiophile_meter_labels[] = {
+	ANA_IN, DIG_IN,
+	ANA_OUT, ANA_OUT, DIG_OUT,
+	HP_OUT, AUX_OUT,
+};
+static int
+audiophile_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+	unsigned int c, channels;
+	int err;
+
+	channels = ARRAY_SIZE(audiophile_meter_labels) * 2;
+	if (size < channels * sizeof(u32))
+		return -EINVAL;
+
+	/* omit last 4 bytes because it's clock info. */
+	err = get_meter(bebob, (void *)buf, size);
+	if (err < 0)
+		goto end;
+
+	for (c = 0; c < channels; c++)
+		buf[c] = be32_to_cpu(buf[c]);
+end:
+	return err;
+}
+
+/* Firewire Solo specific controls */
+static char *solo_clk_src_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL, "Digital Coaxial"
+};
+static int
+solo_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	unsigned int stype, sid, pid;
+	int err;
+
+	err = avc_ccm_get_sig_src(bebob->unit,
+				  &stype, &sid, &pid, 0x0c, 0x00, 0x01);
+	if (err < 0)
+		goto end;
+
+	if ((stype == 0x1f) && (sid = 0x07) && (pid== 0x81))
+		*id = 1;
+	else
+		*id = 0;
+end:
+	return err;
+}
+static int
+solo_clk_src_set(struct snd_bebob *bebob, unsigned int id)
+{
+	unsigned int stype, sid, pid;
+
+	if (id == 0) {
+		stype = 0x0c;
+		sid = 0x00;
+		pid = 0x01;
+	} else {
+		stype = 0x1f;
+		sid = 0x07;
+		pid = 0x81;
+	}
+
+	return avc_ccm_set_sig_src(bebob->unit,
+				   stype, sid, pid, 0x0c, 0x00, 0x01);
+}
+static int
+solo_clk_synced(struct snd_bebob *bebob, bool *synced)
+{
+	return check_clk_sync(bebob, METER_SIZE_SOLO, synced);
+}
+static char *solo_meter_labels[] = {
+	ANA_IN, DIG_IN,
+	STRM_IN, STRM_IN,
+	ANA_OUT, DIG_OUT
+};
+static int
+solo_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+	unsigned int c;
+	int err;
+	u32 tmp;
+
+	if (size < ARRAY_SIZE(solo_meter_labels) * 2 * sizeof(u32))
+		return -ENOMEM;
+
+	/* omit last 4 bytes because it's clock info. */
+	err = get_meter(bebob, (void *)buf, size);
+	if (err < 0)
+		goto end;
+
+	c = 0;
+	do 
+		buf[c] = be32_to_cpu(buf[c]);
+	while (++c < 4);
+
+	/* swap stream channels because inverted */
+	tmp = be32_to_cpu(buf[c]);
+	buf[c] = be32_to_cpu(buf[c + 2]);
+	buf[c + 2] = tmp;
+	tmp = be32_to_cpu(buf[c + 1]);
+	buf[c + 1] = be32_to_cpu(buf[c + 3]);
+	buf[c + 3] = tmp;
+
+	c += 4;
+	do
+		buf[c] = be32_to_cpu(buf[c]);
+	while (++c < 12);
+end:
+	return err;
+}
+
+/* Ozonic specific controls */
+static char *ozonic_meter_labels[] = {
+	ANA_IN, ANA_IN,
+	STRM_IN, STRM_IN,
+	ANA_OUT, ANA_OUT
+};
+static int
+ozonic_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+	unsigned int c, channels;
+	int err;
+
+	channels = ARRAY_SIZE(ozonic_meter_labels) * 2;
+	if (size < channels * sizeof(u32))
+		return -EINVAL;
+
+	err = get_meter(bebob, (void *)buf, size);
+	if (err < 0)
+		goto end;
+
+	for (c = 0; c < channels; c++)
+		buf[c] = be32_to_cpu(buf[c]);
+end:
+	return err;
+}
+
+/* NRV10 specific controls */
+/* TODO: need testers. this is based on my assumption */
+static char *nrv10_meter_labels[] = {
+	ANA_IN, ANA_IN, ANA_IN, ANA_IN,
+	DIG_IN,
+	ANA_OUT, ANA_OUT, ANA_OUT, ANA_OUT,
+	DIG_IN
+};
+static int
+nrv10_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+	unsigned int c, channels;
+	int err;
+
+	channels = ARRAY_SIZE(nrv10_meter_labels) * 2;
+	if (size < channels * sizeof(u32))
+		return -EINVAL;
+
+	err = get_meter(bebob, (void *)buf, size);
+	if (err < 0)
+		goto end;
+
+	for (c = 0; c < channels; c++)
+		buf[c] = be32_to_cpu(buf[c]);
+end:
+	return err;
+}
+
+
+/* BeBoB bootloader specification */
+struct snd_bebob_spec maudio_bootloader_spec = {
+	.load		= &firmware_load,
+	.clock		= NULL,
+};
+
+/* for special customized devices */
+static struct snd_bebob_clock_spec special_clk_spec = {
+	.num		= ARRAY_SIZE(special_clk_src_labels),
+	.labels		= special_clk_src_labels,
+	.get_src	= &special_clk_src_get,
+	.set_src	= &special_clk_src_set,
+	.get_freq	= &special_clk_get_freq,
+	.set_freq	= &snd_bebob_stream_set_rate,
+	.synced		= &special_clk_synced
+};
+static struct snd_bebob_meter_spec special_meter_spec = {
+	.num	= ARRAY_SIZE(special_meter_labels),
+	.labels	= special_meter_labels,
+	.get	= &special_meter_get
+};
+struct snd_bebob_spec maudio_special_spec = {
+	.load		= NULL,
+	.clock		= &special_clk_spec,
+	.meter		= &special_meter_spec
+};
+
+/* Firewire 410 specification */
+static struct snd_bebob_clock_spec fw410_clk_spec = {
+	.num		= ARRAY_SIZE(fw410_clk_src_labels),
+	.labels		= fw410_clk_src_labels,
+	.get_src	= &fw410_clk_src_get,
+	.set_src	= &fw410_clk_src_set,
+	.get_freq	= &snd_bebob_stream_get_rate,
+	.set_freq	= &snd_bebob_stream_set_rate,
+	.synced		= &fw410_clk_synced
+};
+static struct snd_bebob_meter_spec fw410_meter_spec = {
+	.num	= ARRAY_SIZE(fw410_meter_labels),
+	.labels	= fw410_meter_labels,
+	.get	= &fw410_meter_get
+};
+struct snd_bebob_spec maudio_fw410_spec = {
+	.load	= NULL,
+	.clock	= &fw410_clk_spec,
+	.meter	= &fw410_meter_spec
+};
+
+/* Firewire Audiophile specification */
+static struct snd_bebob_clock_spec audiophile_clk_spec = {
+	.num		= ARRAY_SIZE(audiophile_clk_src_labels),
+	.labels		= audiophile_clk_src_labels,
+	.get_src	= &audiophile_clk_src_get,
+	.set_src	= &audiophile_clk_src_set,
+	.get_freq	= &snd_bebob_stream_get_rate,
+	.set_freq	= &snd_bebob_stream_set_rate,
+	.synced		= &audiophile_clk_synced
+};
+static struct snd_bebob_meter_spec audiophile_meter_spec = {
+	.num	= ARRAY_SIZE(audiophile_meter_labels),
+	.labels	= audiophile_meter_labels,
+	.get	= &audiophile_meter_get
+};
+struct snd_bebob_spec maudio_audiophile_spec = {
+	.load	= &firmware_load,
+	.clock	= &audiophile_clk_spec,
+	.meter	= &audiophile_meter_spec
+};
+
+/* Firewire Solo specification */
+static struct snd_bebob_clock_spec solo_clk_spec = {
+	.num		= ARRAY_SIZE(solo_clk_src_labels),
+	.labels		= solo_clk_src_labels,
+	.get_src	= &solo_clk_src_get,
+	.set_src	= &solo_clk_src_set,
+	.get_freq	= &snd_bebob_stream_get_rate,
+	.set_freq	= &snd_bebob_stream_set_rate,
+	.synced		= &solo_clk_synced
+};
+static struct snd_bebob_meter_spec solo_meter_spec = {
+	.num	= ARRAY_SIZE(solo_meter_labels),
+	.labels	= solo_meter_labels,
+	.get	= &solo_meter_get
+};
+struct snd_bebob_spec maudio_solo_spec = {
+	.load	= NULL,
+	.clock	= &solo_clk_spec,
+	.meter	= &solo_meter_spec
+};
+
+/* Ozonic specification */
+struct snd_bebob_clock_spec usual_clk_spec = {
+	.get_freq	= &snd_bebob_stream_get_rate,
+	.set_freq	= &snd_bebob_stream_set_rate
+};
+static struct snd_bebob_meter_spec ozonic_meter_spec = {
+	.num	= ARRAY_SIZE(ozonic_meter_labels),
+	.labels	= ozonic_meter_labels,
+	.get	= &ozonic_meter_get
+};
+struct snd_bebob_spec maudio_ozonic_spec = {
+	.load	= NULL,
+	.clock	= &usual_clk_spec,
+	.meter	= &ozonic_meter_spec
+};
+
+/* NRV10 specification */
+static struct snd_bebob_meter_spec nrv10_meter_spec = {
+	.num	= ARRAY_SIZE(nrv10_meter_labels),
+	.labels	= nrv10_meter_labels,
+	.get	= &nrv10_meter_get
+};
+struct snd_bebob_spec maudio_nrv10_spec = {
+	.load	= NULL,
+	.clock	= &usual_clk_spec,
+	.meter	= &nrv10_meter_spec
+};
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index faa235e..078de08 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -261,9 +261,11 @@ start_stream(struct snd_bebob *bebob, struct amdtp_stream *stream,
 		conn = &bebob->out_conn;
 
 	/* channel mapping */
-	err = snd_bebob_stream_map(bebob, stream);
-	if (err < 0)
-		goto end;
+	if (!bebob->maudio_special_quirk) {
+		err = snd_bebob_stream_map(bebob, stream);
+		if (err < 0)
+			goto end;
+	}
 
 	/* start amdtp stream */
 	err = amdtp_stream_start(stream,
@@ -384,6 +386,20 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 			goto end;
 		}
 
+		/*
+		 * NOTE:
+		 * The firmware customized by M-Audio uses this cue to start
+		 * transmit stream. This is not in specification.
+		 */
+		if (bebob->maudio_special_quirk) {
+			err = spec->set_freq(bebob, rate);
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
