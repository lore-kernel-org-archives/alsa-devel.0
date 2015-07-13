From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: zx: i2s: Fix devm_ioremap_resource
	return value check" to the asoc tree
Date: Mon, 13 Jul 2015 12:16:52 +0100
Message-ID: <E1ZEbjA-0006b6-2p@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F19542605A9
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
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: zx: i2s: Fix devm_ioremap_resource return value check

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

>From a18da49ff3ec849c4584ae3abe2b83ff50705ace Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Date: Thu, 9 Jul 2015 22:19:28 +0900
Subject: [PATCH] ASoC: zx: i2s: Fix devm_ioremap_resource return value check

Value returned by devm_ioremap_resource() was checked for non-NULL but
devm_ioremap_resource() returns IOMEM_ERR_PTR, not NULL. In case of
error this could lead to dereference of ERR_PTR.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Reviewed-by: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/zx296702-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/zte/zx296702-i2s.c b/sound/soc/zte/zx296702-i2s.c
index 98d96e1b17e0..1930c42e1f55 100644
--- a/sound/soc/zte/zx296702-i2s.c
+++ b/sound/soc/zte/zx296702-i2s.c
@@ -393,9 +393,9 @@ static int zx_i2s_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	zx_i2s->mapbase = res->start;
 	zx_i2s->reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (!zx_i2s->reg_base) {
+	if (IS_ERR(zx_i2s->reg_base)) {
 		dev_err(&pdev->dev, "ioremap failed!\n");
-		return -EIO;
+		return PTR_ERR(zx_i2s->reg_base);
 	}
 
 	writel_relaxed(0, zx_i2s->reg_base + ZX_I2S_FIFO_CTRL);
-- 
2.1.4
