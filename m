From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: Fix unmet dependency warning for
	SND_SOC_SDM845" to the asoc tree
Date: Thu,  2 Aug 2018 11:10:26 +0100 (BST)
Message-ID: <20180802101026.E72121124241@debutante.sirena.org.uk>
References: <1533193379-1125-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 227CF2677CD
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 12:10:30 +0200 (CEST)
In-Reply-To: <1533193379-1125-1-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: rohkumar@qti.qualcomm.com, sfr@canb.auug.org.au, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: Fix unmet dependency warning for SND_SOC_SDM845

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

>From 73edbe42582207ff8f47168f05124376394aa643 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Thu, 2 Aug 2018 12:32:59 +0530
Subject: [PATCH] ASoC: qcom: Fix unmet dependency warning for SND_SOC_SDM845

Add DEPENDS_ON QCOM_APR for SND_SOC_SDM845 to fix the
warning: unmet direct dependencies detected for
SND_SOC_QDSP6.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 350730839c6f..5f03312ef007 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -93,6 +93,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
+	depends on QCOM_APR
 	select SND_SOC_QDSP6
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
-- 
2.18.0
