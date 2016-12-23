From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] ASoC: tlv320aic3x: Add delay after power
	on and register sync
Date: Fri, 23 Dec 2016 11:21:11 +0200
Message-ID: <20161223092112.7992-3-peter.ujfalusi@ti.com>
References: <20161223092112.7992-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 18220266949
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 10:21:08 +0100 (CET)
In-Reply-To: <20161223092112.7992-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jarkko.nikula@bitmer.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

When the codec is powered on, it's registers are in reset state as the
power off will do a soft reset of the codec.

After the register sync we need to add delay to remove the pop-noise on
stream start.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 7b6924e19021..bc220f83dd1f 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1393,6 +1393,12 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 			snd_soc_write(codec, AIC3X_PLL_PROGC_REG, pll_c);
 			snd_soc_write(codec, AIC3X_PLL_PROGD_REG, pll_d);
 		}
+
+		/*
+		 * Delay is needed to reduce pop-noise after syncing back the
+		 * registers
+		 */
+		mdelay(50);
 	} else {
 		/*
 		 * Do soft reset to this codec instance in order to clear
-- 
2.11.0
