From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 16/17] firewire-lib: Add some AV/C general
	commands
Date: Sat, 23 Nov 2013 15:08:03 +0900
Message-ID: <1385186884-8259-17-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id D68972651CF
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:08:13 +0100 (CET)
In-Reply-To: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit add three commands. I think many devices use these commands.
These commands are defined in 'AV/C Digital Interface Command Set General
Specification Version 4.2 (2004006, 1394TA)'.

1. INPUT PLUG SIGNAL FORMAT command
2. OUTPUT PLUG SIGNAL FORMAT command
3. PLUG INFO command

By the command 1 and 2, the drivers can get/set sampling frequency.
By the command 3, the drivers can get the number of each plugs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c    |  24 ++++----
 sound/firewire/amdtp.h    |   1 +
 sound/firewire/fcp.c      | 149 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/firewire/fcp.h      |  16 +++++
 sound/firewire/speakers.c |  44 +++-----------
 5 files changed, 186 insertions(+), 48 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 9c7aee4..cb74ade 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -115,6 +115,17 @@ const unsigned int amdtp_syt_intervals[CIP_SFC_COUNT] = {
 };
 EXPORT_SYMBOL(amdtp_syt_intervals);
 
+const unsigned int amdtp_rate_table[] = {
+	[CIP_SFC_32000]  =  32000,
+	[CIP_SFC_44100]  =  44100,
+	[CIP_SFC_48000]  =  48000,
+	[CIP_SFC_88200]  =  88200,
+	[CIP_SFC_96000]  =  96000,
+	[CIP_SFC_176400] = 176400,
+	[CIP_SFC_192000] = 192000,
+};
+EXPORT_SYMBOL(amdtp_rate_table);
+
 /**
  * amdtp_stream_set_parameters - set stream parameters
  * @s: the AMDTP stream to configure
@@ -131,15 +142,6 @@ void amdtp_stream_set_parameters(struct amdtp_stream *s,
 				 unsigned int pcm_channels,
 				 unsigned int midi_ports)
 {
-	static const unsigned int rates[] = {
-		[CIP_SFC_32000]  =  32000,
-		[CIP_SFC_44100]  =  44100,
-		[CIP_SFC_48000]  =  48000,
-		[CIP_SFC_88200]  =  88200,
-		[CIP_SFC_96000]  =  96000,
-		[CIP_SFC_176400] = 176400,
-		[CIP_SFC_192000] = 192000,
-	};
 	unsigned int i, sfc, midi_channels;
 
 	midi_channels = DIV_ROUND_UP(midi_ports, 8);
@@ -148,8 +150,8 @@ void amdtp_stream_set_parameters(struct amdtp_stream *s,
 	    WARN_ON(midi_channels > AMDTP_MAX_CHANNELS_FOR_MIDI))
 		return;
 
-	for (sfc = 0; sfc < sizeof(rates); ++sfc)
-		if (rates[sfc] == rate)
+	for (sfc = 0; sfc < sizeof(amdtp_rate_table); ++sfc)
+		if (amdtp_rate_table[sfc] == rate)
 			goto sfc_found;
 	WARN_ON(1);
 	return;
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 539c007..02ff8de 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -142,6 +142,7 @@ void amdtp_stream_pcm_abort(struct amdtp_stream *s);
 bool amdtp_stream_wait_callback(struct amdtp_stream *s);
 
 extern const unsigned int amdtp_syt_intervals[CIP_SFC_COUNT];
+extern const unsigned int amdtp_rate_table[CIP_SFC_COUNT];
 
 /**
  * amdtp_stream_running - check stream is running or not
diff --git a/sound/firewire/fcp.c b/sound/firewire/fcp.c
index 860c080..ccdd0de 100644
--- a/sound/firewire/fcp.c
+++ b/sound/firewire/fcp.c
@@ -10,12 +10,14 @@
 #include <linux/firewire-constants.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include "fcp.h"
 #include "lib.h"
+#include "amdtp.h"
 
 #define CTS_AVC 0x00
 
@@ -23,6 +25,153 @@
 #define ERROR_DELAY_MS	5
 #define FCP_TIMEOUT_MS	125
 
+int avc_general_set_sig_fmt(struct fw_unit *unit, unsigned int rate,
+			    enum avc_general_plug_dir dir,
+			    unsigned short pid)
+{
+	unsigned int sfc;
+	u8 *buf;
+	bool flag;
+	int err;
+
+	flag = false;
+	for (sfc = 0; sfc < CIP_SFC_COUNT; sfc++) {
+		if (amdtp_rate_table[sfc] == rate) {
+			flag = true;
+			break;
+		}
+	}
+	if (!flag)
+		return -EINVAL;
+
+	buf = kzalloc(8, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0] = 0x00;		/* AV/C CONTROL */
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
+		dev_err(&unit->device, "failed to set sample rate\n");
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
+EXPORT_SYMBOL(avc_general_set_sig_fmt);
+
+int avc_general_get_sig_fmt(struct fw_unit *unit, unsigned int *rate,
+			    enum avc_general_plug_dir dir,
+			    unsigned short pid)
+{
+	unsigned int sfc;
+	u8 *buf;
+	int err;
+
+	buf = kzalloc(8, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0] = 0x01;		/* AV/C STATUS */
+	buf[1] = 0xff;		/* Unit */
+	if (dir == AVC_GENERAL_PLUG_DIR_IN)
+		buf[2] = 0x19;	/* INPUT PLUG SIGNAL FORMAT */
+	else
+		buf[2] = 0x18;	/* OUTPUT PLUG SIGNAL FORMAT */
+	buf[3] = 0xff & pid;	/* plug id */
+	buf[4] = 0x90;		/* EOH_1, Form_1, FMT. AM824 */
+	buf[5] = 0xff;		/* FDF-hi. AM824, frequency */
+	buf[6] = 0xff;		/* FDF-mid. AM824, SYT hi (not used) */
+	buf[7] = 0xff;		/* FDF-low. AM824, SYT lo (not used) */
+
+	/* do transaction and check buf[1-4] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 8, buf, 8,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4));
+	if (err < 0)
+		goto end;
+
+	/* check length */
+	if (err != 8) {
+		dev_err(&unit->device, "failed to get sample rate\n");
+		err = -EIO;
+		goto end;
+	}
+
+	/* check sfc field and pick up rate */
+	sfc = 0x07 & buf[5];
+	if (sfc >= CIP_SFC_COUNT) {
+		err = -EINVAL;
+		goto end;
+	}
+	*rate = amdtp_rate_table[sfc];
+
+	/* return response code */
+	err = buf[0];
+end:
+	kfree(buf);
+	return err;
+}
+EXPORT_SYMBOL(avc_general_get_sig_fmt);
+
+int avc_general_get_plug_info(struct fw_unit *unit,
+			unsigned short bus_plugs[AVC_GENERAL_PLUG_DIR_COUNT],
+			unsigned short ext_plugs[AVC_GENERAL_PLUG_DIR_COUNT])
+{
+	u8 *buf;
+	int err;
+
+	buf = kzalloc(8, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0] = 0x01;	/* AV/C STATUS */
+	buf[1] = 0xff;	/* UNIT */
+	buf[2] = 0x02;	/* PLUG INFO */
+
+	err = fcp_avc_transaction(unit, buf, 8, buf, 8, BIT(1) | BIT(2));
+	if (err < 0)
+		goto end;
+
+	/* check length */
+	if (err != 8) {
+		err = -EIO;
+		goto end;
+	}
+
+	bus_plugs[AVC_GENERAL_PLUG_DIR_IN]  = buf[4];
+	bus_plugs[AVC_GENERAL_PLUG_DIR_OUT] = buf[5];
+	ext_plugs[AVC_GENERAL_PLUG_DIR_IN]  = buf[6];
+	ext_plugs[AVC_GENERAL_PLUG_DIR_OUT] = buf[7];
+
+	/* return response code */
+	err = buf[0];
+end:
+	kfree(buf);
+	return err;
+}
+EXPORT_SYMBOL(avc_general_get_plug_info);
+
 static DEFINE_SPINLOCK(transactions_lock);
 static LIST_HEAD(transactions);
 
diff --git a/sound/firewire/fcp.h b/sound/firewire/fcp.h
index 8659568..84791e0 100644
--- a/sound/firewire/fcp.h
+++ b/sound/firewire/fcp.h
@@ -3,6 +3,22 @@
 
 struct fw_unit;
 
+/* AV/C Digital Interface Command Set General Specification 4.2 (1394TA) */
+enum avc_general_plug_dir {
+	AVC_GENERAL_PLUG_DIR_IN		= 0,
+	AVC_GENERAL_PLUG_DIR_OUT	= 1,
+	AVC_GENERAL_PLUG_DIR_COUNT
+};
+int avc_general_set_sig_fmt(struct fw_unit *unit, unsigned int rate,
+			    enum avc_general_plug_dir dir,
+			    unsigned short plug);
+int avc_general_get_sig_fmt(struct fw_unit *unit, unsigned int *rate,
+			    enum avc_general_plug_dir dir,
+			    unsigned short plug);
+int avc_general_get_plug_info(struct fw_unit *unit,
+			unsigned short bus_plugs[AVC_GENERAL_PLUG_DIR_COUNT],
+			unsigned short ext_plugs[AVC_GENERAL_PLUG_DIR_COUNT]);
+
 int fcp_avc_transaction(struct fw_unit *unit,
 			const void *command, unsigned int command_size,
 			void *response, unsigned int response_size,
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index d548376..5fb3e2c 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -194,42 +194,6 @@ static void fwspk_stop_stream(struct fwspk *fwspk)
 	}
 }
 
-static int fwspk_set_rate(struct fwspk *fwspk, unsigned int sfc)
-{
-	u8 *buf;
-	int err;
-
-	buf = kmalloc(8, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	buf[0] = 0x00;		/* AV/C, CONTROL */
-	buf[1] = 0xff;		/* unit */
-	buf[2] = 0x19;		/* INPUT PLUG SIGNAL FORMAT */
-	buf[3] = 0x00;		/* plug 0 */
-	buf[4] = 0x90;		/* format: audio */
-	buf[5] = 0x00 | sfc;	/* AM824, frequency */
-	buf[6] = 0xff;		/* SYT (not used) */
-	buf[7] = 0xff;
-
-	err = fcp_avc_transaction(fwspk->unit, buf, 8, buf, 8,
-				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5));
-	if (err < 0)
-		goto error;
-	if (err < 6 || buf[0] != 0x09 /* ACCEPTED */) {
-		dev_err(&fwspk->unit->device, "failed to set sample rate\n");
-		err = -EIO;
-		goto error;
-	}
-
-	err = 0;
-
-error:
-	kfree(buf);
-
-	return err;
-}
-
 static int fwspk_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *hw_params)
 {
@@ -253,9 +217,15 @@ static int fwspk_hw_params(struct snd_pcm_substream *substream,
 	amdtp_stream_set_pcm_format(&fwspk->stream,
 				    params_format(hw_params));
 
-	err = fwspk_set_rate(fwspk, fwspk->stream.sfc);
+	err = avc_general_set_sig_fmt(fwspk->unit, params_rate(hw_params),
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
 	if (err < 0)
 		goto err_buffer;
+	if (err != 0x09 /* ACCEPTED */) {
+		dev_err(&fwspk->unit->device, "failed to set sample rate\n");
+		err = -EIO;
+		goto error;
+	}
 
 	return 0;
 
-- 
1.8.3.2
