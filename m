From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Subject: [PATCH] ASoC: txx9: Added blank line after declarations
Date: Sat, 25 Feb 2017 21:17:53 +0200
Message-ID: <1488050273-7929-1-git-send-email-codrut.cristian.grosu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Codrut Grosu <codrut.cristian.grosu@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
---
 sound/soc/txx9/txx9aclc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 98fb989..7912bf0 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -392,6 +392,7 @@ static int txx9aclc_pcm_remove(struct snd_soc_platform *platform)
 	for (i = 0; i < 2; i++) {
 		struct txx9aclc_dmadata *dmadata = &dev->dmadata[i];
 		struct dma_chan *chan = dmadata->dma_chan;
+
 		if (chan) {
 			dmadata->frag_count = -1;
 			dmaengine_terminate_all(chan);
1.9.1
