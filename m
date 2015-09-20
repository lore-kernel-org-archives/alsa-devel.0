From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm0010: fix error path" to the asoc tree
Date: Sat, 19 Sep 2015 17:13:03 -0700
Message-ID: <E1ZdSFb-0003zq-4V@finisterre>
References: <1442572341-28201-3-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F20D260631
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:13:30 +0200 (CEST)
In-Reply-To: <1442572341-28201-3-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip@vectorindia.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm0010: fix error path

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f072f91aa7517386344476813ca0799e08fd0c35 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 18 Sep 2015 16:02:21 +0530
Subject: [PATCH] ASoC: wm0010: fix error path

Fix the error path so that we can free the allocated memory on the error
path instead of releasing them individually on each error.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm0010.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 7a1bc40..76b2f88 100644
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
2.5.0
