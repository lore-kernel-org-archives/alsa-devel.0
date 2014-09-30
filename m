From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: fsl: fix dependencies for wm8962
Date: Tue, 30 Sep 2014 13:43:41 +0200
Message-ID: <1950588.ErdGoiHh8p@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C0E92604BD
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 13:44:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The wm8962 driver uses the input subsystem, but is selected by
SND_SOC_FSL_ASOC_CARD, which can be built with CONFIG_INPUT disabled,
resulting in this link error:

ERROR: "input_event" [sound/soc/codecs/snd-soc-wm8962.ko] undefined!
ERROR: "input_register_device" [sound/soc/codecs/snd-soc-wm8962.ko] undefined!
ERROR: "devm_input_allocate_device" [sound/soc/codecs/snd-soc-wm8962.ko] undefined!

This adds an explicit Kconfig dependency to prevent this configuration
from being used.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 708b4351f08 ("ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support")

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 6164e78b466a..99e9386f7956 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -282,7 +282,7 @@ config SND_SOC_IMX_MC13783
 
 config SND_SOC_FSL_ASOC_CARD
 	tristate "Generic ASoC Sound Card with ASRC support"
-	depends on OF && I2C
+	depends on OF && I2C && INPUT
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_FSL_ESAI
