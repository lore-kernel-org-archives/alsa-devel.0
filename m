From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: cs46xx: Clean up proc file creations
Date: Tue,  5 Feb 2019 17:07:58 +0100
Message-ID: <20190205160758.9172-5-tiwai@suse.de>
References: <20190205160758.9172-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 492752666B3
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:08:01 +0100 (CET)
In-Reply-To: <20190205160758.9172-1-tiwai@suse.de>
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

Again no functional changes, but only code clean up.
Use a standard macro for initializing the procfs entries, also drop
the info entries stored in dsp_spos_instance, as they are removed
recursively by a single snd_info_free_entry() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cs46xx/cs46xx_dsp_spos.h  |  6 ---
 sound/pci/cs46xx/dsp_spos.c         | 87 ++++++++++++-------------------------
 sound/pci/cs46xx/dsp_spos_scb_lib.c | 13 +++---
 3 files changed, 33 insertions(+), 73 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx_dsp_spos.h b/sound/pci/cs46xx/cs46xx_dsp_spos.h
index 8008c59288a6..a02e1e19c021 100644
--- a/sound/pci/cs46xx/cs46xx_dsp_spos.h
+++ b/sound/pci/cs46xx/cs46xx_dsp_spos.h
@@ -177,22 +177,16 @@ struct dsp_spos_instance {
 	/* proc fs */  
 	struct snd_card *snd_card;
 	struct snd_info_entry * proc_dsp_dir;
-	struct snd_info_entry * proc_sym_info_entry;
-	struct snd_info_entry * proc_modules_info_entry;
-	struct snd_info_entry * proc_parameter_dump_info_entry;
-	struct snd_info_entry * proc_sample_dump_info_entry;
 
 	/* SCB's descriptors */
 	int nscb;
 	int scb_highest_frag_index;
 	struct dsp_scb_descriptor scbs[DSP_MAX_SCB_DESC];
-	struct snd_info_entry * proc_scb_info_entry;
 	struct dsp_scb_descriptor * the_null_scb;
 
 	/* Task's descriptors */
 	int ntask;
 	struct dsp_task_descriptor tasks[DSP_MAX_TASK_DESC];
-	struct snd_info_entry * proc_task_info_entry;
 
 	/* SPDIF status */
 	int spdif_status_out;
diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index 3555f839371e..c28e58602679 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -809,52 +809,39 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 
 	entry = snd_info_create_card_entry(card, "spos_symbols",
 					   ins->proc_dsp_dir);
-	if (entry) {
-		entry->private_data = chip;
-		entry->mode = S_IFREG | 0644;
-		entry->c.text.read = cs46xx_dsp_proc_symbol_table_read;
-	}
-	ins->proc_sym_info_entry = entry;
+	if (entry)
+		snd_info_set_text_ops(entry, chip,
+				      cs46xx_dsp_proc_symbol_table_read);
     
-	if ((entry = snd_info_create_card_entry(card, "spos_modules", ins->proc_dsp_dir)) != NULL) {
-		entry->content = SNDRV_INFO_CONTENT_TEXT;
-		entry->private_data = chip;
-		entry->mode = S_IFREG | 0644;
-		entry->c.text.read = cs46xx_dsp_proc_modules_read;
-	}
-	ins->proc_modules_info_entry = entry;
+	entry = snd_info_create_card_entry(card, "spos_modules",
+					   ins->proc_dsp_dir);
+	if (entry)
+		snd_info_set_text_ops(entry, chip,
+				      cs46xx_dsp_proc_modules_read);
 
-	if ((entry = snd_info_create_card_entry(card, "parameter", ins->proc_dsp_dir)) != NULL) {
-		entry->content = SNDRV_INFO_CONTENT_TEXT;
-		entry->private_data = chip;
-		entry->mode = S_IFREG | 0644;
-		entry->c.text.read = cs46xx_dsp_proc_parameter_dump_read;
-	}
-	ins->proc_parameter_dump_info_entry = entry;
+	entry = snd_info_create_card_entry(card, "parameter",
+					   ins->proc_dsp_dir);
+	if (entry)
+		snd_info_set_text_ops(entry, chip,
+				      cs46xx_dsp_proc_parameter_dump_read);
 
-	if ((entry = snd_info_create_card_entry(card, "sample", ins->proc_dsp_dir)) != NULL) {
-		entry->content = SNDRV_INFO_CONTENT_TEXT;
-		entry->private_data = chip;
-		entry->mode = S_IFREG | 0644;
-		entry->c.text.read = cs46xx_dsp_proc_sample_dump_read;
-	}
-	ins->proc_sample_dump_info_entry = entry;
+	entry = snd_info_create_card_entry(card, "sample",
+					   ins->proc_dsp_dir);
+	if (entry)
+		snd_info_set_text_ops(entry, chip,
+				      cs46xx_dsp_proc_sample_dump_read);
 
-	if ((entry = snd_info_create_card_entry(card, "task_tree", ins->proc_dsp_dir)) != NULL) {
-		entry->content = SNDRV_INFO_CONTENT_TEXT;
-		entry->private_data = chip;
-		entry->mode = S_IFREG | 0644;
-		entry->c.text.read = cs46xx_dsp_proc_task_tree_read;
-	}
-	ins->proc_task_info_entry = entry;
+	entry = snd_info_create_card_entry(card, "task_tree",
+					   ins->proc_dsp_dir);
+	if (entry)
+		snd_info_set_text_ops(entry, chip,
+				      cs46xx_dsp_proc_task_tree_read);
 
-	if ((entry = snd_info_create_card_entry(card, "scb_info", ins->proc_dsp_dir)) != NULL) {
-		entry->content = SNDRV_INFO_CONTENT_TEXT;
-		entry->private_data = chip;
-		entry->mode = S_IFREG | 0644;
-		entry->c.text.read = cs46xx_dsp_proc_scb_read;
-	}
-	ins->proc_scb_info_entry = entry;
+	entry = snd_info_create_card_entry(card, "scb_info",
+					   ins->proc_dsp_dir);
+	if (entry)
+		snd_info_set_text_ops(entry, chip,
+				      cs46xx_dsp_proc_scb_read);
 
 	mutex_lock(&chip->spos_mutex);
 	/* register/update SCB's entries on proc */
@@ -876,24 +863,6 @@ int cs46xx_dsp_proc_done (struct snd_cs46xx *chip)
 	if (!ins)
 		return 0;
 
-	snd_info_free_entry(ins->proc_sym_info_entry);
-	ins->proc_sym_info_entry = NULL;
-
-	snd_info_free_entry(ins->proc_modules_info_entry);
-	ins->proc_modules_info_entry = NULL;
-
-	snd_info_free_entry(ins->proc_parameter_dump_info_entry);
-	ins->proc_parameter_dump_info_entry = NULL;
-
-	snd_info_free_entry(ins->proc_sample_dump_info_entry);
-	ins->proc_sample_dump_info_entry = NULL;
-
-	snd_info_free_entry(ins->proc_scb_info_entry);
-	ins->proc_scb_info_entry = NULL;
-
-	snd_info_free_entry(ins->proc_task_info_entry);
-	ins->proc_task_info_entry = NULL;
-
 	mutex_lock(&chip->spos_mutex);
 	for (i = 0; i < ins->nscb; ++i) {
 		if (ins->scbs[i].deleted) continue;
diff --git a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
index e056f9dc228b..1d9d610262de 100644
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c
@@ -254,8 +254,9 @@ void cs46xx_dsp_proc_register_scb_desc (struct snd_cs46xx *chip,
 	if (ins->snd_card != NULL && ins->proc_dsp_dir != NULL &&
 	    scb->proc_info == NULL) {
   
-		if ((entry = snd_info_create_card_entry(ins->snd_card, scb->scb_name, 
-							ins->proc_dsp_dir)) != NULL) {
+		entry = snd_info_create_card_entry(ins->snd_card, scb->scb_name,
+						   ins->proc_dsp_dir);
+		if (entry) {
 			scb_info = kmalloc(sizeof(struct proc_scb_info), GFP_KERNEL);
 			if (!scb_info) {
 				snd_info_free_entry(entry);
@@ -265,12 +266,8 @@ void cs46xx_dsp_proc_register_scb_desc (struct snd_cs46xx *chip,
 
 			scb_info->chip = chip;
 			scb_info->scb_desc = scb;
-      
-			entry->content = SNDRV_INFO_CONTENT_TEXT;
-			entry->private_data = scb_info;
-			entry->mode = S_IFREG | 0644;
-      
-			entry->c.text.read = cs46xx_dsp_proc_scb_info_read;
+			snd_info_set_text_ops(entry, scb_info,
+					      cs46xx_dsp_proc_scb_info_read);
 		}
 out:
 		scb->proc_info = entry;
-- 
2.16.4
