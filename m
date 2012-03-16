From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ASoC: fsl: p1022ds: tell the WM8776 codec
	driver that it's the master
Date: Fri, 16 Mar 2012 16:32:52 -0500
Message-ID: <1331933572-20658-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe002.messaging.microsoft.com [216.32.180.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 086F0243F5
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 22:33:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com, shawn.guo@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The WM8776 codec driver requires the machine driver to set one of the
SND_SOC_DAIFMT_CBx_xxx values.  The P1022DS machine driver should be setting
SND_SOC_DAIFMT_CBM_CFM, but since that value was zero, no one noticed.

Commit 75d9ac46 ("ASoC: Allow DAI formats to be specified in the
dai_link"), however, changed the value of SND_SOC_DAIFMT_CBM_CFM from zero
to a non-zero value, which means that it now needs to be specifically set
by the machine driver.

We also set SND_SOC_DAIFMT_NB_NF, for the same reason.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch should be applied on top of Shawn's patchset "[PATCH v5] ASoC: add
imx-sgtl5000 machine driver working with fsl_ssi", but it may also need to
be back-ported to kernel 3.3.

 sound/soc/fsl/p1022_ds.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 0f42f31..2022985 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -255,7 +255,8 @@ static int p1022_ds_probe(struct platform_device *pdev)
 	}
 
 	if (strcasecmp(sprop, "i2s-slave") == 0) {
-		mdata->dai_format = SND_SOC_DAIFMT_I2S;
+		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;
 
@@ -272,31 +273,38 @@ static int p1022_ds_probe(struct platform_device *pdev)
 		}
 		mdata->clk_frequency = be32_to_cpup(iprop);
 	} else if (strcasecmp(sprop, "i2s-master") == 0) {
-		mdata->dai_format = SND_SOC_DAIFMT_I2S;
+		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_IN;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "lj-slave") == 0) {
-		mdata->dai_format = SND_SOC_DAIFMT_LEFT_J;
+		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBM_CFM;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "lj-master") == 0) {
-		mdata->dai_format = SND_SOC_DAIFMT_LEFT_J;
+		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBS_CFS;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_IN;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "rj-slave") == 0) {
-		mdata->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBM_CFM;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "rj-master") == 0) {
-		mdata->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBS_CFS;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_IN;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "ac97-slave") == 0) {
-		mdata->dai_format = SND_SOC_DAIFMT_AC97;
+		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBM_CFM;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "ac97-master") == 0) {
-		mdata->dai_format = SND_SOC_DAIFMT_AC97;
+		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBS_CFS;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_IN;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else {
-- 
1.7.10.rc1.8.ga99c5.dirty
