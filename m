From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2 03/16] ASoC: fsl_ssi: Maintain a mask of
	active streams
Date: Wed, 10 Jan 2018 22:43:02 -0800
Message-ID: <1515652995-15996-4-git-send-email-nicoleotsuka@gmail.com>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 13B7F266E70
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 07:44:07 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id u19so875310pfa.12
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 22:44:07 -0800 (PST)
In-Reply-To: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org, broonie@kernel.org, mail@maciej.szmigiero.name
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Checking TE and RE bits in SCR register doesn't work for AC97 mode
which enables SSIEN, TE and RE in the fsl_ssi_setup_ac97() that's
called during probe().

So when running into the trigger(), it will always get the result
of both TE and RE being enabled already, even if actually there is
no active stream.

This patch fixes this issue by adding a variable to log the active
streams manually.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 491b660..aa14a5d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -201,6 +201,7 @@ struct fsl_ssi_soc_data {
  * @cpu_dai_drv: CPU DAI driver for this device
  *
  * @dai_fmt: DAI configuration this device is currently used with
+ * @streams: Mask of current active streams: BIT(TX) and BIT(RX)
  * @i2s_net: I2S and Network mode configurations of SCR register
  * @use_dma: DMA is used or FIQ with stream filter
  * @use_dual_fifo: DMA with support for dual FIFO mode
@@ -245,6 +246,7 @@ struct fsl_ssi {
 	struct snd_soc_dai_driver cpu_dai_drv;
 
 	unsigned int dai_fmt;
+	u8 streams;
 	u8 i2s_net;
 	bool use_dma;
 	bool use_dual_fifo;
@@ -440,15 +442,14 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 			   struct fsl_ssi_regvals *vals)
 {
+	bool dir = (&ssi->regvals[TX] == vals) ? TX : RX;
 	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_regvals *avals;
 	int nr_active_streams;
-	u32 scr;
 	int keep_active;
 
-	regmap_read(regs, REG_SSI_SCR, &scr);
-
-	nr_active_streams = !!(scr & SSI_SCR_TE) + !!(scr & SSI_SCR_RE);
+	nr_active_streams = !!(ssi->streams & BIT(TX)) +
+			    !!(ssi->streams & BIT(RX));
 
 	if (nr_active_streams - 1 > 0)
 		keep_active = 1;
@@ -470,6 +471,9 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 					      keep_active);
 		/* Safely disable SCR register for the stream */
 		regmap_update_bits(regs, REG_SSI_SCR, scr, 0);
+
+		/* Log the disabled stream to the mask */
+		ssi->streams &= ~BIT(dir);
 	}
 
 	/*
@@ -545,6 +549,9 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		}
 		/* Enable all remaining bits */
 		regmap_update_bits(regs, REG_SSI_SCR, vals->scr, vals->scr);
+
+		/* Log the enabled stream to the mask */
+		ssi->streams |= BIT(dir);
 	}
 }
 
-- 
2.7.4
