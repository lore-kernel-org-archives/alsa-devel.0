From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 27/38] bebob: Add commands and connections/streams management
Date: Fri, 20 Dec 2013 22:14:18 +0900
Message-ID: <1387545269-3875-28-git-send-email-o-takashi@sakamocchi.jp>
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

This commit adds management functionality for connections and streams.
DM1000/BeBob uses CMP to manage connections and uses AMDTP for streams.

This commit also adds some BridgeCo's AV/C extension commands. There are many
BridgeCo's AV/C extension commands but this commit adds below commands to get
device's capability and status:

 1.Extended Plug Info commands
  - Plug Channel Position Specific Data
  - Plug Type Specific Data
  - Cluster(Section) Info Specific Data
  - Plug Input Specific Data
 2.Extended Stream Format Information commands
  - Extended Stream Format Information Command - Single Request

For Extended Plug Info commands for Cluster Info Specific Data, I pick up
'section' instead of 'cluster' from document to prevent from misunderstanding
because 'cluster' is also used in IEC 61883-6.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/Makefile        |   2 +-
 sound/firewire/bebob/bebob.c         |  10 +
 sound/firewire/bebob/bebob.h         | 120 ++++++
 sound/firewire/bebob/bebob_command.c | 273 +++++++++++++
 sound/firewire/bebob/bebob_stream.c  | 773 +++++++++++++++++++++++++++++++++++
 5 files changed, 1177 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/bebob/bebob_command.c
 create mode 100644 sound/firewire/bebob/bebob_stream.c

diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index c6f0141..5cece62 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,2 +1,2 @@
-snd-bebob-objs := bebob.o
+snd-bebob-objs := bebob_command.o bebob_stream.o bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 83916ad..dbb897a 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -160,6 +160,14 @@ bebob_probe(struct fw_unit *unit,
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
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0) {
@@ -183,12 +191,14 @@ bebob_update(struct fw_unit *unit)
 {
 	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
 	fcp_bus_reset(bebob->unit);
+	snd_bebob_stream_update_duplex(bebob);
 }
 
 
 static void bebob_remove(struct fw_unit *unit)
 {
 	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
+	snd_bebob_stream_destroy_duplex(bebob);
 	snd_card_disconnect(bebob->card);
 	snd_card_free_when_closed(bebob->card);
 }
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index a321c43..125dbea 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -23,11 +23,25 @@
 
 #include "../lib.h"
 #include "../fcp.h"
+#include "../packets-buffer.h"
+#include "../iso-resources.h"
+#include "../amdtp.h"
+#include "../cmp.h"
 
 /* basic register addresses on DM1000 */
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
@@ -36,6 +50,21 @@ struct snd_bebob {
 
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
+	int sync_input_plug;
 };
 
 static inline int
@@ -54,6 +83,97 @@ snd_bebob_read_quad(struct fw_unit *unit, u64 addr, u32 *buf)
 				  (void *)buf, sizeof(u32), 0);
 }
 
+/*
+ * AVC command extensions, AV/C Unit and Subunit, Revision 17
+ * (Nov 2003, BridgeCo)
+ */
+#define	AVC_BRIDGECO_ADDR_BYTES	6
+enum avc_bridgeco_plug_dir {
+	AVC_BRIDGECO_PLUG_DIR_IN	= 0x00,
+	AVC_BRIDGECO_PLUG_DIR_OUT	= 0x01
+};
+enum avc_bridgeco_plug_mode {
+	AVC_BRIDGECO_PLUG_MODE_UNIT		= 0x00,
+	AVC_BRIDGECO_PLUG_MODE_SUBUNIT		= 0x01,
+	AVC_BRIDGECO_PLUG_MODE_FUNCTION_BLOCK	= 0x02
+};
+enum avc_bridgeco_plug_unit {
+	AVC_BRIDGECO_PLUG_UNIT_ISOC	= 0x00,
+	AVC_BRIDGECO_PLUG_UNIT_EXT	= 0x01,
+	AVC_BRIDGECO_PLUG_UNIT_ASYNC	= 0x02
+};
+enum avc_bridgeco_plug_type {
+	AVC_BRIDGECO_PLUG_TYPE_ISOC	= 0x00,
+	AVC_BRIDGECO_PLUG_TYPE_ASYNC	= 0x01,
+	AVC_BRIDGECO_PLUG_TYPE_MIDI	= 0x02,
+	AVC_BRIDGECO_PLUG_TYPE_SYNC	= 0x03,
+	AVC_BRIDGECO_PLUG_TYPE_ANA	= 0x04,
+	AVC_BRIDGECO_PLUG_TYPE_DIG	= 0x05
+};
+static inline void
+avc_bridgeco_fill_unit_addr(u8 buf[AVC_BRIDGECO_ADDR_BYTES],
+			    enum avc_bridgeco_plug_dir dir,
+			    enum avc_bridgeco_plug_unit unit,
+			    unsigned int pid)
+{
+	buf[0] = 0xff;	/* Unit */
+	buf[1] = dir;
+	buf[2] = AVC_BRIDGECO_PLUG_MODE_UNIT;
+	buf[3] = unit;
+	buf[4] = 0xff & pid;
+	buf[5] = 0xff;	/* reserved */
+}
+static inline void
+avc_bridgeco_fill_subunit_addr(u8 buf[AVC_BRIDGECO_ADDR_BYTES],
+			       unsigned int mode,
+			       enum avc_bridgeco_plug_dir dir,
+			       unsigned int pid)
+{
+	buf[0] = 0xff & mode;	/* Subunit */
+	buf[1] = dir;
+	buf[2] = AVC_BRIDGECO_PLUG_MODE_SUBUNIT;
+	buf[3] = 0xff & pid;
+	buf[4] = 0xff;	/* reserved */
+	buf[5] = 0xff;	/* reserved */
+}
+int avc_bridgeco_get_plug_ch_pos(struct fw_unit *unit,
+				 u8 add[AVC_BRIDGECO_ADDR_BYTES],
+				 u8 *buf, unsigned int len);
+int avc_bridgeco_get_plug_type(struct fw_unit *unit,
+			       u8 addr[AVC_BRIDGECO_ADDR_BYTES],
+			       enum avc_bridgeco_plug_type *type);
+int avc_bridgeco_get_plug_section_type(struct fw_unit *unit,
+				       u8 addr[AVC_BRIDGECO_ADDR_BYTES],
+				       unsigned int section_id, u8 *ctype);
+int avc_bridgeco_get_plug_input(struct fw_unit *unit,
+				u8 addr[AVC_BRIDGECO_ADDR_BYTES],
+				u8 input[7]);
+int avc_bridgeco_get_plug_strm_fmt(struct fw_unit *unit,
+				   u8 addr[AVC_BRIDGECO_ADDR_BYTES],
+				   unsigned int entryid, u8 *buf,
+				   unsigned int *len);
+
+int snd_bebob_get_rate(struct snd_bebob *bebob, unsigned int *rate,
+		       enum avc_general_plug_dir dir);
+int snd_bebob_set_rate(struct snd_bebob *bebob, unsigned int rate,
+		       enum avc_general_plug_dir dir);
+
+/* for AMDTP streaming */
+int snd_bebob_stream_get_rate(struct snd_bebob *bebob, unsigned int *rate);
+int snd_bebob_stream_set_rate(struct snd_bebob *bebob, unsigned int rate);
+int snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob,
+					  bool *internal);
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
index 0000000..22a86d0
--- /dev/null
+++ b/sound/firewire/bebob/bebob_command.c
@@ -0,0 +1,273 @@
+/*
+ * bebob_command.c - driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./bebob.h"
+
+#define BEBOB_COMMAND_MAX_TRIAL	3
+#define BEBOB_COMMAND_WAIT_MSEC	100
+
+static inline void
+avc_bridgeco_fill_command_base(u8 *buf, unsigned int ctype, unsigned int opcode,
+			       unsigned int subfunction,
+			       u8 addr[AVC_BRIDGECO_ADDR_BYTES])
+{
+	buf[0] = 0x7 & ctype;
+	buf[1] = addr[0];
+	buf[2] = 0xff & opcode;
+	buf[3] = 0xff & subfunction;
+	buf[4] = addr[1];
+	buf[5] = addr[2];
+	buf[6] = addr[3];
+	buf[7] = addr[4];
+	buf[8] = addr[5];
+}
+
+int avc_bridgeco_get_plug_type(struct fw_unit *unit,
+			       u8 addr[AVC_BRIDGECO_ADDR_BYTES],
+			       enum avc_bridgeco_plug_type *type)
+{
+	u8 *buf;
+	int err;
+
+	buf = kzalloc(12, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	/* status for plug info with bridgeco extension */
+	avc_bridgeco_fill_command_base(buf, 0x01, 0x02, 0xc0, addr);
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
+end:
+	kfree(buf);
+	return err;
+}
+
+int avc_bridgeco_get_plug_ch_pos(struct fw_unit *unit,
+				 u8 addr[AVC_BRIDGECO_ADDR_BYTES],
+				 u8 *buf, unsigned int len)
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
+	/* status for plug info with bridgeco extension */
+	avc_bridgeco_fill_command_base(buf, 0x01, 0x02, 0xc0, addr);
+
+	/* info type is 'channel position' */
+	buf[9] = 0x03;
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
+int avc_bridgeco_get_plug_section_type(struct fw_unit *unit,
+				       u8 addr[AVC_BRIDGECO_ADDR_BYTES],
+				       unsigned int section_id, u8 *type)
+{
+	u8 *buf;
+	int err;
+
+	/* section info includes charactors but this module don't need it */
+	buf = kzalloc(12, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	/* status for plug info with bridgeco extension */
+	avc_bridgeco_fill_command_base(buf, 0x01, 0x02, 0xc0, addr);
+
+	buf[9] = 0x07;		/* info type is 'section info' */
+	buf[10] = 0xff & (section_id + 1);	/* section id */
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
+int avc_bridgeco_get_plug_input(struct fw_unit *unit,
+				u8 addr[AVC_BRIDGECO_ADDR_BYTES], u8 input[7])
+{
+	int err;
+	u8 *buf;
+
+	buf = kzalloc(18, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	/* status for plug info with bridgeco extension */
+	avc_bridgeco_fill_command_base(buf, 0x01, 0x02, 0xc0, addr);
+
+	/* info type is 'Plug Input Specific Data' */
+	buf[9] = 0x05;
+
+	/* do transaction and check buf[1-7] are the same */
+	err = fcp_avc_transaction(unit, buf, 16, buf, 16,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(7));
+	if (err < 0)
+		goto end;
+	else if ((err < 18) && (buf[0] != 0x0c)) {
+		err = -EIO;
+		goto end;
+	}
+
+	memcpy(input, buf + 10, 5);
+end:
+	kfree(buf);
+	return err;
+}
+
+int avc_bridgeco_get_plug_strm_fmt(struct fw_unit *unit,
+				   u8 addr[AVC_BRIDGECO_ADDR_BYTES],
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
+	/* status for plug info with bridgeco extension */
+	avc_bridgeco_fill_command_base(buf, 0x01, 0x2f, 0xc1, addr);
+
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
index 0000000..7c604d8
--- /dev/null
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -0,0 +1,773 @@
+/*
+ * bebob_stream.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
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
+ * [Actual behavior] In some devices, each CMP connection starts to
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
+int
+snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
+{
+	u8 addr[AVC_BRIDGECO_ADDR_BYTES], input[7];
+	int err = 0;
+
+	*internal = false;
+
+	/*
+	 * 1.The device don't support for switching source of clock
+	 *   then assumed to use internal clock always
+	 */
+	if (bebob->sync_input_plug < 0) {
+		*internal = true;
+		goto end;
+	}
+
+	/*
+	 * 2.The device supports to switch source of clock by an usual way.
+	 *   Let's check input for 'Music Sub Unit Sync Input' plug.
+	 */
+	avc_bridgeco_fill_subunit_addr(addr, 0x60, AVC_BRIDGECO_PLUG_DIR_IN,
+				       bebob->sync_input_plug);
+	err = avc_bridgeco_get_plug_input(bebob->unit, addr, input);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * If source of clock is internal CSR, Music Sub Unit Sync Input is
+	 * a destination of Music Sub Unit Sync Output.
+	 */
+	*internal = ((input[0] == AVC_BRIDGECO_PLUG_DIR_OUT) &&
+		     (input[1] == AVC_BRIDGECO_PLUG_MODE_SUBUNIT) &&
+		     (input[2] == 0x0c) &&
+		     (input[3] == 0x00));
+end:
+	return err;
+}
+
+static unsigned int
+map_stream(struct snd_bebob *bebob, struct amdtp_stream *s)
+{
+	unsigned int sec, sections, ch, channels;
+	unsigned int pcm, midi, location;
+	unsigned int stm_pos, sec_loc, pos;
+	u8 *buf, addr[AVC_BRIDGECO_ADDR_BYTES], type;
+	enum avc_bridgeco_plug_dir dir;
+	int err;
+
+	/*
+	 * The length of return value of this command cannot be expected. Here
+	 * use the maximum length of FCP.
+	 */
+	buf = kzalloc(256, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	if (s == &bebob->tx_stream)
+		dir = AVC_BRIDGECO_PLUG_DIR_OUT;
+	else
+		dir = AVC_BRIDGECO_PLUG_DIR_IN;
+
+	avc_bridgeco_fill_unit_addr(addr, dir, AVC_BRIDGECO_PLUG_UNIT_ISOC, 0);
+	err = avc_bridgeco_get_plug_ch_pos(bebob->unit, addr, buf, 256);
+	if (err < 0)
+		goto end;
+	pos = 0;
+
+	/* positions in I/O buffer */
+	pcm = 0;
+	midi = 0;
+
+	/* the number of sections in AMDTP packet */
+	sections = buf[pos++];
+
+	for (sec = 0; sec < sections; sec++) {
+		/* type of this section */
+		avc_bridgeco_fill_unit_addr(addr, dir,
+					    AVC_BRIDGECO_PLUG_UNIT_ISOC, 0);
+		err = avc_bridgeco_get_plug_section_type(bebob->unit, addr,
+							 sec, &type);
+		if (err < 0)
+			goto end;
+		/* NoType */
+		if (type == 0xff) {
+			err = -ENOSYS;
+			goto end;
+		}
+
+		/* the number of channels in this section */
+		channels = buf[pos++];
+
+		for (ch = 0; ch < channels; ch++) {
+			/* position of this channel in AMDTP packet */
+			stm_pos = buf[pos++] - 1;
+			/* location of this channel in this section */
+			sec_loc = buf[pos++] - 1;
+
+			switch (type) {
+			/* for MIDI conformant data channel */
+			case 0x0a:
+				location = midi + sec_loc;
+				if (location >= AMDTP_MAX_CHANNELS_FOR_MIDI) {
+					err = -ENOSYS;
+					goto end;
+				}
+				s->midi_position = stm_pos;
+				break;
+			/* for PCM data channel */
+			case 0x01:	/* Headphone */
+			case 0x02:	/* Microphone */
+			case 0x03:	/* Line */
+			case 0x04:	/* SPDIF */
+			case 0x05:	/* ADAT */
+			case 0x06:	/* TDIF */
+			case 0x07:	/* MADI */
+			/* for undefined/changeable signal  */
+			case 0x08:	/* Analog */
+			case 0x09:	/* Digital */
+			default:
+				location = pcm + sec_loc;
+				if (location >= AMDTP_MAX_CHANNELS_FOR_PCM) {
+					err = -ENOSYS;
+					goto end;
+				}
+				s->pcm_positions[location] = stm_pos;
+				break;
+			}
+		}
+
+		if (type != 0x0a)
+			pcm += channels;
+		else
+			midi += channels;
+	}
+end:
+	kfree(buf);
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
+			amdtp_stream_get_max_payload(&bebob->tx_stream));
+	if (err < 0)
+		goto end;
+	err = cmp_connection_establish(&bebob->in_conn,
+			amdtp_stream_get_max_payload(&bebob->rx_stream));
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
+	err = map_stream(bebob, stream);
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
+				AMDTP_IN_STREAM, CIP_BLOCKING);
+	if (err < 0) {
+		destroy_both_connections(bebob);
+		goto end;
+	}
+
+	err = amdtp_stream_init(&bebob->rx_stream, bebob->unit,
+				AMDTP_OUT_STREAM, CIP_BLOCKING);
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
+		 * If establishing connections at first, Yamaha GO46
+		 * (and maybe Terratec X24) don't generate sound.
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
+		/* PCM for Multi bit linear audio (raw) */
+		case 0x06:
+			formation->pcm += channels;
+			break;
+		/* MIDI comformant (MMA/AMEI RP-027) */
+		case 0x0d:
+			formation->midi += channels;
+			break;
+		/* PCM for Multi bit linear audio (DVD-audio) */
+		case 0x07:
+		/* IEC 61937-3 to 7 */
+		case 0x01:
+		case 0x02:
+		case 0x03:
+		case 0x04:
+		case 0x05:
+		/* High precision multi bit linear audio */
+		case 0x0c:
+		/* Don't care */
+		case 0xff:
+		default:
+			break;	/* not supported */
+		}
+	}
+
+	return;
+}
+
+static int
+fill_stream_formations(struct snd_bebob *bebob, enum avc_bridgeco_plug_dir dir,
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
+	u8 addr[AVC_BRIDGECO_ADDR_BYTES];
+	int err;
+
+	buf = kmalloc(FORMAT_MAXIMUM_LENGTH, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	if (dir == AVC_BRIDGECO_PLUG_DIR_IN)
+		formations = bebob->rx_stream_formations;
+	else
+		formations = bebob->tx_stream_formations;
+
+	for (eid = 0, index = 0; eid < SND_BEBOB_STRM_FMT_ENTRIES; eid++) {
+		len = FORMAT_MAXIMUM_LENGTH;
+
+		memset(buf, 0, len);
+		avc_bridgeco_fill_unit_addr(addr, dir,
+					    AVC_BRIDGECO_PLUG_UNIT_ISOC, pid);
+		err = avc_bridgeco_get_plug_strm_fmt(bebob->unit, addr,
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
+end:
+	kfree(buf);
+	return err;
+}
+
+static int
+seek_msu_sync_input_plug(struct snd_bebob *bebob)
+{
+	u8 plugs[AVC_PLUG_INFO_BUF_COUNT], addr[AVC_BRIDGECO_ADDR_BYTES];
+	unsigned int i, type;
+	int err;
+
+	/* get information about Music Sub Unit */
+	err = avc_general_get_plug_info(bebob->unit, 0x0c, 0x00, 0x00, plugs);
+	if (err < 0)
+		goto end;
+
+	/* seek destination plugs for 'MSU sync input' */
+	bebob->sync_input_plug = -1;
+	for (i = 0; i < plugs[0]; i++) {
+		avc_bridgeco_fill_subunit_addr(addr, 0x60,
+					       AVC_BRIDGECO_PLUG_DIR_IN, i);
+		err = avc_bridgeco_get_plug_type(bebob->unit, addr, &type);
+		if (err < 0)
+			goto end;
+
+		if (type == AVC_BRIDGECO_PLUG_TYPE_SYNC)
+			bebob->sync_input_plug = i;
+	}
+end:
+	return err;
+}
+
+/* In this function, 2 means input and output */
+int snd_bebob_stream_discover(struct snd_bebob *bebob)
+{
+	u8 plugs[AVC_PLUG_INFO_BUF_COUNT], addr[AVC_BRIDGECO_ADDR_BYTES];
+	enum avc_bridgeco_plug_type type;
+	unsigned int i;
+	int err;
+
+	/* the number of plugs for isoc in/out, ext in/out  */
+	err = avc_general_get_plug_info(bebob->unit, 0x1f, 0x07, 0x00, plugs);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * This module supports one ISOC input plug and one ISOC output plug
+	 * then ignores the others.
+	 */
+	if (plugs[0] == 0) {
+		err = -EIO;
+		goto end;
+	}
+	avc_bridgeco_fill_unit_addr(addr, AVC_BRIDGECO_PLUG_DIR_IN,
+				    AVC_BRIDGECO_PLUG_UNIT_ISOC, 0);
+	err = avc_bridgeco_get_plug_type(bebob->unit, addr, &type);
+	if (err < 0)
+		goto end;
+	else if (type != AVC_BRIDGECO_PLUG_TYPE_ISOC) {
+		err = -EIO;
+		goto end;
+	}
+
+	if (plugs[1] == 0) {
+		err = -EIO;
+		goto end;
+	}
+	avc_bridgeco_fill_unit_addr(addr, AVC_BRIDGECO_PLUG_DIR_OUT,
+				    AVC_BRIDGECO_PLUG_UNIT_ISOC, 0);
+	err = avc_bridgeco_get_plug_type(bebob->unit, addr, &type);
+	if (err < 0)
+		goto end;
+	else if (type != AVC_BRIDGECO_PLUG_TYPE_ISOC) {
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
+	for (i = 0; i < plugs[2]; i++) {
+		avc_bridgeco_fill_unit_addr(addr, AVC_BRIDGECO_PLUG_DIR_IN,
+					    AVC_BRIDGECO_PLUG_UNIT_EXT, i);
+		err = avc_bridgeco_get_plug_type(bebob->unit, addr, &type);
+		if (err < 0)
+			goto end;
+		else if (type == AVC_BRIDGECO_PLUG_TYPE_MIDI)
+			bebob->midi_input_ports++;
+	}
+
+	/* count external output plugs for MIDI */
+	bebob->midi_output_ports = 0;
+	for (i = 0; i < plugs[3]; i++) {
+		avc_bridgeco_fill_unit_addr(addr, AVC_BRIDGECO_PLUG_DIR_OUT,
+					    AVC_BRIDGECO_PLUG_UNIT_EXT, i);
+		err = avc_bridgeco_get_plug_type(bebob->unit, addr, &type);
+		if (err < 0)
+			goto end;
+		else if (type == AVC_BRIDGECO_PLUG_TYPE_MIDI)
+			bebob->midi_output_ports++;
+	}
+
+	/* for check source of clock later */
+	err = seek_msu_sync_input_plug(bebob);
+end:
+	return err;
+}
-- 
1.8.3.2


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
