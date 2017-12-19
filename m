From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Rename scr_val to scr" to the
	asoc tree
Date: Tue, 19 Dec 2017 10:59:45 +0000
Message-ID: <E1eRFcf-0000tY-5V@debutante>
References: <1513207108-30430-9-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 67B632676B4
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 11:59:50 +0100 (CET)
In-Reply-To: <1513207108-30430-9-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, arnaud.mouiche@invoxia.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, mail@maciej.szmigiero.name, caleb@crome.org, timur@tabi.org, broonie@kernel.org, kernel@pengutronix.de, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Rename scr_val to scr

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From ff4adb090066c1636a43b88a497c34d2bd2312ec Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Sun, 17 Dec 2017 18:52:07 -0800
Subject: [PATCH] ASoC: fsl_ssi: Rename scr_val to scr

Simplify the variable name. This reduces one over-80-character line.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Timur Tabi <timur@tabi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 237302fb9279..af3ba718d4bb 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -451,12 +451,12 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_reg_val *avals;
 	int nr_active_streams;
-	u32 scr_val;
+	u32 scr;
 	int keep_active;
 
-	regmap_read(regs, REG_SSI_SCR, &scr_val);
+	regmap_read(regs, REG_SSI_SCR, &scr);
 
-	nr_active_streams = !!(scr_val & SSI_SCR_TE) + !!(scr_val & SSI_SCR_RE);
+	nr_active_streams = !!(scr & SSI_SCR_TE) + !!(scr & SSI_SCR_RE);
 
 	if (nr_active_streams - 1 > 0)
 		keep_active = 1;
@@ -810,11 +810,11 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	unsigned int sample_size = params_width(hw_params);
 	u32 wl = SSI_SxCCR_WL(sample_size);
 	int ret;
-	u32 scr_val;
+	u32 scr;
 	int enabled;
 
-	regmap_read(regs, REG_SSI_SCR, &scr_val);
-	enabled = scr_val & SSI_SCR_SSIEN;
+	regmap_read(regs, REG_SSI_SCR, &scr);
+	enabled = scr & SSI_SCR_SSIEN;
 
 	/*
 	 * SSI is properly configured if it is enabled and running in
-- 
2.15.1
