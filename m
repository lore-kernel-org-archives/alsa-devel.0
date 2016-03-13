From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: dai format runtime
	reconfiguration" to the asoc tree
Date: Sun, 13 Mar 2016 15:15:13 +0700
Message-ID: <E1af1BB-0004Ll-9n@finisterre>
References: <1457695131-4841-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 607CA2619FA
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 09:15:21 +0100 (CET)
In-Reply-To: <1457695131-4841-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Misael Lopez Cruz <misael.lopez@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: dai format runtime reconfiguration

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4a11ff260053b1097a5afa6c51e8d5e064aa88a7 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 11 Mar 2016 13:18:51 +0200
Subject: [PATCH] ASoC: davinci-mcasp: dai format runtime reconfiguration

In case when the dai format is set via the dai_link the format
configuration happens once when the links are probed. If the McASP lose
context after this, the information will be lost and McASP will not going
to work correctly.
To overcome this issue, we save the fmt and set it within hw_params as
well.

Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 3cf46afb353f..e1324989bd6b 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -77,6 +77,7 @@ struct davinci_mcasp {
 	u32 fifo_base;
 	struct device *dev;
 	struct snd_pcm_substream *substreams[2];
+	unsigned int dai_fmt;
 
 	/* McASP specific data */
 	int	tdm_slots;
@@ -398,6 +399,9 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	bool fs_pol_rising;
 	bool inv_fs = false;
 
+	if (!fmt)
+		return 0;
+
 	pm_runtime_get_sync(mcasp->dev);
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
@@ -529,6 +533,8 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
 	}
+
+	mcasp->dai_fmt = fmt;
 out:
 	pm_runtime_put(mcasp->dev);
 	return ret;
@@ -1026,6 +1032,10 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
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
2.7.0
