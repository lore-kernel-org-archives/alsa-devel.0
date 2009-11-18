From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 1/2] ASoC: Correcting the config options in
	soc/omap/Makefile
Date: Wed, 18 Nov 2009 18:08:59 +0530
Message-ID: <1258547939-13450-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 43EAF24374
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 13:39:06 +0100 (CET)
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
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Wrong config options were being used in the soc/omap/Makefile
for OMAP2 & OMAP3 and AM3517 EVMs.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/omap/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 02d6947..a69bd04 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -21,8 +21,8 @@ obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) += snd-soc-ams-delta.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
-obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
-obj-$(CONFIG_MACH_OMAP3EVM) += snd-soc-omap3evm.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
+obj-$(CONFIG_SND_SOC_OMAP_OMAP3EVM) += snd-soc-omap3evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
-- 
1.6.2.4
