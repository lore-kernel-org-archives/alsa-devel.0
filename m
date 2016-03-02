From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 14/14] ASoC: rockchip: use __maybe_unused to
	hide st_irq_syscfg_resume
Date: Wed,  2 Mar 2016 16:59:06 +0100
Message-ID: <1456934350-1389172-15-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 2233426548E
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 17:00:56 +0100 (CET)
In-Reply-To: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The rockchip spdif driver uses SIMPLE_DEV_PM_OPS to conditionally
set its power management functions, but we get a warning
about rk_spdif_runtime_resume being unused when CONFIG_PM is not
set:

sound/soc/rockchip/rockchip_spdif.c:67:12: error: 'rk_spdif_runtime_resume' defined but not used [-Werror=unused-function]

This adds a __maybe_unused annotation so the compiler knows
it can silently drop it instead of warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/rockchip/rockchip_spdif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 5a806da89f42..274599d4caeb 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -54,7 +54,7 @@ static const struct of_device_id rk_spdif_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rk_spdif_match);
 
-static int rk_spdif_runtime_suspend(struct device *dev)
+static int __maybe_unused rk_spdif_runtime_suspend(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
 
@@ -64,7 +64,7 @@ static int rk_spdif_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int rk_spdif_runtime_resume(struct device *dev)
+static int __maybe_unused rk_spdif_runtime_resume(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
 	int ret;
-- 
2.7.0
