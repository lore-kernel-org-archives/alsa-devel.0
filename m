From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove snd_soc_pcm_set/get_drvdata()" to the asoc tree
Date: Tue, 09 Aug 2016 13:44:03 +0100
Message-ID: <E1bX6O3-0003a2-Dg@debutante>
References: <87h9b59gag.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87h9b59gag.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.orgalsa-devel@alsa-project.orgLiam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove snd_soc_pcm_set/get_drvdata()

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

>From 1e814030954015e42621191f3adc52df2241dc08 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 1 Aug 2016 06:11:36 +0000
Subject: [PATCH] ASoC: remove snd_soc_pcm_set/get_drvdata()

snd_soc_pcm_set_drvdata() will set driver data to rtd->dev,
but driver data of rtd->dev is already used as "rtd" on
soc_post_component_init().

	static int soc_post_component_init(xxx)
	{
		...
		dev_set_drvdata(rtd->dev, rtd);
		...
	}

To remove confusion, this patch removes snd_soc_pcm_set/get_drvdata().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6144882cc96a..bc953994acb9 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1547,17 +1547,6 @@ static inline void *snd_soc_platform_get_drvdata(struct snd_soc_platform *platfo
 	return snd_soc_component_get_drvdata(&platform->component);
 }
 
-static inline void snd_soc_pcm_set_drvdata(struct snd_soc_pcm_runtime *rtd,
-		void *data)
-{
-	dev_set_drvdata(rtd->dev, data);
-}
-
-static inline void *snd_soc_pcm_get_drvdata(struct snd_soc_pcm_runtime *rtd)
-{
-	return dev_get_drvdata(rtd->dev);
-}
-
 static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 {
 	INIT_LIST_HEAD(&card->codec_dev_list);
-- 
2.8.1
