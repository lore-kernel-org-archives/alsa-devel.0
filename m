From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti-sas: Remove spurious dependency on
	SND_SOC_STI" to the asoc tree
Date: Mon, 13 Jul 2015 12:16:53 +0100
Message-ID: <E1ZEbjB-0006c3-TS@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E9972604D6
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 13:16:58 +0200 (CEST)
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti-sas: Remove spurious dependency on SND_SOC_STI

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

>From a2f3a8ca5219651292447f0e1124b3412bc3abff Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 13 Jul 2015 11:53:08 +0100
Subject: [PATCH] ASoC: sti-sas: Remove spurious dependency on SND_SOC_STI

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 46802eff292e..e20834818bcb 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -613,7 +613,6 @@ config SND_SOC_STAC9766
 
 config SND_SOC_STI_SAS
 	tristate "codec Audio support for STI SAS codec"
-	depends on SND_SOC_STI
 
 config SND_SOC_TAS2552
 	tristate "Texas Instruments TAS2552 Mono Audio amplifier"
-- 
2.1.4
