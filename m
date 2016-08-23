From: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] ASoC: sunxi: depend on ARCH_SUNXI
Date: Tue, 23 Aug 2016 18:17:46 +0100
Message-ID: <20160823171746.16063-1-pbrobinson@gmail.com>
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
 sound/soc/sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 2a954bd..dd23682 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -1,4 +1,5 @@
 menu "Allwinner SoC Audio support"
+	depends on ARCH_SUNXI || COMPILE_TEST
 
 config SND_SUN4I_CODEC
 	tristate "Allwinner A10 Codec Support"
-- 
2.9.3
