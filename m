From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Subject: [PATCH] ASoC: txx9: Added requiered spaces.
Date: Sat, 25 Feb 2017 12:12:21 +0200
Message-ID: <1488017541-14080-1-git-send-email-codrut.cristian.grosu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, perex@perex.cz
Cc: lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Codrut Grosu <codrut.cristian.grosu@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was reported by checpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
---
 sound/soc/txx9/txx9aclc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index a8f705b..98fb989 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -206,7 +206,7 @@ static void txx9aclc_dma_tasklet(unsigned long data)
 static int txx9aclc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct txx9aclc_dmadata *dmadata = substream->runtime->private_data;
-	struct txx9aclc_plat_drvdata *drvdata =txx9aclc_drvdata;
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_drvdata;
 	void __iomem *base = drvdata->base;
 	unsigned long flags;
 	int ret = 0;
@@ -340,7 +340,7 @@ static bool filter(struct dma_chan *chan, void *param)
 static int txx9aclc_dma_init(struct txx9aclc_soc_device *dev,
 			     struct txx9aclc_dmadata *dmadata)
 {
-	struct txx9aclc_plat_drvdata *drvdata =txx9aclc_drvdata;
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_drvdata;
 	struct txx9dmac_slave *ds = &dmadata->dma_slave;
 	dma_cap_mask_t mask;
 
-- 
1.9.1
