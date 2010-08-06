From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Correct WM8580 Capture control names
Date: Fri,  6 Aug 2010 18:35:32 +0100
Message-ID: <1281116132-25432-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1281116132-25432-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D9DDB103969
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 19:35:33 +0200 (CEST)
In-Reply-To: <1281116132-25432-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

Should use Capture rather than ADC so the UI tools can identify their
function more readily.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index c3571ee..1881b16 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -273,8 +273,8 @@ SOC_SINGLE("DAC1 Switch", WM8580_DAC_CONTROL5, 0, 1, 0),
 SOC_SINGLE("DAC2 Switch", WM8580_DAC_CONTROL5, 1, 1, 0),
 SOC_SINGLE("DAC3 Switch", WM8580_DAC_CONTROL5, 2, 1, 0),
 
-SOC_DOUBLE("ADC Mute Switch", WM8580_ADC_CONTROL1, 0, 1, 1, 0),
-SOC_SINGLE("ADC High-Pass Filter Switch", WM8580_ADC_CONTROL1, 4, 1, 0),
+SOC_DOUBLE("Capture Switch", WM8580_ADC_CONTROL1, 0, 1, 1, 0),
+SOC_SINGLE("Capture High-Pass Filter Switch", WM8580_ADC_CONTROL1, 4, 1, 0),
 };
 
 static const struct snd_soc_dapm_widget wm8580_dapm_widgets[] = {
-- 
1.7.1
