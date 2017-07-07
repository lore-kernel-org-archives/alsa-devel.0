From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: spear: fix error return code in
	spdif_in_probe()" to the asoc tree
Date: Fri, 07 Jul 2017 13:51:56 +0100
Message-ID: <E1dTSjk-0002nC-Cz@finisterre>
References: <20170630204350.GA8158@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DBED82671AE
 for <alsa-devel@alsa-project.org>; Fri,  7 Jul 2017 14:52:20 +0200 (CEST)
In-Reply-To: <20170630204350.GA8158@embeddedgus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: spear: fix error return code in spdif_in_probe()

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

>From adee2d75d095c1b0ef83fd2b5f403c819e5c6ef3 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Fri, 30 Jun 2017 15:43:50 -0500
Subject: [PATCH] ASoC: spear: fix error return code in spdif_in_probe()

platform_get_irq() returns an error code, but the spdif_in driver
ignores it and always returns -EINVAL. This is not correct, and
prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print error message and propagate the return value of platform_get_irq
on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/spear/spdif_in.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 977a078eb92f..7f32527fc3c8 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -223,8 +223,10 @@ static int spdif_in_probe(struct platform_device *pdev)
 
 	host->io_base = io_base;
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0)
-		return -EINVAL;
+	if (host->irq < 0) {
+		dev_warn(&pdev->dev, "failed to get IRQ: %d\n", host->irq);
+		return host->irq;
+	}
 
 	host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk))
-- 
2.13.2
