From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Voice wakeup support." to the
	asoc tree
Date: Wed, 08 Nov 2017 21:30:54 +0000
Message-ID: <E1eCXvy-0005Cu-FH@debutante>
References: <1510124662-5065-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3304026764D
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:31:03 +0100 (CET)
In-Reply-To: <1510124662-5065-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Chinyue Chen <chinyue@chromium.org>, alsa-devel@alsa-project.org, jack.yu@realtek.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Voice wakeup support.

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

>From 58f1c07d23cddbc4c8aa99a214934eb7d33e8523 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Wed, 8 Nov 2017 15:04:21 +0800
Subject: [PATCH] ASoC: rt5514: Voice wakeup support.

If the rt5514 Wake on Voice device is opened while suspended, it will
be able to wake up the system when a voice command is detected.
This patch also supports user-space policy to override wakeup behavior
by /sys/bus/spi/drivers/rt5514/spi2.0/power/wakeup.

Signed-off-by: Chinyue Chen <chinyue@chromium.org>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 0896817ffc3f..d03756913dd9 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -456,9 +456,35 @@ static int rt5514_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	device_init_wakeup(&spi->dev, true);
+
+	return 0;
+}
+
+static int rt5514_suspend(struct device *dev)
+{
+	int irq = to_spi_device(dev)->irq;
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(irq);
+
 	return 0;
 }
 
+static int rt5514_resume(struct device *dev)
+{
+	int irq = to_spi_device(dev)->irq;
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(irq);
+
+	return 0;
+}
+
+static const struct dev_pm_ops rt5514_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(rt5514_suspend, rt5514_resume)
+};
+
 static const struct of_device_id rt5514_of_match[] = {
 	{ .compatible = "realtek,rt5514", },
 	{},
@@ -468,6 +494,7 @@ MODULE_DEVICE_TABLE(of, rt5514_of_match);
 static struct spi_driver rt5514_spi_driver = {
 	.driver = {
 		.name = "rt5514",
+		.pm = &rt5514_pm_ops,
 		.of_match_table = of_match_ptr(rt5514_of_match),
 	},
 	.probe = rt5514_spi_probe,
-- 
2.15.0
