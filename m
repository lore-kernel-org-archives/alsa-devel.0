From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm5110: Improve EQ coefficient
	controls
Date: Tue, 21 Jan 2014 15:58:07 +0000
Message-ID: <1390319888-27814-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1390319888-27814-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03B7F2619F2
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 17:06:26 +0100 (CET)
In-Reply-To: <1390319888-27814-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The EQ coefficient binary controls overlapped with the volume controls
for the B4 and B5 volumes, which were controllable from either the
coefficient control or the volume control itself.

This patch adds controls for the mode and moves the coefficient control
to only cover the coefficients.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 0ab2dc2..34fbb03 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -142,15 +142,8 @@ ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ4", ARIZONA_EQ4MIX_INPUT_1_SOURCE),
 
-SND_SOC_BYTES_MASK("EQ1 Coefficients", ARIZONA_EQ1_1, 21,
-		   ARIZONA_EQ1_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ2 Coefficients", ARIZONA_EQ2_1, 21,
-		   ARIZONA_EQ2_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ3 Coefficients", ARIZONA_EQ3_1, 21,
-		   ARIZONA_EQ3_ENA_MASK),
-SND_SOC_BYTES_MASK("EQ4 Coefficients", ARIZONA_EQ4_1, 21,
-		   ARIZONA_EQ4_ENA_MASK),
-
+SND_SOC_BYTES("EQ1 Coefficients", ARIZONA_EQ1_3, 18),
+SOC_SINGLE("EQ1 Mode Switch", ARIZONA_EQ1_2, ARIZONA_EQ1_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ1 B1 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ1 B2 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B2_GAIN_SHIFT,
@@ -162,6 +155,8 @@ SOC_SINGLE_TLV("EQ1 B4 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ1 B5 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
+SND_SOC_BYTES("EQ2 Coefficients", ARIZONA_EQ2_3, 18),
+SOC_SINGLE("EQ2 Mode Switch", ARIZONA_EQ2_2, ARIZONA_EQ2_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ2 B1 Volume", ARIZONA_EQ2_1, ARIZONA_EQ2_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ2 B2 Volume", ARIZONA_EQ2_1, ARIZONA_EQ2_B2_GAIN_SHIFT,
@@ -173,6 +168,8 @@ SOC_SINGLE_TLV("EQ2 B4 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ2 B5 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
+SND_SOC_BYTES("EQ3 Coefficients", ARIZONA_EQ3_3, 18),
+SOC_SINGLE("EQ3 Mode Switch", ARIZONA_EQ3_2, ARIZONA_EQ3_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ3 B1 Volume", ARIZONA_EQ3_1, ARIZONA_EQ3_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ3 B2 Volume", ARIZONA_EQ3_1, ARIZONA_EQ3_B2_GAIN_SHIFT,
@@ -184,6 +181,8 @@ SOC_SINGLE_TLV("EQ3 B4 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ3 B5 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
+SND_SOC_BYTES("EQ4 Coefficients", ARIZONA_EQ4_3, 18),
+SOC_SINGLE("EQ4 Mode Switch", ARIZONA_EQ4_2, ARIZONA_EQ4_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ4 B1 Volume", ARIZONA_EQ4_1, ARIZONA_EQ4_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 SOC_SINGLE_TLV("EQ4 B2 Volume", ARIZONA_EQ4_1, ARIZONA_EQ4_B2_GAIN_SHIFT,
-- 
1.7.2.5
