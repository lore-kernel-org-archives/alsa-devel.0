From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/13] bebob: Add support for Yamaha GO series
Date: Sat, 23 Nov 2013 15:09:24 +0900
Message-ID: <1385186965-8303-13-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 29001265311
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

This commit allows this driver to support all of models which Yamaha produced
with BeBoB chipset. They are:
 - GO44
 - GO46

This commit adds Yamaha specific operations, quirks for three functionalities.

1. Switching source of clock
2. Detecting signal in digital input
3. Check clock synchronization

The driver uses these functionalities with AV/C vendor specific commands and
AV/C Audio Subunit commands.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig              |   1 +
 sound/firewire/bebob/Makefile       |   1 +
 sound/firewire/bebob/bebob.c        |   7 ++
 sound/firewire/bebob/bebob.h        |   1 +
 sound/firewire/bebob/bebob_yamaha.c | 176 ++++++++++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+)
 create mode 100644 sound/firewire/bebob/bebob_yamaha.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 502dce9..08ecc18 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -84,6 +84,7 @@ config SND_BEBOB
 	  * M-Audio Firewire1814/ProjectMix IO/ProfireLightBridge
 	  * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
 	  * TerraTec PHASE 24 FW/PHASE X24 FW/PHASE 88 Rack FW
+	  * Yamaha GO44/GO46
 
           To compile this driver as a module, choose M here: the module
           will be called snd-fireworks.
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 2fefcec..a81540b 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,5 +1,6 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_control.o \
 		  bebob_midi.o bebob_pcm.o bebob_hwdep.o \
 		  bebob_maudio.o bebob_focusrite.o bebob_terratec.o \
+		  bebob_yamaha.o \
 		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 7c5576d..d871fae 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -54,6 +54,7 @@ static unsigned int devices_used;
 #define VEN_MAUDIO2	0x000007f5
 #define VEN_FOCUSRITE	0x0000130e
 #define VEN_TERRATEC	0x00000aac
+#define VEN_YAMAHA	0x0000a0de
 
 #define MODEL_MAUDIO_AUDIOPHILE_BOTH	0x00010060
 #define MODEL_MAUDIO_FW1814		0x00010071
@@ -95,6 +96,8 @@ name_device(struct snd_bebob *bebob, unsigned int vendor_id)
 		strcpy(vendor, "M-Audio");
 	else if (vendor_id == VEN_TERRATEC)
 		strcpy(vendor, "Terratec");
+	else if (vendor_id == VEN_YAMAHA)
+		strcpy(vendor, "YAMAHA");
 
 	/* get model name */
 	err = fw_csr_string(bebob->unit->directory, CSR_MODEL,
@@ -403,6 +406,10 @@ static const struct ieee1394_device_id snd_bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000004, phase24_series_spec),
 	/* TerraTecElectronic GmbH, Phase X24 FW */
 	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000007, phase24_series_spec),
+	/* Yamaha, GO44 */
+	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000b, yamaha_go_spec),
+	/* YAMAHA, GO46 */
+	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000c, yamaha_go_spec),
 	{}
 };
 MODULE_DEVICE_TABLE(ieee1394, snd_bebob_id_table);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 6a92f43..b3211b6 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -240,6 +240,7 @@ extern struct snd_bebob_spec saffire_le_spec;
 extern struct snd_bebob_spec saffire_spec;
 extern struct snd_bebob_spec phase88_rack_spec;
 extern struct snd_bebob_spec phase24_series_spec;
+extern struct snd_bebob_spec yamaha_go_spec;
 
 #define SND_BEBOB_DEV_ENTRY(vendor, model, private_data) \
 { \
diff --git a/sound/firewire/bebob/bebob_yamaha.c b/sound/firewire/bebob/bebob_yamaha.c
new file mode 100644
index 0000000..fc8a44f
--- /dev/null
+++ b/sound/firewire/bebob/bebob_yamaha.c
@@ -0,0 +1,176 @@
+/*
+ * bebob_yamaha.c - a part of driver for BeBoB based devices
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
+ * Yamaha GO44 is not considered to be used as stand-alone mixer. So any streams
+ * must be accompanied. If changing the state, a LED on the device starts to
+ * blink and its sync status is false. In this state, the device sounds nothing
+ * even if streaming. To start streaming at the current sampling rate is only
+ * way to revocer this state. GO46 is better for stand-alone mixer.
+ *
+ * Both of them have a capability to change its sampling rate up to 192.0kHz.
+ * At 192.0kHz, the device reports 4 PCM-in, 1 MIDI-in, 6 PCM-out, 1 MIDI-out.
+ * But Yamaha's driver reduce 2 PCM-in, 1 MIDI-in, 2 PCM-out, 1 MIDI-out to use
+ * 'Extended Stream Format Information Command - Single Request' in 'Additional
+ * AVC commands' defined by BridgeCo.
+ * This ALSA driver don't do this because a bit tiresome. Then isochronous
+ * streaming with many asynchronous transactions brings sounds with noises.
+ * Unfortunately current 'ffado-mixer' generated many asynchronous transaction
+ * to observe device's state, mainly check cmp connection and signal format. I
+ * reccomend users to close ffado-mixer at 192.0kHz if mixer is needless.
+ */
+
+static int
+detect_dig_in(struct snd_bebob *bebob, unsigned int *detect)
+{
+	int err;
+	u8 *buf;
+
+	buf = kmalloc(12, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	/* This is a vendor dependent command */
+	buf[0]  = 0x01;	/* STATUS */
+	buf[1]  = 0xff;	/* UNIT */
+	buf[2]  = 0x00;	/* Vendor Dependent command */
+	buf[3]  = 0x00;	/* Company ID high */
+	buf[4]  = 0x07;	/* Company ID middle */
+	buf[5]  = 0xf5;	/* Company ID low */
+	buf[6]  = 0x00;	/* Unknown Subfunction*/
+	buf[7]  = 0x00;	/* Unknown */
+	buf[8]  = 0x01; /* Unknown */
+	buf[9]  = 0x00;	/* Unknown */
+	buf[10] = 0x00;	/* Unknown */
+	buf[11] = 0x00;	/* Unknown */
+
+	/* do transaction and check buf[1-6] are the same against command */
+	err = fcp_avc_transaction(bebob->unit, buf, 12, buf, 12,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) |
+				  BIT(5) | BIT(6));
+	if (err < 0)
+		goto end;
+	/* IMPLEMENTED/STABLE is OK */
+	if ((err < 6) || (buf[0] != 0x0c)){
+		dev_err(&bebob->unit->device,
+			"failed to detect clock source 0x%02X\n",
+			buf[0]);
+		err = -EIO;
+		goto end;
+	}
+
+	/* when digital clock input exists, 10th byte is 0x01 */
+	*detect = (buf[9] > 0);
+	err = 0;
+end:
+	return err;
+}
+
+static int
+get_sync_status(struct snd_bebob *bebob, bool *sync)
+{
+	u8 *buf;
+	int err;
+
+	buf = kmalloc(8, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0] = 0x01;  /* AV/C STATUS */
+	buf[1] = 0xFF;  /* UNIT */
+	buf[2] = 0x00;  /* Vendor Specific Command */
+	buf[3] = 0x01;	/* Company ID high */
+	buf[4] = 0x02;	/* Company ID middle */
+	buf[5] = 0x03;	/* Company ID low */
+	buf[6] = 0x21;	/* unknown subfunction */
+	buf[7] = 0xff;  /* status */
+
+	err = fcp_avc_transaction(bebob->unit, buf, 8, buf, 8,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) |
+				  BIT(5) | BIT(6));
+	if (err < 0)
+		goto end;
+	if ((err < 6) || (buf[0] != 0x0c)) {
+		dev_err(&bebob->unit->device,
+			"failed to get sync status\n");
+		err = -EIO;
+		goto end;
+	}
+
+	/* 0x00 if losing sync */
+	*sync = (buf[7] != 0x00);
+	err = 0;
+end:
+	kfree(buf);
+	return err;
+}
+
+static char *clk_src_labels[] = {SND_BEBOB_CLOCK_INTERNAL, "SPDIF"};
+static int
+clk_src_set(struct snd_bebob *bebob, unsigned int id)
+{
+	int err;
+	unsigned int detect;
+
+	if (id > 0) {
+		err = detect_dig_in(bebob, &detect);
+		if ((err < 0) || (detect == 0))
+			return -EIO;
+	}
+
+	err = avc_audio_set_selector(bebob->unit, 0, 4, id);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * Yamaha BeBob returns 'IN TRANSITION' status just after returning to
+	 * internal clock
+	 */
+	if (id == 0)
+		msleep(1500);
+
+end:
+	return err;
+}
+static int
+clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	return avc_audio_get_selector(bebob->unit, 0, 4, id);
+}
+static int
+clk_synced(struct snd_bebob *bebob, bool *synced)
+{
+	return get_sync_status(bebob, synced);
+}
+
+static struct snd_bebob_clock_spec clock_spec = {
+	.num		= ARRAY_SIZE(clk_src_labels),
+	.labels		= clk_src_labels,
+	.get_src	= &clk_src_get,
+	.set_src	= &clk_src_set,
+	.get_freq	= &snd_bebob_stream_get_rate,
+	.set_freq	= &snd_bebob_stream_set_rate,
+	.synced		= &clk_synced
+};
+struct snd_bebob_spec yamaha_go_spec = {
+	.load	= NULL,
+	.clock	= &clock_spec,
+	.meter	= NULL
+};
-- 
1.8.3.2
