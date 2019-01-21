From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: merge card resources cleanup
	method" to the asoc tree
Date: Mon, 21 Jan 2019 19:20:26 +0000 (GMT)
Message-ID: <20190121192026.2C8901127D00@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 04FD826747A
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 20:20:27 +0100 (CET)
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

   ASoC: soc-core: merge card resources cleanup method

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

>From 53e947a0e1f770b9707febb7054b856878945d50 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 21 Jan 2019 09:32:42 +0900
Subject: [PATCH] ASoC: soc-core: merge card resources cleanup method

We need to cleanup card resources when snd_soc_instantiate_card() was
failed, or when snd_soc_unbind_card() was called.
But they are cleanuping card resources on each way.
Same code in many places makes code un-understandable.

This patch reuses soc_cleanup_card_resources() for cleanuping code
resource. Then, it makes avoiding cleanup order.
It will be called from snd_soc_instantiate_card() and
snd_soc_unbind_card().

Then, original soc_cleanup_card_resources() included
snd_soc_flush_all_delayed_work(), but it is now separated.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 103 ++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 60 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index eeb794d8a262..d59b5ea9fa25 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2008,6 +2008,29 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 	}
 }
 
+static int soc_cleanup_card_resources(struct snd_soc_card *card)
+{
+	/* free the ALSA card at first; this syncs with pending operations */
+	if (card->snd_card)
+		snd_card_free(card->snd_card);
+
+	/* remove and free each DAI */
+	soc_remove_dai_links(card);
+	soc_remove_pcm_runtimes(card);
+
+	/* remove auxiliary devices */
+	soc_remove_aux_devices(card);
+
+	snd_soc_dapm_free(&card->dapm);
+	soc_cleanup_card_debugfs(card);
+
+	/* remove the card */
+	if (card->remove)
+		card->remove(card);
+
+	return 0;
+}
+
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
@@ -2017,6 +2040,11 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	mutex_lock(&client_mutex);
 	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_INIT);
 
+	card->dapm.bias_level = SND_SOC_BIAS_OFF;
+	card->dapm.dev = card->dev;
+	card->dapm.card = card;
+	list_add(&card->dapm.list, &card->dapm_list);
+
 	/* check whether any platform is ignore machine FE and using topology */
 	soc_check_tplg_fes(card);
 
@@ -2024,14 +2052,14 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	for_each_card_prelinks(card, i, dai_link) {
 		ret = soc_bind_dai_link(card, dai_link);
 		if (ret != 0)
-			goto base_error;
+			goto probe_end;
 	}
 
 	/* bind aux_devs too */
 	for (i = 0; i < card->num_aux_devs; i++) {
 		ret = soc_bind_aux_dev(card, i);
 		if (ret != 0)
-			goto base_error;
+			goto probe_end;
 	}
 
 	/* add predefined DAI links to the list */
@@ -2045,16 +2073,11 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		dev_err(card->dev,
 			"ASoC: can't create sound card for card %s: %d\n",
 			card->name, ret);
-		goto base_error;
+		goto probe_end;
 	}
 
 	soc_init_card_debugfs(card);
 
-	card->dapm.bias_level = SND_SOC_BIAS_OFF;
-	card->dapm.dev = card->dev;
-	card->dapm.card = card;
-	list_add(&card->dapm.list, &card->dapm_list);
-
 #ifdef CONFIG_DEBUG_FS
 	snd_soc_dapm_debugfs_init(&card->dapm, card->debugfs_card_root);
 #endif
@@ -2076,7 +2099,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	if (card->probe) {
 		ret = card->probe(card);
 		if (ret < 0)
-			goto card_probe_error;
+			goto probe_end;
 	}
 
 	/* probe all components used by DAI links on this card */
@@ -2087,7 +2110,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 				dev_err(card->dev,
 					"ASoC: failed to instantiate card %d\n",
 					ret);
-				goto probe_dai_err;
+				goto probe_end;
 			}
 		}
 	}
@@ -2095,7 +2118,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	/* probe auxiliary components */
 	ret = soc_probe_aux_devices(card);
 	if (ret < 0)
-		goto probe_dai_err;
+		goto probe_end;
 
 	/*
 	 * Find new DAI links added during probing components and bind them.
@@ -2107,10 +2130,10 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 		ret = soc_init_dai_link(card, dai_link);
 		if (ret)
-			goto probe_dai_err;
+			goto probe_end;
 		ret = soc_bind_dai_link(card, dai_link);
 		if (ret)
-			goto probe_dai_err;
+			goto probe_end;
 	}
 
 	/* probe all DAI links on this card */
@@ -2121,7 +2144,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 				dev_err(card->dev,
 					"ASoC: failed to instantiate card %d\n",
 					ret);
-				goto probe_dai_err;
+				goto probe_end;
 			}
 		}
 	}
@@ -2168,7 +2191,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: %s late_probe() failed: %d\n",
 				card->name, ret);
-			goto probe_aux_dev_err;
+			goto probe_end;
 		}
 	}
 
@@ -2178,33 +2201,17 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	if (ret < 0) {
 		dev_err(card->dev, "ASoC: failed to register soundcard %d\n",
 				ret);
-		goto probe_aux_dev_err;
+		goto probe_end;
 	}
 
 	card->instantiated = 1;
 	dapm_mark_endpoints_dirty(card);
 	snd_soc_dapm_sync(&card->dapm);
-	mutex_unlock(&card->mutex);
-	mutex_unlock(&client_mutex);
-
-	return 0;
 
-probe_aux_dev_err:
-	soc_remove_aux_devices(card);
-
-probe_dai_err:
-	soc_remove_dai_links(card);
-
-card_probe_error:
-	if (card->remove)
-		card->remove(card);
-
-	snd_soc_dapm_free(&card->dapm);
-	soc_cleanup_card_debugfs(card);
-	snd_card_free(card->snd_card);
+probe_end:
+	if (ret < 0)
+		soc_cleanup_card_resources(card);
 
-base_error:
-	soc_remove_pcm_runtimes(card);
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
 
@@ -2233,31 +2240,6 @@ static int soc_probe(struct platform_device *pdev)
 	return snd_soc_register_card(card);
 }
 
-static int soc_cleanup_card_resources(struct snd_soc_card *card)
-{
-	/* make sure any delayed work runs */
-	snd_soc_flush_all_delayed_work(card);
-
-	/* free the ALSA card at first; this syncs with pending operations */
-	snd_card_free(card->snd_card);
-
-	/* remove and free each DAI */
-	soc_remove_dai_links(card);
-	soc_remove_pcm_runtimes(card);
-
-	/* remove auxiliary devices */
-	soc_remove_aux_devices(card);
-
-	snd_soc_dapm_free(&card->dapm);
-	soc_cleanup_card_debugfs(card);
-
-	/* remove the card */
-	if (card->remove)
-		card->remove(card);
-
-	return 0;
-}
-
 /* removes a socdev */
 static int soc_remove(struct platform_device *pdev)
 {
@@ -2823,6 +2805,7 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
 	if (card->instantiated) {
 		card->instantiated = false;
 		snd_soc_dapm_shutdown(card);
+		snd_soc_flush_all_delayed_work(card);
 		soc_cleanup_card_resources(card);
 		if (!unregister)
 			list_add(&card->list, &unbind_card_list);
-- 
2.20.1
