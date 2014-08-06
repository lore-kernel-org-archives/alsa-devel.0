From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 9/9] ARM: OMAP2+: omap2plus_defconfig: Enable
	BeagleBone Black HDMI audio support
Date: Wed, 6 Aug 2014 16:52:46 +0300
Message-ID: <4258f2c0f4bf3decf18ae01349fbcdc2261db995.1407332062.git.jsarha__38010.3971613154$1407333603$gmane$org@ti.com>
References: <cover.1407332062.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A4A98260824
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 15:53:02 +0200 (CEST)
Received: from dflxv15.itg.ti.com ([128.247.5.124])
 by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id s76Dr1bB006428
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:53:01 -0500
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
 by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76Dr1Rf023379
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:53:01 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76Dr0K0006219	for
 <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:53:00 -0500
In-Reply-To: <cover.1407332062.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Select CONFIG_SND_EDMA_SOC=m and CONFIG_SND_AM335X_SOC_NXPTDA_EVM=m
for BBB HDMI audio.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 8b07fda..73dbfad 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -222,7 +222,9 @@ CONFIG_SND_DEBUG=y
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_OMAP_SOC=m
+CONFIG_SND_EDMA_SOC=m
 CONFIG_SND_AM33XX_SOC_EVM=m
+CONFIG_SND_AM335X_SOC_NXPTDA_EVM=m
 CONFIG_SND_DAVINCI_SOC=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
-- 
1.7.9.5
