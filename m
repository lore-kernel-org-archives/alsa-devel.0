From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: add COMPILE_TEST on SND_MMP_SOC"
	to the asoc tree
Date: Wed, 21 Jun 2017 12:16:41 +0100
Message-ID: <E1dNdcn-0004Ex-6P@debutante>
References: <87lgom6jun.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1976C266C85
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 13:16:48 +0200 (CEST)
In-Reply-To: <87lgom6jun.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: add COMPILE_TEST on SND_MMP_SOC

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

>From d89e69c0f985392e708b54c92b322163da820cb9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jun 2017 04:38:34 +0000
Subject: [PATCH] ASoC: pxa: add COMPILE_TEST on SND_MMP_SOC

It doesn't use asm header. We can add COMPILE_TEST

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 960744e46edc..6feb34b8aa49 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -9,7 +9,7 @@ config SND_PXA2XX_SOC
 
 config SND_MMP_SOC
 	bool "Soc Audio for Marvell MMP chips"
-	depends on ARCH_MMP
+	depends on ARCH_MMP || COMPILE_TEST
 	select MMP_SRAM
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select SND_ARM
-- 
2.11.0
