From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Change
	__davinci_mcasp_set_clkdiv() first parameter" to the asoc tree
Date: Tue, 10 May 2016 19:49:50 +0100
Message-ID: <E1b0Cj8-0008D7-D2@debutante>
References: <1462790552-6438-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 563872674FE
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 20:49:57 +0200 (CEST)
In-Reply-To: <1462790552-6438-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Change __davinci_mcasp_set_clkdiv() first parameter

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

>From 226e73e23b6b7f7d6df47562a7555ddb121163cf Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 9 May 2016 13:42:30 +0300
Subject: [PATCH] ASoC: davinci-mcasp: Change __davinci_mcasp_set_clkdiv()
 first parameter

Change the first parameter to struct davinci_mcasp* from
struct snd_soc_dai*
The function internally does not use or need the DAI information.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index adf1c3941f23..99061c4f3257 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -540,11 +540,9 @@ out:
 	return ret;
 }
 
-static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
+static int __davinci_mcasp_set_clkdiv(struct davinci_mcasp *mcasp, int div_id,
 				      int div, bool explicit)
 {
-	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
-
 	pm_runtime_get_sync(mcasp->dev);
 	switch (div_id) {
 	case MCASP_CLKDIV_AUXCLK:			/* MCLK divider */
@@ -592,7 +590,9 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
 static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
 				    int div)
 {
-	return __davinci_mcasp_set_clkdiv(dai, div_id, div, 1);
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
+
+	return __davinci_mcasp_set_clkdiv(mcasp, div_id, div, 1);
 }
 
 static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
@@ -1056,7 +1056,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 			dev_info(mcasp->dev, "Sample-rate is off by %d PPM\n",
 				 ppm);
 
-		__davinci_mcasp_set_clkdiv(cpu_dai, 1, div, 0);
+		__davinci_mcasp_set_clkdiv(mcasp, 1, div, 0);
 	}
 
 	ret = mcasp_common_hw_param(mcasp, substream->stream,
-- 
2.8.1
