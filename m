From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: move board Kconfig deps to parent
	config" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:41 +0100
Message-ID: <E1ZCTNV-0005To-0l@finisterre>
References: <1434665768-29367-1-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9A042654DD
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:57:52 +0200 (CEST)
In-Reply-To: <1434665768-29367-1-git-send-email-kwestfie@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: move board Kconfig deps to parent config

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

>From 02c4b9c28b973d999073c810a78375e38346d7a3 Mon Sep 17 00:00:00 2001
From: Kenneth Westfield <kwestfie@codeaurora.org>
Date: Thu, 18 Jun 2015 15:16:07 -0700
Subject: [PATCH] ASoC: qcom: move board Kconfig deps to parent config

Rather than have each board define the same set of
dependencies; move the common dependencies to the
SND_SOC_QCOM parent config.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 807fedf..d6ccda7 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -1,5 +1,6 @@
 config SND_SOC_QCOM
 	tristate "ASoC support for QCOM platforms"
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
           Say Y or M if you want to add support to use audio devices
           in Qualcomm Technologies SOC-based platforms.
@@ -26,7 +27,7 @@ config SND_SOC_LPASS_APQ8016
 
 config SND_SOC_STORM
 	tristate "ASoC I2S support for Storm boards"
-	depends on SND_SOC_QCOM && (ARCH_QCOM || COMPILE_TEST)
+	depends on SND_SOC_QCOM
 	select SND_SOC_LPASS_IPQ806X
 	select SND_SOC_MAX98357A
 	help
@@ -35,7 +36,7 @@ config SND_SOC_STORM
 
 config SND_SOC_APQ8016_SBC
 	tristate "SoC Audio support for APQ8016 SBC platforms"
-	depends on SND_SOC_QCOM && (ARCH_QCOM || COMPILE_TEST)
+	depends on SND_SOC_QCOM
 	select SND_SOC_LPASS_APQ8016
 	help
           Support for Qualcomm Technologies LPASS audio block in
-- 
2.1.4
