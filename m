From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Fix channel slipping on
	capture (or playback) restart in full duplex." to the asoc tree
Date: Fri, 13 May 2016 13:25:27 +0100
Message-ID: <E1b1C9n-0007L0-AW@finisterre>
References: <1462277640-20052-7-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D8BF26058D
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 14:26:18 +0200 (CEST)
In-Reply-To: <1462277640-20052-7-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, caleb@crome.org, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Fix channel slipping on capture (or playback) restart in full duplex.

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

>From 027db2e122db81b055a2b569d72f2f1d29c4d007 Mon Sep 17 00:00:00 2001
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Date: Tue, 3 May 2016 14:14:00 +0200
Subject: [PATCH] ASoC: fsl_ssi: Fix channel slipping on capture (or playback)
 restart in full duplex.

Happened when the Playback (or Capture) is running continuously
and Capture (or Playback) is restarted (xrun, manual stop/start...)

Since the RX (or TX) FIFO are only reset when the whole SSI is disabled,
pending samples from previous capture (or playback) session may still
be present. They must be erased to not introduce channel slipping.

FIFO Clear register fields are documented in IMX51, IMX35 reference manual.
They are not documented in IMX50 or IMX6 RM, despite they are
working as expected on IMX6SL and IMX6solo.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Caleb Crome <caleb@crome.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 8944af542b4f..d2dd47d2d500 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -401,6 +401,26 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi_private *ssi_private,
 }
 
 /*
+ * Clear RX or TX FIFO to remove samples from the previous
+ * stream session which may be still present in the FIFO and
+ * may introduce bad samples and/or channel slipping.
+ *
+ * Note: The SOR is not documented in recent IMX datasheet, but
+ * is described in IMX51 reference manual at section 56.3.3.15.
+ */
+static void fsl_ssi_fifo_clear(struct fsl_ssi_private *ssi_private,
+		bool is_rx)
+{
+	if (is_rx) {
+		regmap_update_bits(ssi_private->regs, CCSR_SSI_SOR,
+			CCSR_SSI_SOR_RX_CLR, CCSR_SSI_SOR_RX_CLR);
+	} else {
+		regmap_update_bits(ssi_private->regs, CCSR_SSI_SOR,
+			CCSR_SSI_SOR_TX_CLR, CCSR_SSI_SOR_TX_CLR);
+	}
+}
+
+/*
  * Calculate the bits that have to be disabled for the current stream that is
  * getting disabled. This keeps the bits enabled that are necessary for the
  * second stream to work if 'stream_active' is true.
@@ -475,6 +495,8 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 * (online configuration)
 	 */
 	if (enable) {
+		fsl_ssi_fifo_clear(ssi_private, vals->scr & CCSR_SSI_SCR_RE);
+
 		regmap_update_bits(regs, CCSR_SSI_SRCR, vals->srcr, vals->srcr);
 		regmap_update_bits(regs, CCSR_SSI_STCR, vals->stcr, vals->stcr);
 		regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
-- 
2.8.1
