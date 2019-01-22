From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Fix multi-CODEC setups" to the
	asoc tree
Date: Tue, 22 Jan 2019 20:26:41 +0000 (GMT)
Message-ID: <20190122202641.E6AFD1127955@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A6392674A9
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 21:26:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Fix multi-CODEC setups

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

>From 3f6a125230d8bfcbfe0c06ff0b8eaccbc727acd7 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Tue, 22 Jan 2019 17:36:11 +0000
Subject: [PATCH] ASoC: core: Fix multi-CODEC setups

Revert 10dff9b0d (ASoC: soc-core: use for_each_link_codecs() for
dai_link codecs) for now as Sylwester Nawrocki reports that it causes
oopses on at least Odroid boards.

Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1c92b4aff57b..8a58fa86675a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -870,7 +870,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_dai_link_component *codecs;
+	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	struct snd_soc_dai_link_component cpu_dai_component;
 	struct snd_soc_component *component;
 	struct snd_soc_dai **codec_dais;
@@ -905,8 +905,9 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	rtd->num_codecs = dai_link->num_codecs;
 
 	/* Find CODEC from registered CODECs */
+	/* we can use for_each_rtd_codec_dai() after this */
 	codec_dais = rtd->codec_dais;
-	for_each_link_codecs(dai_link, i, codecs) {
+	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dais[i] = snd_soc_find_dai(&codecs[i]);
 		if (!codec_dais[i]) {
 			dev_info(card->dev, "ASoC: CODEC DAI %s not registered\n",
-- 
2.20.1
