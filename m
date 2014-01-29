From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 33/52] bebob: Add support for Terratec PHASE,
	EWS series and Aureon
Date: Wed, 29 Jan 2014 22:44:40 +0900
Message-ID: <1391003099-7109-34-git-send-email-o-takashi@sakamocchi.jp>
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

This commit allows this driver to support all of models which Terratec produced
with DM1000/BeBoB. They are:
 - PHASE 24 FW
 - PHASE X24 FW
 - PHASE 88 Rack FW
 - EWS MIC2
 - EWS MIC4
 - Aureon 7.1 Firewire

For Phase series, this commit adds a Terratec specific operation. To get source
of clock. AV/C Audio Subunit command is used.

For EWS series and Aureon, this module uses normal operations.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                |  3 ++
 sound/firewire/bebob/Makefile         |  2 +-
 sound/firewire/bebob/bebob.c          | 11 ++++++
 sound/firewire/bebob/bebob.h          |  4 +++
 sound/firewire/bebob/bebob_terratec.c | 68 +++++++++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/bebob/bebob_terratec.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 060fe7e..0a7918a 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -108,6 +108,9 @@ config SND_BEBOB
 	  * Lynx Aurora 8/16 (LT-FW)
 	  * ICON FireXon
 	  * PrismSound Orpheus/ADA-8XR
+	  * TerraTec PHASE 24 FW/PHASE X24 FW/PHASE 88 Rack FW
+	  * Terratec EWS MIC2/EWS MIC4
+	  * Terratec Aureon 7.1 Firewire
 
           To compile this driver as a module, choose M here: the module
           will be called snd-bebob.
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index e4b08e3..cb38dd1 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,3 +1,3 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_midi.o \
-		  bebob_pcm.o bebob_hwdep.o bebob.o
+		  bebob_pcm.o bebob_hwdep.o bebob_terratec.o bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index a53eb13..42e6d6c 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -52,6 +52,7 @@ static unsigned int devices_used;
 #define VEN_LYNX	0x000019e5
 #define VEN_ICON	0x00001a9e
 #define VEN_PRISMSOUND	0x00001198
+#define VEN_TERRATEC	0x00000aac
 
 static int
 name_device(struct snd_bebob *bebob, unsigned int vendor_id)
@@ -294,6 +295,16 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_PRISMSOUND, 0x00010048, &spec_normal),
 	/* PrismSound, ADA-8XR */
 	SND_BEBOB_DEV_ENTRY(VEN_PRISMSOUND, 0x0000ada8, &spec_normal),
+	/* TerraTec Electronic GmbH, PHASE 88 Rack FW */
+	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000003, &phase88_rack_spec),
+	/* TerraTec Electronic GmbH, PHASE 24 FW */
+	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000004, &phase24_series_spec),
+	/* TerraTec Electronic GmbH, Phase X24 FW */
+	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000007, &phase24_series_spec),
+	/* TerraTec Electronic GmbH, EWS MIC2/MIC8 */
+	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000005, &spec_normal),
+	/* Terratec Electronic GmbH, Aureon 7.1 Firewire */
+	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000002, &spec_normal),
 	/* IDs are unknown but able to be supported */
 	/*  Apogee, Mini-ME Firewire */
 	/*  Apogee, Mini-DAC Firewire */
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index ea53d56..3723f2b 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -228,6 +228,10 @@ int snd_bebob_create_pcm_devices(struct snd_bebob *bebob);
 
 int snd_bebob_create_hwdep_device(struct snd_bebob *bebob);
 
+/* model specific operations */
+extern struct snd_bebob_spec phase88_rack_spec;
+extern struct snd_bebob_spec phase24_series_spec;
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model, data) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_terratec.c b/sound/firewire/bebob/bebob_terratec.c
new file mode 100644
index 0000000..9c2cebf
--- /dev/null
+++ b/sound/firewire/bebob/bebob_terratec.c
@@ -0,0 +1,68 @@
+/*
+ * bebob_terratec.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
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
+
+static char *phase24_series_clk_src_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL, "Digital In"
+};
+static int
+phase24_series_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	return avc_audio_get_selector(bebob->unit, 0, 4, id);
+}
+
+struct snd_bebob_rate_spec phase_series_rate_spec = {
+	.get	= &snd_bebob_stream_get_rate,
+	.set	= &snd_bebob_stream_set_rate,
+};
+
+/* PHASE 88 Rack FW */
+struct snd_bebob_clock_spec phase88_rack_clk = {
+	.num	= ARRAY_SIZE(phase88_rack_clk_src_labels),
+	.labels	= phase88_rack_clk_src_labels,
+	.get	= &phase88_rack_clk_src_get,
+};
+struct snd_bebob_spec phase88_rack_spec = {
+	.clock	= &phase88_rack_clk,
+	.rate	= &phase_series_rate_spec,
+	.meter	= NULL
+};
+
+/* 'PHASE 24 FW' and 'PHASE X24 FW' */
+struct snd_bebob_clock_spec phase24_series_clk = {
+	.num	= ARRAY_SIZE(phase24_series_clk_src_labels),
+	.labels	= phase24_series_clk_src_labels,
+	.get	= &phase24_series_clk_src_get,
+};
+struct snd_bebob_spec phase24_series_spec = {
+	.clock	= &phase24_series_clk,
+	.rate	= &phase_series_rate_spec,
+	.meter	= NULL
+};
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
