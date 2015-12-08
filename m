From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: use correct format string for
	dma_addr_t" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:14 +0000
Message-ID: <E1a6NfO-0003xm-Ob@debutante>
References: <1625124.fpu6AsNAkc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3354326063F
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:24 +0100 (CET)
In-Reply-To: <1625124.fpu6AsNAkc@wuerfel>
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

   ASoC: fsl: use correct format string for dma_addr_t

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

>From 34e684fa04fadd513e028fa48123f357deac77e8 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 8 Dec 2015 16:35:51 +0100
Subject: [PATCH] ASoC: fsl: use correct format string for dma_addr_t

We get a warning for the imx-pcm-fiq driver when CONFIG_LPAE
is enabled on ARM, because dma_addr_t is 64-bit then:

sound/soc/fsl/imx-pcm-fiq.c: In function 'snd_imx_pcm_mmap':
sound/soc/fsl/imx-pcm-fiq.c:223:107: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]

This changes the printk to use the correct format string for
printing a dma_addr_t.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-pcm-fiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 7abf6a079574..49d7513f429e 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -220,9 +220,9 @@ static int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 	ret = dma_mmap_writecombine(substream->pcm->card->dev, vma,
 		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
 
-	pr_debug("%s: ret: %d %p 0x%08x 0x%08x\n", __func__, ret,
+	pr_debug("%s: ret: %d %p %pad 0x%08x\n", __func__, ret,
 			runtime->dma_area,
-			runtime->dma_addr,
+			&runtime->dma_addr,
 			runtime->dma_bytes);
 	return ret;
 }
-- 
2.6.2
