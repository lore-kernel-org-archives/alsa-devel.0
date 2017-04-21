From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: add I2C dependency for CS42XX8" to the asoc
 tree
Date: Fri, 21 Apr 2017 18:28:33 +0100
Message-ID: <E1d1cMD-0001wP-SQ@debutante>
References: <20170420081541.658178-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170420081541.658178-1-arnd@arndb.de>
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
Cc: Koro Chen <koro.chen@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, alsa-devel@alsa-project.org, Garlic Tseng <garlic.tseng@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, PC Liao <pc.liao@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: add I2C dependency for CS42XX8

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

>From 362c59436c143edbcdd4cc2ee0e9856eb6a93bc4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Apr 2017 10:15:20 +0200
Subject: [PATCH] ASoC: mediatek: add I2C dependency for CS42XX8

We should not select drivers that depend on I2C when that is disabled,
as it results in a build error:

warning: (SND_SOC_MT2701_WM8960) selects SND_SOC_WM8960 which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && I2C)
sound/soc/codecs/wm8960.c:1469:1: error: data definition has no type or storage class [-Werror]
sound/soc/codecs/wm8960.c:1469:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]

Fixes: 8625c1dbd876 ("ASoC: mediatek: Add mt2701-wm8960 machine driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index c6f39040f71f..5c68797f36c4 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -24,7 +24,7 @@ config SND_SOC_MT2701_CS42448
 
 config SND_SOC_MT2701_WM8960
 	tristate "ASoc Audio driver for MT2701 with WM8960 codec"
-	depends on SND_SOC_MT2701
+	depends on SND_SOC_MT2701 && I2C
 	select SND_SOC_WM8960
 	help
 	  This adds ASoC driver for Mediatek MT2701 boards
-- 
2.11.0
