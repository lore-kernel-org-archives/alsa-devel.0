From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: pdm: Mark RXFIFO_DATA as volatile and
 precious" to the asoc tree
Date: Thu,  4 Apr 2019 15:16:19 +0700 (+07)
Message-ID: <20190404081619.75DA7441D3C@finisterre.ee.mobilebroadband>
References: <1554350228-24440-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554350228-24440-1-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: pdm: Mark RXFIFO_DATA as volatile and precious

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

>From b126fc07328749269021ac53173f9afdd6947248 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:57:08 +0800
Subject: [PATCH] ASoC: rockchip: pdm: Mark RXFIFO_DATA as volatile and
 precious

This patch marks RXFIFO_DATA as precious to avoid being read
outside a call from the driver, such as regmap debugfs

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 068453596470..6c0f242db5ef 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -417,6 +417,7 @@ static bool rockchip_pdm_rd_reg(struct device *dev, unsigned int reg)
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
 	case PDM_DATA_VALID:
+	case PDM_RXFIFO_DATA:
 	case PDM_VERSION:
 		return true;
 	default:
@@ -431,6 +432,17 @@ static bool rockchip_pdm_volatile_reg(struct device *dev, unsigned int reg)
 	case PDM_FIFO_CTRL:
 	case PDM_INT_CLR:
 	case PDM_INT_ST:
+	case PDM_RXFIFO_DATA:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rockchip_pdm_precious_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case PDM_RXFIFO_DATA:
 		return true;
 	default:
 		return false;
@@ -453,6 +465,7 @@ static const struct regmap_config rockchip_pdm_regmap_config = {
 	.writeable_reg = rockchip_pdm_wr_reg,
 	.readable_reg = rockchip_pdm_rd_reg,
 	.volatile_reg = rockchip_pdm_volatile_reg,
+	.precious_reg = rockchip_pdm_precious_reg,
 	.cache_type = REGCACHE_FLAT,
 };
 
-- 
2.20.1
