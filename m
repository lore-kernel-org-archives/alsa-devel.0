From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Only assign compr->ops->copy
	once" to the asoc tree
Date: Fri, 11 May 2018 04:25:37 +0100 (BST)
Message-ID: <20180511032537.7518A44007A@finisterre.ee.mobilebroadband>
References: <20180426163007.5632-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 615B1267801
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 05:25:43 +0200 (CEST)
In-Reply-To: <20180426163007.5632-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, vinod.koul@intel.com, patches@opensource.cirrus.com, lgirdwood@gmail.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Only assign compr->ops->copy once

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

>From ca76db6c7e9c4ab6a98fbe0f92f18bf1375e325d Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 26 Apr 2018 17:30:04 +0100
Subject: [PATCH] ASoC: compress: Only assign compr->ops->copy once

There are only one set of ops on the compressed stream so no need to
reassign the copy callback repeatedly, stop after copy is seen to be
necessary.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index ba56f87f96d4..62875c6a93a1 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -973,6 +973,7 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 			continue;
 
 		compr->ops->copy = soc_compr_copy;
+		break;
 	}
 
 
-- 
2.17.0
