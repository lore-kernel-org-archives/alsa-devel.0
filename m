From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Implement WM8962 DMIC support
Date: Mon, 25 Apr 2011 20:15:05 +0100
Message-ID: <1303758905-5638-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1303758905-5638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 632E1244F9
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Apr 2011 21:15:20 +0200 (CEST)
In-Reply-To: <1303758905-5638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

DMIC support is automatically disabled when none of the GPIOs are set up
to bring out the DMICCLK and DMICDAT pins at startup.

Note that there's no support for controlling DMIC routing except the power
control so the board DAPM configuration will need to manage DMIC enable and
disable if analogue mics (eg, a headset) also exist.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index bc84a1a..7949f89 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2468,6 +2468,7 @@ SND_SOC_DAPM_INPUT("IN3R"),
 SND_SOC_DAPM_INPUT("IN4L"),
 SND_SOC_DAPM_INPUT("IN4R"),
 SND_SOC_DAPM_INPUT("Beep"),
+SND_SOC_DAPM_INPUT("DMICDAT"),
 
 SND_SOC_DAPM_MICBIAS("MICBIAS", WM8962_PWR_MGMT_1, 1, 0),
 
@@ -2487,6 +2488,8 @@ SND_SOC_DAPM_MIXER("MIXINL", WM8962_PWR_MGMT_1, 5, 0,
 SND_SOC_DAPM_MIXER("MIXINR", WM8962_PWR_MGMT_1, 4, 0,
 		   mixinr, ARRAY_SIZE(mixinr)),
 
+SND_SOC_DAPM_AIF_IN("DMIC", NULL, 0, WM8962_PWR_MGMT_1, 10, 0),
+
 SND_SOC_DAPM_ADC("ADCL", "Capture", WM8962_PWR_MGMT_1, 3, 0),
 SND_SOC_DAPM_ADC("ADCR", "Capture", WM8962_PWR_MGMT_1, 2, 0),
 
@@ -2564,13 +2567,17 @@ static const struct snd_soc_dapm_route wm8962_intercon[] = {
 
 	{ "MICBIAS", NULL, "SYSCLK" },
 
+	{ "DMIC", NULL, "DMICDAT" },
+
 	{ "ADCL", NULL, "SYSCLK" },
 	{ "ADCL", NULL, "TOCLK" },
 	{ "ADCL", NULL, "MIXINL" },
+	{ "ADCL", NULL, "DMIC" },
 
 	{ "ADCR", NULL, "SYSCLK" },
 	{ "ADCR", NULL, "TOCLK" },
 	{ "ADCR", NULL, "MIXINR" },
+	{ "ADCR", NULL, "DMIC" },
 
 	{ "STL", "Left", "ADCL" },
 	{ "STL", "Right", "ADCR" },
@@ -3718,6 +3725,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 					      dev);
 	u16 *reg_cache = codec->reg_cache;
 	int i, trigger, irq_pol;
+	bool dmicclk, dmicdat;
 
 	wm8962->codec = codec;
 	INIT_DELAYED_WORK(&wm8962->mic_work, wm8962_mic_work);
@@ -3855,6 +3863,29 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 
 	wm8962_add_widgets(codec);
 
+	/* Save boards having to disable DMIC when not in use */
+	dmicclk = false;
+	dmicdat = false;
+	for (i = 0; i < WM8962_MAX_GPIO; i++) {
+		switch (snd_soc_read(codec, WM8962_GPIO_BASE + i)
+			& WM8962_GP2_FN_MASK) {
+		case WM8962_GPIO_FN_DMICCLK:
+			dmicclk = true;
+			break;
+		case WM8962_GPIO_FN_DMICDAT:
+			dmicdat = true;
+			break;
+		default:
+			break;
+		}
+	}
+	if (!dmicclk || !dmicdat) {
+		dev_dbg(codec->dev, "DMIC not in use, disabling\n");
+		snd_soc_dapm_nc_pin(&codec->dapm, "DMICDAT");
+	}
+	if (dmicclk != dmicdat)
+		dev_warn(codec->dev, "DMIC GPIOs partially configured\n");
+
 	wm8962_init_beep(codec);
 	wm8962_init_gpio(codec);
 
-- 
1.7.4.1
