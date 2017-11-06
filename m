From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: return -EIO if
	rsnd_dmaen_request_channel() failed" to the asoc tree
Date: Mon, 06 Nov 2017 11:37:53 +0000
Message-ID: <E1eBfiz-00057D-Jo@debutante>
References: <877ev45ik4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 09AA726713F
 for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2017 12:38:01 +0100 (CET)
In-Reply-To: <877ev45ik4.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: return -EIO if rsnd_dmaen_request_channel() failed

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

>From c409c2a963475f0288ba3bb47a10f04f6441ffb9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 6 Nov 2017 01:07:27 +0000
Subject: [PATCH] ASoC: rsnd: return -EIO if rsnd_dmaen_request_channel()
 failed

PTR_ERR(NULL) is success. Normally when a function returns both NULL
and error pointers, it means that NULL is not a error.
But, rsnd_dmaen_request_channel() returns NULL if requested resource
was failed.
Let's return -EIO if rsnd_dmaen_request_channel() was failed on
rsnd_dmaen_nolock_start().
This patch fixes commit edce5c496c6a ("ASoC: rsnd: Request/Release DMA
channel eachtime")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 5bc9ec16813c..fd557abfe390 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -219,11 +219,9 @@ static int rsnd_dmaen_nolock_start(struct rsnd_mod *mod,
 						 dma->mod_from,
 						 dma->mod_to);
 	if (IS_ERR_OR_NULL(dmaen->chan)) {
-		int ret = PTR_ERR(dmaen->chan);
-
 		dmaen->chan = NULL;
 		dev_err(dev, "can't get dma channel\n");
-		return ret;
+		return -EIO;
 	}
 
 	return 0;
-- 
2.15.0
