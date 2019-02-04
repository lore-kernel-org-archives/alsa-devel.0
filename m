From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/11] ALSA: pci: Remove superfluous
	snd_info_register() calls
Date: Mon,  4 Feb 2019 16:20:28 +0100
Message-ID: <20190204152036.14102-4-tiwai@suse.de>
References: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AEE0F2674D5
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:39 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4AE8AAEBC
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

The calls of snd_info_register() are superfluous and should be avoided
at the procfs creation time.  They are called at the end of the whole
initialization via snd_card_register().  This patch drops such
superfluous calls, as well as dropping the superfluous setup of
SNDRV_INFO_CONTENT_TEXT.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ac97/ac97_proc.c  | 26 +++++++++-----------------
 sound/pci/cs46xx/dsp_spos.c | 16 +++++-----------
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/sound/pci/ac97/ac97_proc.c b/sound/pci/ac97/ac97_proc.c
index e120a11c69e8..20516b6907b5 100644
--- a/sound/pci/ac97/ac97_proc.c
+++ b/sound/pci/ac97/ac97_proc.c
@@ -436,25 +436,20 @@ void snd_ac97_proc_init(struct snd_ac97 * ac97)
 		return;
 	prefix = ac97_is_audio(ac97) ? "ac97" : "mc97";
 	sprintf(name, "%s#%d-%d", prefix, ac97->addr, ac97->num);
-	if ((entry = snd_info_create_card_entry(ac97->bus->card, name, ac97->bus->proc)) != NULL) {
+	entry = snd_info_create_card_entry(ac97->bus->card, name,
+					   ac97->bus->proc);
+	if (entry)
 		snd_info_set_text_ops(entry, ac97, snd_ac97_proc_read);
-		if (snd_info_register(entry) < 0) {
-			snd_info_free_entry(entry);
-			entry = NULL;
-		}
-	}
 	ac97->proc = entry;
 	sprintf(name, "%s#%d-%d+regs", prefix, ac97->addr, ac97->num);
-	if ((entry = snd_info_create_card_entry(ac97->bus->card, name, ac97->bus->proc)) != NULL) {
+	entry = snd_info_create_card_entry(ac97->bus->card, name,
+					   ac97->bus->proc);
+	if (entry) {
 		snd_info_set_text_ops(entry, ac97, snd_ac97_proc_regs_read);
 #ifdef CONFIG_SND_DEBUG
 		entry->mode |= 0200;
 		entry->c.text.write = snd_ac97_proc_regs_write;
 #endif
-		if (snd_info_register(entry) < 0) {
-			snd_info_free_entry(entry);
-			entry = NULL;
-		}
 	}
 	ac97->proc_regs = entry;
 }
@@ -473,13 +468,10 @@ void snd_ac97_bus_proc_init(struct snd_ac97_bus * bus)
 	char name[32];
 
 	sprintf(name, "codec97#%d", bus->num);
-	if ((entry = snd_info_create_card_entry(bus->card, name, bus->card->proc_root)) != NULL) {
+	entry = snd_info_create_card_entry(bus->card, name,
+					   bus->card->proc_root);
+	if (entry)
 		entry->mode = S_IFDIR | 0555;
-		if (snd_info_register(entry) < 0) {
-			snd_info_free_entry(entry);
-			entry = NULL;
-		}
-	}
 	bus->proc = entry;
 }
 
diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index 5fc497c6d738..19739f2d1abf 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -799,23 +799,17 @@ int cs46xx_dsp_proc_init (struct snd_card *card, struct snd_cs46xx *chip)
 
 	ins->snd_card = card;
 
-	if ((entry = snd_info_create_card_entry(card, "dsp", card->proc_root)) != NULL) {
-		entry->content = SNDRV_INFO_CONTENT_TEXT;
+	entry = snd_info_create_card_entry(card, "dsp", card->proc_root);
+	if (entry)
 		entry->mode = S_IFDIR | 0555;
-      
-		if (snd_info_register(entry) < 0) {
-			snd_info_free_entry(entry);
-			entry = NULL;
-		}
-	}
-
 	ins->proc_dsp_dir = entry;
 
 	if (!ins->proc_dsp_dir)
 		return -ENOMEM;
 
-	if ((entry = snd_info_create_card_entry(card, "spos_symbols", ins->proc_dsp_dir)) != NULL) {
-		entry->content = SNDRV_INFO_CONTENT_TEXT;
+	entry = snd_info_create_card_entry(card, "spos_symbols",
+					   ins->proc_dsp_dir);
+	if (entry) {
 		entry->private_data = chip;
 		entry->mode = S_IFREG | 0644;
 		entry->c.text.read = cs46xx_dsp_proc_symbol_table_read;
-- 
2.16.4
