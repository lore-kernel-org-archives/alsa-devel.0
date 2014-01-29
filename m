From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 47/52] oxfw: Add some AV/C commands to get stream formation
	and supported sample rate
Date: Wed, 29 Jan 2014 22:44:54 +0900
Message-ID: <1391003099-7109-48-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
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

OXFW970/971 may supports AV/C Stream Format Information Specification 1.1
Working Draft (Apr 2005, 1394TA). So this driver uses 'EXTENDED STREAM FORMAT
INFORMATION' command.

This command has two subfunctions, 'SINGLE' and 'LIST'. Drivers can use
'SINGLE' subfunction to know current formation of AMDTP stream, Drivers can
use 'LIST' subfunction to know an available formation of AMDTP stream in a
certain sampling rate. Followed commit adds parser for returned information.

This commit adds 'inquiry' version of 'PLUG SIGNAL FORMAT' command. When
device doesn't support 'LIST' subfunction of 'AV/C Stream Format Information
command, this driver uses 'inquiry' command to get supported sampling rates.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile       |   3 +-
 sound/firewire/oxfw/oxfw.h         |  33 ++++++++++
 sound/firewire/oxfw/oxfw_command.c | 122 +++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/oxfw/oxfw_command.c

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 53b5572..4ee2c97 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,2 +1,3 @@
-snd-oxfw-objs := oxfw_stream.o oxfw_control.o oxfw_proc.o oxfw_pcm.o oxfw.o
+snd-oxfw-objs := oxfw_command.o oxfw_stream.o oxfw_control.o oxfw_proc.o \
+		 oxfw_pcm.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 253986f..081ce83 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -57,6 +57,39 @@ struct snd_oxfw {
 	s16 volume_max;
 };
 
+/*
+ * AV/C Stream Format Information Specification 1.1 Working Draft
+ * (Apr 2005, 1394TA)
+ */
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
 int snd_oxfw_stream_init(struct snd_oxfw *oxfw);
 int snd_oxfw_stream_start(struct snd_oxfw *oxfw, unsigned int rate);
 void snd_oxfw_stream_stop(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_command.c b/sound/firewire/oxfw/oxfw_command.c
new file mode 100644
index 0000000..5f8cb22
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw_command.c
@@ -0,0 +1,122 @@
+/*
+ * oxfw_command.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "oxfw.h"
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


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
