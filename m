From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/15] ALSA: oxfw: Add support for AV/C stream
	format command to get/set supported stream formation
Date: Tue,  9 Dec 2014 00:10:41 +0900
Message-ID: <1418051449-18371-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1418051449-18371-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 28B6A2604A1
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 16:11:01 +0100 (CET)
In-Reply-To: <1418051449-18371-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OXFW970/971 may supports AV/C Stream Format Information Specification 1.1
Working Draft (Apr 2005, 1394TA). By using this command, drivers can get to know
stream formations which device supports.

This commit adds 'EXTENDED STREAM FORMAT INFORMATION' command. This command
has two subfunctions, 'SINGLE' and 'LIST'. Drivers can use 'SINGLE' subfunction
to know/set current formation of AMDTP stream, Drivers can use 'LIST'
subfunction to know an available formation of AMDTP stream in a certain sampling
rate.

But some devices don't implement the 'LIST' subfunction. So this commit uses
an assumption that 'if they don't implement it, they don't change stream
formation depending on current each sampling rate'. With this assumption, this
driver generates formations for such devices by:
 1.getting current formation by SINGLE subfunction
 2.getting supported sampling rates
 3.applying current formation for all of supported sampling rates

Followed commit implements a parser of this format information.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile       |   2 +-
 sound/firewire/oxfw/oxfw-command.c | 153 +++++++++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw.h         |  33 ++++++++
 3 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/oxfw/oxfw-command.c

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 0cf48fd..b107134 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,2 +1,2 @@
-snd-oxfw-objs := oxfw-stream.o oxfw-control.o oxfw-pcm.o oxfw.o
+snd-oxfw-objs := oxfw-command.o oxfw-stream.o oxfw-control.o oxfw-pcm.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw-command.c b/sound/firewire/oxfw/oxfw-command.c
new file mode 100644
index 0000000..12ef325
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw-command.c
@@ -0,0 +1,153 @@
+/*
+ * oxfw_command.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2014 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "oxfw.h"
+
+int avc_stream_set_format(struct fw_unit *unit, enum avc_general_plug_dir dir,
+			  unsigned int pid, u8 *format, unsigned int len)
+{
+	u8 *buf;
+	int err;
+
+	buf = kmalloc(len + 10, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0] = 0x00;		/* CONTROL */
+	buf[1] = 0xff;		/* UNIT */
+	buf[2] = 0xbf;		/* EXTENDED STREAM FORMAT INFORMATION */
+	buf[3] = 0xc0;		/* SINGLE subfunction */
+	buf[4] = dir;		/* Plug Direction */
+	buf[5] = 0x00;		/* UNIT */
+	buf[6] = 0x00;		/* PCR (Isochronous Plug) */
+	buf[7] = 0xff & pid;	/* Plug ID */
+	buf[8] = 0xff;		/* Padding */
+	buf[9] = 0xff;		/* Support status in response */
+	memcpy(buf + 10, format, len);
+
+	/* do transaction and check buf[1-8] are the same against command */
+	err = fcp_avc_transaction(unit, buf, len + 10, buf, len + 10,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(7) | BIT(8));
+	if ((err > 0) && (err < len + 10))
+		err = -EIO;
+	else if (buf[0] == 0x08) /* NOT IMPLEMENTED */
+		err = -ENOSYS;
+	else if (buf[0] == 0x0a) /* REJECTED */
+		err = -EINVAL;
+	else
+		err = 0;
+
+	kfree(buf);
+
+	return err;
+}
+
+int avc_stream_get_format(struct fw_unit *unit,
+			  enum avc_general_plug_dir dir, unsigned int pid,
+			  u8 *buf, unsigned int *len, unsigned int eid)
+{
+	unsigned int subfunc;
+	int err;
+
+	if (eid == 0xff)
+		subfunc = 0xc0;	/* SINGLE */
+	else
+		subfunc = 0xc1;	/* LIST */
+
+	buf[0] = 0x01;		/* STATUS */
+	buf[1] = 0xff;		/* UNIT */
+	buf[2] = 0xbf;		/* EXTENDED STREAM FORMAT INFORMATION */
+	buf[3] = subfunc;	/* SINGLE or LIST */
+	buf[4] = dir;		/* Plug Direction */
+	buf[5] = 0x00;		/* Unit */
+	buf[6] = 0x00;		/* PCR (Isochronous Plug) */
+	buf[7] = 0xff & pid;	/* Plug ID */
+	buf[8] = 0xff;		/* Padding */
+	buf[9] = 0xff;		/* support status in response */
+	buf[10] = 0xff & eid;	/* entry ID for LIST subfunction */
+	buf[11] = 0xff;		/* padding */
+
+	/* do transaction and check buf[1-7] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 12, buf, *len,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(7));
+	if ((err > 0) && (err < 10))
+		err = -EIO;
+	else if (buf[0] == 0x08)	/* NOT IMPLEMENTED */
+		err = -ENOSYS;
+	else if (buf[0] == 0x0a)	/* REJECTED */
+		err = -EINVAL;
+	else if (buf[0] == 0x0b)	/* IN TRANSITION */
+		err = -EAGAIN;
+	/* LIST subfunction has entry ID */
+	else if ((subfunc == 0xc1) && (buf[10] != eid))
+		err = -EIO;
+	if (err < 0)
+		goto end;
+
+	/* keep just stream format information */
+	if (subfunc == 0xc0) {
+		memmove(buf, buf + 10, err - 10);
+		*len = err - 10;
+	} else {
+		memmove(buf, buf + 11, err - 11);
+		*len = err - 11;
+	}
+
+	err = 0;
+end:
+	return err;
+}
+
+int avc_general_inquiry_sig_fmt(struct fw_unit *unit, unsigned int rate,
+				enum avc_general_plug_dir dir,
+				unsigned short pid)
+{
+	unsigned int sfc;
+	u8 *buf;
+	int err;
+
+	for (sfc = 0; sfc < CIP_SFC_COUNT; sfc++) {
+		if (amdtp_rate_table[sfc] == rate)
+			break;
+	}
+	if (sfc == CIP_SFC_COUNT)
+		return -EINVAL;
+
+	buf = kzalloc(8, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0] = 0x02;		/* SPECIFIC INQUIRY */
+	buf[1] = 0xff;		/* UNIT */
+	if (dir == AVC_GENERAL_PLUG_DIR_IN)
+		buf[2] = 0x19;	/* INPUT PLUG SIGNAL FORMAT */
+	else
+		buf[2] = 0x18;	/* OUTPUT PLUG SIGNAL FORMAT */
+	buf[3] = 0xff & pid;	/* plug id */
+	buf[4] = 0x90;		/* EOH_1, Form_1, FMT. AM824 */
+	buf[5] = 0x07 & sfc;	/* FDF-hi. AM824, frequency */
+	buf[6] = 0xff;		/* FDF-mid. AM824, SYT hi (not used) */
+	buf[7] = 0xff;		/* FDF-low. AM824, SYT lo (not used) */
+
+	/* do transaction and check buf[1-5] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 8, buf, 8,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5));
+	if ((err > 0) && (err < 8))
+		err = -EIO;
+	else if (buf[0] == 0x08)	/* NOT IMPLEMENTED */
+		err = -ENOSYS;
+	if (err < 0)
+		goto end;
+
+	err = 0;
+end:
+	kfree(buf);
+	return err;
+}
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index a61c75c..a7031d4 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -49,6 +49,39 @@ struct snd_oxfw {
 	s16 volume_max;
 };
 
+/*
+ * AV/C Stream Format Information Specification 1.1 Working Draft
+ * (Apr 2005, 1394TA)
+ */
+int avc_stream_set_format(struct fw_unit *unit, enum avc_general_plug_dir dir,
+			  unsigned int pid, u8 *format, unsigned int len);
+int avc_stream_get_format(struct fw_unit *unit,
+			  enum avc_general_plug_dir dir, unsigned int pid,
+			  u8 *buf, unsigned int *len, unsigned int eid);
+static inline int
+avc_stream_get_format_single(struct fw_unit *unit,
+			     enum avc_general_plug_dir dir, unsigned int pid,
+			     u8 *buf, unsigned int *len)
+{
+	return avc_stream_get_format(unit, dir, pid, buf, len, 0xff);
+}
+static inline int
+avc_stream_get_format_list(struct fw_unit *unit,
+			   enum avc_general_plug_dir dir, unsigned int pid,
+			   u8 *buf, unsigned int *len,
+			   unsigned int eid)
+{
+	return avc_stream_get_format(unit, dir, pid, buf, len, eid);
+}
+
+/*
+ * AV/C Digital Interface Command Set General Specification 4.2
+ * (Sep 2004, 1394TA)
+ */
+int avc_general_inquiry_sig_fmt(struct fw_unit *unit, unsigned int rate,
+				enum avc_general_plug_dir dir,
+				unsigned short pid);
+
 int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw);
 int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw);
 void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw);
-- 
2.1.0
