From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Change 2nd argument of
	soc_bind_dai_link() to DAI link pointer" to the asoc tree
Date: Wed, 25 Nov 2015 17:57:37 +0000
Message-ID: <E1a1eK1-0006WV-Mb@debutante>
References: <e0d3b63281fb168a8bf5f34db0854dc81ac8fc12.1446717205.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 06100264E9F
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 18:57:48 +0100 (CET)
In-Reply-To: <e0d3b63281fb168a8bf5f34db0854dc81ac8fc12.1446717205.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Change 2nd argument of soc_bind_dai_link() to DAI link pointer

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

>From 6f2f1ff0de83ad69f5a823ae77d1e0f77cc75d45 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Mon, 23 Nov 2015 11:03:52 -0500
Subject: [PATCH] ASoC: Change 2nd argument of soc_bind_dai_link() to DAI link
 pointer

Just code refactoring, to reuse it if new DAI Links are added later
based on topology in component probing phase.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2ecd09475d88..878a9fe92686 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -960,9 +960,9 @@ static struct snd_soc_dai *snd_soc_find_dai(
 	return NULL;
 }
 
-static int soc_bind_dai_link(struct snd_soc_card *card, int num)
+static int soc_bind_dai_link(struct snd_soc_card *card,
+	struct snd_soc_dai_link *dai_link)
 {
-	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	struct snd_soc_dai_link_component cpu_dai_component;
@@ -971,7 +971,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	const char *platform_name;
 	int i;
 
-	dev_dbg(card->dev, "ASoC: binding %s at idx %d\n", dai_link->name, num);
+	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
 
 	rtd = soc_new_pcm_runtime(card, dai_link);
 	if (!rtd)
@@ -1710,7 +1710,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	/* bind DAIs */
 	for (i = 0; i < card->num_links; i++) {
-		ret = soc_bind_dai_link(card, i);
+		ret = soc_bind_dai_link(card, &card->dai_link[i]);
 		if (ret != 0)
 			goto base_error;
 	}
-- 
2.6.2
