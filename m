From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: Fix potential NULL pointer
	dereference" to the asoc tree
Date: Tue, 15 Jan 2019 19:08:17 +0000 (GMT)
Message-ID: <20190115190817.5E33D1127848@debutante.sirena.org.uk>
References: <20190114234010.GA3654@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DB0B52667E7
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 20:08:20 +0100 (CET)
In-Reply-To: <20190114234010.GA3654@embeddedor>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, stable@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: Fix potential NULL pointer dereference

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

>From 4cb79ef9c6c4413427cd70afbb1f3bc01e9b7abf Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 14 Jan 2019 17:40:10 -0600
Subject: [PATCH] ASoC: amd: Fix potential NULL pointer dereference

Check return value from call to devm_kzalloc() in order to prevent a
potential NULL pointer dereference.

Also, notice that it makes no sense to allocate any resources if
res = platform_get_resource(pdev, IORESOURCE_MEM, 0); fails,
so move the call to devm_kzalloc() below the mentioned code.

Lastly, improve the use of sizeof in the call to devm_kzalloc() by
changing it from sizeof(struct i2s_dev_data) to sizeof(*adata)

This issue was detected with the help of Coccinelle.

Fixes: ac289c7ec0bc ("ASoC: amd: add ACP3x PCM platform driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 022a8912c8a2..3d58338fa3cf 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -611,14 +611,16 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 	}
 	irqflags = *((unsigned int *)(pdev->dev.platform_data));
 
-	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data),
-			     GFP_KERNEL);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
 			return -ENODEV;
 	}
 
+	adata = devm_kzalloc(&pdev->dev, sizeof(*adata), GFP_KERNEL);
+	if (!adata)
+		return -ENOMEM;
+
 	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
 					 resource_size(res));
 
-- 
2.20.1
