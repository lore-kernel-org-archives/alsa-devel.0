From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/13] bebob: Add support for Presonus
	FIREBOX/FIREPOD
Date: Sat, 23 Nov 2013 15:09:25 +0900
Message-ID: <1385186965-8303-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id A7356265313
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

This commit allows this driver to support FIREBOX/FIREPOD which PreSonus
produced with BeBoB chipset.

This commit adds FIREBOX specific operations for switching source of clock
with AV/C Signal Cource command. FIREPOD is not tested so use normal spec.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                |  1 +
 sound/firewire/bebob/Makefile         |  2 +-
 sound/firewire/bebob/bebob.c          |  7 ++++
 sound/firewire/bebob/bebob.h          |  1 +
 sound/firewire/bebob/bebob_presonus.c | 75 +++++++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/bebob/bebob_presonus.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 08ecc18..3879a9b 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -85,6 +85,7 @@ config SND_BEBOB
 	  * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
 	  * TerraTec PHASE 24 FW/PHASE X24 FW/PHASE 88 Rack FW
 	  * Yamaha GO44/GO46
+	  * PreSonus FIREBOX/FirePod
 
           To compile this driver as a module, choose M here: the module
           will be called snd-fireworks.
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index a81540b..4510460 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,6 +1,6 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_control.o \
 		  bebob_midi.o bebob_pcm.o bebob_hwdep.o \
 		  bebob_maudio.o bebob_focusrite.o bebob_terratec.o \
-		  bebob_yamaha.o \
+		  bebob_yamaha.o bebob_presonus.o \
 		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index d871fae..fdda63e 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -55,6 +55,7 @@ static unsigned int devices_used;
 #define VEN_FOCUSRITE	0x0000130e
 #define VEN_TERRATEC	0x00000aac
 #define VEN_YAMAHA	0x0000a0de
+#define VEN_PRESONUS	0x00000a92
 
 #define MODEL_MAUDIO_AUDIOPHILE_BOTH	0x00010060
 #define MODEL_MAUDIO_FW1814		0x00010071
@@ -98,6 +99,8 @@ name_device(struct snd_bebob *bebob, unsigned int vendor_id)
 		strcpy(vendor, "Terratec");
 	else if (vendor_id == VEN_YAMAHA)
 		strcpy(vendor, "YAMAHA");
+	else if (vendor_id == VEN_PRESONUS)
+		strcpy(vendor, "Presonus");
 
 	/* get model name */
 	err = fw_csr_string(bebob->unit->directory, CSR_MODEL,
@@ -410,6 +413,10 @@ static const struct ieee1394_device_id snd_bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000b, yamaha_go_spec),
 	/* YAMAHA, GO46 */
 	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000c, yamaha_go_spec),
+	/* Presonus, FireBox */
+	SND_BEBOB_DEV_ENTRY(VEN_PRESONUS, 0x00010000, presonus_firebox_spec),
+	/* PreSonus FirePod */
+	SND_BEBOB_DEV_ENTRY(VEN_PRESONUS, 0x00010066, spec_normal),
 	{}
 };
 MODULE_DEVICE_TABLE(ieee1394, snd_bebob_id_table);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index b3211b6..1f562d4 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -241,6 +241,7 @@ extern struct snd_bebob_spec saffire_spec;
 extern struct snd_bebob_spec phase88_rack_spec;
 extern struct snd_bebob_spec phase24_series_spec;
 extern struct snd_bebob_spec yamaha_go_spec;
+extern struct snd_bebob_spec presonus_firebox_spec;
 
 #define SND_BEBOB_DEV_ENTRY(vendor, model, private_data) \
 { \
diff --git a/sound/firewire/bebob/bebob_presonus.c b/sound/firewire/bebob/bebob_presonus.c
new file mode 100644
index 0000000..cf419b3
--- /dev/null
+++ b/sound/firewire/bebob/bebob_presonus.c
@@ -0,0 +1,75 @@
+/*
+ * bebob_presonus.c - a part of driver for BeBoB based devices
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
+/* FIREBOX specific controls */
+static char *firebox_clk_src_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL, "Digital Coaxial"
+};
+static int
+firebox_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	int err;
+	unsigned int stype, sid, pid;
+
+	err = avc_ccm_get_sig_src(bebob->unit,
+				  &stype, &sid, &pid, 0x0c, 0x00, 0x05);
+	if (err < 0)
+		goto end;
+
+	if ((stype != 0x1f) && (sid != 0x07) && (pid != 0x83))
+		*id = 0;
+	else
+		*id = 1;
+end:
+	return err;
+}
+static int
+firebox_clk_src_set(struct snd_bebob *bebob, unsigned int id)
+{
+	unsigned int stype, sid, pid;
+
+	if (id != 1) {
+		stype = 0x1f;
+		sid = 0x07;
+		pid = 0x83;
+	} else {
+		stype = 0x0c;
+		sid = 0x00;
+		pid = 0x01;
+	}
+
+	return avc_ccm_set_sig_src(bebob->unit,
+				   stype, sid, pid, 0x0c, 0x00, 0x05);
+}
+
+/* FIREBOX specification */
+static struct snd_bebob_clock_spec firebox_clk_spec = {
+	.num		= ARRAY_SIZE(firebox_clk_src_labels),
+	.labels		= firebox_clk_src_labels,
+	.get_src	= &firebox_clk_src_get,
+	.set_src	= &firebox_clk_src_set,
+	.get_freq	= &snd_bebob_stream_get_rate,
+	.set_freq	= &snd_bebob_stream_set_rate,
+	.synced		= NULL
+};
+struct snd_bebob_spec presonus_firebox_spec = {
+	.load	= NULL,
+	.clock	= &firebox_clk_spec,
+	.meter	= NULL
+};
-- 
1.8.3.2
