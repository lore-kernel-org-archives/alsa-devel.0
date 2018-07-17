From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: emu10k1_patch: Use swap macro in snd_emu10k1_sample_new
Date: Tue, 17 Jul 2018 10:00:43 -0500
Message-ID: <20180717150043.GA8729@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Make use of the swap macro and remove unnecessary variable *tmp*. This
makes the code easier to read and maintain.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/pci/emu10k1/emu10k1_patch.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_patch.c b/sound/pci/emu10k1/emu10k1_patch.c
index 0e069ae..c32eb70 100644
--- a/sound/pci/emu10k1/emu10k1_patch.c
+++ b/sound/pci/emu10k1/emu10k1_patch.c
@@ -70,11 +70,8 @@ snd_emu10k1_sample_new(struct snd_emux *rec, struct snd_sf_sample *sp,
 		loopend = sampleend;
 
 	/* be sure loop points start < end */
-	if (sp->v.loopstart >= sp->v.loopend) {
-		int tmp = sp->v.loopstart;
-		sp->v.loopstart = sp->v.loopend;
-		sp->v.loopend = tmp;
-	}
+	if (sp->v.loopstart >= sp->v.loopend)
+		swap(sp->v.loopstart, sp->v.loopend);
 
 	/* compute true data size to be loaded */
 	truesize = sp->v.size + BLANK_HEAD_SIZE;
-- 
2.7.4
