From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: emu10k1: Rate-limit error messages about
	page errors
Date: Thu, 17 May 2018 20:05:48 +0200
Message-ID: <20180517180548.6335-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 912FD266F44
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 20:05:51 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1D1B5AC62
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:05:50 +0000 (UTC)
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

The error messages at sanity checks of memory pages tend to repeat too
many times once when it hits, and without the rate limit, it may flood
and become unreadable.  Replace such messages with the *_ratelimited()
variant.

Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1093027
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/emu10k1/memory.c b/sound/pci/emu10k1/memory.c
index 5865f3b90b34..dbc7d8d0e1c4 100644
--- a/sound/pci/emu10k1/memory.c
+++ b/sound/pci/emu10k1/memory.c
@@ -248,13 +248,13 @@ search_empty(struct snd_emu10k1 *emu, int size)
 static int is_valid_page(struct snd_emu10k1 *emu, dma_addr_t addr)
 {
 	if (addr & ~emu->dma_mask) {
-		dev_err(emu->card->dev,
+		dev_err_ratelimited(emu->card->dev,
 			"max memory size is 0x%lx (addr = 0x%lx)!!\n",
 			emu->dma_mask, (unsigned long)addr);
 		return 0;
 	}
 	if (addr & (EMUPAGESIZE-1)) {
-		dev_err(emu->card->dev, "page is not aligned\n");
+		dev_err_ratelimited(emu->card->dev, "page is not aligned\n");
 		return 0;
 	}
 	return 1;
@@ -345,7 +345,7 @@ snd_emu10k1_alloc_pages(struct snd_emu10k1 *emu, struct snd_pcm_substream *subst
 		else
 			addr = snd_pcm_sgbuf_get_addr(substream, ofs);
 		if (! is_valid_page(emu, addr)) {
-			dev_err(emu->card->dev,
+			dev_err_ratelimited(emu->card->dev,
 				"emu: failure page = %d\n", idx);
 			mutex_unlock(&hdr->block_mutex);
 			return NULL;
-- 
2.16.3
