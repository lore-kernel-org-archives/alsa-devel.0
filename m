From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/1] ASoC: Blackfin: update SPORT0 port
	selector (v2)
Date: Mon, 27 Oct 2008 17:09:25 +0800
Message-ID: <1225098565-6848-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id D4B2524698
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 10:08:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

- Setting the TFS pin selector for SPORT 0 based on whether the selected
  port id F or G. If the port is F then no conflict should exist for the
  TFS. When Port G is selected and EMAC then there is a conflict between
  the PHY interrupt line and TFS.  Current settings prevent the conflict
  by ignoring the TFS pin when Port G is selected. This allows both
  ssm2602 using Port G and EMAC concurrently.

 - some code cleanup

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/bf5xx-i2s.c |   34 ++++++++++++++++++++++------------
 1 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 827587f..e020c16 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -70,12 +70,24 @@ static struct sport_param sport_params[2] = {
 	}
 };
 
-static u16 sport_req[][7] = {
-		{ P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
-		  P_SPORT0_DRPRI, P_SPORT0_RSCLK, 0},
-		{ P_SPORT1_DTPRI, P_SPORT1_TSCLK, P_SPORT1_RFS,
-		  P_SPORT1_DRPRI, P_SPORT1_RSCLK, 0},
-};
+/*
+ * Setting the TFS pin selector for SPORT 0 based on whether the selected
+ * port id F or G. If the port is F then no conflict should exist for the
+ * TFS. When Port G is selected and EMAC then there is a conflict between
+ * the PHY interrupt line and TFS.  Current settings prevent the conflict
+ * by ignoring the TFS pin when Port G is selected. This allows both
+ * ssm2602 using Port G and EMAC concurrently.
+ */
+#ifdef CONFIG_BF527_SPORT0_PORTF
+#define LOCAL_SPORT0_TFS (P_SPORT0_TFS)
+#else
+#define LOCAL_SPORT0_TFS (0)
+#endif
+
+static u16 sport_req[][7] = { {P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
+		P_SPORT0_DRPRI, P_SPORT0_RSCLK, LOCAL_SPORT0_TFS, 0},
+		{P_SPORT1_DTPRI, P_SPORT1_TSCLK, P_SPORT1_RFS, P_SPORT1_DRPRI,
+		P_SPORT1_RSCLK, P_SPORT1_TFS, 0} };
 
 static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
@@ -98,23 +110,21 @@ static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		ret = -EINVAL;
 		break;
 	default:
+		printk(KERN_ERR "%s: Unknown DAI format type\n", __func__);
 		ret = -EINVAL;
 		break;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFS:
-		ret = -EINVAL;
-		break;
-	case SND_SOC_DAIFMT_CBM_CFS:
-		ret = -EINVAL;
-		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_CBM_CFS:
 	case SND_SOC_DAIFMT_CBS_CFM:
 		ret = -EINVAL;
 		break;
 	default:
+		printk(KERN_ERR "%s: Unknown DAI master type\n", __func__);
 		ret = -EINVAL;
 		break;
 	}
-- 
1.5.6
