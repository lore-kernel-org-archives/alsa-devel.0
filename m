From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: Use the IS_ENABLED to supports
	the module build
Date: Wed, 26 Jul 2017 18:32:20 +0800
Message-ID: <1501065140-14843-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DD32266CBB
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 12:32:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch uses the macro IS_ENABLED to make sure that the SPI function also
supports the module build.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 882fdc4..7fffa7c 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -31,7 +31,7 @@
 
 #include "rl6231.h"
 #include "rt5514.h"
-#if defined(CONFIG_SND_SOC_RT5514_SPI)
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
 #include "rt5514-spi.h"
 #endif
 
@@ -312,7 +312,7 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 
 			request_firmware(&fw, RT5514_FIRMWARE1, codec->dev);
 			if (fw) {
-#if defined(CONFIG_SND_SOC_RT5514_SPI)
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
 				rt5514_spi_burst_write(0x4ff60000, fw->data,
 					((fw->size/8)+1)*8);
 #else
@@ -325,7 +325,7 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 
 			request_firmware(&fw, RT5514_FIRMWARE2, codec->dev);
 			if (fw) {
-#if defined(CONFIG_SND_SOC_RT5514_SPI)
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
 				rt5514_spi_burst_write(0x4ffc0000, fw->data,
 					((fw->size/8)+1)*8);
 #else
-- 
2.7.4
