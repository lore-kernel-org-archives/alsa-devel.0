From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: initialize list at one place"
	to the asoc tree
Date: Thu, 22 Aug 2019 19:32:56 +0100 (BST)
Message-ID: <20190822183256.88E80D02CB0@fitzroy.sirena.org.uk>
References: <87y2zozazp.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B960CF80147
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 20:33:02 +0200 (CEST)
In-Reply-To: <87y2zozazp.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Sridharan@sirena.org.uk, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Ranjani <ranjani.sridharan@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: initialize list at one place

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

>From 495efdb01f89a5fc53f9b2e61f5726d804d4a15d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Aug 2019 14:05:20 +0900
Subject: [PATCH] ASoC: soc-core: initialize list at one place

Initialize component related list at random place is very difficult
to read. This patch initialize it at snd_soc_component_initialize().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/87y2zozazp.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1a17cb1bc03b..0af83963289f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1272,7 +1272,6 @@ static int soc_probe_component(struct snd_soc_card *card,
 
 	component->card = card;
 	dapm->card = card;
-	INIT_LIST_HEAD(&component->card_list);
 	INIT_LIST_HEAD(&dapm->list);
 	soc_set_name_prefix(card, component);
 
@@ -2648,6 +2647,8 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	struct snd_soc_dapm_context *dapm;
 
 	INIT_LIST_HEAD(&component->dai_list);
+	INIT_LIST_HEAD(&component->dobj_list);
+	INIT_LIST_HEAD(&component->card_list);
 	mutex_init(&component->io_mutex);
 
 	component->name = fmt_single_name(dev, &component->id);
@@ -2733,7 +2734,6 @@ static void snd_soc_component_add(struct snd_soc_component *component)
 
 	/* see for_each_component */
 	list_add(&component->list, &component_list);
-	INIT_LIST_HEAD(&component->dobj_list);
 
 	mutex_unlock(&client_mutex);
 }
-- 
2.20.1
