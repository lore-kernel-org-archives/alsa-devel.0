From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: fix fsi build warnings for 64 bit"
	to the asoc tree
Date: Sat, 21 Nov 2015 14:01:38 +0000
Message-ID: <E1a08jS-0001Cm-0q@finisterre>
References: <4237757.xIRJLSDgsa@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4BE5260586
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 15:03:26 +0100 (CET)
In-Reply-To: <4237757.xIRJLSDgsa@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sh: fix fsi build warnings for 64 bit

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

>From e6e969f1fd332e7525c577c0d8cfcbe898409abd Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 Nov 2015 22:16:48 +0100
Subject: [PATCH] ASoC: sh: fix fsi build warnings for 64 bit

As this driver can now be compiled for ARM64, we get a new warning
as a result of passing a DMA filter data pointer through an 'int':

sound/soc/sh/fsi.c: In function 'fsi_dma_probe':
sound/soc/sh/fsi.c:1372:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     shdma_chan_filter, (void *)io->dma_id,

We already know that we only need the legacy filter function on
arch/sh, so we can hide the legacy DMA interface function
behind an #ifdef. This has the other advantage of no longer
depending on the shdma_chan_filter function to be visible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/fsi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 0215c78..ead5201 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1362,15 +1362,18 @@ static int fsi_dma_push_start_stop(struct fsi_priv *fsi, struct fsi_stream *io,
 
 static int fsi_dma_probe(struct fsi_priv *fsi, struct fsi_stream *io, struct device *dev)
 {
-	dma_cap_mask_t mask;
 	int is_play = fsi_stream_is_play(fsi, io);
 
+#ifdef CONFIG_SUPERH
+	dma_cap_mask_t mask;
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	io->chan = dma_request_slave_channel_compat(mask,
-				shdma_chan_filter, (void *)io->dma_id,
-				dev, is_play ? "tx" : "rx");
+	io->chan = dma_request_channel(mask, shdma_chan_filter,
+				       (void *)io->dma_id);
+#else
+	io->chan = dma_request_slave_channel(dev, is_play ? "tx" : "rx");
+#endif
 	if (io->chan) {
 		struct dma_slave_config cfg = {};
 		int ret;
-- 
2.6.1
