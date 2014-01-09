From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5110: Add controls for headphone short circuit protection
Date: Thu,  9 Jan 2014 12:44:01 +0000
Message-ID: <1389271441-21046-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1389271441-21046-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389271441-21046-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: sameo@linux.intel.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Add controls to enable/disable the headphone short circuit protection of
the headphone outputs.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 9add6c7..f4b5f0c 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -267,6 +267,13 @@ ARIZONA_MIXER_CONTROLS("SPKDAT1R", ARIZONA_OUT5RMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SPKDAT2L", ARIZONA_OUT6LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SPKDAT2R", ARIZONA_OUT6RMIX_INPUT_1_SOURCE),
 
+SOC_SINGLE("HPOUT1 SC Protect", ARIZONA_HP1_SHORT_CIRCUIT_CTRL,
+	   ARIZONA_HP1_SC_ENA_SHIFT, 1, 0),
+SOC_SINGLE("HPOUT2 SC Protect", ARIZONA_HP2_SHORT_CIRCUIT_CTRL,
+	   ARIZONA_HP2_SC_ENA_SHIFT, 1, 0),
+SOC_SINGLE("HPOUT3 SC Protect", ARIZONA_HP3_SHORT_CIRCUIT_CTRL,
+	   ARIZONA_HP3_SC_ENA_SHIFT, 1, 0),
+
 SOC_DOUBLE_R("HPOUT1 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_1L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_1R, ARIZONA_OUT1L_MUTE_SHIFT, 1, 1),
 SOC_DOUBLE_R("HPOUT2 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_2L,
-- 
1.7.2.5
