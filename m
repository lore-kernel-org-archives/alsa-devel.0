From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: zte: spdif and i2s drivers are not zx296702 specific"
 to the asoc tree
Date: Thu, 08 Dec 2016 16:55:12 +0000
Message-ID: <E1cF1yS-0004xY-9Y@finisterre>
References: <1481186655-8213-1-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1481186655-8213-1-git-send-email-shawnguo@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Baoyou Xie <xie.baoyou@zte.com.cn>, Mark Brown <broonie@kernel.org>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: zte: spdif and i2s drivers are not zx296702 specific

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

>From de7975c2a42de889e2b3fd2f7d46f899ad8ccd45 Mon Sep 17 00:00:00 2001
From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 8 Dec 2016 16:44:14 +0800
Subject: [PATCH] ASoC: zte: spdif and i2s drivers are not zx296702 specific

ZTE ZX SPDIF and I2S drivers can work on not only ZX296702 but also
other ZTE ZX family SoCs like ZX296718, which is an arm64 platform.
Let's make a few renaming and tweak the Kconfig a bit to get the drivers
available for other ZTE ZX platforms.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/Kconfig                          | 16 ++++++++--------
 sound/soc/zte/Makefile                         |  4 ++--
 sound/soc/zte/{zx296702-i2s.c => zx-i2s.c}     |  0
 sound/soc/zte/{zx296702-spdif.c => zx-spdif.c} |  0
 4 files changed, 10 insertions(+), 10 deletions(-)
 rename sound/soc/zte/{zx296702-i2s.c => zx-i2s.c} (100%)
 rename sound/soc/zte/{zx296702-spdif.c => zx-spdif.c} (100%)

diff --git a/sound/soc/zte/Kconfig b/sound/soc/zte/Kconfig
index c47eb25e441f..6d8a90d36315 100644
--- a/sound/soc/zte/Kconfig
+++ b/sound/soc/zte/Kconfig
@@ -1,17 +1,17 @@
-config ZX296702_SPDIF
-	tristate "ZX296702 spdif"
-	depends on SOC_ZX296702 || COMPILE_TEST
+config ZX_SPDIF
+	tristate "ZTE ZX SPDIF Driver Support"
+	depends on ARCH_ZX || COMPILE_TEST
 	depends on COMMON_CLK
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to the
-	  zx296702 spdif interface
+	  ZTE ZX SPDIF interface
 
-config ZX296702_I2S
-	tristate "ZX296702 i2s"
-	depends on SOC_ZX296702 || COMPILE_TEST
+config ZX_I2S
+	tristate "ZTE ZX I2S Driver Support"
+	depends on ARCH_ZX || COMPILE_TEST
 	depends on COMMON_CLK
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to the
-	  zx296702 i2s interface
+	  ZTE ZX I2S interface
diff --git a/sound/soc/zte/Makefile b/sound/soc/zte/Makefile
index 254ed2c8c1a0..77768f5fd10c 100644
--- a/sound/soc/zte/Makefile
+++ b/sound/soc/zte/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_ZX296702_SPDIF)	+= zx296702-spdif.o
-obj-$(CONFIG_ZX296702_I2S)	+= zx296702-i2s.o
+obj-$(CONFIG_ZX_SPDIF)	+= zx-spdif.o
+obj-$(CONFIG_ZX_I2S)	+= zx-i2s.o
diff --git a/sound/soc/zte/zx296702-i2s.c b/sound/soc/zte/zx-i2s.c
similarity index 100%
rename from sound/soc/zte/zx296702-i2s.c
rename to sound/soc/zte/zx-i2s.c
diff --git a/sound/soc/zte/zx296702-spdif.c b/sound/soc/zte/zx-spdif.c
similarity index 100%
rename from sound/soc/zte/zx296702-spdif.c
rename to sound/soc/zte/zx-spdif.c
-- 
2.10.2
