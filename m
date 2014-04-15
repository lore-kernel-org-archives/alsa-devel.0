From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: wm8997: Fix compile error
Date: Tue, 15 Apr 2014 07:46:05 +0200
Message-ID: <1397540765-30843-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-047.synserver.de
 [212.40.185.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CC72261A66
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 07:46:13 +0200 (CEST)
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The macro's name is SOC_ENUM, not SOC_VALUE.

Fixes: e13dd8ce ("ASoC: wm8997: Replace usage deprecated MUX/ENUM macros")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
I'm getting to old for this...
---
 sound/soc/codecs/wm8997.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 61926cb..bb9b47b 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -245,8 +245,8 @@ SND_SOC_BYTES("LHPF2 Coefficients", ARIZONA_HPLPF2_2, 1),
 SND_SOC_BYTES("LHPF3 Coefficients", ARIZONA_HPLPF3_2, 1),
 SND_SOC_BYTES("LHPF4 Coefficients", ARIZONA_HPLPF4_2, 1),
 
-SOC_VALUE("ISRC1 FSL", arizona_isrc_fsl[0]),
-SOC_VALUE("ISRC2 FSL", arizona_isrc_fsl[1]),
+SOC_ENUM("ISRC1 FSL", arizona_isrc_fsl[0]),
+SOC_ENUM("ISRC2 FSL", arizona_isrc_fsl[1]),
 
 ARIZONA_MIXER_CONTROLS("Mic", ARIZONA_MICMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("Noise", ARIZONA_NOISEMIX_INPUT_1_SOURCE),
@@ -286,8 +286,8 @@ SOC_DOUBLE_R_TLV("SPKDAT1 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_5L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_5R, ARIZONA_OUT5L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
-SOC_VALUE("HPOUT1 OSR", wm8997_hpout_osr[0]),
-SOC_VALUE("EPOUT OSR", wm8997_hpout_osr[1]),
+SOC_ENUM("HPOUT1 OSR", wm8997_hpout_osr[0]),
+SOC_ENUM("EPOUT OSR", wm8997_hpout_osr[1]),
 
 SOC_ENUM("Output Ramp Up", arizona_out_vi_ramp),
 SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
-- 
1.8.0
