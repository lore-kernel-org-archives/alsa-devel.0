From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: wm1250-ev1: Define "WM1250 Output" with
 SND_SOC_DAPM_OUTPUT
Date: Thu, 26 May 2011 10:54:12 +0800
Message-ID: <1306378452.10398.9.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Codec output pin should be defined with SND_SOC_DAPM_OUTPUT.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
Note: 
Just found this bug while reading the code.
I don't have this hardware handy. I appreciate if someone can test it.

Axel

 sound/soc/codecs/wm1250-ev1.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index 14d0716..bcc2089 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -22,7 +22,7 @@ SND_SOC_DAPM_ADC("ADC", "wm1250-ev1 Capture", SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_DAC("DAC", "wm1250-ev1 Playback", SND_SOC_NOPM, 0, 0),
 
 SND_SOC_DAPM_INPUT("WM1250 Input"),
-SND_SOC_DAPM_INPUT("WM1250 Output"),
+SND_SOC_DAPM_OUTPUT("WM1250 Output"),
 };
 
 static const struct snd_soc_dapm_route wm1250_ev1_dapm_routes[] = {
-- 
1.7.1
