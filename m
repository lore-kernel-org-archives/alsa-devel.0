From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm0010: fix memory leak" to the asoc
	tree
Date: Wed, 02 Sep 2015 13:12:09 +0100
Message-ID: <E1ZX6td-0003XN-JF@debutante>
References: <1441086245-14732-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 906AB260537
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2015 14:12:24 +0200 (CEST)
In-Reply-To: <1441086245-14732-1-git-send-email-sudipm.mukherjee@gmail.com>
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

   ASoC: wm0010: fix memory leak

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

>From 51d2eeef1d958ef6834b24f548194f5acea0f499 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 1 Sep 2015 11:14:05 +0530
Subject: [PATCH] ASoC: wm0010: fix memory leak

We were aborting if the kzalloc of img_swap fails but without freeing the
already allocated out. Similarly we were aborting if spi_sync fails
without releasing out and img_swap.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm0010.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 6560a66b3f35..9d370a45abe8 100644
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
2.5.0
