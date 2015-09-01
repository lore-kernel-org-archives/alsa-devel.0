From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: wm0010: fix memory leak
Date: Tue,  1 Sep 2015 11:14:05 +0530
Message-ID: <1441086245-14732-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

We were aborting if the kzalloc of img_swap fails but without freeing the
already allocated out. Similarly we were aborting if spi_sync fails
without releasing out and img_swap.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/codecs/wm0010.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index f2c6ad4..8434d45 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -672,8 +672,10 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 		}
 
 		img_swap = kzalloc(len, GFP_KERNEL | GFP_DMA);
-		if (!img_swap)
+		if (!img_swap) {
+			kfree(out);
 			goto abort;
+		}
 
 		/* We need to re-order for 0010 */
 		byte_swap_64((u64 *)&pll_rec, img_swap, len);
@@ -690,6 +692,8 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 		ret = spi_sync(spi, &m);
 		if (ret != 0) {
 			dev_err(codec->dev, "First PLL write failed: %d\n", ret);
+			kfree(img_swap);
+			kfree(out);
 			goto abort;
 		}
 
@@ -697,6 +701,8 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 		ret = spi_sync(spi, &m);
 		if (ret != 0) {
 			dev_err(codec->dev, "Second PLL write failed: %d\n", ret);
+			kfree(img_swap);
+			kfree(out);
 			goto abort;
 		}
 
-- 
1.9.1
