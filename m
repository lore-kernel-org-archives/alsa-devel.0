From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5110: Add OUT3R support
Date: Wed, 26 Sep 2012 19:01:24 +0100
Message-ID: <1348682484-18929-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1348682484-18929-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 74DCC262612
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2012 20:01:27 +0200 (CEST)
In-Reply-To: <1348682484-18929-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm5110.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index e64e769..de60952 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -538,6 +538,9 @@ SND_SOC_DAPM_PGA_E("OUT2R", ARIZONA_OUTPUT_ENABLES_1,
 SND_SOC_DAPM_PGA_E("OUT3L", ARIZONA_OUTPUT_ENABLES_1,
 		   ARIZONA_OUT3L_ENA_SHIFT, 0, NULL, 0, arizona_out_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_PGA_E("OUT3R", ARIZONA_OUTPUT_ENABLES_1,
+		   ARIZONA_OUT3R_ENA_SHIFT, 0, NULL, 0, arizona_out_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_PGA_E("OUT4L", ARIZONA_OUTPUT_ENABLES_1,
 		   ARIZONA_OUT4L_ENA_SHIFT, 0, NULL, 0, arizona_out_ev,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
@@ -711,6 +714,7 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "OUT2L", NULL, "CPVDD" },
 	{ "OUT2R", NULL, "CPVDD" },
 	{ "OUT3L", NULL, "CPVDD" },
+	{ "OUT3R", NULL, "CPVDD" },
 
 	{ "OUT4L", NULL, "SPKVDDL" },
 	{ "OUT4R", NULL, "SPKVDDR" },
-- 
1.7.10.4
