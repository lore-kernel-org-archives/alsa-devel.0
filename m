From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5677: Correct the routing paths of
	that after IF1/2 DACx Mux
Date: Wed, 25 Feb 2015 17:36:13 +0800
Message-ID: <1424856974-18763-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 093E52605D1
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 10:36:26 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch corrects the routing paths of that after IF1/2 DACx Mux

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index ab62777..f87c929 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3297,8 +3297,8 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "IB45 Bypass Mux", "Bypass", "IB45 Mux" },
 	{ "IB45 Bypass Mux", "Pass SRC", "IB45 Mux" },
 
-	{ "IB6 Mux", "IF1 DAC 6", "IF1 DAC6" },
-	{ "IB6 Mux", "IF2 DAC 6", "IF2 DAC6" },
+	{ "IB6 Mux", "IF1 DAC 6", "IF1 DAC6 Mux" },
+	{ "IB6 Mux", "IF2 DAC 6", "IF2 DAC6 Mux" },
 	{ "IB6 Mux", "SLB DAC 6", "SLB DAC6" },
 	{ "IB6 Mux", "STO4 ADC MIX L", "Stereo4 ADC MIXL" },
 	{ "IB6 Mux", "IF4 DAC L", "IF4 DAC L" },
@@ -3306,8 +3306,8 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "IB6 Mux", "STO2 ADC MIX L", "Stereo2 ADC MIXL" },
 	{ "IB6 Mux", "STO3 ADC MIX L", "Stereo3 ADC MIXL" },
 
-	{ "IB7 Mux", "IF1 DAC 7", "IF1 DAC7" },
-	{ "IB7 Mux", "IF2 DAC 7", "IF2 DAC7" },
+	{ "IB7 Mux", "IF1 DAC 7", "IF1 DAC7 Mux" },
+	{ "IB7 Mux", "IF2 DAC 7", "IF2 DAC7 Mux" },
 	{ "IB7 Mux", "SLB DAC 7", "SLB DAC7" },
 	{ "IB7 Mux", "STO4 ADC MIX R", "Stereo4 ADC MIXR" },
 	{ "IB7 Mux", "IF4 DAC R", "IF4 DAC R" },
@@ -3648,15 +3648,15 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "DAC1 FS", NULL, "DAC1 MIXL" },
 	{ "DAC1 FS", NULL, "DAC1 MIXR" },
 
-	{ "DAC2 L Mux", "IF1 DAC 2", "IF1 DAC2" },
-	{ "DAC2 L Mux", "IF2 DAC 2", "IF2 DAC2" },
+	{ "DAC2 L Mux", "IF1 DAC 2", "IF1 DAC2 Mux" },
+	{ "DAC2 L Mux", "IF2 DAC 2", "IF2 DAC2 Mux" },
 	{ "DAC2 L Mux", "IF3 DAC L", "IF3 DAC L" },
 	{ "DAC2 L Mux", "IF4 DAC L", "IF4 DAC L" },
 	{ "DAC2 L Mux", "SLB DAC 2", "SLB DAC2" },
 	{ "DAC2 L Mux", "OB 2", "OutBound2" },
 
-	{ "DAC2 R Mux", "IF1 DAC 3", "IF1 DAC3" },
-	{ "DAC2 R Mux", "IF2 DAC 3", "IF2 DAC3" },
+	{ "DAC2 R Mux", "IF1 DAC 3", "IF1 DAC3 Mux" },
+	{ "DAC2 R Mux", "IF2 DAC 3", "IF2 DAC3 Mux" },
 	{ "DAC2 R Mux", "IF3 DAC R", "IF3 DAC R" },
 	{ "DAC2 R Mux", "IF4 DAC R", "IF4 DAC R" },
 	{ "DAC2 R Mux", "SLB DAC 3", "SLB DAC3" },
@@ -3664,29 +3664,29 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "DAC2 R Mux", "Haptic Generator", "Haptic Generator" },
 	{ "DAC2 R Mux", "VAD ADC", "VAD ADC Mux" },
 
-	{ "DAC3 L Mux", "IF1 DAC 4", "IF1 DAC4" },
-	{ "DAC3 L Mux", "IF2 DAC 4", "IF2 DAC4" },
+	{ "DAC3 L Mux", "IF1 DAC 4", "IF1 DAC4 Mux" },
+	{ "DAC3 L Mux", "IF2 DAC 4", "IF2 DAC4 Mux" },
 	{ "DAC3 L Mux", "IF3 DAC L", "IF3 DAC L" },
 	{ "DAC3 L Mux", "IF4 DAC L", "IF4 DAC L" },
 	{ "DAC3 L Mux", "SLB DAC 4", "SLB DAC4" },
 	{ "DAC3 L Mux", "OB 4", "OutBound4" },
 
-	{ "DAC3 R Mux", "IF1 DAC 5", "IF1 DAC4" },
-	{ "DAC3 R Mux", "IF2 DAC 5", "IF2 DAC4" },
+	{ "DAC3 R Mux", "IF1 DAC 5", "IF1 DAC5 Mux" },
+	{ "DAC3 R Mux", "IF2 DAC 5", "IF2 DAC5 Mux" },
 	{ "DAC3 R Mux", "IF3 DAC R", "IF3 DAC R" },
 	{ "DAC3 R Mux", "IF4 DAC R", "IF4 DAC R" },
 	{ "DAC3 R Mux", "SLB DAC 5", "SLB DAC5" },
 	{ "DAC3 R Mux", "OB 5", "OutBound5" },
 
-	{ "DAC4 L Mux", "IF1 DAC 6", "IF1 DAC6" },
-	{ "DAC4 L Mux", "IF2 DAC 6", "IF2 DAC6" },
+	{ "DAC4 L Mux", "IF1 DAC 6", "IF1 DAC6 Mux" },
+	{ "DAC4 L Mux", "IF2 DAC 6", "IF2 DAC6 Mux" },
 	{ "DAC4 L Mux", "IF3 DAC L", "IF3 DAC L" },
 	{ "DAC4 L Mux", "IF4 DAC L", "IF4 DAC L" },
 	{ "DAC4 L Mux", "SLB DAC 6", "SLB DAC6" },
 	{ "DAC4 L Mux", "OB 6", "OutBound6" },
 
-	{ "DAC4 R Mux", "IF1 DAC 7", "IF1 DAC7" },
-	{ "DAC4 R Mux", "IF2 DAC 7", "IF2 DAC7" },
+	{ "DAC4 R Mux", "IF1 DAC 7", "IF1 DAC7 Mux" },
+	{ "DAC4 R Mux", "IF2 DAC 7", "IF2 DAC7 Mux" },
 	{ "DAC4 R Mux", "IF3 DAC R", "IF3 DAC R" },
 	{ "DAC4 R Mux", "IF4 DAC R", "IF4 DAC R" },
 	{ "DAC4 R Mux", "SLB DAC 7", "SLB DAC7" },
-- 
1.8.1.1.439.g50a6b54
