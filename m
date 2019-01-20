From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/9] ALSA: fireface: obsolete proc node to
	leave one node
Date: Sun, 20 Jan 2019 17:25:47 +0900
Message-ID: <20190120082553.17347-4-o-takashi@sakamocchi.jp>
References: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B7247266A89
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 09:26:14 +0100 (CET)
Received: by mail-pl1-f193.google.com with SMTP id u18so8307925plq.7
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 00:26:14 -0800 (PST)
In-Reply-To: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
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

In a series of Fireface, latter protocol has no way for drivers to
retrieve current clock configuration. On the other hand, this driver
has proc node for it.

This commit removes a proc node to dump both clock configuration
and synchronization status in one proc node.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-proc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/fireface/ff-proc.c b/sound/firewire/fireface/ff-proc.c
index a0c550dabe9a..37f84b7fc432 100644
--- a/sound/firewire/fireface/ff-proc.c
+++ b/sound/firewire/fireface/ff-proc.c
@@ -8,10 +8,8 @@
 
 #include "./ff.h"
 
-static void proc_dump_clock_config(struct snd_info_entry *entry,
-				   struct snd_info_buffer *buffer)
+static void dump_clock_config(struct snd_ff *ff, struct snd_info_buffer *buffer)
 {
-	struct snd_ff *ff = entry->private_data;
 	__le32 reg;
 	u32 data;
 	unsigned int rate;
@@ -87,10 +85,8 @@ static void proc_dump_clock_config(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "Sync to clock source: %s\n", src);
 }
 
-static void proc_dump_sync_status(struct snd_info_entry *entry,
-				  struct snd_info_buffer *buffer)
+static void dump_sync_status(struct snd_ff *ff, struct snd_info_buffer *buffer)
 {
-	struct snd_ff *ff = entry->private_data;
 	__le32 reg;
 	u32 data;
 	int err;
@@ -213,6 +209,15 @@ static void proc_dump_sync_status(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "%d\n", (data & 0x3ff) * 250);
 }
 
+static void proc_dump_status(struct snd_info_entry *entry,
+			     struct snd_info_buffer *buffer)
+{
+	struct snd_ff *ff = entry->private_data;
+
+	dump_clock_config(ff, buffer);
+	dump_sync_status(ff, buffer);
+}
+
 static void add_node(struct snd_ff *ff, struct snd_info_entry *root,
 		     const char *name,
 		     void (*op)(struct snd_info_entry *e,
@@ -247,6 +252,5 @@ void snd_ff_proc_init(struct snd_ff *ff)
 		return;
 	}
 
-	add_node(ff, root, "clock-config", proc_dump_clock_config);
-	add_node(ff, root, "sync-status", proc_dump_sync_status);
+	add_node(ff, root, "status", proc_dump_status);
 }
-- 
2.19.1
