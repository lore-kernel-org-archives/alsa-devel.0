From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5514: Voice wakeup support.
Date: Wed, 8 Nov 2017 15:04:21 +0800
Message-ID: <1510124662-5065-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id A02BE266DF5
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 08:05:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, Chinyue Chen <chinyue@chromium.org>, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

If the rt5514 Wake on Voice device is opened while suspended, it will
be able to wake up the system when a voice command is detected.
This patch also supports user-space policy to override wakeup behavior
by /sys/bus/spi/drivers/rt5514/spi2.0/power/wakeup.

Signed-off-by: Chinyue Chen <chinyue@chromium.org>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514-spi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index b90d6d5..0c0e209 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -448,9 +448,35 @@ static int rt5514_spi_probe(struct spi_device *spi)
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
@@ -460,6 +486,7 @@ MODULE_DEVICE_TABLE(of, rt5514_of_match);
 static struct spi_driver rt5514_spi_driver = {
 	.driver = {
 		.name = "rt5514",
+		.pm = &rt5514_pm_ops,
 		.of_match_table = of_match_ptr(rt5514_of_match),
 	},
 	.probe = rt5514_spi_probe,
-- 
2.7.4
