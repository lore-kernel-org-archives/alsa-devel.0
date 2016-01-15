From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: free memory on error" to the asoc
	tree
Date: Fri, 15 Jan 2016 18:18:57 +0000
Message-ID: <E1aK8xd-0005Rv-6x@debutante>
References: <20160113122002.GA19993@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21AFB26051B
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 19:19:04 +0100 (CET)
In-Reply-To: <20160113122002.GA19993@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: free memory on error

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

>From cde6bcd584b1b910d6ee8d6eb968ea5d20815444 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 13 Jan 2016 15:20:02 +0300
Subject: [PATCH] ASoC: AMD: free memory on error

Static checkers complain if we don't free "adata" before returning.

Fixes: 7c31335a03b6 ('ASoC: AMD: add AMD ASoC ACP 2.x DMA driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 3191e0a7d273..d1fb035f44db 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -635,6 +635,7 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0) {
 		dev_err(prtd->platform->dev, "set integer constraint failed\n");
+		kfree(adata);
 		return ret;
 	}
 
-- 
2.7.0.rc3
