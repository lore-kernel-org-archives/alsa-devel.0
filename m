From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Use defines for clkdiv
	IDs" to the asoc tree
Date: Tue, 10 May 2016 19:49:53 +0100
Message-ID: <E1b0CjB-0008IJ-Cs@debutante>
References: <1462790552-6438-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B2DF267502
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 20:49:59 +0200 (CEST)
In-Reply-To: <1462790552-6438-2-git-send-email-peter.ujfalusi@ti.com>
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

   ASoC: davinci-mcasp: Use defines for clkdiv IDs

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

>From 20d4b10730183a02851580f072bd9b0122873dc5 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 9 May 2016 13:42:29 +0300
Subject: [PATCH] ASoC: davinci-mcasp: Use defines for clkdiv IDs

Instead of hardwired IDs add defines for the available dividers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 7 ++++---
 sound/soc/davinci/davinci-mcasp.h | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 020d8660e4e5..adf1c3941f23 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -547,14 +547,14 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
 
 	pm_runtime_get_sync(mcasp->dev);
 	switch (div_id) {
-	case 0:		/* MCLK divider */
+	case MCASP_CLKDIV_AUXCLK:			/* MCLK divider */
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
 			       AHCLKXDIV(div - 1), AHCLKXDIV_MASK);
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG,
 			       AHCLKRDIV(div - 1), AHCLKRDIV_MASK);
 		break;
 
-	case 1:		/* BCLK divider */
+	case MCASP_CLKDIV_BCLK:			/* BCLK divider */
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG,
 			       ACLKXDIV(div - 1), ACLKXDIV_MASK);
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG,
@@ -563,7 +563,8 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
 			mcasp->bclk_div = div;
 		break;
 
-	case 2:	/*
+	case MCASP_CLKDIV_BCLK_FS_RATIO:
+		/*
 		 * BCLK/LRCLK ratio descries how many bit-clock cycles
 		 * fit into one frame. The clock ratio is given for a
 		 * full period of data (for I2S format both left and
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index a3be108a8c17..1e8787fb3fb7 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -306,4 +306,9 @@
 #define NUMEVT(x)	(((x) & 0xFF) << 8)
 #define NUMDMA_MASK	(0xFF)
 
+/* clock divider IDs */
+#define MCASP_CLKDIV_AUXCLK		0 /* HCLK divider from AUXCLK */
+#define MCASP_CLKDIV_BCLK		1 /* BCLK divider from HCLK */
+#define MCASP_CLKDIV_BCLK_FS_RATIO	2 /* to set BCLK FS ration */
+
 #endif	/* DAVINCI_MCASP_H */
-- 
2.8.1
