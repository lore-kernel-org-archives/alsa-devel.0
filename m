From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: fix memory leak of i2s_data on
	error return" to the asoc tree
Date: Wed, 14 Nov 2018 22:11:28 +0000 (GMT)
Message-ID: <20181114221128.BDB32440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D363267AFF
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 23:11:34 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: fix memory leak of i2s_data on error return

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

>From 46dce4042659755a2b9753369d0c2d8ca33e35cf Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 14 Nov 2018 21:31:48 +0000
Subject: [PATCH] ASoC: amd: fix memory leak of i2s_data on error return

Currently when snd_pcm_hw_constraint_integer fails there is
a memory leak of i2s_data on the error return path. Fix this by
kfree'ing i2s_data before returning.

Detected by CoverityScan, CID#1475479 ("Resource leak")

Fixes: 0b87d6bcd648 ("ASoC: amd: add acp3x pcm driver dma ops")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 2e61cef00f41..b16cdd187139 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -309,6 +309,7 @@ static int acp3x_dma_open(struct snd_pcm_substream *substream)
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0) {
 		dev_err(component->dev, "set integer constraint failed\n");
+		kfree(i2s_data);
 		return ret;
 	}
 
-- 
2.19.1
