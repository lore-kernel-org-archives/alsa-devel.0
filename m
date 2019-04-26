From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: Add missing return 0 in remove()" to the asoc tree
Date: Fri, 26 Apr 2019 11:03:08 +0100 (BST)
Message-ID: <20190426100311.7D977441D3B@finisterre.ee.mobilebroadband>
References: <1556248850-3748-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556248850-3748-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, daniel.baluta@nxp.com, festevam@gmail.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.orgMark Brown <broonie@kernel.org>, perex@perex.cz, sfr@canb.auug.org.auStephen Rothwell <sfr@canb.auug.org.au>, timur@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: Add missing return 0 in remove()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From b46ea8f4d23807e41be86bf214618e4fd4682b9b Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Thu, 25 Apr 2019 20:20:50 -0700
Subject: [PATCH] ASoC: fsl_sai: Add missing return 0 in remove()

Build warning being reported:
    sound/soc/fsl/fsl_sai.c: In function 'fsl_sai_remove':
    sound/soc/fsl/fsl_sai.c:921:1: warning: no return statement in
    function returning non-void [-Wreturn-type]

So this patch just adds a "return 0" to fix it.

Fixes: 812ad463e089 ("ASoC: fsl_sai: Add support for runtime pm")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 26c27dc0781f..8593269156bd 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -918,6 +918,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 static int fsl_sai_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
+
+	return 0;
 }
 
 static const struct of_device_id fsl_sai_ids[] = {
-- 
2.20.1
