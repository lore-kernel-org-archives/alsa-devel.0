From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/6] ASoC: davinci-mcasp: Fix debug typo in
	davinci_mcasp_hw_params()
Date: Tue, 1 Apr 2014 15:55:08 +0300
Message-ID: <1396356912-30466-3-git-send-email-peter.ujfalusi@ti.com>
References: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 31FBE2652CE
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 14:55:23 +0200 (CEST)
In-Reply-To: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: detheridge@ti.com, alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

requred -> required

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 5a83fac15089..4007b1f3141b 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -656,7 +656,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	if (mcasp->bclk_master) {
 		unsigned int bclk_freq = snd_soc_params_to_bclk(params);
 		if (mcasp->sysclk_freq % bclk_freq != 0) {
-			dev_err(mcasp->dev, "Can't produce requred BCLK\n");
+			dev_err(mcasp->dev, "Can't produce required BCLK\n");
 			return -EINVAL;
 		}
 		davinci_mcasp_set_clkdiv(
-- 
1.9.1
