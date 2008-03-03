From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Add Invert Switch for ROUT2
Date: Mon,  3 Mar 2008 15:37:54 +0000
Message-ID: <1204558674-10703-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080303152038.42056376@cimmeria>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 83FB72456D
	for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2008 16:37:58 +0100 (CET)
In-Reply-To: <20080303152038.42056376@cimmeria>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Graeme Gregory <graeme@openmoko.org>, alsa-devel@alsa-project.org, openmoko-kernel@lists.openmoko.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Graeme Gregory <graeme@openmoko.org>

GTA02 device has a speaker between LOUT2 & ROUT2 and in this mode ROUT2
needs to be inverted. This patch adds a mixer control for this.

Signed-off-by: Graeme Gregory <graeme@openmoko.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8753.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 0288275..76a5c7b 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -198,6 +198,7 @@ static const char *wm8753_mic_sel[] = {"Mic 1", "Mic 2", "Mic 3"};
 static const char *wm8753_dai_mode[] = {"DAI 0", "DAI 1", "DAI 2", "DAI 3"};
 static const char *wm8753_dat_sel[] = {"Stereo", "Left ADC", "Right ADC",
 	"Channel Swap"};
+static const char *wm8753_rout2_phase[] = {"Non Inverted", "Inverted"};
 
 static const struct soc_enum wm8753_enum[] = {
 SOC_ENUM_SINGLE(WM8753_BASS, 7, 2, wm8753_base),
@@ -228,6 +229,7 @@ SOC_ENUM_SINGLE(WM8753_ADC, 4, 2, wm8753_adc_filter),
 SOC_ENUM_SINGLE(WM8753_MICBIAS, 6, 3, wm8753_mic_sel),
 SOC_ENUM_SINGLE(WM8753_IOCTL, 2, 4, wm8753_dai_mode),
 SOC_ENUM_SINGLE(WM8753_ADC, 7, 4, wm8753_dat_sel),
+SOC_ENUM_SINGLE(WM8753_OUTCTL, 2, 2, wm8753_rout2_phase),
 };
 
 
@@ -330,6 +332,7 @@ SOC_SINGLE("Mic1 Capture Volume", WM8753_INCTL1, 5, 3, 0),
 SOC_ENUM_EXT("DAI Mode", wm8753_enum[26], wm8753_get_dai, wm8753_set_dai),
 
 SOC_ENUM("ADC Data Select", wm8753_enum[27]),
+SOC_ENUM("ROUT2 Phase", wm8753_enum[28]),
 };
 
 /* add non dapm controls */
-- 
1.5.4.3
