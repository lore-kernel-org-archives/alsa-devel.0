From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514-spi: Fix potential NULL pointer
	dereference" to the asoc tree
Date: Tue, 15 Jan 2019 19:08:21 +0000 (GMT)
Message-ID: <20190115190821.1FF1B1127848@debutante.sirena.org.uk>
References: <20190115175723.GA32176@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A017D2667E7
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 20:08:23 +0100 (CET)
In-Reply-To: <20190115175723.GA32176@embeddedor>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514-spi: Fix potential NULL pointer dereference

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

>From 060d0bf491874daece47053c4e1fb0489eb867d2 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 15 Jan 2019 11:57:23 -0600
Subject: [PATCH] ASoC: rt5514-spi: Fix potential NULL pointer dereference

There is a potential NULL pointer dereference in case devm_kzalloc()
fails and returns NULL.

Fix this by adding a NULL check on rt5514_dsp.

This issue was detected with the help of Coccinelle.

Fixes: 6eebf35b0e4a ("ASoC: rt5514: add rt5514 SPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 4d46f4567c3a..bec2eefa8b0f 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -280,6 +280,8 @@ static int rt5514_spi_pcm_probe(struct snd_soc_component *component)
 
 	rt5514_dsp = devm_kzalloc(component->dev, sizeof(*rt5514_dsp),
 			GFP_KERNEL);
+	if (!rt5514_dsp)
+		return -ENOMEM;
 
 	rt5514_dsp->dev = &rt5514_spi->dev;
 	mutex_init(&rt5514_dsp->dma_lock);
-- 
2.20.1
