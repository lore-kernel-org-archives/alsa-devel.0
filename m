From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Warn if WM8903 platform data is used to
	enable microphone IRQ
Date: Fri, 11 Feb 2011 14:41:29 +0000
Message-ID: <1297435289-13587-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 663C110387A
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 15:41:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM8903 interrupts are clear on read so if the WM8903 detection is
enabled from platform data when the IRQ is in use (rather than using a
direct signal from a GPIO) status may be lost during startup. Help users
spot this misconfiguration by adding a WARN_ON().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 20325b3..b61fe76 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2119,12 +2119,26 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 
 	/* Set up GPIOs and microphone detection */
 	if (pdata) {
+		bool mic_gpio = false;
+
 		for (i = 0; i < ARRAY_SIZE(pdata->gpio_cfg); i++) {
 			if (pdata->gpio_cfg[i] == WM8903_GPIO_NO_CONFIG)
 				continue;
 
 			snd_soc_write(codec, WM8903_GPIO_CONTROL_1 + i,
 				      pdata->gpio_cfg[i] & 0xffff);
+
+			val = (pdata->gpio_cfg[i] & WM8903_GP1_FN_MASK)
+				>> WM8903_GP1_FN_SHIFT;
+
+			switch (val) {
+			case WM8903_GPn_FN_MICBIAS_CURRENT_DETECT:
+			case WM8903_GPn_FN_MICBIAS_SHORT_DETECT:
+				mic_gpio = true;
+				break;
+			default:
+				break;
+			}
 		}
 
 		snd_soc_write(codec, WM8903_MIC_BIAS_CONTROL_0,
@@ -2135,6 +2149,14 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 			snd_soc_update_bits(codec, WM8903_WRITE_SEQUENCER_0,
 					    WM8903_WSEQ_ENA, WM8903_WSEQ_ENA);
 
+		/* If microphone detection is enabled by pdata but
+		 * detected via IRQ then interrupts can be lost before
+		 * the machine driver has set up microphone detection
+		 * IRQs as the IRQs are clear on read.  The detection
+		 * will be enabled when the machine driver configures.
+		 */
+		WARN_ON(!mic_gpio && (pdata->micdet_cfg & WM8903_MICDET_ENA));
+
 		wm8903->mic_delay = pdata->micdet_delay;
 	}
 	
-- 
1.7.2.3
