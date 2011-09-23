From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Convert WM8962 MICBIAS to a supply
	widget
Date: Fri, 23 Sep 2011 16:54:04 +0100
Message-ID: <1316793246-819-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1BA2D103BBB
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 17:54:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

A supply widget is generally clearer than a MICBIAS widget and a mic bias
is just a type of supply so use a supply widget for the MICBIAS. This also
avoids confusion with the routing when connected to multiple inputs.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c           |    2 +-
 sound/soc/samsung/speyside_wm8962.c |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8679f06..59b2ad6 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2669,7 +2669,7 @@ SND_SOC_DAPM_INPUT("IN4R"),
 SND_SOC_DAPM_INPUT("Beep"),
 SND_SOC_DAPM_INPUT("DMICDAT"),
 
-SND_SOC_DAPM_MICBIAS("MICBIAS", WM8962_PWR_MGMT_1, 1, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS", WM8962_PWR_MGMT_1, 1, 0, NULL, 0),
 
 SND_SOC_DAPM_SUPPLY("Class G", WM8962_CHARGE_PUMP_B, 0, 1, NULL, 0),
 SND_SOC_DAPM_SUPPLY("SYSCLK", WM8962_CLOCKING2, 5, 0, sysclk_event,
diff --git a/sound/soc/samsung/speyside_wm8962.c b/sound/soc/samsung/speyside_wm8962.c
index 98b28ea..35539eb 100644
--- a/sound/soc/samsung/speyside_wm8962.c
+++ b/sound/soc/samsung/speyside_wm8962.c
@@ -152,12 +152,12 @@ static struct snd_soc_dapm_route audio_paths[] = {
 	{ "Main Speaker", NULL, "SPKOUTL" },
 	{ "Main Speaker", NULL, "SPKOUTR" },
 
-	{ "MICBIAS", NULL, "Headset Mic" },
-	{ "IN4L", NULL, "MICBIAS" },
-	{ "IN4R", NULL, "MICBIAS" },
+	{ "Headset Mic", NULL, "MICBIAS" },
+	{ "IN4L", NULL, "Headset Mic" },
+	{ "IN4R", NULL, "Headset Mic" },
 
-	{ "MICBIAS", NULL, "DMIC" },
-	{ "DMICDAT", NULL, "MICBIAS" },
+	{ "DMIC", NULL, "MICBIAS" },
+	{ "DMICDAT", NULL, "DMIC" },
 };
 
 static struct snd_soc_jack speyside_wm8962_headset;
-- 
1.7.6.3
