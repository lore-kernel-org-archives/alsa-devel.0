From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add for_each_card_components() macro"
	to the asoc tree
Date: Thu, 20 Sep 2018 18:35:38 +0100 (BST)
Message-ID: <20180920173538.5E50B440078@finisterre.ee.mobilebroadband>
References: <87sh27ppk9.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B64DF2678AB
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 19:35:40 +0200 (CEST)
In-Reply-To: <87sh27ppk9.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: add for_each_card_components() macro

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

>From f70f18f7d459b7958a4d3944396e2bc4a9f7ed72 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Sep 2018 01:29:55 +0000
Subject: [PATCH] ASoC: add for_each_card_components() macro

To be more readable code, this patch adds
new for_each_card_components() macro, and replace existing code to it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h                     | 3 +++
 sound/soc/intel/boards/broadwell.c      | 4 ++--
 sound/soc/intel/boards/bytcr_rt5640.c   | 4 ++--
 sound/soc/intel/boards/bytcr_rt5651.c   | 4 ++--
 sound/soc/intel/boards/cht_bsw_rt5672.c | 4 ++--
 sound/soc/soc-core.c                    | 5 +++--
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 164418dbf40e..34efab6baff6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1135,6 +1135,9 @@ struct snd_soc_card {
 #define for_each_card_rtds_safe(card, rtd, _rtd)	\
 	list_for_each_entry_safe(rtd, _rtd, &(card)->rtd_list, list)
 
+#define for_each_card_components(card, component)			\
+	list_for_each_entry(component, &(card)->component_dev_list, card_list)
+
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
 struct snd_soc_pcm_runtime {
 	struct device *dev;
diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 7b0ee67b4fc8..68e6543e6cb0 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -223,7 +223,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 static int broadwell_suspend(struct snd_soc_card *card){
 	struct snd_soc_component *component;
 
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_card_components(card, component) {
 		if (!strcmp(component->name, "i2c-INT343A:00")) {
 
 			dev_dbg(component->dev, "disabling jack detect before going to suspend.\n");
@@ -237,7 +237,7 @@ static int broadwell_suspend(struct snd_soc_card *card){
 static int broadwell_resume(struct snd_soc_card *card){
 	struct snd_soc_component *component;
 
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_card_components(card, component) {
 		if (!strcmp(component->name, "i2c-INT343A:00")) {
 
 			dev_dbg(component->dev, "enabling jack detect for resume.\n");
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index b6dc524830b2..8587bd3d1cc1 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1048,7 +1048,7 @@ static int byt_rt5640_suspend(struct snd_soc_card *card)
 	if (!BYT_RT5640_JDSRC(byt_rt5640_quirk))
 		return 0;
 
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_card_components(card, component) {
 		if (!strcmp(component->name, byt_rt5640_codec_name)) {
 			dev_dbg(component->dev, "disabling jack detect before suspend\n");
 			snd_soc_component_set_jack(component, NULL, NULL);
@@ -1067,7 +1067,7 @@ static int byt_rt5640_resume(struct snd_soc_card *card)
 	if (!BYT_RT5640_JDSRC(byt_rt5640_quirk))
 		return 0;
 
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_card_components(card, component) {
 		if (!strcmp(component->name, byt_rt5640_codec_name)) {
 			dev_dbg(component->dev, "re-enabling jack detect after resume\n");
 			snd_soc_component_set_jack(component, &priv->jack, NULL);
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index f8a68bdb3885..8dffeecda55b 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -742,7 +742,7 @@ static int byt_rt5651_suspend(struct snd_soc_card *card)
 	if (!BYT_RT5651_JDSRC(byt_rt5651_quirk))
 		return 0;
 
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_card_components(card, component) {
 		if (!strcmp(component->name, byt_rt5651_codec_name)) {
 			dev_dbg(component->dev, "disabling jack detect before suspend\n");
 			snd_soc_component_set_jack(component, NULL, NULL);
@@ -761,7 +761,7 @@ static int byt_rt5651_resume(struct snd_soc_card *card)
 	if (!BYT_RT5651_JDSRC(byt_rt5651_quirk))
 		return 0;
 
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_card_components(card, component) {
 		if (!strcmp(component->name, byt_rt5651_codec_name)) {
 			dev_dbg(component->dev, "re-enabling jack detect after resume\n");
 			snd_soc_component_set_jack(component, &priv->jack, NULL);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index e054318185ea..51f0d45d6f8f 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -347,7 +347,7 @@ static int cht_suspend_pre(struct snd_soc_card *card)
 	struct snd_soc_component *component;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_card_components(card, component) {
 		if (!strncmp(component->name,
 			     ctx->codec_name, sizeof(ctx->codec_name))) {
 
@@ -364,7 +364,7 @@ static int cht_resume_post(struct snd_soc_card *card)
 	struct snd_soc_component *component;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_card_components(card, component) {
 		if (!strncmp(component->name,
 			     ctx->codec_name, sizeof(ctx->codec_name))) {
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7efcf3475d6f..673a694ede3e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -510,7 +510,7 @@ int snd_soc_suspend(struct device *dev)
 	snd_soc_dapm_sync(&card->dapm);
 
 	/* suspend all COMPONENTs */
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_card_components(card, component) {
 		struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 		/* If there are paths active then the COMPONENT will be held with
@@ -602,7 +602,7 @@ static void soc_resume_deferred(struct work_struct *work)
 			cpu_dai->driver->resume(cpu_dai);
 	}
 
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_card_components(card, component) {
 		if (component->suspended) {
 			if (component->driver->resume)
 				component->driver->resume(component);
@@ -1354,6 +1354,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 					component->driver->num_dapm_routes);
 
 	list_add(&dapm->list, &card->dapm_list);
+	/* see for_each_card_components */
 	list_add(&component->card_list, &card->component_dev_list);
 
 	return 0;
-- 
2.19.0
