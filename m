From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] ASoC: ad193X: Remove non-functional DAPM route controls
Date: Mon, 28 Nov 2011 17:28:09 +0100
Message-ID: <1322497692-27868-4-git-send-email-lars@metafoo.de>
References: <1322497692-27868-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322497692-27868-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

DAPM route controls only take effect on paths where the sink is a mixer or a
mux, furthermore the control must be a control assigned to the mixer or mux.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad193x.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 665af5c..c52ebd3 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -90,12 +90,12 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "ADC", NULL, "PLL_PWR" },
 	{ "DAC", NULL, "ADC_PWR" },
 	{ "ADC", NULL, "ADC_PWR" },
-	{ "DAC1OUT", "DAC1 Switch", "DAC" },
-	{ "DAC2OUT", "DAC2 Switch", "DAC" },
-	{ "DAC3OUT", "DAC3 Switch", "DAC" },
-	{ "DAC4OUT", "DAC4 Switch", "DAC" },
-	{ "ADC", "ADC1 Switch", "ADC1IN" },
-	{ "ADC", "ADC2 Switch", "ADC2IN" },
+	{ "DAC1OUT", NULL, "DAC" },
+	{ "DAC2OUT", NULL, "DAC" },
+	{ "DAC3OUT", NULL, "DAC" },
+	{ "DAC4OUT", NULL, "DAC" },
+	{ "ADC", NULL, "ADC1IN" },
+	{ "ADC", NULL, "ADC2IN" },
 };
 
 /*
-- 
1.7.7.3
