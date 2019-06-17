From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: pdm: select CONFIG_RATIONAL" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:30 +0100 (BST)
Message-ID: <20190617152430.93BA7440046@finisterre.sirena.org.uk>
References: <20190617110415.2084205-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190617110415.2084205-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: pdm: select CONFIG_RATIONAL

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

>From 41d92e0c835bff7dec343bf41e79d24b326d94c1 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jun 2019 13:03:51 +0200
Subject: [PATCH] ASoC: rockchip: pdm: select CONFIG_RATIONAL

Without this, we get a link error:

sound/soc/rockchip/rockchip_pdm.o: In function `rockchip_pdm_hw_params':
rockchip_pdm.c:(.text+0x754): undefined reference to `rational_best_approximation'

Fixes: 624e8e00acaf ("ASoC: rockchip: pdm: fixup pdm fractional div")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 957046ac6c8c..d88555e0c389 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -19,6 +19,7 @@ config SND_SOC_ROCKCHIP_PDM
 	tristate "Rockchip PDM Controller Driver"
 	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select RATIONAL
 	help
 	  Say Y or M if you want to add support for PDM driver for
 	  Rockchip PDM Controller. The Controller supports up to maximum of
-- 
2.20.1
