From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-pcm-dma: add NULL test" to the asoc
	tree
Date: Wed, 23 Dec 2015 00:08:57 +0000
Message-ID: <E1aBWzB-0007Kx-Pp@debutante>
References: <1450610153-7746-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 87B6B265DA8
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:09:04 +0100 (CET)
In-Reply-To: <1450610153-7746-2-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: imx-pcm-dma: add NULL test

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

>From 10974ccf04b096fd79ad90fd50276b79c069f2cc Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 20 Dec 2015 12:15:50 +0100
Subject: [PATCH] ASoC: imx-pcm-dma: add NULL test

Add NULL test on call to devm_kzalloc.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x;
@@

* x = devm_kzalloc(...);
  ... when != x == NULL
  *x
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-pcm-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 1fc01ed3279d..f3d3d1ffa84e 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -62,6 +62,8 @@ int imx_pcm_dma_init(struct platform_device *pdev, size_t size)
 
 	config = devm_kzalloc(&pdev->dev,
 			sizeof(struct snd_dmaengine_pcm_config), GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
 	*config = imx_dmaengine_pcm_config;
 	if (size)
 		config->prealloc_buffer_size = size;
-- 
2.6.2
