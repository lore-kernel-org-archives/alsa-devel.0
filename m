From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH] ASoC: rockchip: implement system
	suspend/resume for spdif
Date: Tue,  5 Jul 2016 10:48:06 +0800
Message-ID: <1467686886-53257-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 744F6265558
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 04:51:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

restore hw registers after power loss during a suspend/resume cycle.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_spdif.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 100781e..00ae0e5 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -392,9 +392,35 @@ static int rk_spdif_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int rockchip_spdif_suspend(struct device *dev)
+{
+	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
+
+	regcache_mark_dirty(spdif->regmap);
+
+	return 0;
+}
+
+static int rockchip_spdif_resume(struct device *dev)
+{
+	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
+	ret = regcache_sync(spdif->regmap);
+	pm_runtime_put(dev);
+
+	return ret;
+}
+#endif
+
 static const struct dev_pm_ops rk_spdif_pm_ops = {
 	SET_RUNTIME_PM_OPS(rk_spdif_runtime_suspend, rk_spdif_runtime_resume,
 			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(rockchip_spdif_suspend, rockchip_spdif_resume)
 };
 
 static struct platform_driver rk_spdif_driver = {
-- 
1.9.1
