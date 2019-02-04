From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/11] ALSA: compress: Remove superfluous
	snd_info_register() calls
Date: Mon,  4 Feb 2019 16:20:27 +0100
Message-ID: <20190204152036.14102-3-tiwai@suse.de>
References: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B575B267557
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:39 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 427C7AD3F
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
superfluous calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/compress_offload.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index f7d2b373da0a..a1a6fd75cfe5 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1015,22 +1015,13 @@ static int snd_compress_proc_init(struct snd_compr *compr)
 	if (!entry)
 		return -ENOMEM;
 	entry->mode = S_IFDIR | 0555;
-	if (snd_info_register(entry) < 0) {
-		snd_info_free_entry(entry);
-		return -ENOMEM;
-	}
 	compr->proc_root = entry;
 
 	entry = snd_info_create_card_entry(compr->card, "info",
 					   compr->proc_root);
-	if (entry) {
+	if (entry)
 		snd_info_set_text_ops(entry, compr,
 				      snd_compress_proc_info_read);
-		if (snd_info_register(entry) < 0) {
-			snd_info_free_entry(entry);
-			entry = NULL;
-		}
-	}
 	compr->proc_info_entry = entry;
 
 	return 0;
-- 
2.16.4
