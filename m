From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: use for_each_link_codecs()
	for dai_link codecs V2" to the asoc tree
Date: Mon, 28 Jan 2019 12:35:24 +0000 (GMT)
Message-ID: <20190128123524.B6B061127D29@debutante.sirena.org.uk>
References: <87munlh8np.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A5A4F267454
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 13:35:26 +0100 (CET)
In-Reply-To: <87munlh8np.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: use for_each_link_codecs() for dai_link codecs V2

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

>From 720734a0b66f9ca42ec6663a48702b16e49552ee Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 28 Jan 2019 10:40:24 +0900
Subject: [PATCH] ASoC: soc-core: use for_each_link_codecs() for dai_link
 codecs V2

We can use for_each_link_codecs() without waiting
for_each_rtd_codec_dai() on soc_bind_dai_link().
Let's use for_each macro.

Fixes: 50acc7e49 ("ASoC: core: Fix multi-CODEC setups")
Fixes: 10dff9b0d ("ASoC: soc-core: use for_each_link_codecs() for dai_link codecs")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8a58fa86675a..93efab486736 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -870,7 +870,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
+	struct snd_soc_dai_link_component *codecs;
 	struct snd_soc_dai_link_component cpu_dai_component;
 	struct snd_soc_component *component;
 	struct snd_soc_dai **codec_dais;
@@ -905,13 +905,12 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	rtd->num_codecs = dai_link->num_codecs;
 
 	/* Find CODEC from registered CODECs */
-	/* we can use for_each_rtd_codec_dai() after this */
 	codec_dais = rtd->codec_dais;
-	for (i = 0; i < rtd->num_codecs; i++) {
-		codec_dais[i] = snd_soc_find_dai(&codecs[i]);
+	for_each_link_codecs(dai_link, i, codecs) {
+		codec_dais[i] = snd_soc_find_dai(codecs);
 		if (!codec_dais[i]) {
 			dev_info(card->dev, "ASoC: CODEC DAI %s not registered\n",
-				 codecs[i].dai_name);
+				 codecs->dai_name);
 			goto _err_defer;
 		}
 		snd_soc_rtdcom_add(rtd, codec_dais[i]->component);
-- 
2.20.1
