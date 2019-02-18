From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_spdif: fix TXCLK_DF mask" to the
	asoc tree
Date: Mon, 18 Feb 2019 18:49:28 +0000 (GMT)
Message-ID: <20190218184928.B77BB1128009@debutante.sirena.org.uk>
References: <1550499117-11801-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 34374265567
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 19:49:30 +0100 (CET)
In-Reply-To: <1550499117-11801-1-git-send-email-viorel.suman@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Viorel Suman <viorel.suman@gmail.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_spdif: fix TXCLK_DF mask

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

>From 30c498a10ac6586778062062c064ae54e3897762 Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Mon, 18 Feb 2019 14:12:17 +0000
Subject: [PATCH] ASoC: fsl_spdif: fix TXCLK_DF mask

According to RM SPDIF TXCLK_DF mask is 7-bit wide.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_spdif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
index 7666dabaccfd..e6c61e07bc1a 100644
--- a/sound/soc/fsl/fsl_spdif.h
+++ b/sound/soc/fsl/fsl_spdif.h
@@ -152,7 +152,7 @@ enum spdif_gainsel {
 #define STC_TXCLK_ALL_EN_MASK		(1 << STC_TXCLK_ALL_EN_OFFSET)
 #define STC_TXCLK_ALL_EN		(1 << STC_TXCLK_ALL_EN_OFFSET)
 #define STC_TXCLK_DF_OFFSET		0
-#define STC_TXCLK_DF_MASK		(0x7ff << STC_TXCLK_DF_OFFSET)
+#define STC_TXCLK_DF_MASK		(0x7f << STC_TXCLK_DF_OFFSET)
 #define STC_TXCLK_DF(x)		((((x) - 1) << STC_TXCLK_DF_OFFSET) & STC_TXCLK_DF_MASK)
 #define STC_TXCLK_SRC_MAX		8
 
-- 
2.20.1
