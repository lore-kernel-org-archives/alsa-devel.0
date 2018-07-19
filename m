From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Correct algorithm list
	allocation size" to the asoc tree
Date: Thu, 19 Jul 2018 17:57:47 +0100
Message-ID: <E1fgCFP-0005XW-DK@debutante>
References: <20180719105039.28312-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 18920267727
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 18:57:49 +0200 (CEST)
In-Reply-To: <20180719105039.28312-1-ckeepax@opensource.cirrus.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, stuarth@opensource.cirrus.com, rf@opensource.cirrus.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Correct algorithm list allocation size

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

>From 517ee74e1b3124b696f293aa4e220418f8125b4c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 19 Jul 2018 11:50:35 +0100
Subject: [PATCH] ASoC: wm_adsp: Correct algorithm list allocation size

Commit 6396bb221514 ("treewide: kzalloc() -> kcalloc()") was
overlooked when doing some refactoring to the algorithm list
handling, which lead to twice as much buffer being allocated
as required for reading the algorithm list. A kcalloc is no
longer appropriate since the allocation size is now in bytes
not registers, as such change back to kzalloc.

Fixes: 7f7cca08abf4 ("ASoC: wm_adsp: Simplify handling of alg offset and length")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 07c17acc8a4f..99108d18de8d 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1906,7 +1906,7 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 	/* Convert length from DSP words to bytes */
 	len *= sizeof(u32);
 
-	alg = kcalloc(len, 2, GFP_KERNEL | GFP_DMA);
+	alg = kzalloc(len, GFP_KERNEL | GFP_DMA);
 	if (!alg)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.18.0
