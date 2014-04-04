From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/7] ASoC: davinci-mcasp: Support for DSP_A
	format
Date: Fri, 4 Apr 2014 14:31:43 +0300
Message-ID: <1396611107-30765-4-git-send-email-peter.ujfalusi@ti.com>
References: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C7A82657C9
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

DSP_A is like DSP_B mode but with one bit delay after the FS.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index d9ea709cb6d0..7076dba66031 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -268,6 +268,13 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 	pm_runtime_get_sync(mcasp->dev);
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+
+		/* 1st data bit occur one ACLK cycle after the frame sync */
+		data_delay = 1;
+		break;
 	case SND_SOC_DAIFMT_DSP_B:
 	case SND_SOC_DAIFMT_AC97:
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
-- 
1.9.1
