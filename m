From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-sai: add 32 bit word length
	support" to the asoc tree
Date: Tue, 11 Aug 2015 19:37:32 +0100
Message-ID: <E1ZPEQW-0002LG-42@finisterre>
References: <69f72120dad256225cbe771207e0f6b84a8f93df.1439262749.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E7BB26056B
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 20:37:43 +0200 (CEST)
In-Reply-To: <69f72120dad256225cbe771207e0f6b84a8f93df.1439262749.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-sai: add 32 bit word length support

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

>From 9b7493d00c06013fb9192ea23cc83a1a2d003d61 Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Tue, 11 Aug 2015 11:14:26 +0800
Subject: [PATCH] ASoC: fsl-sai: add 32 bit word length support

Add 32 bit word length support. There are no code changes required
in the SAI driver since it has already wirten the word width to the
corresponding register.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 0662809..d137290 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -13,7 +13,8 @@
 
 #define FSL_SAI_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
 			 SNDRV_PCM_FMTBIT_S20_3LE |\
-			 SNDRV_PCM_FMTBIT_S24_LE)
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
 
 /* SAI Register Map Register */
 #define FSL_SAI_TCSR	0x00 /* SAI Transmit Control */
-- 
2.5.0
