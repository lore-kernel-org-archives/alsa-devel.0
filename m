From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH] ASoC: pcm186x: Fix device reset-registers
	trigger value
Date: Thu, 15 Nov 2018 11:01:31 -0600
Message-ID: <20181115170131.1839-1-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by alsa0.perex.cz (Postfix) with ESMTP id E916A267AFC
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 18:01:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Andrew F Davis <afd@ti.com>, linux-kernel@vger.kernel.org, Stephane Le Provost <stephane.leprovost@mediatek.com>, Andreas Dannenberg <dannenberg@ti.com>
List-Id: alsa-devel@alsa-project.org

According to the current device datasheet (TI Lit # SLAS831D, revised
March 2018) the value written to the device's PAGE register to trigger
a complete register reset should be 0xfe, not 0xff. So go ahead and
update to the correct value.

Reported-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
Tested-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 sound/soc/codecs/pcm186x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm186x.h b/sound/soc/codecs/pcm186x.h
index 2c6ba55bf394..bb3f0c42a1cd 100644
--- a/sound/soc/codecs/pcm186x.h
+++ b/sound/soc/codecs/pcm186x.h
@@ -139,7 +139,7 @@ enum pcm186x_type {
 #define PCM186X_MAX_REGISTER		PCM186X_CURR_TRIM_CTRL
 
 /* PCM186X_PAGE */
-#define PCM186X_RESET			0xff
+#define PCM186X_RESET			0xfe
 
 /* PCM186X_ADCX_INPUT_SEL_X */
 #define PCM186X_ADC_INPUT_SEL_POL	BIT(7)
-- 
2.15.1
