From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sunxi: depend on ARCH_SUNXI" to the asoc tree
Date: Wed, 24 Aug 2016 12:20:31 +0100
Message-ID: <E1bcWER-00008q-V4@debutante>
References: <2008659.grltYsYuN0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2008659.grltYsYuN0@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Robinson <pbrobinson@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, wens@csie.org, broonie@kernel.org, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sunxi: depend on ARCH_SUNXI

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

>From 702650bda073cb9df90e3a091ee515f340133b05 Mon Sep 17 00:00:00 2001
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 23 Aug 2016 18:17:46 +0100
Subject: [PATCH] ASoC: sunxi: depend on ARCH_SUNXI

Depend on ARCH_SUNXI or COMPILE_TEST as it doesn't make sense to enable
these if the appropriate SoC they're embedded in isn't enabled.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 2a954bd01fd8..dd2368297fd3 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -1,4 +1,5 @@
 menu "Allwinner SoC Audio support"
+	depends on ARCH_SUNXI || COMPILE_TEST
 
 config SND_SUN4I_CODEC
 	tristate "Allwinner A10 Codec Support"
-- 
2.8.1
