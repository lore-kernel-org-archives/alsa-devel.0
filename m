From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: emux: Remove superfluous
	snd_info_register() calls
Date: Tue,  5 Feb 2019 17:05:27 +0100
Message-ID: <20190205160527.8815-4-tiwai@suse.de>
References: <20190205160527.8815-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C4CF32674C5
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
 sound/synth/emux/emux_proc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/synth/emux/emux_proc.c b/sound/synth/emux/emux_proc.c
index a82b4053bee8..c14781ac7941 100644
--- a/sound/synth/emux/emux_proc.c
+++ b/sound/synth/emux/emux_proc.c
@@ -115,10 +115,6 @@ void snd_emux_proc_init(struct snd_emux *emu, struct snd_card *card, int device)
 	entry->content = SNDRV_INFO_CONTENT_TEXT;
 	entry->private_data = emu;
 	entry->c.text.read = snd_emux_proc_info_read;
-	if (snd_info_register(entry) < 0)
-		snd_info_free_entry(entry);
-	else
-		emu->proc = entry;
 }
 
 void snd_emux_proc_free(struct snd_emux *emu)
-- 
2.16.4
