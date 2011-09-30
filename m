From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 1/3] ASoC: omap-mcbsp: Prepare for init time
	DAI format setting
Date: Fri, 30 Sep 2011 16:07:44 +0300
Message-ID: <1317388066-28443-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id AD50C103B91
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 15:08:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Before commit 75d9ac4 ("ASoC: Allow DAI formats to be specified in the
dai_link") expectation for omap-mcbsp was that snd_soc_dai_set_fmt is to be
called first in machine hw_params callback before other CPU DAI functions.
Thus it was enough that only omap_mcbsp_dai_set_dai_fmt cleared the
mcbsp->regs structure.

Now this doesn't hold anymore since machine drivers can set the DAI format
only once on init time and thus mcbsp->regs may get out of sync when other
CPU DAI functions are modifying them dynamically with different values
between the calls. Therefore clear the accessed mcbsp->regs bits and
bitfields in other functions too.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 894f2f3..7f70061 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -317,6 +317,10 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
+	regs->rcr2	&= ~(RPHASE | RFRLEN2(0x7f) | RWDLEN2(7));
+	regs->xcr2	&= ~(RPHASE | XFRLEN2(0x7f) | XWDLEN2(7));
+	regs->rcr1	&= ~(RFRLEN1(0x7f) | RWDLEN1(7));
+	regs->xcr1	&= ~(XFRLEN1(0x7f) | XWDLEN1(7));
 	format = mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 	wpf = channels = params_channels(params);
 	if (channels == 2 && (format == SND_SOC_DAIFMT_I2S ||
@@ -369,6 +373,8 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		framesize = wlen * channels;
 
 	/* Set FS period and length in terms of bit clock periods */
+	regs->srgr2	&= ~FPER(0xfff);
+	regs->srgr1	&= ~FWID(0xff);
 	switch (format) {
 	case SND_SOC_DAIFMT_I2S:
 	case SND_SOC_DAIFMT_LEFT_J:
@@ -505,6 +511,7 @@ static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
 		return -ENODEV;
 
 	mcbsp_data->clk_div = div;
+	regs->srgr1	&= ~CLKGDV(0xff);
 	regs->srgr1	|= CLKGDV(div - 1);
 
 	return 0;
@@ -534,6 +541,8 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 			return -EINVAL;
 
 	mcbsp_data->in_freq = freq;
+	regs->srgr2	&= ~CLKSM;
+	regs->pcr0	&= ~SCLKME;
 
 	switch (clk_id) {
 	case OMAP_MCBSP_SYSCLK_CLK:
-- 
1.7.6.3
