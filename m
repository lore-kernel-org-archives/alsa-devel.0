From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: dapm_dai_get_connected_widgets:
	Fix missing mutex unlock" to the asoc tree
Date: Fri, 14 Aug 2015 01:00:50 +0100
Message-ID: <E1ZQ2QU-0003Fi-8E@finisterre>
References: <1439321881-29476-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04376264F3A
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 02:00:58 +0200 (CEST)
In-Reply-To: <1439321881-29476-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: dapm_dai_get_connected_widgets: Fix missing mutex unlock

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

>From 30abbe7727b23c6661daeea5d36be36ed7a41665 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 11 Aug 2015 21:37:59 +0200
Subject: [PATCH] ASoC: dapm: dapm_dai_get_connected_widgets: Fix missing mutex
 unlock

Make sure to unlock the DAPM mutex when dapm_widget_list_create() fails.

This means the function will now generate a trace_snd_soc_dapm_connected
event, even if the creation of the list fails. But that was the behavior
before the patch that introduced the unlock issue, so that should be fine.

Fixes: 1ce43acff0c0 ("ASoC: dapm: Simplify list creation in dapm_dai_get_connected_widgets()")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ac506cf..fa09108 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1191,7 +1191,7 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 
 	ret = dapm_widget_list_create(list, &widgets);
 	if (ret)
-		return ret;
+		paths = ret;
 
 	trace_snd_soc_dapm_connected(paths, stream);
 	mutex_unlock(&card->dapm_mutex);
-- 
2.5.0
