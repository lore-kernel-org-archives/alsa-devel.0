From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: Remove spaces before tabs" to the
	asoc tree
Date: Tue, 07 Mar 2017 14:33:38 +0100
Message-ID: <E1clFFC-0005cl-8A@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94411266FA8
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 14:33:47 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: Remove spaces before tabs

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

>From 672e3cbe783e2f3f40bdc19e5cb09accdd3e4b6b Mon Sep 17 00:00:00 2001
From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Date: Sat, 25 Feb 2017 22:50:29 +0200
Subject: [PATCH] ASoC: pxa: Remove spaces before tabs

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/pxa2xx-i2s.c | 6 +++---
 sound/soc/pxa/pxa2xx-pcm.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 27aa0e4341bc..3fb60baf6eab 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -46,10 +46,10 @@
 #define SACR0_STRF	(1 << 5)	/* FIFO Select for EFWR Special Function */
 #define SACR0_EFWR	(1 << 4)	/* Enable EFWR Function  */
 #define SACR0_RST	(1 << 3)	/* FIFO, i2s Register Reset */
-#define SACR0_BCKD	(1 << 2) 	/* Bit Clock Direction */
+#define SACR0_BCKD	(1 << 2)	/* Bit Clock Direction */
 #define SACR0_ENB	(1 << 0)	/* Enable I2S Link */
 #define SACR1_ENLBF	(1 << 5)	/* Enable Loopback */
-#define SACR1_DRPL	(1 << 4) 	/* Disable Replaying Function */
+#define SACR1_DRPL	(1 << 4)	/* Disable Replaying Function */
 #define SACR1_DREC	(1 << 3)	/* Disable Recording Function */
 #define SACR1_AMSL	(1 << 0)	/* Specify Alternate Mode */
 
@@ -60,7 +60,7 @@
 #define SASR0_TFS	(1 << 3)	/* Tx FIFO Service Request */
 #define SASR0_BSY	(1 << 2)	/* I2S Busy */
 #define SASR0_RNE	(1 << 1)	/* Rx FIFO Not Empty */
-#define SASR0_TNF	(1 << 0) 	/* Tx FIFO Not Empty */
+#define SASR0_TNF	(1 << 0)	/* Tx FIFO Not Empty */
 
 #define SAICR_ROR	(1 << 6)	/* Clear Rx FIFO Overrun Interrupt */
 #define SAICR_TUR	(1 << 5)	/* Clear Tx FIFO Underrun Interrupt */
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 410d48b93031..b51d7a0755d5 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -85,7 +85,7 @@ static int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 }
 
 static struct snd_soc_platform_driver pxa2xx_soc_platform = {
-	.ops 	= &pxa2xx_pcm_ops,
+	.ops		= &pxa2xx_pcm_ops,
 	.pcm_new	= pxa2xx_soc_pcm_new,
 	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
 };
-- 
2.11.0
