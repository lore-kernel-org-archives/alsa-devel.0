From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ASoC: mpc8610: tell the CS4270 codec that it's
	the master
Date: Tue, 22 Nov 2011 14:38:59 -0600
Message-ID: <1321994339-21906-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CED9103807
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 21:39:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit ac601555 ("ASoC: Return early with -EINVAL if invalid dai format is
detected") requires the machine driver to tell the CS4270 codec driver
whether the CS4270 should be configured for master or slave operation.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/mpc8610_hpcd.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 31af405..ae49f1c 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -392,7 +392,8 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	}
 
 	if (strcasecmp(sprop, "i2s-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_I2S;
+		machine_data->dai_format =
+			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
 
@@ -409,31 +410,38 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 		}
 		machine_data->clk_frequency = be32_to_cpup(iprop);
 	} else if (strcasecmp(sprop, "i2s-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_I2S;
+		machine_data->dai_format =
+			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "lj-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
+		machine_data->dai_format =
+			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBM_CFM;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "lj-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
+		machine_data->dai_format =
+			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBS_CFS;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "rj-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+		machine_data->dai_format =
+			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBM_CFM;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "rj-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+		machine_data->dai_format =
+			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBS_CFS;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "ac97-slave") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_AC97;
+		machine_data->dai_format =
+			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBM_CFM;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "ac97-master") == 0) {
-		machine_data->dai_format = SND_SOC_DAIFMT_AC97;
+		machine_data->dai_format =
+			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBS_CFS;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else {
-- 
1.7.3.4
