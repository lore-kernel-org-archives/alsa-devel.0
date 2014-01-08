From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: bcm: Remove obsoleted Kconfig dependency
Date: Wed,  8 Jan 2014 10:37:07 +0100
Message-ID: <1389173827-1554-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EDCD261664
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 10:37:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: alsa-devel@alsa-project.org, Florian Meier <florian.meier@koalo.de>
List-Id: alsa-devel@alsa-project.org

CONFIG_SND_SOC_DMAENGINE_PCM was renamed to CONFIG_SND_DMAENGINE_PCM
recently.  And yet we don't have to select it since
CONFIG_SND_GENERIC_DMAENGINE_PCM selects the dependency by itself, so
just rip it off.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/bcm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/bcm/Kconfig b/sound/soc/bcm/Kconfig
index 3d82a29ce3a8..6a834e109f1d 100644
--- a/sound/soc/bcm/Kconfig
+++ b/sound/soc/bcm/Kconfig
@@ -1,7 +1,6 @@
 config SND_BCM2835_SOC_I2S
 	tristate "SoC Audio support for the Broadcom BCM2835 I2S module"
 	depends on ARCH_BCM2835 || COMPILE_TEST
-	select SND_SOC_DMAENGINE_PCM
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
 	help
-- 
1.8.5.2
