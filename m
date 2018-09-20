From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rename for_each_rtd_codec_dai_reverse
	to rollback" to the asoc tree
Date: Thu, 20 Sep 2018 18:36:09 +0100 (BST)
Message-ID: <20180920173609.A54B1440078@finisterre.ee.mobilebroadband>
References: <87y3bzppmg.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E043126789F
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 19:36:11 +0200 (CEST)
In-Reply-To: <87y3bzppmg.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rename for_each_rtd_codec_dai_reverse to rollback

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

>From 6d11b12879144da5f5aa08071a8a7f95f3b5a4e8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Sep 2018 01:28:30 +0000
Subject: [PATCH] ASoC: rename for_each_rtd_codec_dai_reverse to rollback

commit 0b7990e38971 ("ASoC: add for_each_rtd_codec_dai() macro")
added for_each_rtd_codec_dai_reverse(). but _rollback() is better
naming than _reverse(). This patch rename it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 2 +-
 sound/soc/soc-pcm.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1e093b399bc0..ec1ae9f4feeb 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1164,7 +1164,7 @@ struct snd_soc_pcm_runtime {
 	for ((i) = 0;						       \
 	     ((i) < rtd->num_codecs) && ((dai) = rtd->codec_dais[i]); \
 	     (i)++)
-#define for_each_rtd_codec_dai_reverse(rtd, i, dai)				\
+#define for_each_rtd_codec_dai_rollback(rtd, i, dai)		\
 	for (; ((i--) >= 0) && ((dai) = rtd->codec_dais[i]);)
 
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e387fff352c8..1eff1dbb0d00 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -621,7 +621,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	i = rtd->num_codecs;
 
 codec_dai_err:
-	for_each_rtd_codec_dai_reverse(rtd, i, codec_dai) {
+	for_each_rtd_codec_dai_rollback(rtd, i, codec_dai) {
 		if (codec_dai->driver->ops->shutdown)
 			codec_dai->driver->ops->shutdown(substream, codec_dai);
 	}
@@ -1015,7 +1015,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	i = rtd->num_codecs;
 
 codec_err:
-	for_each_rtd_codec_dai_reverse(rtd, i, codec_dai) {
+	for_each_rtd_codec_dai_rollback(rtd, i, codec_dai) {
 		if (codec_dai->driver->ops->hw_free)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 		codec_dai->rate = 0;
-- 
2.19.0
