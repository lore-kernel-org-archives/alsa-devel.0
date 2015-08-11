From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Silence DMA slave ID compile
	warning on 64-bit" to the asoc tree
Date: Tue, 11 Aug 2015 17:27:53 +0100
Message-ID: <E1ZPCP3-00059W-8o@finisterre>
References: <1439297238-28943-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21FF2260542
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 18:28:05 +0200 (CEST)
In-Reply-To: <1439297238-28943-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Silence DMA slave ID compile warning on 64-bit

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

>From 1af2cc64b18c29f1d774caa7e592c781bee6a7eb Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 11 Aug 2015 14:47:18 +0200
Subject: [PATCH] ASoC: rsnd: Silence DMA slave ID compile warning on 64-bit

On arm64:

    sound/soc/sh/rcar/dma.c: In function 'rsnd_dmaen_init':
    sound/soc/sh/rcar/dma.c:180:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
	     (void *)id);
	     ^
    include/linux/dmaengine.h:1185:75: note: in definition of macro 'dma_request_channel'
     #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
									       ^

Add an intermediate cast to "uintptr_t" to kill the compile warning.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 305b129..bfbb8a5 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -177,7 +177,7 @@ static int rsnd_dmaen_init(struct rsnd_dai_stream *io,
 		dma_cap_set(DMA_SLAVE, mask);
 
 		dmaen->chan = dma_request_channel(mask, shdma_chan_filter,
-						  (void *)id);
+						  (void *)(uintptr_t)id);
 	}
 	if (IS_ERR_OR_NULL(dmaen->chan)) {
 		dmaen->chan = NULL;
-- 
2.5.0
