From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/11] ALSA: sparc: Clean up with new procfs
	helpers
Date: Mon,  4 Feb 2019 16:20:35 +0100
Message-ID: <20190204152036.14102-11-tiwai@suse.de>
References: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DFF83267563
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:40 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A6E82AF50
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 15:20:40 +0000 (UTC)
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
 sound/sparc/dbri.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 7609eceba1a2..682166202098 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2510,16 +2510,10 @@ static void dbri_debug_read(struct snd_info_entry *entry,
 static void snd_dbri_proc(struct snd_card *card)
 {
 	struct snd_dbri *dbri = card->private_data;
-	struct snd_info_entry *entry;
-
-	if (!snd_card_proc_new(card, "regs", &entry))
-		snd_info_set_text_ops(entry, dbri, dbri_regs_read);
 
+	snd_card_ro_proc_new(card, "regs", dbri, dbri_regs_read);
 #ifdef DBRI_DEBUG
-	if (!snd_card_proc_new(card, "debug", &entry)) {
-		snd_info_set_text_ops(entry, dbri, dbri_debug_read);
-		entry->mode = S_IFREG | 0444;	/* Readable only. */
-	}
+	snd_card_ro_proc_new(card, "debug", dbri, dbri_debug_read);
 #endif
 }
 
-- 
2.16.4
