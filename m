From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel: Use IS_ENABLED()" to the asoc
	tree
Date: Wed, 17 May 2017 10:51:28 +0100
Message-ID: <E1dAvc8-0006gT-48@debutante>
References: <20170515093201.20813-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 52BA6267094
 for <alsa-devel@alsa-project.org>; Wed, 17 May 2017 11:51:42 +0200 (CEST)
In-Reply-To: <20170515093201.20813-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel: Use IS_ENABLED()

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

>From cd187753dc24e269080520aae5ee753414ba9edc Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 15 May 2017 11:32:01 +0200
Subject: [PATCH] ASoC: atmel: Use IS_ENABLED()

Simplify the ifdef conditions with IS_ENABLED() macro.
No functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-pcm.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
index 6eaf081cad50..4b27aed40a51 100644
--- a/sound/soc/atmel/atmel-pcm.h
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -83,8 +83,7 @@ struct atmel_pcm_dma_params {
 #define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
 #define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
 
-#if defined(CONFIG_SND_ATMEL_SOC_PDC) || \
-	defined(CONFIG_SND_ATMEL_SOC_PDC_MODULE)
+#if IS_ENABLED(CONFIG_SND_ATMEL_SOC_PDC)
 int atmel_pcm_pdc_platform_register(struct device *dev);
 void atmel_pcm_pdc_platform_unregister(struct device *dev);
 #else
@@ -97,8 +96,7 @@ static inline void atmel_pcm_pdc_platform_unregister(struct device *dev)
 }
 #endif
 
-#if defined(CONFIG_SND_ATMEL_SOC_DMA) || \
-	defined(CONFIG_SND_ATMEL_SOC_DMA_MODULE)
+#if IS_ENABLED(CONFIG_SND_ATMEL_SOC_DMA)
 int atmel_pcm_dma_platform_register(struct device *dev);
 void atmel_pcm_dma_platform_unregister(struct device *dev);
 #else
-- 
2.11.0
