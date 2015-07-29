From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Drop always true checks" to the
	asoc tree
Date: Wed, 29 Jul 2015 15:13:24 +0100
Message-ID: <E1ZKS6m-0004dw-8B@finisterre>
References: <1437930302-2789-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 166382659E3
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:36 +0200 (CEST)
In-Reply-To: <1437930302-2789-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Drop always true checks

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

>From 787126ebdb9821f1a19b1dfd1ab1bbb74b8c80b8 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 26 Jul 2015 19:04:58 +0200
Subject: [PATCH] ASoC: dapm: Drop always true checks

list_first_entry() always returns non NULL and since the code previously
checked that list is not empty it will also be a valid pointer. Furthermore
a path has always a sink or a source widget. So both checks are redundant
and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index cb4bc1c..f80b7de 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3482,11 +3482,6 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	sink_p = list_first_entry(&w->sinks, struct snd_soc_dapm_path,
 				  list_source);
 
-	if (WARN_ON(!source_p || !sink_p) ||
-	    WARN_ON(!sink_p->source || !source_p->sink) ||
-	    WARN_ON(!source_p->source || !sink_p->sink))
-		return -EINVAL;
-
 	source = source_p->source->priv;
 	sink = sink_p->sink->priv;
 
-- 
2.1.4
