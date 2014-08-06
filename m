Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A30662608D3
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 15:52:56 +0200 (CEST)
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
 by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id s76Dqt2v006391
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:55 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
 by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76DqtUN003459
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76DqspD005464	for
 <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:55 -0500
From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 6 Aug 2014 16:52:42 +0300
Message-ID: <fe4c93a553cf1f6476dc80fd016a94cec4a24715.1407332062.git.jsarha@ti.com>
In-Reply-To: <cover.1407332062.git.jsarha@ti.com>
References: <cover.1407332062.git.jsarha@ti.com>
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH 5/9] ASoC: davinci: HDMI audio build for AM33XX
	and TDA998x
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-ID: <alsa-devel@alsa-project.org>

Adds configuration option for HDMI audio support for AM33XX based
boards with NXP TDA998x HDMI transmitter. The audio is connected to
NXP TDA998x trough McASP running in i2s mode.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/Kconfig |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index b310dd3..59c61a0 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -37,6 +37,18 @@ config SND_AM33XX_SOC_EVM
 	  AM335X-EVMSK, and BeagelBone with AudioCape boards have this
 	  setup.
 
+config SND_AM335X_SOC_NXPTDA_EVM
+	tristate "HDMI Audio for the AM33XX chip based boards with TDA998x"
+	depends on SND_EDMA_SOC && SOC_AM33XX && DRM_I2C_NXP_TDA998X
+	select SND_SOC_HDMI_CODEC
+	select SND_DAVINCI_SOC_MCASP
+	select SND_DAVINCI_SOC_GENERIC_EVM
+	help
+	  Say Y or M if you want to add support for HDMI SoC audio on
+	  AM33XX boards with NXP TDA998x HDMI transmitter. For example
+	  BeagleBoneBack. The audio is connected to NXP TDA998x trough
+	  McASP running in i2s mode.
+
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC && I2C
-- 
1.7.9.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
