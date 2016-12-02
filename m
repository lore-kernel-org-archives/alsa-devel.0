From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: disable sinc filter for high
	THD of ADC
Date: Fri, 2 Dec 2016 09:48:58 +0800
Message-ID: <1480643338-9423-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D8A44266539
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2016 02:49:24 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

This bit will enable 4th order SINC filter.  
=1, filter will enable;  but it consumes higher power.
=0, the sinc filter is disable, and it should always keep 0 value to
get high THD.

Therefor, disable the filter when codec initiation for better
performance when recording.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 3 ++-
 sound/soc/codecs/nau8825.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 2b89569..efe3a44 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1846,7 +1846,8 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 	 * (audible hiss). Set it to something better.
 	 */
 	regmap_update_bits(regmap, NAU8825_REG_ADC_RATE,
-		NAU8825_ADC_SYNC_DOWN_MASK, NAU8825_ADC_SYNC_DOWN_64);
+		NAU8825_ADC_SYNC_DOWN_MASK | NAU8825_ADC_SINC4_EN,
+		NAU8825_ADC_SYNC_DOWN_64);
 	regmap_update_bits(regmap, NAU8825_REG_DAC_CTRL1,
 		NAU8825_DAC_OVERSAMPLE_MASK, NAU8825_DAC_OVERSAMPLE_64);
 	/* Disable DACR/L power */
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 0672a25..5d1704e 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -269,6 +269,8 @@
 #define NAU8825_BIQ_PATH_DAC   (1 << NAU8825_BIQ_PATH_SFT)
 
 /* ADC_RATE (0x2b) */
+#define NAU8825_ADC_SINC4_SFT		4
+#define NAU8825_ADC_SINC4_EN		(1 << NAU8825_ADC_SINC4_SFT)
 #define NAU8825_ADC_SYNC_DOWN_SFT	0
 #define NAU8825_ADC_SYNC_DOWN_MASK	0x3
 #define NAU8825_ADC_SYNC_DOWN_32	0
-- 
2.6.4
