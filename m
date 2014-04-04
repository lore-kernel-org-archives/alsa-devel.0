From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 7/7] ASoC: davinci-mcasp: Remove excess empty
	lines from davinci_mcasp_set_dai_fmt()
Date: Fri, 4 Apr 2014 14:31:47 +0300
Message-ID: <1396611107-30765-8-git-send-email-peter.ujfalusi@ti.com>
References: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FE022657F3
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 13:32:06 +0200 (CEST)
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

To make the code look uniform.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index da9533b8e2dd..ce0e55a4304c 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -273,7 +273,6 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	case SND_SOC_DAIFMT_DSP_A:
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
-
 		/* 1st data bit occur one ACLK cycle after the frame sync */
 		data_delay = 1;
 		break;
@@ -281,7 +280,6 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	case SND_SOC_DAIFMT_AC97:
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
-
 		/* No delay after FS */
 		data_delay = 0;
 		break;
@@ -289,7 +287,6 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* configure a full-word SYNC pulse (LRCLK) */
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
-
 		/* 1st data bit occur one ACLK cycle after the frame sync */
 		data_delay = 1;
 		/* FS need to be inverted */
@@ -349,7 +346,6 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 			       ACLKX | AHCLKX | AFSX | ACLKR | AHCLKR | AFSR);
 		mcasp->bclk_master = 0;
 		break;
-
 	default:
 		ret = -EINVAL;
 		goto out;
@@ -361,25 +357,21 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
 		fs_pol_rising = true;
 		break;
-
 	case SND_SOC_DAIFMT_NB_IF:
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
 		fs_pol_rising = false;
 		break;
-
 	case SND_SOC_DAIFMT_IB_IF:
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
 		fs_pol_rising = false;
 		break;
-
 	case SND_SOC_DAIFMT_NB_NF:
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
 		fs_pol_rising = true;
 		break;
-
 	default:
 		ret = -EINVAL;
 		goto out;
-- 
1.9.1
