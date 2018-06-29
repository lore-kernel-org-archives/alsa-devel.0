From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: make SND_PXA2XX_SOC_I2S
	selectable" to the asoc tree
Date: Fri, 29 Jun 2018 12:07:07 +0100
Message-ID: <E1fYrF5-0002Zm-DB@debutante>
References: <20180627193359.26631-8-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 65D2F267A2F
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 13:07:10 +0200 (CEST)
In-Reply-To: <20180627193359.26631-8-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, robert.jarzmik@free.fr, lgirdwood@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: make SND_PXA2XX_SOC_I2S selectable

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

>From 0a94cf3457408058f894cc4d95e58d8e18eb7f75 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Wed, 27 Jun 2018 21:33:59 +0200
Subject: [PATCH] ASoC: pxa: make SND_PXA2XX_SOC_I2S selectable

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 960744e46edc..95dcf97a6271 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -31,7 +31,7 @@ config SND_PXA2XX_SOC_I2S
 	tristate
 
 config SND_PXA_SOC_SSP
-	tristate
+	tristate "Soc Audio via PXA2xx/PXA3xx SSP ports"
 	select PXA_SSP
 
 config SND_MMP_SOC_SSPA
-- 
2.18.0.rc2
