From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/13] speakers: Add proc interface for
	debugging purpose
Date: Sat, 11 Jan 2014 00:29:29 +0900
Message-ID: <1389367775-21360-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 373A8261A60
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:29:55 +0100 (CET)
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

The previous commit adds stream formation. This commit adds proc interface to
get information about stream:
 - stream formation
 - current sampling rate

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/speakers/Makefile        |  2 +-
 sound/firewire/speakers/speakers.c      |  2 ++
 sound/firewire/speakers/speakers.h      |  2 ++
 sound/firewire/speakers/speakers_proc.c | 54 +++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/speakers/speakers_proc.c

diff --git a/sound/firewire/speakers/Makefile b/sound/firewire/speakers/Makefile
index 8ee55ee..8936816 100644
--- a/sound/firewire/speakers/Makefile
+++ b/sound/firewire/speakers/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-speakers-objs := speakers_stream.o speakers_pcm.o speakers_control.o \
-			      speakers.o
+			      speakers_proc.o speakers.o
 obj-m += snd-firewire-speakers.o
diff --git a/sound/firewire/speakers/speakers.c b/sound/firewire/speakers/speakers.c
index e07ed5f..8c3bf4a 100644
--- a/sound/firewire/speakers/speakers.c
+++ b/sound/firewire/speakers/speakers.c
@@ -131,6 +131,8 @@ static int fwspk_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto err_card;
 
+	snd_fwspk_proc_init(fwspk);
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0)
diff --git a/sound/firewire/speakers/speakers.h b/sound/firewire/speakers/speakers.h
index d3029f0..977db20 100644
--- a/sound/firewire/speakers/speakers.h
+++ b/sound/firewire/speakers/speakers.h
@@ -18,6 +18,7 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/info.h>
 
 #include "../cmp.h"
 #include "../fcp.h"
@@ -69,3 +70,4 @@ int snd_fwspk_create_pcm(struct fwspk *fwspk);
 
 int snd_fwspk_create_mixer(struct fwspk *fwspk);
 
+void snd_fwspk_proc_init(struct fwspk *fwspk);
diff --git a/sound/firewire/speakers/speakers_proc.c b/sound/firewire/speakers/speakers_proc.c
new file mode 100644
index 0000000..9721e52
--- /dev/null
+++ b/sound/firewire/speakers/speakers_proc.c
@@ -0,0 +1,54 @@
+/*
+ * speakers_proc.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./speakers.h"
+
+static void
+proc_read_formation(struct snd_info_entry *entry,
+		    struct snd_info_buffer *buffer)
+{
+	struct fwspk *fwspk = entry->private_data;
+	struct fwspk_stream_formation *formation;
+	unsigned int i;
+
+	snd_iprintf(buffer, "Input Stream to device:\n");
+	snd_iprintf(buffer, "\tRate\tPCM\tMIDI\n");
+	formation = fwspk->rx_stream_formations;
+	for (i = 0; i < FWSPK_STREAM_TABLE_ENTRIES; i++) {
+		snd_iprintf(buffer,
+			"\t%d\t%d\t%d\n", fwspk_rate_table[i],
+			formation[i].pcm, formation[i].midi);
+	}
+}
+
+static void
+proc_read_clock(struct snd_info_entry *entry,
+		struct snd_info_buffer *buffer)
+{
+	struct fwspk *fwspk = entry->private_data;
+	unsigned int rate;
+	int err;
+
+	err = avc_general_get_sig_fmt(fwspk->unit, &rate,
+				      AVC_GENERAL_PLUG_DIR_IN, 0);
+	if ((err < 0) && (err == 0x09))
+		snd_iprintf(buffer, "Sampling rate: %d\n", rate);
+}
+
+void snd_fwspk_proc_init(struct fwspk *fwspk)
+{
+	struct snd_info_entry *entry;
+
+	if (!snd_card_proc_new(fwspk->card, "#formation", &entry))
+		snd_info_set_text_ops(entry, fwspk, proc_read_formation);
+
+	if (!snd_card_proc_new(fwspk->card, "#clock", &entry))
+		snd_info_set_text_ops(entry, fwspk, proc_read_clock);
+
+	return;
+}
-- 
1.8.3.2
