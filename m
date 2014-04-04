From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/7] ASoC: davinci-mcasp: Format data delay
	configuration enhancement
Date: Fri, 4 Apr 2014 14:31:42 +0300
Message-ID: <1396611107-30765-3-git-send-email-peter.ujfalusi@ti.com>
References: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 290F02657D4
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 13:31:55 +0200 (CEST)
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

Use intermediate variable for the data delay needed for the specific format
and write the register after the format configuration at once.
This will help to control the number of lines as support for more formats
going to be added.
Also fixes a case when we switch between two formats with different delay
requirements.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 95b38f74e2af..d9ea709cb6d0 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -264,6 +264,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
 	int ret = 0;
+	u32 data_delay;
 
 	pm_runtime_get_sync(mcasp->dev);
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -271,18 +272,25 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	case SND_SOC_DAIFMT_AC97:
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+
+		/* No delay after FS */
+		data_delay = 0;
 		break;
 	default:
 		/* configure a full-word SYNC pulse (LRCLK) */
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
 
-		/* make 1st data bit occur one ACLK cycle after the frame sync */
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, FSXDLY(1));
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, FSRDLY(1));
+		/* 1st data bit occur one ACLK cycle after the frame sync */
+		data_delay = 1;
 		break;
 	}
 
+	mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, FSXDLY(data_delay),
+		       FSXDLY(3));
+	mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, FSRDLY(data_delay),
+		       FSRDLY(3));
+
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		/* codec is clock and frame slave */
-- 
1.9.1
