From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm5102: Enable volume ramp control
Date: Sun,  9 Dec 2012 12:31:09 +0900
Message-ID: <1355023870-32040-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1355023870-32040-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5CD9E2616D7
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2012 04:31:19 +0100 (CET)
In-Reply-To: <1355023870-32040-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index b4d8fed..17e28da 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -638,6 +638,9 @@ SOC_DOUBLE_R_TLV("IN3 Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_3L,
 		 ARIZONA_ADC_DIGITAL_VOLUME_3R, ARIZONA_IN3L_DIG_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
+SOC_ENUM("Input Ramp Up", arizona_in_vi_ramp),
+SOC_ENUM("Input Ramp Down", arizona_in_vd_ramp),
+
 ARIZONA_MIXER_CONTROLS("EQ1", ARIZONA_EQ1MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
@@ -765,6 +768,9 @@ SOC_DOUBLE_R_TLV("SPKDAT1 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_5L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_5R, ARIZONA_OUT5L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
+SOC_ENUM("Output Ramp Up", arizona_out_vi_ramp),
+SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
+
 SOC_DOUBLE("SPKDAT1 Switch", ARIZONA_PDM_SPK1_CTRL_1, ARIZONA_SPK1L_MUTE_SHIFT,
 	   ARIZONA_SPK1R_MUTE_SHIFT, 1, 1),
 
-- 
1.7.10.4
