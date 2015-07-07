From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: remove Kconfig deps from variant
	configs" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:39 +0100
Message-ID: <E1ZCTNT-0005TL-Sx@finisterre>
References: <1433221532-9489-1-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B28BE26548E
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:57:52 +0200 (CEST)
In-Reply-To: <1433221532-9489-1-git-send-email-kwestfie@codeaurora.org>
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

   ASoC: qcom: remove Kconfig deps from variant configs

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

>From 7f005256f70a8c1c60b2f8a7449137da0c5e5bd9 Mon Sep 17 00:00:00 2001
From: Kenneth Westfield <kwestfie@codeaurora.org>
Date: Thu, 18 Jun 2015 15:16:08 -0700
Subject: [PATCH] ASoC: qcom: remove Kconfig deps from variant configs

Remove the SND_SOC_QCOM dependency from the variant
configs.  The board configs, which select the
variants, already have this dependency.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index d6ccda7..3cc252e 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -15,13 +15,11 @@ config SND_SOC_LPASS_PLATFORM
 
 config SND_SOC_LPASS_IPQ806X
 	tristate
-	depends on SND_SOC_QCOM
 	select SND_SOC_LPASS_CPU
 	select SND_SOC_LPASS_PLATFORM
 
 config SND_SOC_LPASS_APQ8016
 	tristate
-	depends on SND_SOC_QCOM
 	select SND_SOC_LPASS_CPU
 	select SND_SOC_LPASS_PLATFORM
 
-- 
2.1.4
