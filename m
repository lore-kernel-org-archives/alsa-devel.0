From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm186x: Fix device reset-registers
	trigger value" to the asoc tree
Date: Thu, 15 Nov 2018 19:46:26 +0000 (GMT)
Message-ID: <20181115194626.9A5C4440079@finisterre.ee.mobilebroadband>
References: <20181115170131.1839-1-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8657D267B00
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 20:46:34 +0100 (CET)
In-Reply-To: <20181115170131.1839-1-dannenberg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephane Le Provost <stephane.leprovost@mediatek.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Andrew F Davis <afd@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm186x: Fix device reset-registers trigger value

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5277715639ff6f75c729e657690751a831112c4b Mon Sep 17 00:00:00 2001
From: Andreas Dannenberg <dannenberg@ti.com>
Date: Thu, 15 Nov 2018 11:01:31 -0600
Subject: [PATCH] ASoC: pcm186x: Fix device reset-registers trigger value

According to the current device datasheet (TI Lit # SLAS831D, revised
March 2018) the value written to the device's PAGE register to trigger
a complete register reset should be 0xfe, not 0xff. So go ahead and
update to the correct value.

Reported-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
Tested-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Acked-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/pcm186x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm186x.h b/sound/soc/codecs/pcm186x.h
index 2c6ba55bf394..bb3f0c42a1cd 100644
--- a/sound/soc/codecs/pcm186x.h
+++ b/sound/soc/codecs/pcm186x.h
@@ -139,7 +139,7 @@ enum pcm186x_type {
 #define PCM186X_MAX_REGISTER		PCM186X_CURR_TRIM_CTRL
 
 /* PCM186X_PAGE */
-#define PCM186X_RESET			0xff
+#define PCM186X_RESET			0xfe
 
 /* PCM186X_ADCX_INPUT_SEL_X */
 #define PCM186X_ADC_INPUT_SEL_POL	BIT(7)
-- 
2.19.1
