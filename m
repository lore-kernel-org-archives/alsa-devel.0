From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/3] ASoC: wm0010: fix error path
Date: Fri, 18 Sep 2015 16:02:21 +0530
Message-ID: <1442572341-28201-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1442572341-28201-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442572341-28201-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix the error path so that we can free the allocated memory on the error
path instead of releasing them individually on each error.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/codecs/wm0010.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 4947be5..3ced902 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -663,10 +663,8 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 		}
 
 		img_swap = kzalloc(len, GFP_KERNEL | GFP_DMA);
-		if (!img_swap) {
-			kfree(out);
-			goto abort;
-		}
+		if (!img_swap)
+			goto abort_out;
 
 		/* We need to re-order for 0010 */
 		byte_swap_64((u64 *)&pll_rec, img_swap, len);
@@ -681,20 +679,16 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 		spi_message_add_tail(&t, &m);
 
 		ret = spi_sync(spi, &m);
-		if (ret != 0) {
+		if (ret) {
 			dev_err(codec->dev, "First PLL write failed: %d\n", ret);
-			kfree(img_swap);
-			kfree(out);
-			goto abort;
+			goto abort_swap;
 		}
 
 		/* Use a second send of the message to get the return status */
 		ret = spi_sync(spi, &m);
-		if (ret != 0) {
+		if (ret) {
 			dev_err(codec->dev, "Second PLL write failed: %d\n", ret);
-			kfree(img_swap);
-			kfree(out);
-			goto abort;
+			goto abort_swap;
 		}
 
 		p = (u32 *)out;
@@ -727,6 +721,10 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 
 	return 0;
 
+abort_swap:
+	kfree(img_swap);
+abort_out:
+	kfree(out);
 abort:
 	/* Put the chip back into reset */
 	wm0010_halt(codec);
-- 
1.9.1
