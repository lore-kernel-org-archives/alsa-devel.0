From: Mark Brown <broonie@linaro.org>
Subject: [PATCH] ASoC: wm8962: Restore device state after reset
	in runtime resume
Date: Fri,  7 Jun 2013 16:43:17 +0100
Message-ID: <1370619797-17503-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9894A2610CA
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 17:43:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

After the device has been reset we need to repeat the same
initialisation we do on probe to make sure that the device is in
a known state.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8962.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index d56dd86..32c2c47 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3723,6 +3723,21 @@ static int wm8962_runtime_resume(struct device *dev)
 
 	wm8962_reset(wm8962);
 
+	/* SYSCLK defaults to on; make sure it is off so we can safely
+	 * write to registers if the device is declocked.
+	 */
+	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
+			   WM8962_SYSCLK_ENA, 0);
+
+	/* Ensure we have soft control over all registers */
+	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
+			   WM8962_CLKREG_OVD, WM8962_CLKREG_OVD);
+
+	/* Ensure that the oscillator and PLLs are disabled */
+	regmap_update_bits(wm8962->regmap, WM8962_PLL2,
+			   WM8962_OSC_ENA | WM8962_PLL2_ENA | WM8962_PLL3_ENA,
+			   0);
+
 	regcache_sync(wm8962->regmap);
 
 	return 0;
-- 
1.7.10.4
