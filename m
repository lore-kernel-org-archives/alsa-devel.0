From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/13] bebob: Add command and stream management
Date: Sat, 23 Nov 2013 15:09:14 +0900
Message-ID: <1385186965-8303-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id F28032652E7
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:09:34 +0100 (CET)
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

This commit adds BridgeCo's AV/C extension commands and connection/stream
management. The driver can get channel combination with the commands.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/Makefile        |   3 +-
 sound/firewire/bebob/bebob.c         |  10 +
 sound/firewire/bebob/bebob.h         |  83 +++++
 sound/firewire/bebob/bebob_command.c | 263 ++++++++++++++
 sound/firewire/bebob/bebob_stream.c  | 666 +++++++++++++++++++++++++++++++++++
 5 files changed, 1024 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/bebob/bebob_command.c
 create mode 100644 sound/firewire/bebob/bebob_stream.c

diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index c6f0141..b29ca99 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,2 +1,3 @@
-snd-bebob-objs := bebob.o
+snd-bebob-objs := bebob_command.o bebob_stream.o \
+		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index bec4b6f..3597a3e 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -177,6 +177,14 @@ snd_bebob_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_bebob_stream_discover(bebob);
+	if (err < 0)
+		goto error;
+
+	err = snd_bebob_stream_init_duplex(bebob);
+	if (err < 0)
+		goto error;
+
 	/* register card and device */
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
@@ -204,12 +212,14 @@ snd_bebob_update(struct fw_unit *unit)
 {
 	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
 	fcp_bus_reset(bebob->unit);
+	snd_bebob_stream_update_duplex(bebob);
 }
 
 
 static void snd_bebob_remove(struct fw_unit *unit)
 {
 	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
+	snd_bebob_stream_destroy_duplex(bebob);
 	snd_card_disconnect(bebob->card);
 	snd_card_free_when_closed(bebob->card);
 }
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 60d875e..f8f3025 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -30,13 +30,27 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 
+#include "../packets-buffer.h"
+#include "../iso-resources.h"
+#include "../amdtp.h"
 #include "../lib.h"
+#include "../cmp.h"
 #include "../fcp.h"
 
 /* basic register addresses on bebob chip */
 #define BEBOB_ADDR_REG_INFO	0xffffc8020000
 #define BEBOB_ADDR_REG_REQ	0xffffc8021000
 
+struct snd_bebob;
+
+#define SND_BEBOB_STRM_FMT_ENTRIES	9
+struct snd_bebob_stream_formation {
+	unsigned int pcm;
+	unsigned int midi;
+};
+/* this is a lookup table for index of stream formations */
+extern const unsigned int snd_bebob_rate_table[SND_BEBOB_STRM_FMT_ENTRIES];
+
 struct snd_bebob {
         struct snd_card *card;
         struct fw_device *device;
@@ -45,6 +59,20 @@ struct snd_bebob {
 
         struct mutex mutex;
         spinlock_t lock;
+
+	unsigned int midi_input_ports;
+	unsigned int midi_output_ports;
+
+	struct cmp_connection out_conn;
+	struct amdtp_stream tx_stream;
+	struct cmp_connection in_conn;
+	struct amdtp_stream rx_stream;
+
+	struct snd_bebob_stream_formation
+		tx_stream_formations[SND_BEBOB_STRM_FMT_ENTRIES];
+	struct snd_bebob_stream_formation
+		rx_stream_formations[SND_BEBOB_STRM_FMT_ENTRIES];
+
 };
 
 static inline int
@@ -63,6 +91,61 @@ snd_bebob_read_quad(struct snd_bebob *bebob, u64 addr, void *buf, int size)
 				  buf, size, 0);
 }
 
+/* AVC command extensions, AV/C Unit and Subunit, Revision 17 (BridgeCo.) */
+enum snd_bebob_plug_dir {
+	SND_BEBOB_PLUG_DIR_IN	= 0x00,
+	SND_BEBOB_PLUG_DIR_OUT	= 0x01
+};
+enum snd_bebob_plug_unit {
+	SND_BEBOB_PLUG_UNIT_ISOC	= 0x00,
+	SND_BEBOB_PLUG_UNIT_EXT		= 0x01,
+	SND_BEBOB_PLUG_UNIT_ASYNC	= 0x02
+};
+enum snd_bebob_plug_type {
+	SND_BEBOB_PLUG_TYPE_ISOC	= 0x00,
+	SND_BEBOB_PLUG_TYPE_ASYNC	= 0x01,
+	SND_BEBOB_PLUG_TYPE_MIDI	= 0x02,
+	SND_BEBOB_PLUG_TYPE_SYNC	= 0x03,
+	SND_BEBOB_PLUG_TYPE_ANA		= 0x04,
+	SND_BEBOB_PLUG_TYPE_DIG		= 0x05
+};
+int avc_bridgeco_get_plug_ch_pos(struct fw_unit *unit,
+				 enum snd_bebob_plug_dir pdir,
+				 unsigned short pid, u8 *buf, unsigned int len);
+int avc_bridgeco_get_plug_type(struct fw_unit *unit,
+			       enum snd_bebob_plug_dir pdir,
+			       enum snd_bebob_plug_unit punit,
+			       unsigned short p_id,
+			       enum snd_bebob_plug_type *type);
+int avc_bridgeco_get_plug_cluster_type(struct fw_unit *unit,
+				       enum snd_bebob_plug_dir pdir,
+				       unsigned int pid, unsigned int cluster_id,
+				       u8 *ctype);
+int avc_bridgeco_get_plug_strm_fmt(struct fw_unit *unit,
+				   enum snd_bebob_plug_dir pdir,
+				   unsigned short pid,
+				   unsigned int entryid, u8 *buf,
+				   unsigned int *len);
+
+int snd_bebob_get_rate(struct snd_bebob *bebob, unsigned int *rate,
+                       enum avc_general_plug_dir dir);
+int snd_bebob_set_rate(struct snd_bebob *bebob, unsigned int rate,
+                       enum avc_general_plug_dir dir);
+
+/* for AMDTP streaming */
+int snd_bebob_stream_get_rate(struct snd_bebob *bebob, unsigned int *rate);
+int snd_bebob_stream_set_rate(struct snd_bebob *bebob, unsigned int rate);
+int snd_bebob_stream_discover(struct snd_bebob *bebob);
+int snd_bebob_stream_map(struct snd_bebob *bebob,
+			 struct amdtp_stream *stream);
+int snd_bebob_stream_init_duplex(struct snd_bebob *bebob);
+int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
+				  struct amdtp_stream *stream,
+				   unsigned int sampling_rate);
+int snd_bebob_stream_stop_duplex(struct snd_bebob *bebob);
+void snd_bebob_stream_update_duplex(struct snd_bebob *bebob);
+void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_command.c b/sound/firewire/bebob/bebob_command.c
new file mode 100644
index 0000000..98b7668
--- /dev/null
+++ b/sound/firewire/bebob/bebob_command.c
@@ -0,0 +1,263 @@
+/*
+ * bebob_command.c - driver for BeBoB based devices
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
+#define BEBOB_COMMAND_MAX_TRIAL	3
+#define BEBOB_COMMAND_WAIT_MSEC	100
+
+int avc_bridgeco_get_plug_type(struct fw_unit *unit,
+			       enum snd_bebob_plug_dir pdir,
+			       enum snd_bebob_plug_unit punit,
+			       unsigned short pid,
+			       enum snd_bebob_plug_type *type)
+{
+	u8 *buf;
+	int err;
+
+	buf = kzalloc(12, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0] = 0x01;		/* AV/C STATUS */
+	buf[1] = 0xff;		/* UNIT */
+	buf[2] = 0x02;		/* PLUG INFO */
+	buf[3] = 0xC0;		/* Extended Plug Info */
+	buf[4] = pdir;		/* plug direction */
+	buf[5] = 0x00;		/* address mode [0x00/0x01/0x02] */
+	buf[6] = punit;		/* plug unit type */
+	buf[7]  = 0xff & pid;	/* plug id */
+	buf[8]  = 0xff;		/* reserved */
+	buf[9]  = 0x00;		/* info type is 'plug type' */
+	buf[10] = 0xff;		/* plug type in response */
+
+	/* do transaction and check buf[1-7,9] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 12, buf, 12,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(7) | BIT(9));
+	if (err < 0)
+		goto end;
+	/* IMPLEMENTED/STABLE is OK */
+	else if ((err < 6) || (buf[0] != 0x0c)) {
+		err = -EIO;
+		goto end;
+	}
+
+	*type = buf[10];
+	err = 0;
+
+end:
+	kfree(buf);
+	return err;
+}
+
+int avc_bridgeco_get_plug_ch_pos(struct fw_unit *unit,
+				 enum snd_bebob_plug_dir pdir,
+				 unsigned short pid, u8 *buf, unsigned int len)
+{
+	unsigned int trial;
+	int err;
+
+	/* check given buffer */
+	if ((buf == NULL) || (len < 256)) {
+		err = -EINVAL;
+		goto end;
+	}
+
+	buf[0] = 0x01;		/* AV/C STATUS */
+	buf[1] = 0xff;		/* Unit */
+	buf[2] = 0x02;		/* PLUG INFO */
+	buf[3] = 0xC0;		/* Extended Plug Info */
+	buf[4] = pdir;		/* plug direction */
+	buf[5] = 0x00;		/* address mode is 'Unit' */
+	buf[6] = 0x00;		/* plug unit type is 'ISOC'*/
+	buf[7] = 0xff & pid;	/* plug id */
+	buf[8] = 0xff;		/* reserved */
+	buf[9] = 0x03;		/* info type is 'channel position' */
+
+	/*
+	 * NOTE:
+	 * M-Audio Firewire 410 returns 0x09 (ACCEPTED) just after changing
+	 * signal format even if this command asks STATE. This is not in
+	 * AV/C command specification.
+	 */
+	for (trial = 0; trial < BEBOB_COMMAND_MAX_TRIAL; trial++) {
+		/* do transaction and check buf[1-7,9] are the same */
+		err = fcp_avc_transaction(unit, buf, 12, buf, 256,
+					  BIT(1) | BIT(2) | BIT(3) | BIT(4) |
+					  BIT(5) | BIT(6) | BIT(7) | BIT(9));
+		if (err < 0)
+			goto end;
+		else if (err < 6) {
+			err = -EIO;
+			goto end;
+		} else if (buf[0] == 0x0c)
+			break;
+		else if (trial < BEBOB_COMMAND_MAX_TRIAL)
+			msleep(BEBOB_COMMAND_WAIT_MSEC);
+		else {
+			err = -EIO;
+			goto end;
+		}
+	}
+
+	/* strip command header */
+	memmove(buf, buf + 10, err - 10);
+	err = 0;
+end:
+	return err;
+}
+
+int avc_bridgeco_get_plug_cluster_type(struct fw_unit *unit,
+				       enum snd_bebob_plug_dir pdir,
+				       unsigned int pid, unsigned int cluster_id,
+				       u8 *type)
+{
+	u8 *buf;
+	int err;
+
+	/* cluster info includes characters but this module don't need it */
+	buf = kzalloc(12, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0] = 0x01;		/* AV/C STATUS */
+	buf[1] = 0xff;		/* UNIT */
+	buf[2] = 0x02;		/* PLUG INFO */
+	buf[3] = 0xc0;		/* Extended Plug Info */
+	buf[4] = pdir;		/* plug direction */
+	buf[5] = 0x00;		/* address mode is 'Unit' */
+	buf[6] = 0x00;		/* plug unit type is 'ISOC' */
+	buf[7] = 0xff & pid;	/* plug id */
+	buf[8] = 0xff;		/* reserved */
+	buf[9] = 0x07;		/* info type is 'cluster info' */
+	buf[10] = 0xff & (cluster_id + 1);	/* cluster id */
+	buf[11] = 0x00;		/* type in response */
+
+	/* do transaction and check buf[1-7,9,10] are the same */
+	err = fcp_avc_transaction(unit, buf, 12, buf, 12,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(7) | BIT(9) | BIT(10));
+	if (err < 0)
+		goto end;
+	else if ((err < 12) && (buf[0] != 0x0c)) {
+		err = -EIO;
+		goto end;
+	}
+
+	*type = buf[11];
+	err = 0;
+end:
+	kfree(buf);
+	return err;
+}
+
+int avc_bridgeco_get_plug_strm_fmt(struct fw_unit *unit,
+				   enum snd_bebob_plug_dir pdir,
+				   unsigned short pid,
+				   unsigned int entryid, u8 *buf,
+				   unsigned int *len)
+{
+	int err;
+
+	/* check given buffer */
+	if ((buf == NULL) || (*len < 12)) {
+		err = -EINVAL;
+		goto end;
+	}
+
+	/* fill buffer as command */
+	buf[0] = 0x01;			/* AV/C STATUS */
+	buf[1] = 0xff;			/* unit */
+	buf[2] = 0x2f;			/* opcode is STREAM FORMAT SUPPORT */
+	buf[3] = 0xc1;			/* COMMAND LIST, BridgeCo extension */
+	buf[4] = pdir;			/* plug direction */
+	buf[5] = 0x00;			/* address mode is 'Unit' */
+	buf[6] = 0x00;			/* plug unit type is 'ISOC' */
+	buf[7] = 0xff & pid;		/* plug ID */
+	buf[8] = 0xff;			/* reserved */
+	buf[9] = 0xff;			/* stream status in response */
+	buf[10] = 0xff & entryid;	/* entry ID */
+
+	/* do transaction and check buf[1-7,10] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 12, buf, *len,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(7) | BIT(10));
+	if (err < 0)
+		goto end;
+	/* reach the end of entries */
+	else if (buf[0] == 0x0a) {
+		err = 0;
+		*len = 0;
+		goto end;
+	} else if (buf[0] != 0x0c) {
+		err = -EINVAL;
+		goto end;
+	/* the header of this command is 11 bytes */
+	} else if (err < 12) {
+		err = -EIO;
+		goto end;
+	} else if (buf[10] != entryid) {
+		err = -EIO;
+		goto end;
+	}
+
+	/* strip command header */
+	memmove(buf, buf + 11, err - 11);
+	*len = err - 11;
+	err = 0;
+end:
+	return err;
+}
+
+int snd_bebob_get_rate(struct snd_bebob *bebob, unsigned int *rate,
+		       enum avc_general_plug_dir dir)
+{
+	int err;
+
+	err = avc_general_get_sig_fmt(bebob->unit, rate, dir, 0);
+	if (err < 0)
+		goto end;
+
+	/* IMPLEMENTED/STABLE is OK */
+	if (err != 0x0c) {
+		dev_err(&bebob->unit->device,
+			"failed to get sampling rate\n");
+		err = -EIO;
+	}
+end:
+	return err;
+}
+
+int snd_bebob_set_rate(struct snd_bebob *bebob, unsigned int rate,
+		       enum avc_general_plug_dir dir)
+{
+	int err;
+
+	err = avc_general_set_sig_fmt(bebob->unit, rate, dir, 0);
+	if (err < 0)
+		goto end;
+
+	/* ACCEPTED or INTERIM is OK */
+	if ((err != 0x0f) && (err != 0x09)) {
+		dev_err(&bebob->unit->device,
+			"failed to set sampling rate\n");
+		err = -EIO;
+	}
+end:
+	return err;
+}
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
new file mode 100644
index 0000000..6852945
--- /dev/null
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -0,0 +1,666 @@
+/*
+ * bebob_stream.c - a part of driver for BeBoB based devices
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
+ * NOTE;
+ * For BeBoB streams, Both of input and output CMP connection is important.
+ *
+ * [Communication with Windows driver] According to logs of IEEE1394 packets,
+ * all models seem to make both of connections when booting.
+ *
+ * [Actual behavior] In some devices, one CMP connection starts to
+ * transmit/receive a corresponding stream. But in the others, both of CMP
+ * connection needs to start transmitting stream. An example of the latter is
+ * 'M-Audio Firewire 410'.
+ */
+
+/* 128 is an arbitrary length but it seems to be enough */
+#define FORMAT_MAXIMUM_LENGTH 128
+
+const unsigned int snd_bebob_rate_table[SND_BEBOB_STRM_FMT_ENTRIES] = {
+	[0] = 22050,
+	[1] = 24000,
+	[2] = 32000,
+	[3] = 44100,
+	[4] = 48000,
+	[5] = 88200,
+	[6] = 96000,
+	[7] = 176400,
+	[8] = 192000,
+};
+
+static unsigned int
+get_formation_index(unsigned int rate)
+{
+	unsigned int i;
+
+	for (i = 0; i < sizeof(snd_bebob_rate_table); i++) {
+		if (snd_bebob_rate_table[i] == rate)
+			return i;
+	}
+	return -1;
+}
+
+int
+snd_bebob_stream_get_rate(struct snd_bebob *bebob, unsigned int *curr_rate)
+{
+	unsigned int tx_rate, rx_rate;
+	int err;
+
+	err = snd_bebob_get_rate(bebob, &tx_rate, AVC_GENERAL_PLUG_DIR_OUT);
+	if (err < 0)
+		goto end;
+
+	err = snd_bebob_get_rate(bebob, &rx_rate, AVC_GENERAL_PLUG_DIR_IN);
+	if (err < 0)
+		goto end;
+
+	*curr_rate = rx_rate;
+	if (rx_rate == tx_rate)
+		goto end;
+
+	/* synchronize receive stream rate to transmit stream rate */
+	err = snd_bebob_set_rate(bebob, rx_rate, AVC_GENERAL_PLUG_DIR_IN);
+end:
+	return err;
+}
+
+int
+snd_bebob_stream_set_rate(struct snd_bebob *bebob, unsigned int rate)
+{
+	int err;
+
+	/* TODO: move to strem_start? */
+	err = snd_bebob_set_rate(bebob, rate, AVC_GENERAL_PLUG_DIR_OUT);
+	if (err < 0)
+		goto end;
+
+	err = snd_bebob_set_rate(bebob, rate, AVC_GENERAL_PLUG_DIR_IN);
+end:
+	return err;
+}
+
+int snd_bebob_stream_map(struct snd_bebob *bebob,
+			 struct amdtp_stream *stream)
+{
+	unsigned int cl, ch, clusters, channels, pos, pcm, midi;
+	u8 *buf, ctype;
+	enum snd_bebob_plug_dir dir;
+	int err;
+
+	/*
+	 * The length of return value of this command cannot be assumed. Here
+	 * keep the maximum length of AV/C command which defined specification.
+	 */
+	buf = kzalloc(256, GFP_KERNEL);
+	if (buf == NULL) {
+		err = -ENOMEM;
+		goto end;
+	}
+
+	if (stream == &bebob->tx_stream)
+		dir = SND_BEBOB_PLUG_DIR_OUT;
+	else
+		dir = SND_BEBOB_PLUG_DIR_IN;
+
+	err = avc_bridgeco_get_plug_ch_pos(bebob->unit, dir, 0, buf, 256);
+	if (err < 0)
+		goto end;
+
+	clusters = *buf;
+	buf++;
+	pcm = 0;
+	midi = 0;
+	for (cl = 0; cl < clusters; cl++) {
+		err = avc_bridgeco_get_plug_cluster_type(bebob->unit, dir, 0,
+							 cl, &ctype);
+		if (err < 0)
+			goto end;
+
+		channels = *buf;
+		buf++;
+		for (ch = 0; ch < channels; ch++) {
+			pos = *buf - 1;
+			if (ctype != 0x0a)
+				stream->pcm_positions[pcm++] = pos;
+			else
+				stream->midi_positions[midi++] = pos;
+			buf += 2;
+		}
+	}
+
+end:
+	return err;
+}
+
+static int
+init_both_connections(struct snd_bebob *bebob)
+{
+	int err;
+
+	err = cmp_connection_init(&bebob->in_conn,
+				  bebob->unit, CMP_INPUT, 0);
+	if (err < 0)
+		goto end;
+
+	err = cmp_connection_init(&bebob->out_conn,
+				  bebob->unit, CMP_OUTPUT, 0);
+	if (err < 0)
+		cmp_connection_destroy(&bebob->in_conn);
+end:
+	return err;
+}
+
+static int
+check_connection_used_by_others(struct snd_bebob *bebob,
+				struct amdtp_stream *s, bool *used)
+{
+	struct cmp_connection *conn;
+	int err;
+
+	if (s == &bebob->tx_stream)
+		conn = &bebob->out_conn;
+	else
+		conn = &bebob->in_conn;
+
+	err = cmp_connection_check_used(conn, used);
+	if (err >= 0)
+		*used = (*used && !amdtp_stream_running(s));
+
+	return err;
+}
+
+static int
+make_both_connections(struct snd_bebob *bebob, unsigned int rate)
+{
+	int index, pcm_channels, midi_channels, err;
+
+	/* confirm params for both streams */
+	index = get_formation_index(rate);
+	pcm_channels = bebob->tx_stream_formations[index].pcm;
+	midi_channels = bebob->tx_stream_formations[index].midi;
+	amdtp_stream_set_parameters(&bebob->tx_stream,
+				    rate, pcm_channels, midi_channels * 8);
+	pcm_channels = bebob->rx_stream_formations[index].pcm;
+	midi_channels = bebob->rx_stream_formations[index].midi;
+	amdtp_stream_set_parameters(&bebob->rx_stream,
+				    rate, pcm_channels, midi_channels * 8);
+
+	/* establish connections for both streams */
+	err = cmp_connection_establish(&bebob->out_conn,
+				amdtp_stream_get_max_payload(&bebob->tx_stream));
+	if (err < 0)
+		goto end;
+	err = cmp_connection_establish(&bebob->in_conn,
+				amdtp_stream_get_max_payload(&bebob->rx_stream));
+	if (err < 0)
+		cmp_connection_break(&bebob->out_conn);
+end:
+	return err;
+}
+
+static void
+break_both_connections(struct snd_bebob *bebob)
+{
+	cmp_connection_break(&bebob->in_conn);
+	cmp_connection_break(&bebob->out_conn);
+	return;
+}
+
+static void
+destroy_both_connections(struct snd_bebob *bebob)
+{
+	break_both_connections(bebob);
+
+	cmp_connection_destroy(&bebob->in_conn);
+	cmp_connection_destroy(&bebob->out_conn);
+}
+
+static int
+get_roles(struct snd_bebob *bebob, enum cip_flags *sync_mode,
+	  struct amdtp_stream **master, struct amdtp_stream **slave)
+{
+	/* currently this module doesn't support SYT-Match mode */
+	*sync_mode = CIP_SYNC_TO_DEVICE;
+	*master = &bebob->tx_stream;
+	*slave = &bebob->rx_stream;
+
+	return 0;
+}
+
+static int
+start_stream(struct snd_bebob *bebob, struct amdtp_stream *stream,
+	     unsigned int rate)
+{
+	struct cmp_connection *conn;
+	int err = 0;
+
+	/* already running */
+	if (amdtp_stream_running(stream))
+		goto end;
+
+	if (stream == &bebob->rx_stream)
+		conn = &bebob->in_conn;
+	else
+		conn = &bebob->out_conn;
+
+	/* channel mapping */
+	err = snd_bebob_stream_map(bebob, stream);
+	if (err < 0)
+		goto end;
+
+	/* start amdtp stream */
+	err = amdtp_stream_start(stream,
+				 conn->resources.channel,
+				 conn->speed);
+end:
+	return err;
+}
+
+int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
+{
+	int err;
+
+	err = init_both_connections(bebob);
+	if (err < 0)
+		goto end;
+
+	err = amdtp_stream_init(&bebob->tx_stream, bebob->unit,
+				AMDTP_TRANSMIT_STREAM, CIP_BLOCKING);
+	if (err < 0) {
+		destroy_both_connections(bebob);
+		goto end;
+	}
+
+	err = amdtp_stream_init(&bebob->rx_stream, bebob->unit,
+				AMDTP_RECEIVE_STREAM, CIP_BLOCKING);
+	if (err < 0) {
+		amdtp_stream_destroy(&bebob->tx_stream);
+		destroy_both_connections(bebob);
+	}
+end:
+	return err;
+}
+
+int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
+				  struct amdtp_stream *request,
+				  unsigned int rate)
+{
+	struct amdtp_stream *master, *slave;
+	enum cip_flags sync_mode;
+	unsigned int curr_rate;
+	bool slave_flag, used;
+	int err;
+
+	mutex_lock(&bebob->mutex);
+
+	err = get_roles(bebob, &sync_mode, &master, &slave);
+	if (err < 0)
+		goto end;
+
+	if ((request == slave) || amdtp_stream_running(slave))
+		slave_flag = true;
+	else
+		slave_flag = false;
+
+	/*
+	 * Considering JACK/FFADO streaming:
+	 * TODO: This can be removed hwdep functionality becomes popular.
+	 */
+	err = check_connection_used_by_others(bebob, master, &used);
+	if (err < 0)
+		goto end;
+	if (used) {
+		dev_err(&bebob->unit->device,
+			"connections established by others: %d\n",
+			used);
+		err = -EBUSY;
+		goto end;
+	}
+
+	/* get current rate */
+	err = snd_bebob_stream_get_rate(bebob, &curr_rate);
+	if (err < 0)
+		goto end;
+	if (rate == 0)
+		rate = curr_rate;
+
+	/* change sampling rate if needed */
+	if (rate != curr_rate) {
+		/* slave is just for MIDI stream */
+		if (amdtp_stream_running(slave) &&
+		    !amdtp_stream_pcm_running(slave))
+			amdtp_stream_stop(slave);
+
+		/* master is just for MIDI stream */
+		if (amdtp_stream_running(master) &&
+		    !amdtp_stream_pcm_running(master)) {
+			amdtp_stream_stop(master);
+			break_both_connections(bebob);
+		}
+	}
+
+	/* master should be always running */
+	if (!amdtp_stream_running(master)) {
+		amdtp_stream_set_sync(sync_mode, master, slave);
+
+		/*
+		 * NOTE:
+		 * If establishing connections at first, Yamaha GO46 (and maybe
+		 * TerraTek X24) don't generate sound.
+		 */
+		err = snd_bebob_stream_set_rate(bebob, rate);
+		if (err < 0)
+			goto end;
+
+		err = make_both_connections(bebob, rate);
+		if (err < 0)
+			goto end;
+
+		err = start_stream(bebob, master, rate);
+		if (err < 0) {
+			dev_err(&bebob->unit->device,
+				"fail to run AMDTP master stream:%d\n", err);
+			break_both_connections(bebob);
+			goto end;
+		}
+
+		/* wait first callback */
+		if (!amdtp_stream_wait_callback(master)) {
+			amdtp_stream_stop(master);
+			break_both_connections(bebob);
+			err = -ETIMEDOUT;
+			goto end;
+		}
+	}
+
+	/* start slave if needed */
+	if (slave_flag && !amdtp_stream_running(slave)) {
+		err = start_stream(bebob, slave, rate);
+		if (err < 0) {
+			dev_err(&bebob->unit->device,
+				"fail to run AMDTP slave stream:%d\n", err);
+			amdtp_stream_stop(master);
+			break_both_connections(bebob);
+			goto end;
+		}
+
+		/* wait first callback */
+		if (!amdtp_stream_wait_callback(slave)) {
+			amdtp_stream_stop(slave);
+			amdtp_stream_stop(master);
+			break_both_connections(bebob);
+			err = -ETIMEDOUT;
+			goto end;
+		}
+	}
+end:
+	mutex_unlock(&bebob->mutex);
+	return err;
+}
+
+int snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
+{
+	struct amdtp_stream *master, *slave;
+	enum cip_flags sync_mode;
+	int err;
+
+	mutex_lock(&bebob->mutex);
+
+	err = get_roles(bebob, &sync_mode, &master, &slave);
+	if (err < 0)
+		goto end;
+
+	if (amdtp_stream_pcm_running(slave) ||
+	    amdtp_stream_midi_running(slave))
+		goto end;
+
+	amdtp_stream_stop(slave);
+
+	if (amdtp_stream_pcm_running(master) ||
+	    amdtp_stream_midi_running(master))
+		goto end;
+
+	amdtp_stream_stop(master);
+	break_both_connections(bebob);
+end:
+	mutex_unlock(&bebob->mutex);
+	return err;
+}
+
+void snd_bebob_stream_update_duplex(struct snd_bebob *bebob)
+{
+	if ((cmp_connection_update(&bebob->in_conn) > 0) ||
+	    (cmp_connection_update(&bebob->out_conn) > 0)) {
+		mutex_lock(&bebob->mutex);
+		amdtp_stream_pcm_abort(&bebob->rx_stream);
+		amdtp_stream_pcm_abort(&bebob->tx_stream);
+		break_both_connections(bebob);
+		mutex_unlock(&bebob->mutex);
+	}
+
+	amdtp_stream_update(&bebob->rx_stream);
+	amdtp_stream_update(&bebob->tx_stream);
+}
+
+void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob)
+{
+	mutex_lock(&bebob->mutex);
+
+	if (amdtp_stream_pcm_running(&bebob->rx_stream))
+		amdtp_stream_pcm_abort(&bebob->rx_stream);
+	if (amdtp_stream_pcm_running(&bebob->tx_stream))
+		amdtp_stream_pcm_abort(&bebob->tx_stream);
+
+	amdtp_stream_stop(&bebob->rx_stream);
+	amdtp_stream_stop(&bebob->tx_stream);
+	destroy_both_connections(bebob);
+
+	mutex_unlock(&bebob->mutex);
+}
+
+static void
+set_stream_formation(u8 *buf, unsigned int len,
+		     struct snd_bebob_stream_formation *formation)
+{
+	unsigned int e, channels, format;
+
+	for (e = 0; e < buf[4]; e++) {
+		channels = buf[5 + e * 2];
+		format = buf[6 + e * 2];
+
+		switch (format) {
+		/* PCM for IEC 60958-3 */
+		case 0x00:
+		/* PCM for IEC 61937-3 to 7 */
+		case 0x01:
+		case 0x02:
+		case 0x03:
+		case 0x04:
+		case 0x05:
+		/* PCM for Multi bit linear audio */
+		case 0x06:	/* raw */
+		case 0x07:	/* DVD-Audio */
+			formation->pcm += channels;
+			break;
+		/* MIDI comformant (MMA/AMEI RP-027) */
+		case 0x0d:
+			formation->midi += channels;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return;
+}
+
+static int
+fill_stream_formations(struct snd_bebob *bebob, enum snd_bebob_plug_dir dir,
+		       unsigned short pid)
+{
+	static const unsigned int freq_table[] = {
+		[0x00] = 0,	/*  22050 */
+		[0x01] = 1,	/*  24000 */
+		[0x02] = 2,	/*  32000 */
+		[0x03] = 3,	/*  44100 */
+		[0x04] = 4,	/*  48000 */
+		[0x05] = 6,	/*  96000 */
+		[0x06] = 7,	/* 176400 */
+		[0x07] = 8,	/* 192000 */
+		[0x0a] = 5	/*  88200 */
+	};
+
+	u8 *buf;
+	struct snd_bebob_stream_formation *formations;
+	unsigned int i, index, len, eid;
+	int err;
+
+	buf = kmalloc(FORMAT_MAXIMUM_LENGTH, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	if (dir == SND_BEBOB_PLUG_DIR_IN)
+		formations = bebob->rx_stream_formations;
+	else
+		formations = bebob->tx_stream_formations;
+
+	for (eid = 0, index = 0; eid < SND_BEBOB_STRM_FMT_ENTRIES; eid++) {
+		len = FORMAT_MAXIMUM_LENGTH;
+
+		memset(buf, 0, len);
+		err = avc_bridgeco_get_plug_strm_fmt(bebob->unit, dir, pid,
+						     eid, buf, &len);
+		if (err < 0)
+			goto end;
+		else if (len < 3)
+			break;
+		/*
+		 * this module can support a hierarchy combination that:
+		 *  Root:	Audio and Music (0x90)
+		 *  Level 1:	AM824 Compound  (0x40)
+		 */
+		else if ((buf[0] != 0x90) || (buf[1] != 0x40))
+			break;
+
+		/* check sampling rate */
+		index = -1;
+		for (i = 0; i < sizeof(freq_table); i++) {
+			if (i == buf[2])
+				index = freq_table[i];
+		}
+		if (index < 0)
+			break;
+
+		/* parse and set stream formation */
+		set_stream_formation(buf, len, &formations[index]);
+	}
+
+	err = 0;
+end:
+	kfree(buf);
+	return err;
+}
+
+/* In this function, 2 means input and output */
+int snd_bebob_stream_discover(struct snd_bebob *bebob)
+{
+	/* the number of plugs for input and output */
+	unsigned short bus_plugs[AVC_GENERAL_PLUG_DIR_COUNT];
+	unsigned short ext_plugs[AVC_GENERAL_PLUG_DIR_COUNT];
+	enum snd_bebob_plug_type type;
+	unsigned int i;
+	int err;
+
+	err = avc_general_get_plug_info(bebob->unit, bus_plugs, ext_plugs);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * This module supports one ISOC input plug and one ISOC output plug
+	 * then ignores the others.
+	 */
+	if (bus_plugs[AVC_GENERAL_PLUG_DIR_IN] == 0) {
+		err = -EIO;
+		goto end;
+	}
+	err = avc_bridgeco_get_plug_type(bebob->unit,
+					 SND_BEBOB_PLUG_DIR_IN,
+					 SND_BEBOB_PLUG_UNIT_ISOC,
+					 0, &type);
+	if (err < 0)
+		goto end;
+	else if (type != SND_BEBOB_PLUG_TYPE_ISOC) {
+		err = -EIO;
+		goto end;
+	}
+
+	if (bus_plugs[AVC_GENERAL_PLUG_DIR_OUT] == 0) {
+		err = -EIO;
+		goto end;
+	}
+	err = avc_bridgeco_get_plug_type(bebob->unit,
+					 SND_BEBOB_PLUG_DIR_OUT,
+					 SND_BEBOB_PLUG_UNIT_ISOC,
+					 0, &type);
+	if (err < 0)
+		goto end;
+	else if (type != SND_BEBOB_PLUG_TYPE_ISOC) {
+		err = -EIO;
+		goto end;
+	}	
+
+	/* store formations */
+	for (i = 0; i < 2; i++) {
+		err = fill_stream_formations(bebob, i, 0);
+		if (err < 0)
+			goto end;
+	}
+
+	/* count external input plugs for MIDI */
+	bebob->midi_input_ports = 0;
+	for (i = 0; i < ext_plugs[0]; i++) {
+		err = avc_bridgeco_get_plug_type(bebob->unit,
+						 SND_BEBOB_PLUG_DIR_IN,
+						 SND_BEBOB_PLUG_UNIT_EXT,
+						 i, &type);
+		if (err < 0)
+			goto end;
+		else if (type == SND_BEBOB_PLUG_TYPE_MIDI)
+			bebob->midi_input_ports++;
+	}
+
+	/* count external output plugs for MIDI */
+	bebob->midi_output_ports = 0;
+	for (i = 0; i < ext_plugs[1]; i++) {
+		err = avc_bridgeco_get_plug_type(bebob->unit,
+						 SND_BEBOB_PLUG_DIR_OUT,
+						 SND_BEBOB_PLUG_UNIT_EXT,
+						 i, &type);
+		if (err < 0)
+			goto end;
+		else if (type == SND_BEBOB_PLUG_TYPE_MIDI)
+			bebob->midi_output_ports++;
+	}
+
+	err = 0;
+
+end:
+	return err;
+}
-- 
1.8.3.2
