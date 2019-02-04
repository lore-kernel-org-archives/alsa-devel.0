From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/11] ALSA: isa: Clean up with new procfs
	helpers
Date: Mon,  4 Feb 2019 16:20:31 +0100
Message-ID: <20190204152036.14102-7-tiwai@suse.de>
References: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DFAC326755F
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:40 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6AF0AAF27
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 15:20:39 +0000 (UTC)
In-Reply-To: <20190204152036.14102-1-tiwai@suse.de>
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

Simplify the proc fs creation code with new helper functions,
snd_card_ro_proc_new() and snd_card_rw_proc_new().
Just a code refactoring and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/gus/gus_irq.c  | 5 +----
 sound/isa/gus/gus_mem.c  | 6 +-----
 sound/isa/opti9xx/miro.c | 5 +----
 sound/isa/sb/sb16_csp.c  | 5 ++---
 4 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/sound/isa/gus/gus_irq.c b/sound/isa/gus/gus_irq.c
index 2055aff71b50..0ca6c38e2ed9 100644
--- a/sound/isa/gus/gus_irq.c
+++ b/sound/isa/gus/gus_irq.c
@@ -140,10 +140,7 @@ static void snd_gus_irq_info_read(struct snd_info_entry *entry,
 
 void snd_gus_irq_profile_init(struct snd_gus_card *gus)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(gus->card, "gusirq", &entry))
-		snd_info_set_text_ops(entry, gus, snd_gus_irq_info_read);
+	snd_card_ro_proc_new(gus->card, "gusirq", gus, snd_gus_irq_info_read);
 }
 
 #endif
diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index af888a022fc0..4ac76f46dd76 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -238,9 +238,6 @@ int snd_gf1_mem_init(struct snd_gus_card * gus)
 {
 	struct snd_gf1_mem *alloc;
 	struct snd_gf1_mem_block block;
-#ifdef CONFIG_SND_DEBUG
-	struct snd_info_entry *entry;
-#endif
 
 	alloc = &gus->gf1.mem_alloc;
 	mutex_init(&alloc->memory_mutex);
@@ -263,8 +260,7 @@ int snd_gf1_mem_init(struct snd_gus_card * gus)
 	if (snd_gf1_mem_xalloc(alloc, &block) == NULL)
 		return -ENOMEM;
 #ifdef CONFIG_SND_DEBUG
-	if (! snd_card_proc_new(gus->card, "gusmem", &entry))
-		snd_info_set_text_ops(entry, gus, snd_gf1_mem_info_read);
+	snd_card_ro_proc_new(gus->card, "gusmem", gus, snd_gf1_mem_info_read);
 #endif
 	return 0;
 }
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index c6136c6b0214..997cdfd7b1ea 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -997,10 +997,7 @@ static void snd_miro_proc_read(struct snd_info_entry * entry,
 static void snd_miro_proc_init(struct snd_card *card,
 			       struct snd_miro *miro)
 {
-	struct snd_info_entry *entry;
-
-	if (!snd_card_proc_new(card, "miro", &entry))
-		snd_info_set_text_ops(entry, miro, snd_miro_proc_read);
+	snd_card_ro_proc_new(card, "miro", miro, snd_miro_proc_read);
 }
 
 /*
diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index bf3db0d2ea12..a09ad57b8313 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -1126,10 +1126,9 @@ static int snd_sb_csp_qsound_transfer(struct snd_sb_csp * p)
 static int init_proc_entry(struct snd_sb_csp * p, int device)
 {
 	char name[16];
-	struct snd_info_entry *entry;
+
 	sprintf(name, "cspD%d", device);
-	if (! snd_card_proc_new(p->chip->card, name, &entry))
-		snd_info_set_text_ops(entry, p, info_read);
+	snd_card_ro_proc_new(p->chip->card, name, p, info_read);
 	return 0;
 }
 
-- 
2.16.4
