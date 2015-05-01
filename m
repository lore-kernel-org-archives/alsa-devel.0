From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v3 2/8] ASoC: arizona: add defines for single-input gain control
Date: Fri,  1 May 2015 16:15:13 +0100
Message-ID: <1430493319-23808-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com
Cc: myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Adds convenience defines for declaring a gain control that
has an input mux. These blocks are functionally equivalent to
the existing mixer blocks but can only have a single input
active at once.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 11ff899..6559ca0 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -92,6 +92,11 @@ extern const unsigned int arizona_mixer_tlv[];
 extern const char *arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS];
 extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 
+#define ARIZONA_GAINMUX_CONTROLS(name, base) \
+	SOC_SINGLE_RANGE_TLV(name " Input Volume", base + 1,		\
+			     ARIZONA_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
+			     arizona_mixer_tlv)
+
 #define ARIZONA_MIXER_CONTROLS(name, base) \
 	SOC_SINGLE_RANGE_TLV(name " Input 1 Volume", base + 1,		\
 			     ARIZONA_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
-- 
1.7.2.5

