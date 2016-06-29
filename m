From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Fix number of words per frame
	for I2S-slave mode" to the asoc tree
Date: Wed, 29 Jun 2016 19:20:37 +0100
Message-ID: <E1bIK6H-0004gq-If@finisterre>
References: <1466830762-31646-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33DEB265DA4
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 20:20:58 +0200 (CEST)
In-Reply-To: <1466830762-31646-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Fix number of words per frame for I2S-slave mode

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

>From 4f14f5c11db161ab89b02f7196496ca32ca5dbf8 Mon Sep 17 00:00:00 2001
From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 25 Jun 2016 07:59:22 +0300
Subject: [PATCH] ASoC: fsl_ssi: Fix number of words per frame for I2S-slave
 mode

The i.MX51 datasheet says:
Chapter 56.1.2.4 I2S Mode
...
When I2S modes are entered (I2S master (01) or I2S slave (10)),
the following settings are recommended:
...
- TX Frame Rate should be 2 i.e. (STCCR[12:8] = 1)
- RX Frame Rate should be 2 i.e. (SRCCR[12:8] = 1)

Chapter 56.3.3.12 SSI Transmit and Receive Clock Control Registers (STCCR & SRCCR)
...
Bits 12-8 DC4-DC0
Frame Rate Divider Control. These bits are used to control the divide ratio
for the programmable frame rate dividers. The divide ratio works on the word
clock. In Normal mode, this ratio determines the word transfer rate.
In Network mode, this ratio sets the number of words per frame. The divide
ratio ranges from 1 to 32 in Normal mode and from 2 to 32 in Network mode.
In Normal mode, a divide ratio of 1 (DC=00000) provides continuous periodic
data word transfer. A bit-length frame sync must be used in this case.

Function fsl_ssi_hw_params() setup Normal mode for MONO output,
so with DC=0, SSI enters to continuous periodic data word transfer.
To fix this, setup DC for any I2S mode.
Patch has tested on custom board based on Digi CCMX-51 module (i.MX51).

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 632ecc0e3956..bedec4a32581 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -952,16 +952,16 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	ssi_private->i2s_mode = CCSR_SSI_SCR_NET;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
+		regmap_update_bits(regs, CCSR_SSI_STCCR,
+				   CCSR_SSI_SxCCR_DC_MASK,
+				   CCSR_SSI_SxCCR_DC(2));
+		regmap_update_bits(regs, CCSR_SSI_SRCCR,
+				   CCSR_SSI_SxCCR_DC_MASK,
+				   CCSR_SSI_SxCCR_DC(2));
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 		case SND_SOC_DAIFMT_CBM_CFS:
 		case SND_SOC_DAIFMT_CBS_CFS:
 			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_MASTER;
-			regmap_update_bits(regs, CCSR_SSI_STCCR,
-					CCSR_SSI_SxCCR_DC_MASK,
-					CCSR_SSI_SxCCR_DC(2));
-			regmap_update_bits(regs, CCSR_SSI_SRCCR,
-					CCSR_SSI_SxCCR_DC_MASK,
-					CCSR_SSI_SxCCR_DC(2));
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_SLAVE;
-- 
2.8.1
