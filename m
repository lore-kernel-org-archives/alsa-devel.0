From: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] ASoC: sunxi: depend on ARCH_SUNXI
Date: Mon, 22 Aug 2016 13:12:42 +0100
Message-ID: <20160822121242.18827-1-pbrobinson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: maxime.ripard@free-electrons.com, broonie@kernel.org, lgirdwood@gmail.com, wens@csie.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Peter Robinson <pbrobinson@gmail.com>
List-Id: alsa-devel@alsa-project.org

Depend on ARCH_SUNXI or COMPILE_TEST as it doesn't make sense to enable
these if the appropriate SoC they're embedded in isn't enabled.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 sound/soc/sunxi/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 2a954bd..a2b62dc5 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -2,6 +2,7 @@ menu "Allwinner SoC Audio support"
 
 config SND_SUN4I_CODEC
 	tristate "Allwinner A10 Codec Support"
+	depends on ARCH_SUNXI || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
@@ -10,6 +11,7 @@ config SND_SUN4I_CODEC
 
 config SND_SUN4I_I2S
 	tristate "Allwinner A10 I2S Support"
+	depends on ARCH_SUNXI || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
@@ -19,7 +21,7 @@ config SND_SUN4I_I2S
 
 config SND_SUN4I_SPDIF
 	tristate "Allwinner A10 SPDIF Support"
-	depends on OF
+	depends on OF && (ARCH_SUNXI || COMPILE_TEST)
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
-- 
2.9.3
