From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/17] ASoC: wm5110: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:31:06 +0200
Message-ID: <1397503872-20864-12-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 5653F2656BD
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:29 +0200 (CEST)
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
 sound/soc/codecs/wm5110.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 7485f27..2e5fcb5 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -324,13 +324,13 @@ SOC_ENUM("LHPF2 Mode", arizona_lhpf2_mode),
 SOC_ENUM("LHPF3 Mode", arizona_lhpf3_mode),
 SOC_ENUM("LHPF4 Mode", arizona_lhpf4_mode),
 
-SOC_VALUE_ENUM("ISRC1 FSL", arizona_isrc_fsl[0]),
-SOC_VALUE_ENUM("ISRC2 FSL", arizona_isrc_fsl[1]),
-SOC_VALUE_ENUM("ISRC3 FSL", arizona_isrc_fsl[2]),
-SOC_VALUE_ENUM("ISRC1 FSH", arizona_isrc_fsh[0]),
-SOC_VALUE_ENUM("ISRC2 FSH", arizona_isrc_fsh[1]),
-SOC_VALUE_ENUM("ISRC3 FSH", arizona_isrc_fsh[2]),
-SOC_VALUE_ENUM("ASRC RATE 1", arizona_asrc_rate1),
+SOC_ENUM("ISRC1 FSL", arizona_isrc_fsl[0]),
+SOC_ENUM("ISRC2 FSL", arizona_isrc_fsl[1]),
+SOC_ENUM("ISRC3 FSL", arizona_isrc_fsl[2]),
+SOC_ENUM("ISRC1 FSH", arizona_isrc_fsh[0]),
+SOC_ENUM("ISRC2 FSH", arizona_isrc_fsh[1]),
+SOC_ENUM("ISRC3 FSH", arizona_isrc_fsh[2]),
+SOC_ENUM("ASRC RATE 1", arizona_asrc_rate1),
 
 ARIZONA_MIXER_CONTROLS("DSP1L", ARIZONA_DSP1LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("DSP1R", ARIZONA_DSP1RMIX_INPUT_1_SOURCE),
@@ -597,7 +597,7 @@ static const struct soc_enum wm5110_aec_loopback =
 			      wm5110_aec_loopback_values);
 
 static const struct snd_kcontrol_new wm5110_aec_loopback_mux =
-	SOC_DAPM_VALUE_ENUM("AEC Loopback", wm5110_aec_loopback);
+	SOC_DAPM_ENUM("AEC Loopback", wm5110_aec_loopback);
 
 static const struct snd_soc_dapm_widget wm5110_dapm_widgets[] = {
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
@@ -779,7 +779,7 @@ SND_SOC_DAPM_PGA("ISRC3DEC3", ARIZONA_ISRC_3_CTRL_3,
 SND_SOC_DAPM_PGA("ISRC3DEC4", ARIZONA_ISRC_3_CTRL_3,
 		 ARIZONA_ISRC3_DEC3_ENA_SHIFT, 0, NULL, 0),
 
-SND_SOC_DAPM_VALUE_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
+SND_SOC_DAPM_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
 		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
 		       &wm5110_aec_loopback_mux),
 
-- 
1.8.0
