From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/8] fireworks: Add transaction and some
	commands
Date: Wed, 11 Dec 2013 18:15:53 +0900
Message-ID: <1386753359-12458-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BC062616B9
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 10:16:31 +0100 (CET)
In-Reply-To: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fireworks uses own command and response. This commit adds functionality to
transact and adds some commands required for sound card instance and kernel
streaming.

There are two ways to deliver substance of this transaction:
1.AV/C vendor dependent command for command/response
2.Specific addresses for command/response

By way 1, I confirm AudioFire12 cannot correctly response to some commands with
firmware version 5.0 or later. This is also confirmed by FFADO. So this module
implement way 2.

The address for response gives an issue. When this driver allocate own callback
function into the address, then no one can allocate its own callback function.
This situation is not good for applications in user-land. Currently this commit
don't solve this issue. This issue is solved in later commit.

I note there is a command to change the address for response if the device
supports. But this module uses default value. So users should not execute this
command as long as hoping this module works correctly.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/Makefile                |   2 +-
 sound/firewire/fireworks/fireworks.c             |  74 ++++-
 sound/firewire/fireworks/fireworks.h             | 127 ++++++++
 sound/firewire/fireworks/fireworks_command.c     | 399 +++++++++++++++++++++++
 sound/firewire/fireworks/fireworks_transaction.c | 204 ++++++++++++
 5 files changed, 796 insertions(+), 10 deletions(-)
 create mode 100644 sound/firewire/fireworks/fireworks_command.c
 create mode 100644 sound/firewire/fireworks/fireworks_transaction.c

diff --git a/sound/firewire/fireworks/Makefile b/sound/firewire/fireworks/Makefile
index 99f6fc3..a6ce214 100644
--- a/sound/firewire/fireworks/Makefile
+++ b/sound/firewire/fireworks/Makefile
@@ -1,2 +1,2 @@
-snd-fireworks-objs := fireworks.o
+snd-fireworks-objs := fireworks_transaction.o fireworks_command.o fireworks.o
 obj-m += snd-fireworks.o
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 3b62387..ab60b60 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -69,6 +69,46 @@ static unsigned int devices_used;
 /* unknown as product */
 #define  MODEL_GIBSON_GOLDTOP		0x00afb9
 
+/* part of hardware capability flags */
+#define FLAG_RESP_ADDR_CHANGABLE	0
+
+static int
+get_hardware_info(struct snd_efw *efw)
+{
+	struct snd_efw_hwinfo *hwinfo;
+	char version[12] = {0};
+	int err;
+
+	hwinfo = kzalloc(sizeof(struct snd_efw_hwinfo), GFP_KERNEL);
+	if (hwinfo == NULL)
+		return -ENOMEM;
+
+	err = snd_efw_command_get_hwinfo(efw, hwinfo);
+	if (err < 0)
+		goto end;
+
+	/* firmware version */
+	err = sprintf(version, "%u.%u",
+		      (hwinfo->arm_version >> 24) & 0xff,
+		      (hwinfo->arm_version >> 16) & 0xff);
+
+	/* set names */
+	strcpy(efw->card->driver, "Fireworks");
+	strcpy(efw->card->shortname, hwinfo->model_name);
+	snprintf(efw->card->longname, sizeof(efw->card->longname),
+		 "%s %s v%s, GUID %08x%08x at %s, S%d",
+		 hwinfo->vendor_name, hwinfo->model_name, version,
+		 hwinfo->guid_hi, hwinfo->guid_lo,
+		 dev_name(&efw->unit->device), 100 << efw->device->max_speed);
+	strcpy(efw->card->mixername, hwinfo->model_name);
+
+	if (hwinfo->flags & BIT(FLAG_RESP_ADDR_CHANGABLE))
+		efw->resp_addr_changable = true;
+end:
+	kfree(hwinfo);
+	return err;
+}
+
 static void
 efw_card_free(struct snd_card *card)
 {
@@ -118,27 +158,31 @@ efw_probe(struct fw_unit *unit,
 	mutex_init(&efw->mutex);
 	spin_lock_init(&efw->lock);
 
-	strcpy(efw->card->driver, "Fireworks");
-	strcpy(efw->card->shortname, "Fireworks");
-	strcpy(efw->card->longname, "Fireworks");
-	strcpy(efw->card->mixername, "Fireworks");
+	err = get_hardware_info(efw);
+	if (err < 0)
+		goto error;
 
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		goto end;
-	}
+	if (err < 0)
+		goto error;
+
 	dev_set_drvdata(&unit->device, efw);
 	devices_used |= BIT(card_index);
 	efw->card_index = card_index;
 end:
 	mutex_unlock(&devices_mutex);
 	return err;
+error:
+	snd_card_free(card);
+	mutex_unlock(&devices_mutex);
+	return err;
 }
 
 static void efw_update(struct fw_unit *unit)
 {
+	struct snd_efw *efw = dev_get_drvdata(&unit->device);
+	snd_efw_transaction_bus_reset(efw->unit);
 	return;
 }
 
@@ -182,11 +226,23 @@ static struct fw_driver efw_driver = {
 
 static int __init snd_efw_init(void)
 {
-	return driver_register(&efw_driver.driver);
+	int err;
+
+	err = snd_efw_transaction_register();
+	if (err < 0)
+		goto end;
+
+	err = driver_register(&efw_driver.driver);
+	if (err < 0)
+		snd_efw_transaction_unregister();
+
+end:
+	return err;
 }
 
 static void __exit snd_efw_exit(void)
 {
+	snd_efw_transaction_unregister();
 	driver_unregister(&efw_driver.driver);
 	mutex_destroy(&devices_mutex);
 }
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index ed745d0..f07b57a 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -30,6 +30,19 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/pcm.h>
+
+#include "../cmp.h"
+#include "../lib.h"
+
+#define SND_EFW_MUITIPLIER_MODES	3
+#define HWINFO_NAME_SIZE_BYTES		32
+#define HWINFO_MAX_CAPS_GROUPS		8
+
+struct snd_efw_phys_grp {
+	u8 type;	/* see enum snd_efw_grp_type */
+	u8 count;
+} __packed;
 
 struct snd_efw {
 	struct snd_card *card;
@@ -39,8 +52,122 @@ struct snd_efw {
 
 	struct mutex mutex;
 	spinlock_t lock;
+
+	/* for transaction */
+	u32 seqnum;
+	bool resp_addr_changable;
+};
+
+/* for transaction */
+struct snd_efw_transaction {
+	u32 length;
+	u32 version;
+	u32 seqnum;
+	u32 category;
+	u32 command;
+	u32 status;
+	u32 params[0];
+};
+
+int snd_efw_transaction_run(struct fw_unit *unit,
+			    const void *cmd, unsigned int cmd_size,
+			    void *resp, unsigned int resp_size, u32 seqnum);
+int snd_efw_transaction_register(void);
+void snd_efw_transaction_unregister(void);
+void snd_efw_transaction_bus_reset(struct fw_unit *unit);
+
+/* for needed commands */
+struct snd_efw_hwinfo {
+	u32 flags;
+	u32 guid_hi;
+	u32 guid_lo;
+	u32 type;
+	u32 version;
+	char vendor_name[HWINFO_NAME_SIZE_BYTES];
+	char model_name[HWINFO_NAME_SIZE_BYTES];
+	u32 supported_clocks;
+	u32 amdtp_rx_pcm_channels;
+	u32 amdtp_tx_pcm_channels;
+	u32 phys_out;
+	u32 phys_in;
+	u32 phys_out_grp_count;
+	struct snd_efw_phys_grp phys_out_grps[HWINFO_MAX_CAPS_GROUPS];
+	u32 phys_in_grp_count;
+	struct snd_efw_phys_grp phys_in_grps[HWINFO_MAX_CAPS_GROUPS];
+	u32 midi_out_ports;
+	u32 midi_in_ports;
+	u32 max_sample_rate;
+	u32 min_sample_rate;
+	u32 dsp_version;
+	u32 arm_version;
+	u32 mixer_playback_channels;
+	u32 mixer_capture_channels;
+	u32 fpga_version;
+	u32 amdtp_rx_pcm_channels_2x;
+	u32 amdtp_tx_pcm_channels_2x;
+	u32 amdtp_rx_pcm_channels_4x;
+	u32 amdtp_tx_pcm_channels_4x;
+	u32 reserved[16];
+} __packed;
+
+enum snd_efw_grp_type {
+	SND_EFW_CH_TYPE_ANALOG			= 0,
+	SND_EFW_CH_TYPE_SPDIF			= 1,
+	SND_EFW_CH_TYPE_ADAT			= 2,
+	SND_EFW_CH_TYPE_SPDIF_OR_ADAT		= 3,
+	SND_EFW_CH_TYPE_ANALOG_MIRRORING	= 4,
+	SND_EFW_CH_TYPE_HEADPHONES		= 5,
+	SND_EFW_CH_TYPE_I2S			= 6,
+	SND_EFW_CH_TYPE_GUITAR			= 7,
+	SND_EFW_CH_TYPE_PIEZO_GUITAR		= 8,
+	SND_EFW_CH_TYPE_GUITAR_STRING		= 9,
+	SND_EFW_CH_TYPE_VIRTUAL			= 0x10000,
+	SND_EFW_CH_TYPE_DUMMY
+};
+
+struct snd_efw_phys_meters {
+	u32 clock_in;
+	u32 reserved0;
+	u32 reserved1;
+	u32 reserved2;
+	u32 reserved3;
+	u32 out_meters;
+	u32 in_meters;
+	u32 reserved4;
+	u32 reserved5;
+	u32 values[0];
+} __packed;
+
+enum snd_efw_clock_source {
+	SND_EFW_CLOCK_SOURCE_INTERNAL	= 0,
+	SND_EFW_CLOCK_SOURCE_SYTMATCH	= 1,
+	SND_EFW_CLOCK_SOURCE_WORDCLOCK	= 2,
+	SND_EFW_CLOCK_SOURCE_SPDIF	= 3,
+	SND_EFW_CLOCK_SOURCE_ADAT_1	= 4,
+	SND_EFW_CLOCK_SOURCE_ADAT_2	= 5,
+};
+
+enum snd_efw_transport_mode {
+	SND_EFW_TRANSPORT_MODE_WINDOWS	= 0,
+	SND_EFW_TRANSPORT_MODE_IEC61883	= 1,
 };
 
+int snd_efw_command_identify(struct snd_efw *efw);
+int snd_efw_command_set_resp_addr(struct snd_efw *efw,
+				  u16 addr_high, u32 addr_low);
+int snd_efw_command_set_tx_mode(struct snd_efw *efw, unsigned int mode);
+int snd_efw_command_get_hwinfo(struct snd_efw *efw,
+			       struct snd_efw_hwinfo *hwinfo);
+int snd_efw_command_get_phys_meters(struct snd_efw *efw,
+				    struct snd_efw_phys_meters *meters,
+				    unsigned int len);
+int snd_efw_command_get_clock_source(struct snd_efw *efw,
+				     enum snd_efw_clock_source *source);
+int snd_efw_command_set_clock_source(struct snd_efw *efw,
+				     enum snd_efw_clock_source source);
+int snd_efw_command_get_sampling_rate(struct snd_efw *efw, unsigned int *rate);
+int snd_efw_command_set_sampling_rate(struct snd_efw *efw, unsigned int rate);
+
 #define SND_EFW_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/fireworks/fireworks_command.c b/sound/firewire/fireworks/fireworks_command.c
new file mode 100644
index 0000000..14906bb
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks_command.c
@@ -0,0 +1,399 @@
+/*
+ * fireworks_command.c - a part of driver for Fireworks based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto <o-takashi@sakmocchi.jp>
+ *
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
+#include "./fireworks.h"
+
+/*
+ * This driver uses transaction version 1 or later to use extended hardware
+ * information. Then too old devices are not available.
+ *
+ * Each commands are not required to have continuous sequence numbers. This
+ * number is just used to match command and response.
+ *
+ * NOTE: FFADO implementaion is EFC over AVC but device with firmware
+ * version 5.5 or later support it but don't use it. This module support a part
+ * of commands. Please see FFADO if you want to see whole commands. But I note
+ * there are some commands which FFADO don't implement
+ */
+
+#define EFW_TRANSACTION_SEQNUM_MAX	((u32)~0)
+
+/* for clock source and sampling rate */
+struct efc_clock {
+	u32 source;
+	u32 sampling_rate;
+	u32 index;
+};
+
+/* command categories */
+enum efc_category {
+	EFC_CAT_HWINFO		= 0,
+	EFC_CAT_TRANSPORT	= 2,
+	EFC_CAT_HWCTL		= 3,
+};
+
+/* hardware info category commands */
+enum efc_cmd_hwinfo {
+	EFC_CMD_HWINFO_GET_CAPS		= 0,
+	EFC_CMD_HWINFO_GET_POLLED	= 1,
+	EFC_CMD_HWINFO_SET_RESP_ADDR	= 2
+};
+
+enum efc_cmd_transport {
+	EFC_CMD_TRANSPORT_SET_TX_MODE	= 0
+};
+
+/* hardware control category commands */
+enum efc_cmd_hwctl {
+	EFC_CMD_HWCTL_SET_CLOCK		= 0,
+	EFC_CMD_HWCTL_GET_CLOCK		= 1,
+	EFC_CMD_HWCTL_IDENTIFY		= 5
+};
+
+/* return values in response */
+enum efr_status {
+	EFC_RETVAL_OK			= 0,
+	EFC_RETVAL_BAD			= 1,
+	EFC_RETVAL_BAD_COMMAND		= 2,
+	EFC_RETVAL_COMM_ERR		= 3,
+	EFC_RETVAL_BAD_QUAD_COUNT	= 4,
+	EFC_RETVAL_UNSUPPORTED		= 5,
+	EFC_RETVAL_1394_TIMEOUT		= 6,
+	EFC_RETVAL_DSP_TIMEOUT		= 7,
+	EFC_RETVAL_BAD_RATE		= 8,
+	EFC_RETVAL_BAD_CLOCK		= 9,
+	EFC_RETVAL_BAD_CHANNEL		= 10,
+	EFC_RETVAL_BAD_PAN		= 11,
+	EFC_RETVAL_FLASH_BUSY		= 12,
+	EFC_RETVAL_BAD_MIRROR		= 13,
+	EFC_RETVAL_BAD_LED		= 14,
+	EFC_RETVAL_BAD_PARAMETER	= 15,
+	EFC_RETVAL_INCOMPLETE		= 0x80000000
+};
+
+static const char *const efr_status_names[] = {
+	[EFC_RETVAL_OK]			= "OK",
+	[EFC_RETVAL_BAD]		= "bad",
+	[EFC_RETVAL_BAD_COMMAND]	= "bad command",
+	[EFC_RETVAL_COMM_ERR]		= "comm err",
+	[EFC_RETVAL_BAD_QUAD_COUNT]	= "bad quad count",
+	[EFC_RETVAL_UNSUPPORTED]	= "unsupported",
+	[EFC_RETVAL_1394_TIMEOUT]	= "1394 timeout",
+	[EFC_RETVAL_DSP_TIMEOUT]	= "DSP timeout",
+	[EFC_RETVAL_BAD_RATE]		= "bad rate",
+	[EFC_RETVAL_BAD_CLOCK]		= "bad clock",
+	[EFC_RETVAL_BAD_CHANNEL]	= "bad channel",
+	[EFC_RETVAL_BAD_PAN]		= "bad pan",
+	[EFC_RETVAL_FLASH_BUSY]		= "flash busy",
+	[EFC_RETVAL_BAD_MIRROR]		= "bad mirror",
+	[EFC_RETVAL_BAD_LED]		= "bad LED",
+	[EFC_RETVAL_BAD_PARAMETER]	= "bad parameter",
+	[EFC_RETVAL_BAD_PARAMETER + 1]	= "incomplete"
+};
+
+static int
+efw_transaction(struct snd_efw *efw, unsigned int category,
+		unsigned int command,
+		const __be32 *params, unsigned int param_quads,
+		const __be32 *resp, unsigned int resp_quads)
+{
+	struct snd_efw_transaction *header;
+	__be32 *buf;
+	u32 seqnum;
+	unsigned int i, buf_bytes, cmd_bytes;
+	int err;
+
+	/* calculate buffer size*/
+	buf_bytes = sizeof(struct snd_efw_transaction) +
+		    max(param_quads, resp_quads) * sizeof(u32);
+
+	/* keep buffer */
+	buf = kzalloc(buf_bytes, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	/* to keep consistency of sequence number */
+	spin_lock(&efw->lock);
+	if (efw->seqnum + 1 >= EFW_TRANSACTION_SEQNUM_MAX)
+		efw->seqnum = 0;
+	else
+		efw->seqnum += 2;
+	seqnum = efw->seqnum;
+	spin_unlock(&efw->lock);
+
+	/* fill transaction header fields */
+	cmd_bytes = sizeof(struct snd_efw_transaction) +
+		    param_quads * sizeof(u32);
+	header = (struct snd_efw_transaction *)buf;
+	header->length	 = cmd_bytes / sizeof(u32);
+	header->version	 = 1;
+	header->seqnum	 = seqnum;
+	header->category = category;
+	header->command	 = command;
+	header->status	 = 0;
+	for (i = 0; i < sizeof(struct snd_efw_transaction) / sizeof(u32); i++)
+		cpu_to_be32s(&buf[i]);
+
+	/* fill transaction command parameters */
+	for (i = 0; i < param_quads; i++)
+		buf[6 + i] = params[i];
+
+	err = snd_efw_transaction_run(efw->unit, buf, cmd_bytes,
+				      buf, buf_bytes, seqnum);
+	if (err < 0)
+		goto end;
+
+	/* check transaction header fields */
+	for (i = 0; i < sizeof(struct snd_efw_transaction) / sizeof(u32); i++)
+		be32_to_cpus(&buf[i]);
+	if ((header->version  < 1) ||
+	    (header->category != category) ||
+	    (header->command  != command) ||
+	    (header->status   != EFC_RETVAL_OK)) {
+		dev_err(&efw->unit->device, "EFC failed [%u/%u]: %s\n",
+			be32_to_cpu(buf[3]), be32_to_cpu(buf[4]),
+			efr_status_names[be32_to_cpu(buf[5])]);
+		err = -EIO;
+		goto end;
+	}
+
+	/* fill transaction response parameters */
+	if (resp != NULL) {
+		memset((void *)resp, 0, resp_quads * sizeof(u32));
+		resp_quads = min_t(unsigned int, resp_quads,
+				   header->length -
+				    sizeof(struct snd_efw_transaction) /
+				    sizeof(u32));
+		memcpy((void *)resp, &buf[6], resp_quads * sizeof(u32));
+	}
+end:
+	kfree(buf);
+	return err;
+}
+
+int snd_efw_command_identify(struct snd_efw *efw)
+{
+	return efw_transaction(efw, EFC_CAT_HWCTL,
+			       EFC_CMD_HWCTL_IDENTIFY,
+			       NULL, 0, NULL, 0);
+}
+
+/*
+ * The address in host system for EFC response is changable when the device
+ * supports. struct hwinfo.flags includes its flag. The default is
+ * INITIAL_MEMORY_SPACE_EFC_RESPONSE
+ */
+int snd_efw_command_set_resp_addr(struct snd_efw *efw,
+				  u16 addr_high, u32 addr_low)
+{
+	__be32 addr[2];
+
+	addr[0] = cpu_to_be32(addr_high);
+	addr[1] = cpu_to_be32(addr_low);
+
+	if (!efw->resp_addr_changable)
+		return -ENOSYS;
+
+	return efw_transaction(efw, EFC_CAT_HWCTL,
+			       EFC_CMD_HWINFO_SET_RESP_ADDR,
+			       addr, 2, NULL, 0);
+}
+
+/*
+ * This is for timestamp processing. In Windows mode, all 32bit fields of second
+ * CIP header in AMDTP transmit packet is used for 'presentation timestamp'. In
+ * 'no data' packet the value of this field is 0x90ffffff.
+ */
+int snd_efw_command_set_tx_mode(struct snd_efw *efw,
+				enum snd_efw_transport_mode mode)
+{
+	__be32 param = cpu_to_be32(mode);
+	return efw_transaction(efw, EFC_CAT_TRANSPORT,
+			       EFC_CMD_TRANSPORT_SET_TX_MODE,
+			       &param, 1, NULL, 0);
+}
+
+int snd_efw_command_get_hwinfo(struct snd_efw *efw,
+			       struct snd_efw_hwinfo *hwinfo)
+{
+	int err;
+
+	err  = efw_transaction(efw, EFC_CAT_HWINFO,
+			       EFC_CMD_HWINFO_GET_CAPS,
+			       NULL, 0, (__be32 *)hwinfo, sizeof(*hwinfo) / 4);
+	if (err < 0)
+		goto end;
+
+	be32_to_cpus(&hwinfo->flags);
+	be32_to_cpus(&hwinfo->guid_hi);
+	be32_to_cpus(&hwinfo->guid_lo);
+	be32_to_cpus(&hwinfo->type);
+	be32_to_cpus(&hwinfo->version);
+	be32_to_cpus(&hwinfo->supported_clocks);
+	be32_to_cpus(&hwinfo->amdtp_rx_pcm_channels);
+	be32_to_cpus(&hwinfo->amdtp_tx_pcm_channels);
+	be32_to_cpus(&hwinfo->phys_out);
+	be32_to_cpus(&hwinfo->phys_in);
+	be32_to_cpus(&hwinfo->phys_out_grp_count);
+	be32_to_cpus(&hwinfo->phys_in_grp_count);
+	be32_to_cpus(&hwinfo->midi_out_ports);
+	be32_to_cpus(&hwinfo->midi_in_ports);
+	be32_to_cpus(&hwinfo->max_sample_rate);
+	be32_to_cpus(&hwinfo->min_sample_rate);
+	be32_to_cpus(&hwinfo->dsp_version);
+	be32_to_cpus(&hwinfo->arm_version);
+	be32_to_cpus(&hwinfo->mixer_playback_channels);
+	be32_to_cpus(&hwinfo->mixer_capture_channels);
+	be32_to_cpus(&hwinfo->fpga_version);
+	be32_to_cpus(&hwinfo->amdtp_rx_pcm_channels_2x);
+	be32_to_cpus(&hwinfo->amdtp_tx_pcm_channels_2x);
+	be32_to_cpus(&hwinfo->amdtp_rx_pcm_channels_4x);
+	be32_to_cpus(&hwinfo->amdtp_tx_pcm_channels_4x);
+
+	/* ensure terminated */
+	hwinfo->vendor_name[HWINFO_NAME_SIZE_BYTES - 1] = '\0';
+	hwinfo->model_name[HWINFO_NAME_SIZE_BYTES  - 1] = '\0';
+end:
+	return err;
+}
+
+int snd_efw_command_get_phys_meters(struct snd_efw *efw,
+				    struct snd_efw_phys_meters *meters,
+				    unsigned int len)
+{
+	__be32 *buf = (__be32 *)meters;
+	unsigned int i;
+	int err;
+
+	err = efw_transaction(efw, EFC_CAT_HWINFO,
+			      EFC_CMD_HWINFO_GET_POLLED,
+			      NULL, 0, (__be32 *)meters, len / 4);
+	if (err >= 0)
+		for (i = 0; i < len / 4; i++)
+			be32_to_cpus(&buf[i]);
+
+	return err;
+}
+
+static int
+command_get_clock(struct snd_efw *efw, struct efc_clock *clock)
+{
+	int err;
+
+	err = efw_transaction(efw, EFC_CAT_HWCTL,
+			      EFC_CMD_HWCTL_GET_CLOCK,
+			      NULL, 0,
+			      (__be32 *)clock, sizeof(struct efc_clock) / 4);
+	if (err >= 0) {
+		be32_to_cpus(&clock->source);
+		be32_to_cpus(&clock->sampling_rate);
+		be32_to_cpus(&clock->index);
+	}
+
+	return err;
+}
+
+/* give UINT_MAX if set nothing */
+static int
+command_set_clock(struct snd_efw *efw,
+		  unsigned int source, unsigned int rate)
+{
+	struct efc_clock clock = {0};
+	int err;
+
+	/* check arguments */
+	if ((source == UINT_MAX) && (rate == UINT_MAX)) {
+		err = -EINVAL;
+		goto end;
+	}
+
+	/* get current status */
+	err = command_get_clock(efw, &clock);
+	if (err < 0)
+		goto end;
+
+	/* no need */
+	if ((clock.source == source) && (clock.sampling_rate == rate))
+		goto end;
+
+	/* set params */
+	if ((source != UINT_MAX) && (clock.source != source))
+		clock.source = source;
+	if ((rate != UINT_MAX) && (clock.sampling_rate != rate))
+		clock.sampling_rate = rate;
+	clock.index = 0;
+
+	cpu_to_be32s(&clock.source);
+	cpu_to_be32s(&clock.sampling_rate);
+	cpu_to_be32s(&clock.index);
+
+	err = efw_transaction(efw, EFC_CAT_HWCTL,
+			      EFC_CMD_HWCTL_SET_CLOCK,
+			      (__be32 *)&clock, 3, NULL, 0);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * With firmware version 5.8, just after changing clock state, these
+	 * parameters are not immediately retrieved by get command. In my
+	 * trial, there needs to be 100msec to get changed parameters.
+	 */
+	msleep(150);
+end:
+	return err;
+}
+
+int snd_efw_command_get_clock_source(struct snd_efw *efw,
+				     enum snd_efw_clock_source *source)
+{
+	int err;
+	struct efc_clock clock = {0};
+
+	err = command_get_clock(efw, &clock);
+	if (err >= 0)
+		*source = clock.source;
+
+	return err;
+}
+
+int snd_efw_command_set_clock_source(struct snd_efw *efw,
+				     enum snd_efw_clock_source source)
+{
+	return command_set_clock(efw, source, UINT_MAX);
+}
+
+int snd_efw_command_get_sampling_rate(struct snd_efw *efw,
+				      unsigned int *rate)
+{
+	int err;
+	struct efc_clock clock = {0};
+
+	err = command_get_clock(efw, &clock);
+	if (err >= 0)
+		*rate = clock.sampling_rate;
+
+	return err;
+}
+
+int
+snd_efw_command_set_sampling_rate(struct snd_efw *efw,
+				  unsigned int rate)
+{
+	return command_set_clock(efw, UINT_MAX, rate);
+}
+
diff --git a/sound/firewire/fireworks/fireworks_transaction.c b/sound/firewire/fireworks/fireworks_transaction.c
new file mode 100644
index 0000000..a701e76
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks_transaction.c
@@ -0,0 +1,204 @@
+/*
+ * fireworks_transaction.c - a part of driver for Fireworks based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto <o-takashi@sakmocchi.jp>
+ *
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
+ *
+ * Mostly based on FFADO's souce, which is licensed under GPL version 2 (and
+ * optionally version 3).
+ */
+
+/*
+ * Fireworks have its own transaction. Fireworks also support AV/C General
+ * commands and AV/C Stream Format Information commands. This module supports
+ * own commands.
+ *
+ * Transaction substance:
+ *  At first, 6 data exist. Following to the 6 data, parameters for each
+ *  commands exists. All of parameters are 32 bit alighed to big endian.
+ *   data[0]:	Length of transaction substance
+ *   data[1]:	Transaction version
+ *   data[2]:	Sequence number. This is incremented by the device
+ *   data[3]:	transaction category
+ *   data[4]:	transaction command
+ *   data[5]:	return value in response.
+ *   data[6-]:	parameters
+ *
+ * Transaction address:
+ *  command:	0xecc000000000
+ *  response:	0xecc080000000 (default)
+ *
+ * I note that the address for response can be changed by command. But this
+ * module uses the default address.
+ */
+#include "./fireworks.h"
+
+#define MEMORY_SPACE_EFW_COMMAND	0xecc000000000
+#define MEMORY_SPACE_EFW_RESPONSE	0xecc080000000
+/* this is for juju convinience? */
+#define MEMORY_SPACE_EFW_END		0xecc080000200
+
+#define ERROR_RETRIES 3
+#define ERROR_DELAY_MS 5
+#define EFC_TIMEOUT_MS 125
+
+static DEFINE_SPINLOCK(transaction_queues_lock);
+static LIST_HEAD(transaction_queues);
+
+enum transaction_queue_state {
+	STATE_PENDING,
+	STATE_BUS_RESET,
+	STATE_COMPLETE
+};
+
+struct transaction_queue {
+	struct list_head list;
+	struct fw_unit *unit;
+	void *buf;
+	unsigned int size;
+	u32 seqnum;
+	enum transaction_queue_state state;
+	wait_queue_head_t wait;
+};
+
+int snd_efw_transaction_run(struct fw_unit *unit,
+			    const void *cmd, unsigned int cmd_size,
+			    void *resp, unsigned int resp_size, u32 seqnum)
+{
+	struct transaction_queue t;
+	unsigned int tries;
+	int ret;
+
+	t.unit = unit;
+	t.buf = resp;
+	t.size = resp_size;
+	t.seqnum = seqnum + 1;
+	t.state = STATE_PENDING;
+	init_waitqueue_head(&t.wait);
+
+	spin_lock_irq(&transaction_queues_lock);
+	list_add_tail(&t.list, &transaction_queues);
+	spin_unlock_irq(&transaction_queues_lock);
+
+	tries = 0;
+	do {
+		ret = snd_fw_transaction(unit, TCODE_WRITE_BLOCK_REQUEST,
+					 MEMORY_SPACE_EFW_COMMAND,
+					 (void *)cmd, cmd_size, 0);
+		if (ret < 0)
+			break;
+
+		wait_event_timeout(t.wait, t.state != STATE_PENDING,
+				   msecs_to_jiffies(EFC_TIMEOUT_MS));
+
+		if (t.state == STATE_COMPLETE) {
+			ret = t.size;
+			break;
+		} else if (t.state == STATE_BUS_RESET) {
+			msleep(ERROR_DELAY_MS);
+		} else if (++tries >= ERROR_RETRIES) {
+			dev_err(&t.unit->device, "EFC command timed out\n");
+			ret = -EIO;
+			break;
+		}
+	} while (1);
+
+	spin_lock_irq(&transaction_queues_lock);
+	list_del(&t.list);
+	spin_unlock_irq(&transaction_queues_lock);
+
+	return ret;
+}
+
+static void
+efw_response(struct fw_card *card, struct fw_request *request,
+	     int tcode, int destination, int source,
+	     int generation, unsigned long long offset,
+	     void *data, size_t length, void *callback_data)
+{
+	struct fw_device *device;
+	struct transaction_queue *t;
+	unsigned long flags;
+	int rcode;
+	u32 seqnum;
+
+	rcode = RCODE_TYPE_ERROR;
+	if (length < sizeof(struct snd_efw_transaction)) {
+		rcode = RCODE_DATA_ERROR;
+		goto end;
+	} else if (offset != MEMORY_SPACE_EFW_RESPONSE) {
+		rcode = RCODE_ADDRESS_ERROR;
+		goto end;
+	}
+
+	seqnum = be32_to_cpu(((struct snd_efw_transaction *)data)->seqnum);
+
+	spin_lock_irqsave(&transaction_queues_lock, flags);
+	list_for_each_entry(t, &transaction_queues, list) {
+		device = fw_parent_device(t->unit);
+		if ((device->card != card) ||
+		    (device->generation != generation))
+			continue;
+		smp_rmb();	/* node_id vs. generation */
+		if (device->node_id != source)
+			continue;
+
+		if ((t->state == STATE_PENDING) && (t->seqnum == seqnum)) {
+			t->state = STATE_COMPLETE;
+			t->size = min_t(unsigned int, length, t->size);
+			memcpy(t->buf, data, t->size);
+			wake_up(&t->wait);
+			rcode = RCODE_COMPLETE;
+		}
+	}
+	spin_unlock_irqrestore(&transaction_queues_lock, flags);
+end:
+	fw_send_response(card, request, rcode);
+}
+
+void snd_efw_transaction_bus_reset(struct fw_unit *unit)
+{
+	struct transaction_queue *t;
+
+	spin_lock_irq(&transaction_queues_lock);
+	list_for_each_entry(t, &transaction_queues, list) {
+		if ((t->unit == unit) &&
+		    (t->state == STATE_PENDING)) {
+			t->state = STATE_BUS_RESET;
+			wake_up(&t->wait);
+		}
+	}
+	spin_unlock_irq(&transaction_queues_lock);
+}
+
+static struct fw_address_handler resp_register_handler = {
+	.length = MEMORY_SPACE_EFW_END - MEMORY_SPACE_EFW_RESPONSE,
+	.address_callback = efw_response
+};
+
+int snd_efw_transaction_register(void)
+{
+	static const struct fw_address_region resp_register_region = {
+		.start	= MEMORY_SPACE_EFW_RESPONSE,
+		.end	= MEMORY_SPACE_EFW_END
+	};
+	return fw_core_add_address_handler(&resp_register_handler,
+					   &resp_register_region);
+}
+
+void snd_efw_transaction_unregister(void)
+{
+	WARN_ON(!list_empty(&transaction_queues));
+	fw_core_remove_address_handler(&resp_register_handler);
+}
-- 
1.8.3.2
