From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 14/20] ASoC: davinci-mcasp: Be consistent with
	the use of base in davinci_mcasp_set_dai_fmt
Date: Thu, 14 Nov 2013 11:35:30 +0200
Message-ID: <1384421737-4467-15-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A72F26516B
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:36:13 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Replace mcasp->base use with plain base in the davinci_mcasp_set_dai_fmt()
function since it has been already used by the remaining part of the function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index bd85c98..1341f327 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -243,17 +243,17 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_B:
 	case SND_SOC_DAIFMT_AC97:
-		mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
-		mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+		mcasp_clr_bits(base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_clr_bits(base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
 		break;
 	default:
 		/* configure a full-word SYNC pulse (LRCLK) */
-		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
-		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+		mcasp_set_bits(base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
 
 		/* make 1st data bit occur one ACLK cycle after the frame sync */
-		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_TXFMT_REG, FSXDLY(1));
-		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_RXFMT_REG, FSRDLY(1));
+		mcasp_set_bits(base + DAVINCI_MCASP_TXFMT_REG, FSXDLY(1));
+		mcasp_set_bits(base + DAVINCI_MCASP_RXFMT_REG, FSRDLY(1));
 		break;
 	}
 
-- 
1.8.4.2
