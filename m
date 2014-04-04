From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/7] ASoC: davinci-mcasp: Add support for I2S
	format
Date: Fri, 4 Apr 2014 14:31:45 +0300
Message-ID: <1396611107-30765-6-git-send-email-peter.ujfalusi@ti.com>
References: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 253052657CE
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 13:32:01 +0200 (CEST)
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

The FS needs to be inverted in McASP compared to other supported formats.
Use a flag to indicate if the FS needs to be inverted.
At the same time fail when non supported format is asked since the default
case was anyways configuring McASP to a not valid format.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 3f67e374829e..af6cca3e61e4 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -266,6 +266,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	int ret = 0;
 	u32 data_delay;
 	bool fs_pol_rising;
+	bool inv_fs = false;
 
 	pm_runtime_get_sync(mcasp->dev);
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -284,14 +285,19 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* No delay after FS */
 		data_delay = 0;
 		break;
-	default:
+	case SND_SOC_DAIFMT_I2S:
 		/* configure a full-word SYNC pulse (LRCLK) */
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
 
 		/* 1st data bit occur one ACLK cycle after the frame sync */
 		data_delay = 1;
+		/* FS need to be inverted */
+		inv_fs = true;
 		break;
+	default:
+		ret = -EINVAL;
+		goto out;
 	}
 
 	mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, FSXDLY(data_delay),
@@ -372,6 +378,9 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		goto out;
 	}
 
+	if (inv_fs)
+		fs_pol_rising = !fs_pol_rising;
+
 	if (fs_pol_rising) {
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
-- 
1.9.1
