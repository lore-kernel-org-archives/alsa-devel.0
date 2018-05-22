From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa-ssp: allow more flexible setup
	order" to the asoc tree
Date: Tue, 22 May 2018 11:59:25 +0100
Message-ID: <E1fL50n-0000Ui-GH@debutante>
References: <20180521215017.29095-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A523026765F
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 12:59:28 +0200 (CEST)
In-Reply-To: <20180521215017.29095-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, robert.jarzmik@free.fr, lars@metafoo.de, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa-ssp: allow more flexible setup order

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

>From 737e370a57e4e83ead04166e89a8b53eee9734b0 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Mon, 21 May 2018 23:50:16 +0200
Subject: [PATCH] ASoC: pxa-ssp: allow more flexible setup order

The pxa-ssp driver currently assumes that .set_fmt() is called before
.set_clkdiv(), .set_pll() etc.

Commit a8bd0ee558714 ("ASoC: raumfeld: Use static DAI format setup") broke
support for Raumfeld hardware (and possible other PXA based ones) because
it effectively changed the order of these calls. Also, as the call to
.set_fmt() is now done at probe time, the port clock is not yet enabled.

To fix this, strip all hardware register access code from the .set_fmt()
callback and memorize the desired value, so we can use it from the
.hw_params() callback. Also make the .set_fmt() callback less destructive
by reading all registers that it writes to in the beginning and only
masking out the bits that it possibly fiddles with.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/pxa-ssp.c | 82 +++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 0291c7cb64eb..ffddcf117eb8 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -43,7 +43,8 @@
 struct ssp_priv {
 	struct ssp_device *ssp;
 	unsigned int sysclk;
-	int dai_fmt;
+	unsigned int dai_fmt;
+	unsigned int configured_dai_fmt;
 #ifdef CONFIG_PM
 	uint32_t	cr0;
 	uint32_t	cr1;
@@ -433,36 +434,72 @@ static int pxa_ssp_set_dai_tristate(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
+static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+			       unsigned int fmt)
+{
+	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_IF:
+	case SND_SOC_DAIFMT_IB_NF:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* Settings will be applied in hw_params() */
+	priv->dai_fmt = fmt;
+
+	return 0;
+}
+
 /*
  * Set up the SSP DAI format.
  * The SSP Port must be inactive before calling this function as the
  * physical interface format is changed.
  */
-static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
-		unsigned int fmt)
+static int pxa_ssp_configure_dai_fmt(struct ssp_priv *priv)
 {
-	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
 	u32 sscr0, sscr1, sspsp, scfr;
 
 	/* check if we need to change anything at all */
-	if (priv->dai_fmt == fmt)
+	if (priv->configured_dai_fmt == priv->dai_fmt)
 		return 0;
 
-	/* we can only change the settings if the port is not in use */
-	if (pxa_ssp_read_reg(ssp, SSCR0) & SSCR0_SSE) {
-		dev_err(&ssp->pdev->dev,
-			"can't change hardware dai format: stream is in use");
-		return -EINVAL;
-	}
-
 	/* reset port settings */
 	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) &
-		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
-	sscr1 = SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
-	sspsp = 0;
+		~(SSCR0_PSP | SSCR0_MOD);
+	sscr1 = pxa_ssp_read_reg(ssp, SSCR1) &
+		~(SSCR1_SCLKDIR | SSCR1_SFRMDIR | SSCR1_SCFR |
+		  SSCR1_RWOT | SSCR1_TRAIL | SSCR1_TFT | SSCR1_RFT);
+	sspsp = pxa_ssp_read_reg(ssp, SSPSP) &
+		~(SSPSP_SFRMP | SSPSP_SCMODE(3));
 
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	sscr1 |= SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
+
+	switch (priv->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
 		sscr1 |= SSCR1_SCLKDIR | SSCR1_SFRMDIR | SSCR1_SCFR;
 		break;
@@ -475,7 +512,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	switch (priv->dai_fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 		sspsp |= SSPSP_SFRMP;
 		break;
@@ -491,7 +528,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
-	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		sscr0 |= SSCR0_PSP;
 		sscr1 |= SSCR1_RWOT | SSCR1_TRAIL;
@@ -513,7 +550,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	pxa_ssp_write_reg(ssp, SSCR1, sscr1);
 	pxa_ssp_write_reg(ssp, SSPSP, sspsp);
 
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	switch (priv->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
 	case SND_SOC_DAIFMT_CBM_CFS:
 		scfr = pxa_ssp_read_reg(ssp, SSCR1) | SSCR1_SCFR;
@@ -530,7 +567,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	 * we have to defer some things until hw_params() where we
 	 * know parameters like the sample size.
 	 */
-	priv->dai_fmt = fmt;
+	priv->configured_dai_fmt = priv->dai_fmt;
 
 	return 0;
 }
@@ -551,6 +588,7 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	int width = snd_pcm_format_physical_width(params_format(params));
 	int ttsa = pxa_ssp_read_reg(ssp, SSTSA) & 0xf;
 	struct snd_dmaengine_dai_dma_data *dma_data;
+	int ret;
 
 	dma_data = snd_soc_dai_get_dma_data(cpu_dai, substream);
 
@@ -566,6 +604,10 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	if (pxa_ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
 		return 0;
 
+	ret = pxa_ssp_configure_dai_fmt(priv);
+	if (ret < 0)
+		return ret;
+
 	/* clear selected SSP bits */
 	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
 
-- 
2.17.0
