From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: Do not force codecs selection by
	SND_SOC_FSL_ASOC_CARD
Date: Tue, 30 Sep 2014 16:52:15 -0300
Message-ID: <1412106735-18892-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f41.google.com (mail-yh0-f41.google.com
 [209.85.213.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CD6F260442
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 21:52:40 +0200 (CEST)
Received: by mail-yh0-f41.google.com with SMTP id i57so1721074yha.0
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 12:52:39 -0700 (PDT)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The wm8962 driver uses the input subsystem, but it is selected by
SND_SOC_FSL_ASOC_CARD, which can be built with CONFIG_INPUT disabled,
resulting in this link error:

ERROR: "input_event" [sound/soc/codecs/snd-soc-wm8962.ko] undefined!
ERROR: "input_register_device" [sound/soc/codecs/snd-soc-wm8962.ko] undefined!
ERROR: "devm_input_allocate_device" [sound/soc/codecs/snd-soc-wm8962.ko] undefined!

Do not force the selection of the codecs by SND_SOC_FSL_ASOC_CARD to avoid
such problem.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 6164e78..081e406 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -288,9 +288,6 @@ config SND_SOC_FSL_ASOC_CARD
 	select SND_SOC_FSL_ESAI
 	select SND_SOC_FSL_SAI
 	select SND_SOC_FSL_SSI
-	select SND_SOC_CS42XX8_I2C
-	select SND_SOC_SGTL5000
-	select SND_SOC_WM8962
 	help
 	 ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
 	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888
-- 
1.9.1
