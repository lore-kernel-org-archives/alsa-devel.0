From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/7] ASoC: davinci-mcasp: Move the FS polarity
	change out from the switch case
Date: Fri, 4 Apr 2014 14:31:44 +0300
Message-ID: <1396611107-30765-5-git-send-email-peter.ujfalusi@ti.com>
References: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AF0D2657DB
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 13:31:59 +0200 (CEST)
In-Reply-To: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

FS polarity can be either rising or falling edge in McASP. Instead of
accessing the registers in every switch/case set a flag and write the
registers after the switch for the invert configuration.
This change will help when adding support for more formats also.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 7076dba66031..3f67e374829e 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -265,6 +265,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
 	int ret = 0;
 	u32 data_delay;
+	bool fs_pol_rising;
 
 	pm_runtime_get_sync(mcasp->dev);
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -344,39 +345,39 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_IB_NF:
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
-
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		fs_pol_rising = true;
 		break;
 
 	case SND_SOC_DAIFMT_NB_IF:
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
-
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		fs_pol_rising = false;
 		break;
 
 	case SND_SOC_DAIFMT_IB_IF:
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
-
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		fs_pol_rising = false;
 		break;
 
 	case SND_SOC_DAIFMT_NB_NF:
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
-
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		fs_pol_rising = true;
 		break;
 
 	default:
 		ret = -EINVAL;
-		break;
+		goto out;
+	}
+
+	if (fs_pol_rising) {
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+	} else {
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
 	}
 out:
 	pm_runtime_put_sync(mcasp->dev);
-- 
1.9.1
