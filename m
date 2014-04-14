From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/17] ASoC: wm8997: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:31:11 +0200
Message-ID: <1397503872-20864-17-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 3481E2656C5
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:35 +0200 (CEST)
In-Reply-To: <1397503872-20864-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

SOC_VALUE_ENUM, SND_SOC_DAPM_VALUE_MUX and SOC_DAPM_VALUE_ENUM are deprecated
and merely an alias for SOC_ENUM, SND_SOC_DAPM_MUX and SOC_DAPM_ENUM. Replace
the deprecated macros so we can eventually remove their definition.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8997.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 09c4150..61926cb 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -245,8 +245,8 @@ SND_SOC_BYTES("LHPF2 Coefficients", ARIZONA_HPLPF2_2, 1),
 SND_SOC_BYTES("LHPF3 Coefficients", ARIZONA_HPLPF3_2, 1),
 SND_SOC_BYTES("LHPF4 Coefficients", ARIZONA_HPLPF4_2, 1),
 
-SOC_VALUE_ENUM("ISRC1 FSL", arizona_isrc_fsl[0]),
-SOC_VALUE_ENUM("ISRC2 FSL", arizona_isrc_fsl[1]),
+SOC_VALUE("ISRC1 FSL", arizona_isrc_fsl[0]),
+SOC_VALUE("ISRC2 FSL", arizona_isrc_fsl[1]),
 
 ARIZONA_MIXER_CONTROLS("Mic", ARIZONA_MICMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("Noise", ARIZONA_NOISEMIX_INPUT_1_SOURCE),
@@ -286,8 +286,8 @@ SOC_DOUBLE_R_TLV("SPKDAT1 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_5L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_5R, ARIZONA_OUT5L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
-SOC_VALUE_ENUM("HPOUT1 OSR", wm8997_hpout_osr[0]),
-SOC_VALUE_ENUM("EPOUT OSR", wm8997_hpout_osr[1]),
+SOC_VALUE("HPOUT1 OSR", wm8997_hpout_osr[0]),
+SOC_VALUE("EPOUT OSR", wm8997_hpout_osr[1]),
 
 SOC_ENUM("Output Ramp Up", arizona_out_vi_ramp),
 SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
@@ -405,7 +405,7 @@ static const struct soc_enum wm8997_aec_loopback =
 			      wm8997_aec_loopback_values);
 
 static const struct snd_kcontrol_new wm8997_aec_loopback_mux =
-	SOC_DAPM_VALUE_ENUM("AEC Loopback", wm8997_aec_loopback);
+	SOC_DAPM_ENUM("AEC Loopback", wm8997_aec_loopback);
 
 static const struct snd_soc_dapm_widget wm8997_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
@@ -604,7 +604,7 @@ SND_SOC_DAPM_AIF_IN("SLIMRX8", NULL, 0,
 		    ARIZONA_SLIMBUS_RX_CHANNEL_ENABLE,
 		    ARIZONA_SLIMRX8_ENA_SHIFT, 0),
 
-SND_SOC_DAPM_VALUE_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
+SND_SOC_DAPM_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
 		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
 		       &wm8997_aec_loopback_mux),
 
-- 
1.8.0
