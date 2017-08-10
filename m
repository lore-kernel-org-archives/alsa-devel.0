From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: spear: Delete an error message for a failed memory allocation in two functions" to the asoc tree
Date: Thu, 10 Aug 2017 16:42:43 +0100
Message-ID: <E1dfpbf-0001mV-TK@finisterre>
References: <1488018810-11973-1-git-send-email-despotovici.mihai@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488018810-11973-1-git-send-email-despotovici.mihai@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, dspmihai <despotovici.mihai@gmail.com>, alsa-devel@alsa-project.orgbroonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: spear: Delete an error message for a failed memory allocation in two functions

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

>From 65d55e8a3bb2d2a98078590cfa49cd508aa80e81 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 10 Aug 2017 09:50:51 +0200
Subject: [PATCH] ASoC: spear: Delete an error message for a failed memory
 allocation in two functions

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/spear/spdif_in.c  | 4 +---
 sound/soc/spear/spdif_out.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 7f32527fc3c8..01b28e59b4c0 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -216,10 +216,8 @@ static int spdif_in_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
-	if (!host) {
-		dev_warn(&pdev->dev, "kzalloc fail\n");
+	if (!host)
 		return -ENOMEM;
-	}
 
 	host->io_base = io_base;
 	host->irq = platform_get_irq(pdev, 0);
diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
index 0a72d52d533e..58d5843811f9 100644
--- a/sound/soc/spear/spdif_out.c
+++ b/sound/soc/spear/spdif_out.c
@@ -282,10 +282,8 @@ static int spdif_out_probe(struct platform_device *pdev)
 	int ret;
 
 	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
-	if (!host) {
-		dev_warn(&pdev->dev, "kzalloc fail\n");
+	if (!host)
 		return -ENOMEM;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->io_base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.13.2
