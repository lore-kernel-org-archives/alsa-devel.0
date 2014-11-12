From: <bardliao@realtek.com>
Subject: [PATCH 4/4] ASoC:rt5670:change dapm routes of PLL
	connection
Date: Wed, 12 Nov 2014 14:21:32 +0800
Message-ID: <1415773292-2299-4-git-send-email-bardliao@realtek.com>
References: <1415773292-2299-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C1810265275
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 07:22:02 +0100 (CET)
In-Reply-To: <1415773292-2299-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

PLL should be powered up once filter power is on. So, "PLL1"
should be connected to filters instead of DACs.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index c3914e8..c4d4e3f 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1927,6 +1927,10 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 	{ "DAC1 MIXR", "DAC1 Switch", "DAC1 R Mux" },
 	{ "DAC1 MIXR", NULL, "DAC Stereo1 Filter" },
 
+	{ "DAC Stereo1 Filter", NULL, "PLL1", is_sys_clk_from_pll },
+	{ "DAC Mono Left Filter", NULL, "PLL1", is_sys_clk_from_pll },
+	{ "DAC Mono Right Filter", NULL, "PLL1", is_sys_clk_from_pll },
+
 	{ "DAC MIX", NULL, "DAC1 MIXL" },
 	{ "DAC MIX", NULL, "DAC1 MIXR" },
 
@@ -1976,14 +1980,10 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 
 	{ "DAC L1", NULL, "DAC L1 Power" },
 	{ "DAC L1", NULL, "Stereo DAC MIXL" },
-	{ "DAC L1", NULL, "PLL1", is_sys_clk_from_pll },
 	{ "DAC R1", NULL, "DAC R1 Power" },
 	{ "DAC R1", NULL, "Stereo DAC MIXR" },
-	{ "DAC R1", NULL, "PLL1", is_sys_clk_from_pll },
 	{ "DAC L2", NULL, "Mono DAC MIXL" },
-	{ "DAC L2", NULL, "PLL1", is_sys_clk_from_pll },
 	{ "DAC R2", NULL, "Mono DAC MIXR" },
-	{ "DAC R2", NULL, "PLL1", is_sys_clk_from_pll },
 
 	{ "OUT MIXL", "BST1 Switch", "BST1" },
 	{ "OUT MIXL", "INL Switch", "INL VOL" },
-- 
1.8.1.1.439.g50a6b54
