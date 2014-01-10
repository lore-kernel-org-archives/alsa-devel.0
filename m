From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: PCM: Warn when buffer preallocation fails
Date: Fri, 10 Jan 2014 13:06:00 +0100
Message-ID: <1389355560-14472-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D533A260320
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 13:06:00 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DF385AC3C
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 12:06:00 +0000 (UTC)
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

The failures of buffer preallocations at driver initializations aren't
critical but it's still helpful to inform, so that user can know that
something doesn't work as expected.

For example, the recent page allocator change triggered regressions,
but developers didn't notice until recently because the driver didn't
complain.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 01f8eafebda6..54debc07f5cb 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -51,6 +51,7 @@ static const size_t snd_minimum_buffer = 16384;
 static int preallocate_pcm_pages(struct snd_pcm_substream *substream, size_t size)
 {
 	struct snd_dma_buffer *dmab = &substream->dma_buffer;
+	size_t orig_size = size;
 	int err;
 
 	do {
@@ -63,6 +64,10 @@ static int preallocate_pcm_pages(struct snd_pcm_substream *substream, size_t siz
 		size >>= 1;
 	} while (size >= snd_minimum_buffer);
 	dmab->bytes = 0; /* tell error */
+	pr_warn("ALSA pcmC%dD%d%c,%d:%s: cannot preallocate for size %zu\n",
+		substream->pcm->card->number, substream->pcm->device,
+		substream->stream ? 'c' : 'p', substream->number,
+		substream->pcm->name, orig_size);
 	return 0;
 }
 
-- 
1.8.5.2
