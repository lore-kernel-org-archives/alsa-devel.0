From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: sai: Fix get reset controller" to the asoc tree
Date: Sat, 21 Oct 2017 11:32:00 +0100 (BST)
Message-ID: <20171021103200.CB1CF440057@finisterre.ee.mobilebroadband>
References: <1508418203-16840-7-git-send-email-olivier.moysan@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508418203-16840-7-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: sai: Fix get reset controller

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

>From 3c6f6c53ab4df585639bbe647b45aa81ca54bdd2 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 19 Oct 2017 15:03:22 +0200
Subject: [PATCH] ASoC: stm32: sai: Fix get reset controller

Use devm version of reset_control_get function
to manage driver removing properly.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 1258bef4dcb3..5fe878ace605 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -85,7 +85,7 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	}
 
 	/* reset */
-	rst = reset_control_get_exclusive(&pdev->dev, NULL);
+	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (!IS_ERR(rst)) {
 		reset_control_assert(rst);
 		udelay(2);
-- 
2.14.1
