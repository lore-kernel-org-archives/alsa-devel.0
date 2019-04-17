From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: ps3: Remove set but not used variables 'start_vaddr' and 'pcm_index'
Date: Wed, 17 Apr 2019 22:57:22 +0800
Message-ID: <20190417145722.20448-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: geoff@infradead.org, perex@perex.cz, tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warnings:

sound/ppc/snd_ps3.c: In function 'snd_ps3_program_dma':
sound/ppc/snd_ps3.c:236:8: warning: variable 'start_vaddr' set but not used [-Wunused-but-set-variable]
sound/ppc/snd_ps3.c: In function 'snd_ps3_pcm_open':
sound/ppc/snd_ps3.c:529:6: warning: variable 'pcm_index' set but not used [-Wunused-but-set-variable]

They are never used and can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/ppc/snd_ps3.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 521236e..f77a0d5 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -233,7 +233,6 @@ static int snd_ps3_program_dma(struct snd_ps3_card_info *card,
 	int fill_stages, dma_ch, stage;
 	enum snd_ps3_ch ch;
 	uint32_t ch0_kick_event = 0; /* initialize to mute gcc */
-	void *start_vaddr;
 	unsigned long irqsave;
 	int silent = 0;
 
@@ -257,7 +256,6 @@ static int snd_ps3_program_dma(struct snd_ps3_card_info *card,
 	fill_stages = 4;
 	spin_lock_irqsave(&card->dma_lock, irqsave);
 	for (ch = 0; ch < 2; ch++) {
-		start_vaddr = card->dma_next_transfer_vaddr[0];
 		for (stage = 0; stage < fill_stages; stage++) {
 			dma_ch = stage * 2 + ch;
 			if (silent)
@@ -526,9 +524,7 @@ static int snd_ps3_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_ps3_card_info *card = snd_pcm_substream_chip(substream);
-	int pcm_index;
 
-	pcm_index = substream->pcm->device;
 	/* to retrieve substream/runtime in interrupt handler */
 	card->substream = substream;
 
-- 
2.7.4
