From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 03/13] ALSA: dice: add proc node for stream
	formation
Date: Sun, 29 Apr 2018 15:50:22 +0900
Message-ID: <20180429065032.13869-4-o-takashi@sakamocchi.jp>
References: <20180429065032.13869-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DF2C266EB0
 for <alsa-devel@alsa-project.org>; Sun, 29 Apr 2018 08:51:08 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id j5so4452754pfh.2
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 23:51:08 -0700 (PDT)
In-Reply-To: <20180429065032.13869-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Products with DICE interface in market can support variable stream
formats for three levels of sampling transmission frequencies. To
record these formats, a proxy structure got several fields in former
commit.

This commit adds a proc node to output the stream formats for debugging
purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-proc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/firewire/dice/dice-proc.c b/sound/firewire/dice/dice-proc.c
index 43b130b7aa07..f967e0ec7598 100644
--- a/sound/firewire/dice/dice-proc.c
+++ b/sound/firewire/dice/dice-proc.c
@@ -243,6 +243,40 @@ static void dice_proc_read(struct snd_info_entry *entry,
 	}
 }
 
+static void dice_proc_read_formation(struct snd_info_entry *entry,
+				     struct snd_info_buffer *buffer)
+{
+	static const char *const rate_labels[] = {
+		[0] = "low",
+		[1] = "middle",
+		[2] = "high",
+	};
+	struct snd_dice *dice = entry->private_data;
+	int i, j;
+
+	snd_iprintf(buffer, "Output stream from unit:\n");
+	for (i = 0; i < 3; ++i)
+		snd_iprintf(buffer, "\t%s", rate_labels[i]);
+	snd_iprintf(buffer, "\tMIDI\n");
+	for (i = 0; i < MAX_STREAMS; ++i) {
+		snd_iprintf(buffer, "Tx %u:", i);
+		for (j = 0; j < 3; ++j)
+			snd_iprintf(buffer, "\t%u", dice->tx_pcm_chs[i][j]);
+		snd_iprintf(buffer, "\t%u\n", dice->tx_midi_ports[i]);
+	}
+
+	snd_iprintf(buffer, "Input stream to unit:\n");
+	for (i = 0; i < 3; ++i)
+		snd_iprintf(buffer, "\t%s", rate_labels[i]);
+	snd_iprintf(buffer, "\n");
+	for (i = 0; i < MAX_STREAMS; ++i) {
+		snd_iprintf(buffer, "Rx %u:", i);
+		for (j = 0; j < 3; ++j)
+			snd_iprintf(buffer, "\t%u", dice->rx_pcm_chs[i][j]);
+		snd_iprintf(buffer, "\t%u\n", dice->rx_midi_ports[i]);
+	}
+}
+
 static void add_node(struct snd_dice *dice, struct snd_info_entry *root,
 		     const char *name,
 		     void (*op)(struct snd_info_entry *entry,
@@ -278,4 +312,5 @@ void snd_dice_create_proc(struct snd_dice *dice)
 	}
 
 	add_node(dice, root, "dice", dice_proc_read);
+	add_node(dice, root, "formation", dice_proc_read_formation);
 }
-- 
2.14.1
