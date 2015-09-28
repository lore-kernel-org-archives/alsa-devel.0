From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: arizona: add defines for single-input gain control
Date: Mon, 28 Sep 2015 13:26:37 +0100
Message-ID: <1443443198-29710-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1443443198-29710-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443443198-29710-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Adds convenience defines for declaring a gain control that
has an input mux. These blocks are functionally equivalent to
the existing mixer blocks but can only have a single input
active at once.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 7b68d05..b73920a 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -99,6 +99,11 @@ extern const unsigned int arizona_mixer_tlv[];
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
1.9.1
