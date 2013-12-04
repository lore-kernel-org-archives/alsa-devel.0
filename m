From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: wm8962: Enable SYSCLK provisonally
	before fetching generated DSPCLK_DIV
Date: Wed, 4 Dec 2013 17:22:16 +0800
Message-ID: <1386148936-15899-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 by alsa0.perex.cz (Postfix) with ESMTP id C2F152615F7
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 10:22:21 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

DSPCLK_DIV can be only generated correctly after enabling SYSCLK. But if the
current bias_level hasn't reached SND_SOC_BIAS_ON, DAPM won't enable SYSCLK,
which would cause the calculation result from DSPCLK_DIV invalid since bit
DSPCLK_DIV will be finally turned to its true value after DAPM enables SYSCLK
while the driver won't calculate it again for the current instance. In this
circumstance, a playback which needs non-zero DSPCLK_DIV would be distorted
due to unexpected clock frequency resulted from an invalid DSPCLK_DIV value.

So this patch provisionally enables the SYSCLK to get a valid DSPCLK_DIV for
calculation and then disables it afterward.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/codecs/wm8962.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 07da601..97db3b4 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2439,7 +2439,20 @@ static void wm8962_configure_bclk(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8962_CLOCKING_4,
 			    WM8962_SYSCLK_RATE_MASK, clocking4);
 
+	/* DSPCLK_DIV can be only generated correctly after enabling SYSCLK.
+	 * So we here provisionally enable it and then disable it afterward
+	 * if current bias_level hasn't reached SND_SOC_BIAS_ON.
+	 */
+	if (codec->dapm.bias_level != SND_SOC_BIAS_ON)
+		snd_soc_update_bits(codec, WM8962_CLOCKING2,
+				WM8962_SYSCLK_ENA_MASK, WM8962_SYSCLK_ENA);
+
 	dspclk = snd_soc_read(codec, WM8962_CLOCKING1);
+
+	if (codec->dapm.bias_level != SND_SOC_BIAS_ON)
+		snd_soc_update_bits(codec, WM8962_CLOCKING2,
+				WM8962_SYSCLK_ENA_MASK, 0);
+
 	if (dspclk < 0) {
 		dev_err(codec->dev, "Failed to read DSPCLK: %d\n", dspclk);
 		return;
-- 
1.8.4
