From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: zx296702-i2s: Fix resource leak when
	unload module" to the asoc tree
Date: Sun, 30 Aug 2015 12:26:45 +0100
Message-ID: <E1ZW0l3-0008DS-Ek@finisterre>
References: <1440860970.28601.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C9E026049A
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 16:17:31 +0200 (CEST)
In-Reply-To: <1440860970.28601.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: zx296702-i2s: Fix resource leak when unload module

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

>From a695d474ab850cde27e82e4f3f1431269f00762b Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 29 Aug 2015 23:09:30 +0800
Subject: [PATCH] ASoC: zx296702-i2s: Fix resource leak when unload module

Use devm_* API to fix leaks in current code.
1. Use devm_kzalloc to fix memory leak for zx_i2s when unload the module.
2. Use devm_snd_soc_register_component to ensure component is unregistered
   when unload the module.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/zx296702-i2s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/zte/zx296702-i2s.c b/sound/soc/zte/zx296702-i2s.c
index 98d96e1..f4b681d 100644
--- a/sound/soc/zte/zx296702-i2s.c
+++ b/sound/soc/zte/zx296702-i2s.c
@@ -380,7 +380,7 @@ static int zx_i2s_probe(struct platform_device *pdev)
 	struct zx_i2s_info *zx_i2s;
 	int ret;
 
-	zx_i2s =  kzalloc(sizeof(*zx_i2s), GFP_KERNEL);
+	zx_i2s = devm_kzalloc(&pdev->dev, sizeof(*zx_i2s), GFP_KERNEL);
 	if (!zx_i2s)
 		return -ENOMEM;
 
@@ -401,8 +401,8 @@ static int zx_i2s_probe(struct platform_device *pdev)
 	writel_relaxed(0, zx_i2s->reg_base + ZX_I2S_FIFO_CTRL);
 	platform_set_drvdata(pdev, zx_i2s);
 
-	ret = snd_soc_register_component(&pdev->dev, &zx_i2s_component,
-					 &zx_i2s_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &zx_i2s_component,
+					      &zx_i2s_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Register DAI failed: %d\n", ret);
 		return ret;
-- 
2.5.0
