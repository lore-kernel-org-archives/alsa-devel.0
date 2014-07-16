From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: mcasp: don't override bclk divider if it
	was provided by the machine
Date: Wed, 16 Jul 2014 14:04:41 +0200
Message-ID: <1405512281-8188-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E28A2619E9
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 14:04:50 +0200 (CEST)
Received: by mail-wi0-f172.google.com with SMTP id n3so6017342wiv.17
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 05:04:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

If a machine driver provides an BCLK divider to the McASP driver, skip the
automatic calculation.

This fixes machines on which the physical sample transport always works
in 32 bits, even though not all of them are actually used.
snd_soc_params_to_bclk() will fail to address such cases properly.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/davinci/davinci-mcasp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 0518f27..dbeb4fd 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -64,6 +64,7 @@ struct davinci_mcasp {
 	u8	num_serializer;
 	u8	*serial_dir;
 	u8	version;
+	u8	bclk_div;
 	u16	bclk_lrclk_ratio;
 	int	streams;
 
@@ -420,6 +421,7 @@ static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div
 			       ACLKXDIV(div - 1), ACLKXDIV_MASK);
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG,
 			       ACLKRDIV(div - 1), ACLKRDIV_MASK);
+		mcasp->bclk_div = div;
 		break;
 
 	case 2:		/* BCLK/LRCLK ratio */
@@ -722,8 +724,11 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	int period_size = params_period_size(params);
 	int ret;
 
-	/* If mcasp is BCLK master we need to set BCLK divider */
-	if (mcasp->bclk_master) {
+	/*
+	 * If mcasp is BCLK master, and a BCLK divider was not provided by
+	 * the machine driver, we need to calculate the ratio.
+	 */
+	if (mcasp->bclk_master && mcasp->bclk_div == 0) {
 		unsigned int bclk_freq = snd_soc_params_to_bclk(params);
 		if (mcasp->sysclk_freq % bclk_freq != 0) {
 			dev_err(mcasp->dev, "Can't produce required BCLK\n");
-- 
1.9.3
