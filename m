From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: dai format runtime
	reconfiguration
Date: Fri, 11 Mar 2016 13:18:51 +0200
Message-ID: <1457695131-4841-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 03BD22608B4
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 12:19:05 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In case when the dai format is set via the dai_link the format
configuration happens once when the links are probed. If the McASP lose
context after this, the information will be lost and McASP will not going
to work correctly.
To overcome this issue, we save the fmt and set it within hw_params as
well.

Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 1bd86c8e7bc8..b0d1b9f93fa1 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -78,6 +78,7 @@ struct davinci_mcasp {
 	u32 fifo_base;
 	struct device *dev;
 	struct snd_pcm_substream *substreams[2];
+	unsigned int dai_fmt;
 
 	/* McASP specific data */
 	int	tdm_slots;
@@ -399,6 +400,9 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	bool fs_pol_rising;
 	bool inv_fs = false;
 
+	if (!fmt)
+		return 0;
+
 	pm_runtime_get_sync(mcasp->dev);
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
@@ -530,6 +534,8 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
 	}
+
+	mcasp->dai_fmt = fmt;
 out:
 	pm_runtime_put(mcasp->dev);
 	return ret;
@@ -1048,6 +1054,10 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	int period_size = params_period_size(params);
 	int ret;
 
+	ret = davinci_mcasp_set_dai_fmt(cpu_dai, mcasp->dai_fmt);
+	if (ret)
+		return ret;
+
 	/*
 	 * If mcasp is BCLK master, and a BCLK divider was not provided by
 	 * the machine driver, we need to calculate the ratio.
-- 
2.7.2
