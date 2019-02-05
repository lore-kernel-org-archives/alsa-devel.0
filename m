From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: firewire: Remove superfluous
	snd_info_register() calls
Date: Tue,  5 Feb 2019 17:05:25 +0100
Message-ID: <20190205160527.8815-2-tiwai@suse.de>
References: <20190205160527.8815-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C21832674B6
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:05:32 +0100 (CET)
In-Reply-To: <20190205160527.8815-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The calls of snd_info_register() are superfluous and should be avoided
at the procfs creation time.  They are called at the end of the whole
initialization via snd_card_register().  This patch drops such
superfluous calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/firewire/bebob/bebob_proc.c         | 12 ++----------
 sound/firewire/dice/dice-proc.c           | 12 ++----------
 sound/firewire/digi00x/digi00x-proc.c     | 16 ++--------------
 sound/firewire/fireface/ff-proc.c         | 12 ++----------
 sound/firewire/fireworks/fireworks_proc.c | 12 ++----------
 sound/firewire/motu/motu-proc.c           | 12 ++----------
 sound/firewire/oxfw/oxfw-proc.c           | 12 ++----------
 sound/firewire/tascam/tascam-proc.c       | 12 ++----------
 8 files changed, 16 insertions(+), 84 deletions(-)

diff --git a/sound/firewire/bebob/bebob_proc.c b/sound/firewire/bebob/bebob_proc.c
index 8096891af913..05e2a1c6326c 100644
--- a/sound/firewire/bebob/bebob_proc.c
+++ b/sound/firewire/bebob/bebob_proc.c
@@ -163,12 +163,8 @@ add_node(struct snd_bebob *bebob, struct snd_info_entry *root, const char *name,
 	struct snd_info_entry *entry;
 
 	entry = snd_info_create_card_entry(bebob->card, name, root);
-	if (entry == NULL)
-		return;
-
-	snd_info_set_text_ops(entry, bebob, op);
-	if (snd_info_register(entry) < 0)
-		snd_info_free_entry(entry);
+	if (entry)
+		snd_info_set_text_ops(entry, bebob, op);
 }
 
 void snd_bebob_proc_init(struct snd_bebob *bebob)
@@ -184,10 +180,6 @@ void snd_bebob_proc_init(struct snd_bebob *bebob)
 	if (root == NULL)
 		return;
 	root->mode = S_IFDIR | 0555;
-	if (snd_info_register(root) < 0) {
-		snd_info_free_entry(root);
-		return;
-	}
 
 	add_node(bebob, root, "clock", proc_read_clock);
 	add_node(bebob, root, "firmware", proc_read_hw_info);
diff --git a/sound/firewire/dice/dice-proc.c b/sound/firewire/dice/dice-proc.c
index bb870fc73f99..9b1d509c6320 100644
--- a/sound/firewire/dice/dice-proc.c
+++ b/sound/firewire/dice/dice-proc.c
@@ -285,12 +285,8 @@ static void add_node(struct snd_dice *dice, struct snd_info_entry *root,
 	struct snd_info_entry *entry;
 
 	entry = snd_info_create_card_entry(dice->card, name, root);
-	if (!entry)
-		return;
-
-	snd_info_set_text_ops(entry, dice, op);
-	if (snd_info_register(entry) < 0)
-		snd_info_free_entry(entry);
+	if (entry)
+		snd_info_set_text_ops(entry, dice, op);
 }
 
 void snd_dice_create_proc(struct snd_dice *dice)
@@ -306,10 +302,6 @@ void snd_dice_create_proc(struct snd_dice *dice)
 	if (!root)
 		return;
 	root->mode = S_IFDIR | 0555;
-	if (snd_info_register(root) < 0) {
-		snd_info_free_entry(root);
-		return;
-	}
 
 	add_node(dice, root, "dice", dice_proc_read);
 	add_node(dice, root, "formation", dice_proc_read_formation);
diff --git a/sound/firewire/digi00x/digi00x-proc.c b/sound/firewire/digi00x/digi00x-proc.c
index 6996d5a6ff5f..d22e8675b10f 100644
--- a/sound/firewire/digi00x/digi00x-proc.c
+++ b/sound/firewire/digi00x/digi00x-proc.c
@@ -80,20 +80,8 @@ void snd_dg00x_proc_init(struct snd_dg00x *dg00x)
 		return;
 
 	root->mode = S_IFDIR | 0555;
-	if (snd_info_register(root) < 0) {
-		snd_info_free_entry(root);
-		return;
-	}
 
 	entry = snd_info_create_card_entry(dg00x->card, "clock", root);
-	if (entry == NULL) {
-		snd_info_free_entry(root);
-		return;
-	}
-
-	snd_info_set_text_ops(entry, dg00x, proc_read_clock);
-	if (snd_info_register(entry) < 0) {
-		snd_info_free_entry(entry);
-		snd_info_free_entry(root);
-	}
+	if (entry)
+		snd_info_set_text_ops(entry, dg00x, proc_read_clock);
 }
diff --git a/sound/firewire/fireface/ff-proc.c b/sound/firewire/fireface/ff-proc.c
index a55e68ec1832..b886b541c94b 100644
--- a/sound/firewire/fireface/ff-proc.c
+++ b/sound/firewire/fireface/ff-proc.c
@@ -41,12 +41,8 @@ static void add_node(struct snd_ff *ff, struct snd_info_entry *root,
 	struct snd_info_entry *entry;
 
 	entry = snd_info_create_card_entry(ff->card, name, root);
-	if (entry == NULL)
-		return;
-
-	snd_info_set_text_ops(entry, ff, op);
-	if (snd_info_register(entry) < 0)
-		snd_info_free_entry(entry);
+	if (entry)
+		snd_info_set_text_ops(entry, ff, op);
 }
 
 void snd_ff_proc_init(struct snd_ff *ff)
@@ -62,10 +58,6 @@ void snd_ff_proc_init(struct snd_ff *ff)
 	if (root == NULL)
 		return;
 	root->mode = S_IFDIR | 0555;
-	if (snd_info_register(root) < 0) {
-		snd_info_free_entry(root);
-		return;
-	}
 
 	add_node(ff, root, "status", proc_dump_status);
 }
diff --git a/sound/firewire/fireworks/fireworks_proc.c b/sound/firewire/fireworks/fireworks_proc.c
index 779ecec5af62..9fa5c34a9572 100644
--- a/sound/firewire/fireworks/fireworks_proc.c
+++ b/sound/firewire/fireworks/fireworks_proc.c
@@ -199,12 +199,8 @@ add_node(struct snd_efw *efw, struct snd_info_entry *root, const char *name,
 	struct snd_info_entry *entry;
 
 	entry = snd_info_create_card_entry(efw->card, name, root);
-	if (entry == NULL)
-		return;
-
-	snd_info_set_text_ops(entry, efw, op);
-	if (snd_info_register(entry) < 0)
-		snd_info_free_entry(entry);
+	if (entry)
+		snd_info_set_text_ops(entry, efw, op);
 }
 
 void snd_efw_proc_init(struct snd_efw *efw)
@@ -220,10 +216,6 @@ void snd_efw_proc_init(struct snd_efw *efw)
 	if (root == NULL)
 		return;
 	root->mode = S_IFDIR | 0555;
-	if (snd_info_register(root) < 0) {
-		snd_info_free_entry(root);
-		return;
-	}
 
 	add_node(efw, root, "clock", proc_read_clock);
 	add_node(efw, root, "firmware", proc_read_hwinfo);
diff --git a/sound/firewire/motu/motu-proc.c b/sound/firewire/motu/motu-proc.c
index ab6830a6d242..94327853620a 100644
--- a/sound/firewire/motu/motu-proc.c
+++ b/sound/firewire/motu/motu-proc.c
@@ -87,12 +87,8 @@ static void add_node(struct snd_motu *motu, struct snd_info_entry *root,
 	struct snd_info_entry *entry;
 
 	entry = snd_info_create_card_entry(motu->card, name, root);
-	if (entry == NULL)
-		return;
-
-	snd_info_set_text_ops(entry, motu, op);
-	if (snd_info_register(entry) < 0)
-		snd_info_free_entry(entry);
+	if (entry)
+		snd_info_set_text_ops(entry, motu, op);
 }
 
 void snd_motu_proc_init(struct snd_motu *motu)
@@ -108,10 +104,6 @@ void snd_motu_proc_init(struct snd_motu *motu)
 	if (root == NULL)
 		return;
 	root->mode = S_IFDIR | 0555;
-	if (snd_info_register(root) < 0) {
-		snd_info_free_entry(root);
-		return;
-	}
 
 	add_node(motu, root, "clock", proc_read_clock);
 	add_node(motu, root, "format", proc_read_format);
diff --git a/sound/firewire/oxfw/oxfw-proc.c b/sound/firewire/oxfw/oxfw-proc.c
index 27dac071bc73..644107e3782e 100644
--- a/sound/firewire/oxfw/oxfw-proc.c
+++ b/sound/firewire/oxfw/oxfw-proc.c
@@ -83,12 +83,8 @@ static void add_node(struct snd_oxfw *oxfw, struct snd_info_entry *root,
 	struct snd_info_entry *entry;
 
 	entry = snd_info_create_card_entry(oxfw->card, name, root);
-	if (entry == NULL)
-		return;
-
-	snd_info_set_text_ops(entry, oxfw, op);
-	if (snd_info_register(entry) < 0)
-		snd_info_free_entry(entry);
+	if (entry)
+		snd_info_set_text_ops(entry, oxfw, op);
 }
 
 void snd_oxfw_proc_init(struct snd_oxfw *oxfw)
@@ -104,10 +100,6 @@ void snd_oxfw_proc_init(struct snd_oxfw *oxfw)
 	if (root == NULL)
 		return;
 	root->mode = S_IFDIR | 0555;
-	if (snd_info_register(root) < 0) {
-		snd_info_free_entry(root);
-		return;
-	}
 
 	add_node(oxfw, root, "formation", proc_read_formation);
 }
diff --git a/sound/firewire/tascam/tascam-proc.c b/sound/firewire/tascam/tascam-proc.c
index fee3bf32a0da..8bc8d277394a 100644
--- a/sound/firewire/tascam/tascam-proc.c
+++ b/sound/firewire/tascam/tascam-proc.c
@@ -58,12 +58,8 @@ static void add_node(struct snd_tscm *tscm, struct snd_info_entry *root,
 	struct snd_info_entry *entry;
 
 	entry = snd_info_create_card_entry(tscm->card, name, root);
-	if (entry == NULL)
-		return;
-
-	snd_info_set_text_ops(entry, tscm, op);
-	if (snd_info_register(entry) < 0)
-		snd_info_free_entry(entry);
+	if (entry)
+		snd_info_set_text_ops(entry, tscm, op);
 }
 
 void snd_tscm_proc_init(struct snd_tscm *tscm)
@@ -79,10 +75,6 @@ void snd_tscm_proc_init(struct snd_tscm *tscm)
 	if (root == NULL)
 		return;
 	root->mode = S_IFDIR | 0555;
-	if (snd_info_register(root) < 0) {
-		snd_info_free_entry(root);
-		return;
-	}
 
 	add_node(tscm, root, "firmware", proc_read_firmware);
 }
-- 
2.16.4
