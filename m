From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH] ASoC: OMAP4: HDMI: Make stricter dependency on
	OMAP2_DSS
Date: Thu,  7 Jul 2011 15:38:54 -0500
Message-ID: <1310071134-11625-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E99C21038F0
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 11:37:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, tomi.valkeinen@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>
List-Id: alsa-devel@alsa-project.org

When building DSS HDMI driver with audio support, there is dependency
on SND_SOC to register the ASoC audio codec. Also, SND_OMAP_SOC_OMAP4_HDMI
has dependency on OMAP2_DSS. Then, to avoid build breakages,
SND_OMAP_SOC_OMAP4_HDMI, is restricted to be available only when
OMAP2_DSS AND SND_SOC have the same build type.

Also, dependency on ARCH_OMAP4 is removed, as it is checked indirectly
by OMAP4_DSS_HDMI.

Reported-by: Liam Girdwood <lrg@ti.com>
Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index e8ca5be..ffbd83f 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -113,7 +113,7 @@ config SND_OMAP_SOC_SDP4430
 
 config SND_OMAP_SOC_OMAP4_HDMI
 	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
-	depends on SND_OMAP_SOC && OMAP4_DSS_HDMI && OMAP2_DSS && ARCH_OMAP4
+	depends on SND_OMAP_SOC && OMAP4_DSS_HDMI && (OMAP2_DSS = SND_SOC)
 	select SND_OMAP_SOC_HDMI
 	help
 	  Say Y if you want to add support for SoC HDMI audio on Texas Instruments
-- 
1.7.4.1
