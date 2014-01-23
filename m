From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm5102: Correct typo in EQ
	coefficient sizes
Date: Thu, 23 Jan 2014 13:45:34 +0000
Message-ID: <1390484736-12316-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E627D2625FF
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 14:53:52 +0100 (CET)
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

Sorry seems there was a small typo in my patches from
yesterday.

Let me know if you would rather I respun the patches from
yesterday but for now here they are as an incremental fix.

Thanks,
Charles

 sound/soc/codecs/wm5102.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 5e03a83..ebffe81 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -685,7 +685,7 @@ ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ4", ARIZONA_EQ4MIX_INPUT_1_SOURCE),
 
-SND_SOC_BYTES("EQ1 Coefficients", ARIZONA_EQ1_3, 18),
+SND_SOC_BYTES("EQ1 Coefficients", ARIZONA_EQ1_3, 19),
 SOC_SINGLE("EQ1 Mode Switch", ARIZONA_EQ1_2, ARIZONA_EQ1_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ1 B1 Volume", ARIZONA_EQ1_1, ARIZONA_EQ1_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
@@ -698,7 +698,7 @@ SOC_SINGLE_TLV("EQ1 B4 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ1 B5 Volume", ARIZONA_EQ1_2, ARIZONA_EQ1_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ2 Coefficients", ARIZONA_EQ2_3, 18),
+SND_SOC_BYTES("EQ2 Coefficients", ARIZONA_EQ2_3, 19),
 SOC_SINGLE("EQ2 Mode Switch", ARIZONA_EQ2_2, ARIZONA_EQ2_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ2 B1 Volume", ARIZONA_EQ2_1, ARIZONA_EQ2_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
@@ -711,7 +711,7 @@ SOC_SINGLE_TLV("EQ2 B4 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ2 B5 Volume", ARIZONA_EQ2_2, ARIZONA_EQ2_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ3 Coefficients", ARIZONA_EQ3_3, 18),
+SND_SOC_BYTES("EQ3 Coefficients", ARIZONA_EQ3_3, 19),
 SOC_SINGLE("EQ3 Mode Switch", ARIZONA_EQ3_2, ARIZONA_EQ3_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ3 B1 Volume", ARIZONA_EQ3_1, ARIZONA_EQ3_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
@@ -724,7 +724,7 @@ SOC_SINGLE_TLV("EQ3 B4 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B4_GAIN_SHIFT,
 SOC_SINGLE_TLV("EQ3 B5 Volume", ARIZONA_EQ3_2, ARIZONA_EQ3_B5_GAIN_SHIFT,
 	       24, 0, eq_tlv),
 
-SND_SOC_BYTES("EQ4 Coefficients", ARIZONA_EQ4_3, 18),
+SND_SOC_BYTES("EQ4 Coefficients", ARIZONA_EQ4_3, 19),
 SOC_SINGLE("EQ4 Mode Switch", ARIZONA_EQ4_2, ARIZONA_EQ4_B1_MODE, 1, 0),
 SOC_SINGLE_TLV("EQ4 B1 Volume", ARIZONA_EQ4_1, ARIZONA_EQ4_B1_GAIN_SHIFT,
 	       24, 0, eq_tlv),
-- 
1.7.2.5
