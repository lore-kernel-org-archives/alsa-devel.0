From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 09/16] ASoC: wm0010: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:29:05 +0530
Message-ID: <1403258352-8210-9-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E8EF265011
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:02:50 +0200 (CEST)
Received: by mail-pd0-f173.google.com with SMTP id r10so2819508pdi.4
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:02:49 -0700 (PDT)
In-Reply-To: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
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
Cc: broonie@kernel.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Let memory subsystem handle the error logging.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/soc/codecs/wm0010.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 71ce3159a62e..982467c1d56a 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -413,7 +413,6 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 
 		xfer = kzalloc(sizeof(*xfer), GFP_KERNEL);
 		if (!xfer) {
-			dev_err(codec->dev, "Failed to allocate xfer\n");
 			ret = -ENOMEM;
 			goto abort;
 		}
@@ -423,8 +422,6 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 
 		out = kzalloc(len, GFP_KERNEL | GFP_DMA);
 		if (!out) {
-			dev_err(codec->dev,
-				"Failed to allocate RX buffer\n");
 			ret = -ENOMEM;
 			goto abort1;
 		}
@@ -432,8 +429,6 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 
 		img = kzalloc(len, GFP_KERNEL | GFP_DMA);
 		if (!img) {
-			dev_err(codec->dev,
-				"Failed to allocate image buffer\n");
 			ret = -ENOMEM;
 			goto abort1;
 		}
@@ -526,14 +521,12 @@ static int wm0010_stage2_load(struct snd_soc_codec *codec)
 	/* Copy to local buffer first as vmalloc causes problems for dma */
 	img = kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
 	if (!img) {
-		dev_err(codec->dev, "Failed to allocate image buffer\n");
 		ret = -ENOMEM;
 		goto abort2;
 	}
 
 	out = kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
 	if (!out) {
-		dev_err(codec->dev, "Failed to allocate output buffer\n");
 		ret = -ENOMEM;
 		goto abort1;
 	}
@@ -679,11 +672,8 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 		}
 
 		img_swap = kzalloc(len, GFP_KERNEL | GFP_DMA);
-		if (!img_swap) {
-			dev_err(codec->dev,
-				"Failed to allocate image buffer\n");
+		if (!img_swap)
 			goto abort;
-		}
 
 		/* We need to re-order for 0010 */
 		byte_swap_64((u64 *)&pll_rec, img_swap, len);
-- 
1.7.9.5
