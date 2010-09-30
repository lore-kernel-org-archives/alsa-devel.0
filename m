From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Provide microphone bias
	configuration for WM8962
Date: Wed, 29 Sep 2010 17:28:41 -0700
Message-ID: <1285806521-23090-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1285806521-23090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8ECF8103801
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 02:28:29 +0200 (CEST)
In-Reply-To: <1285806521-23090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Add the widget for MICBIAS power control and allow configuration of the
microphone bias setup via the platform data for the WM8962. When
microphone status signals are brought out to GPIO this should be
sufficient to enable microphone detection.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/wm8962.h    |    6 ++++++
 sound/soc/codecs/wm8962.c |   12 ++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/include/sound/wm8962.h b/include/sound/wm8962.h
index cc32aff..9722aac 100644
--- a/include/sound/wm8962.h
+++ b/include/sound/wm8962.h
@@ -17,6 +17,12 @@
 struct wm8962_pdata {
 	u32 gpio_init[WM8962_MAX_GPIO];
 
+	/* Setup for microphone detection, raw value to be written to
+	 * R48(0x30) - only microphone related bits will be updated.
+	 * Detection may be enabled here for use with signals brought
+	 * out on the GPIOs. */
+	u32 mic_cfg;
+
 	bool irq_active_low;
 
 	bool spk_mono;   /* Speaker outputs tied together as mono */
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 4fa5de8..be34146 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -630,6 +630,8 @@ SND_SOC_DAPM_INPUT("IN4L"),
 SND_SOC_DAPM_INPUT("IN4R"),
 SND_SOC_DAPM_INPUT("Beep"),
 
+SND_SOC_DAPM_MICBIAS("MICBIAS", WM8962_PWR_MGMT_1, 1, 0),
+
 SND_SOC_DAPM_SUPPLY("Class G", WM8962_CHARGE_PUMP_B, 0, 1, NULL, 0),
 SND_SOC_DAPM_SUPPLY("SYSCLK", WM8962_CLOCKING2, 5, 0, sysclk_event,
 		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
@@ -1755,6 +1757,16 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 		if (pdata->spk_mono)
 			wm8962->reg_cache[WM8962_CLASS_D_CONTROL_2]
 				|= WM8962_SPK_MONO;
+
+		/* Micbias setup, detection enable and detection
+		 * threasholds. */
+		if (pdata->mic_cfg)
+			snd_soc_update_bits(codec, WM8962_ADDITIONAL_CONTROL_4,
+					    WM8962_MICDET_ENA |
+					    WM8962_MICDET_THR_MASK |
+					    WM8962_MICSHORT_THR_MASK |
+					    WM8962_MICBIAS_LVL,
+					    pdata->mic_cfg);
 	}
 
 	/* Latch volume update bits */
-- 
1.7.1
