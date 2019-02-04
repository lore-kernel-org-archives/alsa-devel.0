From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/11] ALSA: pcmcia: Clean up with new procfs
	helpers
Date: Mon,  4 Feb 2019 16:20:34 +0100
Message-ID: <20190204152036.14102-10-tiwai@suse.de>
References: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 12590267567
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:40 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9A65FAF4D
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
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf_core.c b/sound/pcmcia/pdaudiocf/pdaudiocf_core.c
index eabf29252895..910478275fd9 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf_core.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf_core.c
@@ -148,10 +148,7 @@ static void pdacf_proc_read(struct snd_info_entry * entry,
 
 static void pdacf_proc_init(struct snd_pdacf *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(chip->card, "pdaudiocf", &entry))
-		snd_info_set_text_ops(entry, chip, pdacf_proc_read);
+	snd_card_ro_proc_new(chip->card, "pdaudiocf", chip, pdacf_proc_read);
 }
 
 struct snd_pdacf *snd_pdacf_create(struct snd_card *card)
-- 
2.16.4
