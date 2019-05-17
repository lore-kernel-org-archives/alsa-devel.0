From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Date: Fri, 17 May 2019 03:09:22 +0000
Message-ID: <20190517030903.25731-1-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <CD952D0B5BE728489F6FFD2DDF2D3DA2@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

There is chip errata ERR008000, the reference doc is
(https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf),

The issue is "While using ESAI transmit or receive and
an underrun/overrun happens, channel swap may occur.
The only recovery mechanism is to reset the ESAI."

In this commit add a tasklet to handle reset of ESAI
after xrun happens

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_esai.c | 166 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 10d2210c91ef..149972894c95 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -52,17 +52,20 @@ struct fsl_esai {
 	struct clk *extalclk;
 	struct clk *fsysclk;
 	struct clk *spbaclk;
+	struct tasklet_struct task;
 	u32 fifo_depth;
 	u32 slot_width;
 	u32 slots;
 	u32 tx_mask;
 	u32 rx_mask;
+	u32 tx_channels;
 	u32 hck_rate[2];
 	u32 sck_rate[2];
 	bool hck_dir[2];
 	bool sck_div[2];
 	bool slave_mode;
 	bool synchronous;
+	bool reset_at_xrun;
 	char name[32];
 };
=20
@@ -71,8 +74,14 @@ static irqreturn_t esai_isr(int irq, void *devid)
 	struct fsl_esai *esai_priv =3D (struct fsl_esai *)devid;
 	struct platform_device *pdev =3D esai_priv->pdev;
 	u32 esr;
+	u32 saisr;
=20
 	regmap_read(esai_priv->regmap, REG_ESAI_ESR, &esr);
+	regmap_read(esai_priv->regmap, REG_ESAI_SAISR, &saisr);
+
+	if ((saisr & (ESAI_SAISR_TUE | ESAI_SAISR_ROE))
+		&& esai_priv->reset_at_xrun)
+		tasklet_schedule(&esai_priv->task);
=20
 	if (esr & ESAI_ESR_TINIT_MASK)
 		dev_dbg(&pdev->dev, "isr: Transmission Initialized\n");
@@ -552,6 +561,9 @@ static int fsl_esai_trigger(struct snd_pcm_substream *s=
ubstream, int cmd,
 	u32 pins =3D DIV_ROUND_UP(channels, esai_priv->slots);
 	u32 mask;
=20
+	if (tx)
+		esai_priv->tx_channels =3D channels;
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -585,10 +597,16 @@ static int fsl_esai_trigger(struct snd_pcm_substream =
*substream, int cmd,
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
 				   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(mask));
=20
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
+				   ESAI_xCR_xEIE_MASK, ESAI_xCR_xEIE);
+
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
+				   ESAI_xCR_xEIE_MASK, 0);
+
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK, 0);
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
@@ -618,6 +636,145 @@ static const struct snd_soc_dai_ops fsl_esai_dai_ops =
=3D {
 	.set_tdm_slot =3D fsl_esai_set_dai_tdm_slot,
 };
=20
+static void fsl_esai_reset(unsigned long arg)
+{
+	struct fsl_esai *esai_priv =3D (struct fsl_esai *)arg;
+	u32 saisr;
+	u32 tsma, tsmb, rsma, rsmb, tcr, rcr, tfcr, rfcr;
+	int i;
+
+	/*
+	 * stop the tx & rx
+	 */
+	regmap_read(esai_priv->regmap, REG_ESAI_TSMA, &tsma);
+	regmap_read(esai_priv->regmap, REG_ESAI_TSMB, &tsmb);
+	regmap_read(esai_priv->regmap, REG_ESAI_RSMA, &rsma);
+	regmap_read(esai_priv->regmap, REG_ESAI_RSMB, &rsmb);
+
+	regmap_read(esai_priv->regmap, REG_ESAI_TCR, &tcr);
+	regmap_read(esai_priv->regmap, REG_ESAI_RCR, &rcr);
+
+	regmap_read(esai_priv->regmap, REG_ESAI_TFCR, &tfcr);
+	regmap_read(esai_priv->regmap, REG_ESAI_RFCR, &rfcr);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+				ESAI_xCR_xEIE_MASK | ESAI_xCR_TE_MASK, 0);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
+				ESAI_xCR_xEIE_MASK | ESAI_xCR_RE_MASK, 0);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMA,
+				ESAI_xSMA_xS_MASK, 0);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMB,
+				ESAI_xSMB_xS_MASK, 0);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMA,
+				ESAI_xSMA_xS_MASK, 0);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMB,
+				ESAI_xSMB_xS_MASK, 0);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,
+				ESAI_xFCR_xFR | ESAI_xFCR_xFEN, ESAI_xFCR_xFR);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,
+				ESAI_xFCR_xFR, 0);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RFCR,
+				ESAI_xFCR_xFR | ESAI_xFCR_xFEN, ESAI_xFCR_xFR);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RFCR,
+				ESAI_xFCR_xFR, 0);
+
+	/*
+	 * reset the esai, and restore the registers
+	 */
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_ECR,
+				ESAI_ECR_ESAIEN_MASK | ESAI_ECR_ERST_MASK,
+				ESAI_ECR_ESAIEN | ESAI_ECR_ERST);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_ECR,
+				ESAI_ECR_ESAIEN_MASK | ESAI_ECR_ERST_MASK,
+				ESAI_ECR_ESAIEN);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+				ESAI_xCR_xPR_MASK,
+				ESAI_xCR_xPR);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
+				ESAI_xCR_xPR_MASK,
+				ESAI_xCR_xPR);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
+				ESAI_PRRC_PDC_MASK, 0);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_PCRC,
+				ESAI_PCRC_PC_MASK, 0);
+
+	/*
+	 * Add fifo reset here, because the regcache_sync will
+	 * write one more data to ETDR.
+	 * Which will cause channel shift.
+	 */
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,
+				ESAI_xFCR_xFR_MASK, ESAI_xFCR_xFR);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RFCR,
+				ESAI_xFCR_xFR_MASK, ESAI_xFCR_xFR);
+
+	regcache_mark_dirty(esai_priv->regmap);
+	regcache_sync(esai_priv->regmap);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,
+				ESAI_xFCR_xFR_MASK, 0);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RFCR,
+				ESAI_xFCR_xFR_MASK, 0);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+				ESAI_xCR_xPR_MASK, 0);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
+				ESAI_xCR_xPR_MASK, 0);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
+				ESAI_PRRC_PDC_MASK,
+				ESAI_PRRC_PDC(ESAI_GPIO));
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_PCRC,
+				ESAI_PCRC_PC_MASK,
+				ESAI_PCRC_PC(ESAI_GPIO));
+
+	regmap_read(esai_priv->regmap, REG_ESAI_SAISR, &saisr);
+
+	/*
+	 * restart tx / rx, if they already enabled
+	 */
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TFCR,
+				ESAI_xFCR_xFEN_MASK, tfcr & ESAI_xFCR_xFEN);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RFCR,
+				ESAI_xFCR_xFEN_MASK, rfcr & ESAI_xFCR_xFEN);
+
+	/* Write initial words reqiured by ESAI as normal procedure */
+	for (i =3D 0; i < esai_priv->tx_channels; i++)
+		regmap_write(esai_priv->regmap, REG_ESAI_ETDR, 0x0);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+				ESAI_xCR_TE_MASK,
+				ESAI_xCR_TE_MASK & tcr);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
+				ESAI_xCR_RE_MASK,
+				ESAI_xCR_RE_MASK & rcr);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMB,
+				ESAI_xSMB_xS_MASK,
+				ESAI_xSMB_xS_MASK & tsmb);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMA,
+				ESAI_xSMA_xS_MASK,
+				ESAI_xSMA_xS_MASK & tsma);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMB,
+				ESAI_xSMB_xS_MASK,
+				ESAI_xSMB_xS_MASK & rsmb);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMA,
+				ESAI_xSMA_xS_MASK,
+				ESAI_xSMA_xS_MASK & rsma);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+			   ESAI_xCR_xEIE_MASK, ESAI_xCR_xEIE & tcr);
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
+			   ESAI_xCR_xEIE_MASK, ESAI_xCR_xEIE & rcr);
+}
+
 static int fsl_esai_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_esai *esai_priv =3D snd_soc_dai_get_drvdata(dai);
@@ -787,6 +944,10 @@ static int fsl_esai_probe(struct platform_device *pdev=
)
 	esai_priv->pdev =3D pdev;
 	snprintf(esai_priv->name, sizeof(esai_priv->name), "%pOFn", np);
=20
+	if (of_device_is_compatible(np, "fsl,vf610-esai") ||
+	    of_device_is_compatible(np, "fsl,imx35-esai"))
+		esai_priv->reset_at_xrun =3D true;
+
 	/* Get the addresses and IRQ */
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs =3D devm_ioremap_resource(&pdev->dev, res);
@@ -899,6 +1060,8 @@ static int fsl_esai_probe(struct platform_device *pdev=
)
 		return ret;
 	}
=20
+	tasklet_init(&esai_priv->task, fsl_esai_reset, (unsigned long)esai_priv);
+
 	pm_runtime_enable(&pdev->dev);
=20
 	regcache_cache_only(esai_priv->regmap, true);
@@ -912,7 +1075,10 @@ static int fsl_esai_probe(struct platform_device *pde=
v)
=20
 static int fsl_esai_remove(struct platform_device *pdev)
 {
+	struct fsl_esai *esai_priv =3D platform_get_drvdata(pdev);
+
 	pm_runtime_disable(&pdev->dev);
+	tasklet_kill(&esai_priv->task);
=20
 	return 0;
 }
--=20
2.21.0
