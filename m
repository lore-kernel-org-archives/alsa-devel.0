From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add snd_soc_disconnect_sync()" to the
	asoc tree
Date: Tue, 28 Nov 2017 16:09:12 +0000
Message-ID: <E1eJiRc-0001rc-DX@debutante>
References: <87o9of4xjt.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CE052677F9
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 17:09:20 +0100 (CET)
In-Reply-To: <87o9of4xjt.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add snd_soc_disconnect_sync()

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

>From ef2e8175eb19011f756469d4d14f4207bf7f289c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:27:09 +0000
Subject: [PATCH] ASoC: add snd_soc_disconnect_sync()

Now, we have snd_card_disconnect_sync() on ALSA framework.
snd_soc_disconnect_sync() is ASoC version of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1a7323238c49..22f479e1da0a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -494,6 +494,8 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
 int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
 #endif
 
+void snd_soc_disconnect_sync(struct device *dev);
+
 struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
 		const char *dai_link, int stream);
 struct snd_soc_pcm_runtime *snd_soc_get_pcm_runtime(struct snd_soc_card *card,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0edac80df34..9047046c749c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1392,6 +1392,16 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	return 0;
 }
 
+void snd_soc_disconnect_sync(struct device *dev)
+{
+	struct snd_soc_component *component = snd_soc_lookup_component(dev, NULL);
+
+	if (!component || !component->card)
+		return;
+
+	snd_card_disconnect_sync(component->card->snd_card);
+}
+
 /**
  * snd_soc_add_dai_link - Add a DAI link dynamically
  * @card: The ASoC card to which the DAI link is added
-- 
2.15.0
