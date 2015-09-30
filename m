From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-ssi: Fix DAI hardware signal
	inversions" to the asoc tree
Date: Wed, 30 Sep 2015 20:32:19 +0100
Message-ID: <E1ZhN6x-00064K-V6@finisterre>
References: <1442504814-16965-1-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4098641303012429753=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04D2926648B
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 21:32:28 +0200 (CEST)
In-Reply-To: <1442504814-16965-1-git-send-email-benoit@wsystem.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============4098641303012429753==
Content-Type: text/plain

The patch

   ASoC: imx-ssi: Fix DAI hardware signal inversions

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

>From b7b01d345b83602a42b6ff02cacb9d9ada5ecd0a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit@wsystem.com>
Date: Tue, 29 Sep 2015 17:59:14 +0200
Subject: [PATCH] ASoC: imx-ssi: Fix DAI hardware signal inversions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SND_SOC_DAIFMT_{IB|NB}_{IF|NF} are defined as inverting or not BCLK or
FRM relatively to what is standard for the specified DAI hardware audio
format. Consequently, the absolute polarities of these signals cannot be
derived only from these settings as this driver did. The format has to
be taken into account too.

This fixes inverted left/right channels in I²S mode.

Signed-off-by: Benoît Thébaudeau <benoit@wsystem.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-ssi.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 48b2d24..b95132e 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -95,7 +95,8 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		/* data on rising edge of bclk, frame low 1clk before data */
-		strcr |= SSI_STCR_TFSI | SSI_STCR_TEFS | SSI_STCR_TXBIT0;
+		strcr |= SSI_STCR_TXBIT0 | SSI_STCR_TSCKP | SSI_STCR_TFSI |
+			SSI_STCR_TEFS;
 		scr |= SSI_SCR_NET;
 		if (ssi->flags & IMX_SSI_USE_I2S_SLAVE) {
 			scr &= ~SSI_I2S_MODE_MASK;
@@ -104,33 +105,31 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		/* data on rising edge of bclk, frame high with data */
-		strcr |= SSI_STCR_TXBIT0;
+		strcr |= SSI_STCR_TXBIT0 | SSI_STCR_TSCKP;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		/* data on rising edge of bclk, frame high with data */
-		strcr |= SSI_STCR_TFSL | SSI_STCR_TXBIT0;
+		strcr |= SSI_STCR_TXBIT0 | SSI_STCR_TSCKP | SSI_STCR_TFSL;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* data on rising edge of bclk, frame high 1clk before data */
-		strcr |= SSI_STCR_TFSL | SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
+		strcr |= SSI_STCR_TXBIT0 | SSI_STCR_TSCKP | SSI_STCR_TFSL |
+			SSI_STCR_TEFS;
 		break;
 	}
 
 	/* DAI clock inversion */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_IB_IF:
-		strcr |= SSI_STCR_TFSI;
-		strcr &= ~SSI_STCR_TSCKP;
+		strcr ^= SSI_STCR_TSCKP | SSI_STCR_TFSI;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
-		strcr &= ~(SSI_STCR_TSCKP | SSI_STCR_TFSI);
+		strcr ^= SSI_STCR_TSCKP;
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
-		strcr |= SSI_STCR_TFSI | SSI_STCR_TSCKP;
+		strcr ^= SSI_STCR_TFSI;
 		break;
 	case SND_SOC_DAIFMT_NB_NF:
-		strcr &= ~SSI_STCR_TFSI;
-		strcr |= SSI_STCR_TSCKP;
 		break;
 	}
 
-- 
2.5.0


--===============4098641303012429753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4098641303012429753==--
