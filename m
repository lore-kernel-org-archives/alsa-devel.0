From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3 02/13] ALSA: dice: add 'firewire' directory
	for proc nodes
Date: Wed,  2 May 2018 19:16:40 +0900
Message-ID: <20180502101651.26173-3-o-takashi@sakamocchi.jp>
References: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F2C1266F44
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 12:17:25 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id k11-v6so9181750pgo.10
 for <alsa-devel@alsa-project.org>; Wed, 02 May 2018 03:17:25 -0700 (PDT)
In-Reply-To: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
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

Unlike the other drivers in ALSA firewire stack, ALSA dice driver does't
create 'firewire' directory for proc nodes because it has 'dice' node
only. But this is inconvenient because I have a plan to add another proc
node to output available stream formats from cache.

This commit let the driver to create the directory and put 'dice' node
into it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-proc.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/dice/dice-proc.c b/sound/firewire/dice/dice-proc.c
index cc079323ed30..43b130b7aa07 100644
--- a/sound/firewire/dice/dice-proc.c
+++ b/sound/firewire/dice/dice-proc.c
@@ -243,10 +243,39 @@ static void dice_proc_read(struct snd_info_entry *entry,
 	}
 }
 
-void snd_dice_create_proc(struct snd_dice *dice)
+static void add_node(struct snd_dice *dice, struct snd_info_entry *root,
+		     const char *name,
+		     void (*op)(struct snd_info_entry *entry,
+				struct snd_info_buffer *buffer))
 {
 	struct snd_info_entry *entry;
 
-	if (!snd_card_proc_new(dice->card, "dice", &entry))
-		snd_info_set_text_ops(entry, dice, dice_proc_read);
+	entry = snd_info_create_card_entry(dice->card, name, root);
+	if (!entry)
+		return;
+
+	snd_info_set_text_ops(entry, dice, op);
+	if (snd_info_register(entry) < 0)
+		snd_info_free_entry(entry);
+}
+
+void snd_dice_create_proc(struct snd_dice *dice)
+{
+	struct snd_info_entry *root;
+
+	/*
+	 * All nodes are automatically removed at snd_card_disconnect(),
+	 * by following to link list.
+	 */
+	root = snd_info_create_card_entry(dice->card, "firewire",
+					  dice->card->proc_root);
+	if (!root)
+		return;
+	root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	if (snd_info_register(root) < 0) {
+		snd_info_free_entry(root);
+		return;
+	}
+
+	add_node(dice, root, "dice", dice_proc_read);
 }
-- 
2.14.1
