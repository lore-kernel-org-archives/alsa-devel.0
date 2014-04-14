From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/17] ASoC: wm5102: Replace usage deprecated
	SOC_VALUE_ENUM macro
Date: Mon, 14 Apr 2014 21:31:08 +0200
Message-ID: <1397503872-20864-14-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DA442656BF
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:32 +0200 (CEST)
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

SOC_VALUE_ENUM is deprecated and merely an alias for SOC_EMUM. Replace the
deprecated macros so we can eventually remove their definition.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm5102.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 3c1dfeb..289b64d 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -764,8 +764,8 @@ SOC_ENUM("LHPF2 Mode", arizona_lhpf2_mode),
 SOC_ENUM("LHPF3 Mode", arizona_lhpf3_mode),
 SOC_ENUM("LHPF4 Mode", arizona_lhpf4_mode),
 
-SOC_VALUE_ENUM("ISRC1 FSL", arizona_isrc_fsl[0]),
-SOC_VALUE_ENUM("ISRC2 FSL", arizona_isrc_fsl[1]),
+SOC_ENUM("ISRC1 FSL", arizona_isrc_fsl[0]),
+SOC_ENUM("ISRC2 FSL", arizona_isrc_fsl[1]),
 
 ARIZONA_MIXER_CONTROLS("Mic", ARIZONA_MICMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("Noise", ARIZONA_NOISEMIX_INPUT_1_SOURCE),
@@ -814,9 +814,9 @@ SOC_DOUBLE_R_TLV("SPKDAT1 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_5L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_5R, ARIZONA_OUT5L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
-SOC_VALUE_ENUM("HPOUT1 OSR", wm5102_hpout_osr[0]),
-SOC_VALUE_ENUM("HPOUT2 OSR", wm5102_hpout_osr[1]),
-SOC_VALUE_ENUM("EPOUT OSR", wm5102_hpout_osr[2]),
+SOC_ENUM("HPOUT1 OSR", wm5102_hpout_osr[0]),
+SOC_ENUM("HPOUT2 OSR", wm5102_hpout_osr[1]),
+SOC_ENUM("EPOUT OSR", wm5102_hpout_osr[2]),
 
 SOC_DOUBLE("HPOUT1 DRE Switch", ARIZONA_DRE_ENABLE,
 	   ARIZONA_DRE1L_ENA_SHIFT, ARIZONA_DRE1R_ENA_SHIFT, 1, 0),
-- 
1.8.0
