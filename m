From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/13] bebob: Add support for Terratec PHASE
	series
Date: Sat, 23 Nov 2013 15:09:23 +0900
Message-ID: <1385186965-8303-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 31A2D265312
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

This commit allows this driver to support all of models which Terratec produced
with BeBoB chipset. They are:
 - PHASE 24 FW
 - PHASE X24 FW
 - PHASE 88 Rack FW

This commit adds Terratec specific operations, quirks for three functionalities.

1. Switching source of clock
2. Change sampling frequency
3. Check clock synchronization

The driver uses these functionalities with AV/C vendor specific commands and
AV/C Audio Subunit commands.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                |   1 +
 sound/firewire/bebob/Makefile         |   2 +-
 sound/firewire/bebob/bebob.c          |   9 +++
 sound/firewire/bebob/bebob.h          |   2 +
 sound/firewire/bebob/bebob_terratec.c | 143 ++++++++++++++++++++++++++++++++++
 5 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/bebob/bebob_terratec.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index b8d7fb5..502dce9 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -83,6 +83,7 @@ config SND_BEBOB
 	  * M-Audio Firewire410/AudioPhile/Solo/Ozonic/NRV10
 	  * M-Audio Firewire1814/ProjectMix IO/ProfireLightBridge
 	  * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
+	  * TerraTec PHASE 24 FW/PHASE X24 FW/PHASE 88 Rack FW
 
           To compile this driver as a module, choose M here: the module
           will be called snd-fireworks.
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 96f8e92..2fefcec 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,5 +1,5 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_control.o \
 		  bebob_midi.o bebob_pcm.o bebob_hwdep.o \
-		  bebob_maudio.o bebob_focusrite.o \
+		  bebob_maudio.o bebob_focusrite.o bebob_terratec.o \
 		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 6382b49..7c5576d 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -53,6 +53,7 @@ static unsigned int devices_used;
 #define VEN_MAUDIO1	0x00000d6c
 #define VEN_MAUDIO2	0x000007f5
 #define VEN_FOCUSRITE	0x0000130e
+#define VEN_TERRATEC	0x00000aac
 
 #define MODEL_MAUDIO_AUDIOPHILE_BOTH	0x00010060
 #define MODEL_MAUDIO_FW1814		0x00010071
@@ -92,6 +93,8 @@ name_device(struct snd_bebob *bebob, unsigned int vendor_id)
 		strcpy(vendor, "Phonic");
 	else if ((vendor_id == VEN_MAUDIO1) || (vendor_id == VEN_MAUDIO2))
 		strcpy(vendor, "M-Audio");
+	else if (vendor_id == VEN_TERRATEC)
+		strcpy(vendor, "Terratec");
 
 	/* get model name */
 	err = fw_csr_string(bebob->unit->directory, CSR_MODEL,
@@ -394,6 +397,12 @@ static const struct ieee1394_device_id snd_bebob_id_table[] = {
 	/* Focusrite, Saffire(no label and LE) */
 	SND_BEBOB_DEV_ENTRY(VEN_FOCUSRITE, MODEL_FOCUSRITE_SAFFIRE_BOTH,
 			    saffire_spec),
+	/* TerraTecElectronic GmbH, PHASE 88 Rack FW */
+	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000003, phase88_rack_spec),
+	/* TerraTecElectronic GmbH, PHASE 24 FW */
+	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000004, phase24_series_spec),
+	/* TerraTecElectronic GmbH, Phase X24 FW */
+	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000007, phase24_series_spec),
 	{}
 };
 MODULE_DEVICE_TABLE(ieee1394, snd_bebob_id_table);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 90b37eb..6a92f43 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -238,6 +238,8 @@ extern struct snd_bebob_spec saffirepro_26_spec;
 extern struct snd_bebob_spec saffirepro_10_spec;
 extern struct snd_bebob_spec saffire_le_spec;
 extern struct snd_bebob_spec saffire_spec;
+extern struct snd_bebob_spec phase88_rack_spec;
+extern struct snd_bebob_spec phase24_series_spec;
 
 #define SND_BEBOB_DEV_ENTRY(vendor, model, private_data) \
 { \
diff --git a/sound/firewire/bebob/bebob_terratec.c b/sound/firewire/bebob/bebob_terratec.c
new file mode 100644
index 0000000..149507a
--- /dev/null
+++ b/sound/firewire/bebob/bebob_terratec.c
@@ -0,0 +1,143 @@
+/*
+ * bebob_terratec.c - a part of driver for BeBoB based devices
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
+static char *phase88_rack_clk_src_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL, "Digital In", "Word Clock"
+};
+static int
+phase88_rack_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	unsigned int enable_ext, enable_word;
+	int err;
+
+	err = avc_audio_get_selector(bebob->unit, 0, 0, &enable_ext);
+	if (err < 0)
+		goto end;
+	err = avc_audio_get_selector(bebob->unit, 0, 0, &enable_word);
+	if (err < 0)
+		goto end;
+
+	*id = (enable_ext & 0x01) || ((enable_word & 0x01) << 1);
+end:
+	return err;
+}
+static int
+phase88_rack_clk_src_set(struct snd_bebob *bebob, unsigned int id)
+{
+	unsigned int enable_ext, enable_word;
+	int err;
+
+	enable_ext = id & 0x01;
+	enable_word = (id >> 1) & 0x01;
+
+	err = avc_audio_set_selector(bebob->unit, 0, 9, enable_ext);
+	if (err < 0)
+		goto end;
+	err = avc_audio_set_selector(bebob->unit, 0, 8, enable_word);
+	if (err < 0)
+		goto end;
+end:
+	return err;
+}
+
+static int
+phase88_rack_clk_synced(struct snd_bebob *bebob, bool *synced)
+{
+	int err;
+	u8 *buf;
+
+	buf = kmalloc(8, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0]  = 0x01;	/* STATUS */
+	buf[1]  = 0xff;	/* UNIT */
+	buf[2]  = 0x00;	/* Vendor Dependent */
+	buf[3]  = 0x00; /* Company ID high */
+	buf[4]  = 0x0a;	/* Company ID middle */
+	buf[5]  = 0xac; /* Company ID low */
+	buf[6]  = 0x21;	/* subfunction */
+	buf[7]  = 0xff;	/* the state */
+
+	/* do transaction and check buf[1-6] are the same against command */
+	err = fcp_avc_transaction(bebob->unit, buf, 8, buf, 8,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) |
+				  BIT(5) | BIT(6));
+	if (err < 0)
+		goto end;
+	/* IMPLEMENTED/STABLE is OK */
+	if ((err < 6) || (buf[0] != 0x0c)) {
+		dev_err(&bebob->unit->device,
+			"fail to execute Terratek command: %02X\n",
+			buf[0]);
+		err = -EIO;
+		goto end;
+	}
+
+	*synced = (buf[7] = 0x01);
+end:
+	kfree(buf);
+	return err;
+}
+
+static char *phase24_series_clk_src_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL, "Digital In"
+};
+static int
+phase24_series_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	return avc_audio_get_selector(bebob->unit, 0, 4, id);
+}
+static int
+phase24_series_clk_src_set(struct snd_bebob *bebob, unsigned int id)
+{
+	return avc_audio_set_selector(bebob->unit, 0, 4, id);
+}
+
+/* PHASE 88 Rack FW */
+struct snd_bebob_clock_spec phase88_rack_clk = {
+	.num		= ARRAY_SIZE(phase88_rack_clk_src_labels),
+	.labels		= phase88_rack_clk_src_labels,
+	.get_src	= &phase88_rack_clk_src_get,
+	.set_src	= &phase88_rack_clk_src_set,
+	.get_freq	= &snd_bebob_stream_get_rate,
+	.set_freq	= &snd_bebob_stream_set_rate,
+	.synced		= &phase88_rack_clk_synced
+};
+struct snd_bebob_spec phase88_rack_spec = {
+	.load	= NULL,
+	.clock	= &phase88_rack_clk,
+	.meter	= NULL
+};
+
+/* 'PHASE 24 FW' and 'PHASE X24 FW' */
+struct snd_bebob_clock_spec phase24_series_clk = {
+	.num		= ARRAY_SIZE(phase24_series_clk_src_labels),
+	.labels		= phase24_series_clk_src_labels,
+	.get_src	= &phase24_series_clk_src_get,
+	.set_src	= &phase24_series_clk_src_set,
+	.get_freq	= &snd_bebob_stream_get_rate,
+	.set_freq	= &snd_bebob_stream_set_rate,
+	.synced		= NULL
+};
+struct snd_bebob_spec phase24_series_spec = {
+	.load	= NULL,
+	.clock	= &phase24_series_clk,
+	.meter	= NULL
+};
-- 
1.8.3.2
