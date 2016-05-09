From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] ASoC: davinci-mcasp: Change
	__davinci_mcasp_set_clkdiv() first parameter
Date: Mon, 9 May 2016 13:42:30 +0300
Message-ID: <1462790552-6438-3-git-send-email-peter.ujfalusi@ti.com>
References: <1462790552-6438-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 52F6126578F
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 12:42:40 +0200 (CEST)
In-Reply-To: <1462790552-6438-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Change the first parameter to struct davinci_mcasp* from
struct snd_soc_dai*
The function internally does not use or need the DAI information.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 836f694e4b9d..47be74d74384 100644
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
2.8.2
