From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 45/52] oxfw: Add proc interface for debugging purpose
Date: Wed, 29 Jan 2014 22:44:52 +0900
Message-ID: <1391003099-7109-46-git-send-email-o-takashi@sakamocchi.jp>
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

The previous commit adds stream formation. This commit adds proc interface
to get information about:
 - stream formation
 - current sampling rate

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile    |  2 +-
 sound/firewire/oxfw/oxfw.c      |  2 ++
 sound/firewire/oxfw/oxfw.h      |  3 +++
 sound/firewire/oxfw/oxfw_proc.c | 54 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/oxfw/oxfw_proc.c

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 3eaec6d..53b5572 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,2 +1,2 @@
-snd-oxfw-objs := oxfw_stream.o oxfw_control.o oxfw_pcm.o oxfw.o
+snd-oxfw-objs := oxfw_stream.o oxfw_control.o oxfw_proc.o oxfw_pcm.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index fda1ada..b0c7b2a 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -127,6 +127,8 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto err_card;
 
+	snd_oxfw_proc_init(oxfw);
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0)
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index c3a7e22..2de6671 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -18,6 +18,7 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/info.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -68,3 +69,5 @@ int lacie_speakers_stream_discover(struct snd_oxfw *oxfw);
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_mixer(struct snd_oxfw *oxfw);
+
+void snd_oxfw_proc_init(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_proc.c b/sound/firewire/oxfw/oxfw_proc.c
new file mode 100644
index 0000000..e8d80d5
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw_proc.c
@@ -0,0 +1,54 @@
+/*
+ * oxfw_proc.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./oxfw.h"
+
+static void
+proc_read_formation(struct snd_info_entry *entry,
+		    struct snd_info_buffer *buffer)
+{
+	struct snd_oxfw *oxfw = entry->private_data;
+	struct snd_oxfw_stream_formation *formation;
+	unsigned int i;
+
+	snd_iprintf(buffer, "Input Stream to device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = oxfw->rx_stream_formations;
+	for (i = 0; i < SND_OXFW_STREAM_TABLE_ENTRIES; i++) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", snd_oxfw_rate_table[i],
+			formation[i].pcm, formation[i].midi);
+	}
+}
+
+static void
+proc_read_clock(struct snd_info_entry *entry,
+		struct snd_info_buffer *buffer)
+{
+	struct snd_oxfw *oxfw = entry->private_data;
+	unsigned int rate;
+	int err;
+
+	err = avc_general_get_sig_fmt(oxfw->unit, &rate,
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	if ((err < 0) && (err == 0x09))
+		snd_iprintf(buffer, "Sampling rate: %d\n", rate);
+}
+
+void snd_oxfw_proc_init(struct snd_oxfw *oxfw)
+{
+	struct snd_info_entry *entry;
+
+	if (!snd_card_proc_new(oxfw->card, "#formation", &entry))
+		snd_info_set_text_ops(entry, oxfw, proc_read_formation);
+
+	if (!snd_card_proc_new(oxfw->card, "#clock", &entry))
+		snd_info_set_text_ops(entry, oxfw, proc_read_clock);
+
+	return;
+}
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
