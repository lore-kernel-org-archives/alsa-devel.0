From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: omap: N810: Don't select CONFIG_OMAP_MUX
	but make it as dependency
Date: Wed,  1 Dec 2010 11:01:20 +0200
Message-ID: <1291194080-8101-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E9581039B2
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 10:00:48 +0100 (CET)
Received: by eyg24 with SMTP id 24so3302679eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Dec 2010 01:00:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Not all omap boards use kernel based pin multiplexing so
CONFIG_SND_OMAP_SOC_N810 should not select it by default as it can make
harm to other boards in multi-board kernels.

Therefore put CONFIG_OMAP_MUX as a dependency to N810 ASoC machine driver.

Thanks to Tony Lindgren <tony@atomide.com> for noticing.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 sound/soc/omap/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index d542ea2..a088db6 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -12,8 +12,8 @@ config SND_OMAP_SOC_MCPDM
 config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
 	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
+	depends on OMAP_MUX
 	select SND_OMAP_SOC_MCBSP
-	select OMAP_MUX
 	select SND_SOC_TLV320AIC3X
 	help
 	  Say Y if you want to add support for SoC audio on Nokia N810.
-- 
1.7.2.3
