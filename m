From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: Remove unneeded return statement
	in void function" to the asoc tree
Date: Tue, 07 Mar 2017 14:33:35 +0100
Message-ID: <E1clFF9-0005c4-MA@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C1CCF266FA2
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 14:33:45 +0100 (CET)
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
To: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: Remove unneeded return statement in void function

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

>From 17339f6099154678485244cc17d700f19ece0dc0 Mon Sep 17 00:00:00 2001
From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Date: Sat, 25 Feb 2017 23:06:36 +0200
Subject: [PATCH] ASoC: pxa: Remove unneeded return statement in void function

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/mmp-pcm.c  | 1 -
 sound/soc/pxa/mmp-sspa.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 96df9b2d8fc4..5b5f1a442891 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -166,7 +166,6 @@ static void mmp_pcm_free_dma_buffers(struct snd_pcm *pcm)
 		buf->area = NULL;
 	}
 
-	return;
 }
 
 static int mmp_pcm_preallocate_dma_buffer(struct snd_pcm_substream *substream,
diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index ca8b23f8c525..9cc35012e6e5 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -119,7 +119,6 @@ static void mmp_sspa_shutdown(struct snd_pcm_substream *substream,
 	clk_disable(priv->sspa->clk);
 	clk_disable(priv->sysclk);
 
-	return;
 }
 
 /*
-- 
2.11.0
