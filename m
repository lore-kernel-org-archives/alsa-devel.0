From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/13] speakers: Add some AV/C commands to get
	stream formation and supported sampling rates
Date: Sat, 11 Jan 2014 00:29:31 +0900
Message-ID: <1389367775-21360-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 107562650E7
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:30:00 +0100 (CET)
In-Reply-To: <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
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

OXFW970/971 may supports AV/C Stream Format Information Specification 1.1
Working Draft (Apr 2005, 1394TA). So this driver uses 'EXTENDED STREAM FORMAT
INFORMATION' command.

This command has two subfunctions, 'SINGLE' and 'LIST'. Drivers can use
'SINGLE' subfunction to know current formation of AMDTP stream, Drivers can
use 'LIST' subfunction to know an available formation of AMDTP stream in a
certain sampling rate. Followed commit adds parser for returned information.

This commit adds 'inquiry' version of 'PLUG SIGNAL FORMAT' command. When
device doesn't support 'LIST' subfunction of 'AV/C Stream Format Information'
command, drivers can use 'inquiry' command to get supported sampling rates.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/speakers/Makefile           |   2 +-
 sound/firewire/speakers/speakers.h         |  30 +++++++
 sound/firewire/speakers/speakers_command.c | 122 +++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/speakers/speakers_command.c

diff --git a/sound/firewire/speakers/Makefile b/sound/firewire/speakers/Makefile
index 8936816..86b2b6c 100644
--- a/sound/firewire/speakers/Makefile
+++ b/sound/firewire/speakers/Makefile
@@ -1,3 +1,3 @@
-snd-firewire-speakers-objs := speakers_stream.o speakers_pcm.o speakers_control.o \
+snd-firewire-speakers-objs := speakers_command.o speakers_stream.o speakers_pcm.o speakers_control.o \
 			      speakers_proc.o speakers.o
 obj-m += snd-firewire-speakers.o
diff --git a/sound/firewire/speakers/speakers.h b/sound/firewire/speakers/speakers.h
index 90c65f4..386e267 100644
--- a/sound/firewire/speakers/speakers.h
+++ b/sound/firewire/speakers/speakers.h
@@ -57,6 +57,36 @@ struct fwspk {
 	s16 volume_max;
 };
 
+/* AV/C Stream Format Information Specification 1.1 (Apr 2005, 1394TA) */
+#define AVC_GENERIC_FRAME_MAXIMUM_BYTES	512
+int avc_stream_get_format(struct fw_unit *unit,
+			  enum avc_general_plug_dir dir, unsigned int pid,
+			  u8 *buf, unsigned int *len,
+			  unsigned int eid);
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
 int snd_fwspk_stream_init(struct fwspk *fwspk);
 int snd_fwspk_stream_start(struct fwspk *fwspk, unsigned int rate);
 void snd_fwspk_stream_stop(struct fwspk *fwspk);
diff --git a/sound/firewire/speakers/speakers_command.c b/sound/firewire/speakers/speakers_command.c
new file mode 100644
index 0000000..a13bc9e
--- /dev/null
+++ b/sound/firewire/speakers/speakers_command.c
@@ -0,0 +1,122 @@
+/*
+ * speakers_command.c - part of OXFW970/971-based speakers driver
+ *
+ * Copyright (c) Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "speakers.h"
+
+int avc_stream_get_format(struct fw_unit *unit,
+			  enum avc_general_plug_dir dir, unsigned int pid,
+			  u8 *buf, unsigned int *len,
+			  unsigned int eid)
+{
+	unsigned int subfunc;
+	int err;
+
+	/* check given buffer */
+	if ((buf == NULL) || (*len < 12)) {
+		err = -EINVAL;
+		goto end;
+	}
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
+	buf[10] = 0xff & eid;	/* entry ID */
+	buf[11] = 0xff;		/* padding */
+
+	/* do transaction and check buf[1-7] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 12, buf, *len,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(7));
+	if (err < 0) {
+		goto end;
+	/* reach the end of entries */
+	} else if (buf[0] == 0x0a) {
+		err = 0;
+		*len = 0;
+		goto end;
+	} else if (buf[0] != 0x0c) {
+		err = -EINVAL;
+		goto end;
+	/* the content starts at 11th bytes */
+	} else if (err < 9) {
+		err = -EIO;
+		goto end;
+	} else if ((subfunc == 0xc1) && (buf[10] != eid)) {
+		err = -EIO;
+		goto end;
+	}
+
+	/* strip */
+	memmove(buf, buf + 10, err - 10);
+	*len = err - 10;
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
+	buf[6] = 0xff;		/* FDF-mid. AM824, SYT hi (not used)*/
+	buf[7] = 0xff;		/* FDF-low. AM824, SYT lo (not used) */
+
+	/* do transaction and check buf[1-5] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 8, buf, 8,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5));
+	if (err < 0)
+		goto end;
+
+	/* check length */
+	if (err != 8) {
+		dev_err(&unit->device, "failed to inquiry sample rate\n");
+		err = -EIO;
+		goto end;
+	}
+
+	/* return response code */
+	err = buf[0];
+end:
+	kfree(buf);
+	return err;
+}
-- 
1.8.3.2
