From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: print dai_link name of BE other
	than FE." to the asoc tree
Date: Mon, 26 Sep 2016 09:43:48 -0700
Message-ID: <E1boZ0O-00078A-19@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B994266D6B
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 18:44:04 +0200 (CEST)
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
Cc: Donglin Peng <pengdonglin@smartisan.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: print dai_link name of BE other than FE.

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

>From 94d215cc6fc5f0a5d202ed2b12fa0b14392cc2e4 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?=E5=BD=AD=E4=B8=9C=E6=9E=97?= <pengdonglin@smartisan.com>
Date: Mon, 26 Sep 2016 08:29:31 +0000
Subject: [PATCH] ASoC: dpcm: print dai_link name of BE other than FE.

When operating the BE, we should print out the dai_link name of BE other
than FE. This is useful when analyzing the kernel log.

Signed-off-by: Donglin Peng <pengdonglin@smartisan.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index c1bfe9d8406d..d56a16a0f6fa 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1793,7 +1793,7 @@ int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		dev_dbg(be->dev, "ASoC: close BE %s\n",
-			dpcm->fe->dai_link->name);
+			be->dai_link->name);
 
 		soc_pcm_close(be_substream);
 		be_substream->runtime = NULL;
@@ -1859,7 +1859,7 @@ int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		dev_dbg(be->dev, "ASoC: hw_free BE %s\n",
-			dpcm->fe->dai_link->name);
+			be->dai_link->name);
 
 		soc_pcm_hw_free(be_substream);
 
@@ -1937,7 +1937,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		dev_dbg(be->dev, "ASoC: hw_params BE %s\n",
-			dpcm->fe->dai_link->name);
+			be->dai_link->name);
 
 		ret = soc_pcm_hw_params(be_substream, &dpcm->hw_params);
 		if (ret < 0) {
@@ -2017,7 +2017,7 @@ static int dpcm_do_trigger(struct snd_soc_dpcm *dpcm,
 	int ret;
 
 	dev_dbg(dpcm->be->dev, "ASoC: trigger BE %s cmd %d\n",
-			dpcm->fe->dai_link->name, cmd);
+			dpcm->be->dai_link->name, cmd);
 
 	ret = soc_pcm_trigger(substream, cmd);
 	if (ret < 0)
@@ -2232,7 +2232,7 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
-			dpcm->fe->dai_link->name);
+			be->dai_link->name);
 
 		ret = soc_pcm_prepare(be_substream);
 		if (ret < 0) {
-- 
2.9.3
