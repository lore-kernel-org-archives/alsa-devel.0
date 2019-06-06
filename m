From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-topology: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:14 +0100 (BST)
Message-ID: <20190606212614.91D92440046@finisterre.sirena.org.uk>
References: <87v9xjfjgo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B3B6F89755
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:15 +0200 (CEST)
In-Reply-To: <87v9xjfjgo.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-topology: use modern dai_link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 23b946ce2808bd4f1bfca1bae1fafbf552be18a4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:19:14 +0900
Subject: [PATCH] ASoC: soc-topology: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 3299ebb48c1a..f485f7f751a1 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -560,7 +560,7 @@ static void remove_link(struct snd_soc_component *comp,
 
 	kfree(link->name);
 	kfree(link->stream_name);
-	kfree(link->cpu_dai_name);
+	kfree(link->cpus->dai_name);
 
 	list_del(&dobj->list);
 	snd_soc_remove_dai_link(comp->card, link);
@@ -1879,12 +1879,22 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
 {
 	struct snd_soc_dai_link *link;
+	struct snd_soc_dai_link_component *dlc;
 	int ret;
 
-	link = kzalloc(sizeof(struct snd_soc_dai_link), GFP_KERNEL);
+	/* link + cpu + codec */
+	link = kzalloc(sizeof(*link) + (2 * sizeof(*dlc)), GFP_KERNEL);
 	if (link == NULL)
 		return -ENOMEM;
 
+	dlc = (struct snd_soc_dai_link_component *)(link + 1);
+
+	link->cpus	= &dlc[0];
+	link->codecs	= &dlc[1];
+
+	link->num_cpus	 = 1;
+	link->num_codecs = 1;
+
 	if (strlen(pcm->pcm_name)) {
 		link->name = kstrdup(pcm->pcm_name, GFP_KERNEL);
 		link->stream_name = kstrdup(pcm->pcm_name, GFP_KERNEL);
@@ -1892,10 +1902,10 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	link->id = le32_to_cpu(pcm->pcm_id);
 
 	if (strlen(pcm->dai_name))
-		link->cpu_dai_name = kstrdup(pcm->dai_name, GFP_KERNEL);
+		link->cpus->dai_name = kstrdup(pcm->dai_name, GFP_KERNEL);
 
-	link->codec_name = "snd-soc-dummy";
-	link->codec_dai_name = "snd-soc-dummy-dai";
+	link->codecs->name = "snd-soc-dummy";
+	link->codecs->dai_name = "snd-soc-dummy-dai";
 
 	/* enable DPCM */
 	link->dynamic = 1;
@@ -1912,7 +1922,7 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 		dev_err(tplg->comp->dev, "ASoC: FE link loading failed\n");
 		kfree(link->name);
 		kfree(link->stream_name);
-		kfree(link->cpu_dai_name);
+		kfree(link->cpus->dai_name);
 		kfree(link);
 		return ret;
 	}
-- 
2.20.1
