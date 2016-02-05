From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mxs-saif: check BUSY bit in hw_params()
	only if not mclk_in_use" to the asoc tree
Date: Fri, 05 Feb 2016 13:35:16 +0000
Message-ID: <E1aRgXc-00012t-UW@finisterre>
References: <1454505500-30384-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 23246260601
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 14:35:34 +0100 (CET)
In-Reply-To: <1454505500-30384-1-git-send-email-mans@mansr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mans Rullgard <mans@mansr.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mxs-saif: check BUSY bit in hw_params() only if not mclk_in_use

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

>From 436e056c4ba368f13a5709a5a4a7f26fc238a5a6 Mon Sep 17 00:00:00 2001
From: Mans Rullgard <mans@mansr.com>
Date: Wed, 3 Feb 2016 13:18:20 +0000
Subject: [PATCH] ASoC: mxs-saif: check BUSY bit in hw_params() only if not
 mclk_in_use

If something else, typically a codec, has enabled mclk, the BUSY
bit may be set when hw_params() is called without this being an
error.  This check thus causes intermittent failures to configure
the sound device when used in such a manner.  Fix this by making
the test conditional on !saif->mclk_in_use.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mxs/mxs-saif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index c866ade..cd04eb7e 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -408,7 +408,7 @@ static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	stat = __raw_readl(saif->base + SAIF_STAT);
-	if (stat & BM_SAIF_STAT_BUSY) {
+	if (!saif->mclk_in_use && (stat & BM_SAIF_STAT_BUSY)) {
 		dev_err(cpu_dai->dev, "error: busy\n");
 		return -EBUSY;
 	}
-- 
2.6.4
