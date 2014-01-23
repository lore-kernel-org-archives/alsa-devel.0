From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm8997: Correct typo in EQ
	coefficient sizes
Date: Thu, 23 Jan 2014 13:45:36 +0000
Message-ID: <1390484736-12316-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1390484736-12316-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E1349264F0B
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 14:53:53 +0100 (CET)
In-Reply-To: <1390484736-12316-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8997.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 4a38249..6107108 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -170,7 +170,7 @@ ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ4", ARIZONA_EQ4MIX_INPUT_1_SOURCE),
 
-SND_SOC_BYTES("EQ1 Coefficients", ARIZONA_EQ1_3, 18),
+SND_SOC_BYTES("EQ1 Coefficients", ARIZONA_EQ1_3, 19),
 SOC_SINGLE("EQ1 Mode Switch", ARIZONA_EQ1_2, ARIZONA_EQ1_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ1 B1 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
@@ -183,7 +183,7 @@ SOC_SINGLE_TLV("EQ1 B4 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ1 B5 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ2 Coefficients", ARIZONA_EQ2_3, 18),
+SND_SOC_BYTES("EQ2 Coefficients", ARIZONA_EQ2_3, 19),
 SOC_SINGLE("EQ2 Mode Switch", ARIZONA_EQ2_2, ARIZONA_EQ2_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ2 B1 Volume", ARIZONA_EQ2_1, ARIZONA_EQ2_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
@@ -196,7 +196,7 @@ SOC_SINGLE_TLV("EQ2 B4 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ2 B5 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ3 Coefficients", ARIZONA_EQ3_3, 18),
+SND_SOC_BYTES("EQ3 Coefficients", ARIZONA_EQ3_3, 19),
 SOC_SINGLE("EQ3 Mode Switch", ARIZONA_EQ3_2, ARIZONA_EQ3_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ3 B1 Volume", ARIZONA_EQ3_1, ARIZONA_EQ3_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
@@ -209,7 +209,7 @@ SOC_SINGLE_TLV("EQ3 B4 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ3 B5 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ4 Coefficients", ARIZONA_EQ4_3, 18),
+SND_SOC_BYTES("EQ4 Coefficients", ARIZONA_EQ4_3, 19),
 SOC_SINGLE("EQ4 Mode Switch", ARIZONA_EQ4_2, ARIZONA_EQ4_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ4 B1 Volume", ARIZONA_EQ4_1, ARIZONA_EQ4_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
-- 
1.7.2.5
