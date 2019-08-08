From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: tidyup for
	snd_soc_dapm_add_routes()" to the asoc tree
Date: Thu,  8 Aug 2019 21:33:41 +0100 (BST)
Message-ID: <20190808203341.6EF2127430BD@ypsilon.sirena.org.uk>
References: <87d0hhahon.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65C34F805A9
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 22:33:42 +0200 (CEST)
In-Reply-To: <87d0hhahon.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: tidyup for snd_soc_dapm_add_routes()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From daa480bde6b3a9b728965e52efffc329ccee3f77 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Aug 2019 10:31:03 +0900
Subject: [PATCH] ASoC: soc-core: tidyup for snd_soc_dapm_add_routes()

snd_soc_dapm_add_routes() registers routes by using
for(... i < num; ...). If routes was NULL, num should be zero.
Thus, we don't need to check about route pointer.
This patch also cares missing return value.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87d0hhahon.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e481f9999bfb..de95b68ce9ee 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1310,10 +1310,11 @@ static int soc_probe_component(struct snd_soc_card *card,
 	if (ret < 0)
 		goto err_probe;
 
-	if (component->driver->dapm_routes)
-		snd_soc_dapm_add_routes(dapm,
-					component->driver->dapm_routes,
-					component->driver->num_dapm_routes);
+	ret = snd_soc_dapm_add_routes(dapm,
+				      component->driver->dapm_routes,
+				      component->driver->num_dapm_routes);
+	if (ret < 0)
+		goto err_probe;
 
 	list_add(&dapm->list, &card->dapm_list);
 	/* see for_each_card_components */
@@ -2061,13 +2062,15 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		snd_soc_add_card_controls(card, card->controls,
 					  card->num_controls);
 
-	if (card->dapm_routes)
-		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
-					card->num_dapm_routes);
+	ret = snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
+				      card->num_dapm_routes);
+	if (ret < 0)
+		goto probe_end;
 
-	if (card->of_dapm_routes)
-		snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
-					card->num_of_dapm_routes);
+	ret = snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
+				      card->num_of_dapm_routes);
+	if (ret < 0)
+		goto probe_end;
 
 	/* try to set some sane longname if DMI is available */
 	snd_soc_set_dmi_name(card, NULL);
-- 
2.20.1
