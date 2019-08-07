From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: tidyup for
	snd_soc_dapm_new_controls()" to the asoc tree
Date: Wed,  7 Aug 2019 14:30:47 +0100 (BST)
Message-ID: <20190807133047.D3F0B2742B9E@ypsilon.sirena.org.uk>
References: <87ftmdahow.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB6A8F804CB
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 15:30:49 +0200 (CEST)
In-Reply-To: <87ftmdahow.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: tidyup for snd_soc_dapm_new_controls()

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

>From b8ba3b572c70c8559ef76c1e0ca02e7b05126e8c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Aug 2019 10:30:53 +0900
Subject: [PATCH] ASoC: soc-core: tidyup for snd_soc_dapm_new_controls()

snd_soc_dapm_new_controls() registers controls by using
for(... i < num; ...). It means if widget was NULL, num should be zero.
Thus, we don't need to check about widget pointer.
This patch also cares missing return value.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87ftmdahow.wl-kuninori.morimoto.gx@renesas.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d12054ab8741..bb1e9e2c4ff4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1264,16 +1264,14 @@ static int soc_probe_component(struct snd_soc_card *card,
 
 	soc_init_component_debugfs(component);
 
-	if (component->driver->dapm_widgets) {
-		ret = snd_soc_dapm_new_controls(dapm,
+	ret = snd_soc_dapm_new_controls(dapm,
 					component->driver->dapm_widgets,
 					component->driver->num_dapm_widgets);
 
-		if (ret != 0) {
-			dev_err(component->dev,
-				"Failed to create new controls %d\n", ret);
-			goto err_probe;
-		}
+	if (ret != 0) {
+		dev_err(component->dev,
+			"Failed to create new controls %d\n", ret);
+		goto err_probe;
 	}
 
 	for_each_component_dais(component, dai) {
@@ -1990,13 +1988,15 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
 #endif
 
-	if (card->dapm_widgets)
-		snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
-					  card->num_dapm_widgets);
+	ret = snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
+					card->num_dapm_widgets);
+	if (ret < 0)
+		goto probe_end;
 
-	if (card->of_dapm_widgets)
-		snd_soc_dapm_new_controls(&card->dapm, card->of_dapm_widgets,
-					  card->num_of_dapm_widgets);
+	ret = snd_soc_dapm_new_controls(&card->dapm, card->of_dapm_widgets,
+					card->num_of_dapm_widgets);
+	if (ret < 0)
+		goto probe_end;
 
 	/* initialise the sound card only once */
 	if (card->probe) {
-- 
2.20.1
