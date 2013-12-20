From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 34/38] bebob: Add support for Yamaha GO series
Date: Fri, 20 Dec 2013 22:14:25 +0900
Message-ID: <1387545269-3875-35-git-send-email-o-takashi@sakamocchi.jp>
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

This commit allows this driver to support all of models which Yamaha produced
with DM1000/BeBoB. They are:
 - GO44
 - GO46

This commit adds Yamaha specific operations. To get source of clock, AV/C Audio
Subunit command is used.

I note that their appearances are similar to some models of TerraTec; 'Go44' is
similar to 'PHASE 24 FW' and 'GO46' is similar to 'PHASE X24 FW'. But their
combination of Audio/Music subunit are a bit different.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig              |  1 +
 sound/firewire/bebob/Makefile       |  3 ++-
 sound/firewire/bebob/bebob.c        |  5 ++++
 sound/firewire/bebob/bebob.h        |  1 +
 sound/firewire/bebob/bebob_yamaha.c | 50 +++++++++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/bebob/bebob_yamaha.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 34615e5..d23bfa8 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -107,6 +107,7 @@ config SND_BEBOB
 	  * TerraTec PHASE 24 FW/PHASE X24 FW/PHASE 88 Rack FW
 	  * Terratec EWS MIC2/EWS MIC4
 	  * Terratec Aureon 7.1 Firewire
+	  * Yamaha GO44/GO46
 
           To compile this driver as a module, choose M here: the module
           will be called snd-bebob.
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index cb38dd1..c35eee1 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,3 +1,4 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_midi.o \
-		  bebob_pcm.o bebob_hwdep.o bebob_terratec.o bebob.o
+		  bebob_pcm.o bebob_hwdep.o bebob_terratec.o bebob_yamaha.o \
+		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index f0a4ecb..ad6a27e 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -53,6 +53,7 @@ static unsigned int devices_used;
 #define VEN_ICON	0x00001a9e
 #define VEN_PRISMSOUND	0x00001198
 #define VEN_TERRATEC	0x00000aac
+#define VEN_YAMAHA	0x0000a0de
 
 static int
 name_device(struct snd_bebob *bebob, unsigned int vendor_id)
@@ -296,6 +297,10 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000005, &spec_normal),
 	/* Terratec Electronic GmbH, Aureon 7.1 Firewire */
 	SND_BEBOB_DEV_ENTRY(VEN_TERRATEC, 0x00000002, &spec_normal),
+	/* Yamaha, GO44 */
+	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000b, &yamaha_go_spec),
+	/* YAMAHA, GO46 */
+	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000c, &yamaha_go_spec),
 	/* Ids are unknown but able to be supported */
 	/*  Mackie, Digital X Bus x.200 */
 	/*  Mackie, Digital X Bus x.400 */
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 1cb171b..a684f06 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -230,6 +230,7 @@ int snd_bebob_create_hwdep_device(struct snd_bebob *bebob);
 /* model specific operations */
 extern struct snd_bebob_spec phase88_rack_spec;
 extern struct snd_bebob_spec phase24_series_spec;
+extern struct snd_bebob_spec yamaha_go_spec;
 
 #define SND_BEBOB_DEV_ENTRY(vendor, model, data) \
 { \
diff --git a/sound/firewire/bebob/bebob_yamaha.c b/sound/firewire/bebob/bebob_yamaha.c
new file mode 100644
index 0000000..f71af6b
--- /dev/null
+++ b/sound/firewire/bebob/bebob_yamaha.c
@@ -0,0 +1,50 @@
+/*
+ * bebob_yamaha.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./bebob.h"
+
+/*
+ * NOTE:
+ * Yamaha GO44 is not designed to be used as stand-alone mixer. So any streams
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
+static char *clk_src_labels[] = {SND_BEBOB_CLOCK_INTERNAL, "SPDIF"};
+static int
+clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	return avc_audio_get_selector(bebob->unit, 0, 4, id);
+}
+static struct snd_bebob_clock_spec clock_spec = {
+	.num	= ARRAY_SIZE(clk_src_labels),
+	.labels	= clk_src_labels,
+	.get	= &clk_src_get,
+};
+static struct snd_bebob_rate_spec rate_spec = {
+	.get	= &snd_bebob_stream_get_rate,
+	.set	= &snd_bebob_stream_set_rate,
+};
+struct snd_bebob_spec yamaha_go_spec = {
+	.clock	= &clock_spec,
+	.rate	= &rate_spec,
+	.meter	= NULL
+};
-- 
1.8.3.2


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
