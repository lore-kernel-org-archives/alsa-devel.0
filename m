From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: au1x: psc-i2s.c: use
	devm_snd_soc_register_component()" to the asoc tree
Date: Tue,  2 Jul 2019 14:04:42 +0100 (BST)
Message-ID: <20190702130442.6FB67440049@finisterre.sirena.org.uk>
References: <87zhm2s69u.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A1C1F800DA
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 15:04:43 +0200 (CEST)
In-Reply-To: <87zhm2s69u.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: au1x: psc-i2s.c: use devm_snd_soc_register_component()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 7422104037773624d2a6cdb9becb68278befbd88 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Jun 2019 13:08:48 +0900
Subject: [PATCH] ASoC: au1x: psc-i2s.c: use devm_snd_soc_register_component()

We have devm_xxx version of snd_soc_register_component,
let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/au1x/psc-i2s.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 4a5a095076f4..076303f96b8c 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -340,16 +340,14 @@ static int au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wd);
 
-	return snd_soc_register_component(&pdev->dev, &au1xpsc_i2s_component,
-					  &wd->dai_drv, 1);
+	return devm_snd_soc_register_component(&pdev->dev,
+				&au1xpsc_i2s_component, &wd->dai_drv, 1);
 }
 
 static int au1xpsc_i2s_drvremove(struct platform_device *pdev)
 {
 	struct au1xpsc_audio_data *wd = platform_get_drvdata(pdev);
 
-	snd_soc_unregister_component(&pdev->dev);
-
 	__raw_writel(0, I2S_CFG(wd));
 	wmb(); /* drain writebuffer */
 	__raw_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
-- 
2.20.1
