From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-component: move
	snd_soc_component_seq_notifier()" to the asoc tree
Date: Mon,  5 Aug 2019 17:09:58 +0100 (BST)
Message-ID: <20190805160958.1BBE92742E44@ypsilon.sirena.org.uk>
References: <87wog54d0v.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8904CF805AF
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 18:09:59 +0200 (CEST)
In-Reply-To: <87wog54d0v.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-component: move snd_soc_component_seq_notifier()

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

>From 9d415fbf773f162a5c274e671741c6fa94b74287 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2019 13:51:35 +0900
Subject: [PATCH] ASoC: soc-component: move snd_soc_component_seq_notifier()

Current soc-dapm / soc-core are using a long way round to call
.seq_notifier.

	if (driver->seq_notifier)
		dapm->seq_notifier = ...;
	...
	if (dapm->seq_notifier)
		ret = dapm->seq_notifier(...);

We can directly call it via driver->seq_notifier.
One note here is that both Card and Component have dapm,
but, Card's dapm doesn't have dapm->component.
We need to check it.

This patch moves snd_soc_component_seq_notifier() to soc-component.c,
and updates parameters.
dapm->seq_notifier is no longer needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87wog54d0v.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-component.h |  3 +++
 include/sound/soc-dapm.h      |  2 --
 sound/soc/soc-component.c     |  7 +++++++
 sound/soc/soc-core.c          | 10 ----------
 sound/soc/soc-dapm.c          | 15 ++++++++-------
 5 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 3ed2c39e45c2..7ac903c1e33f 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -281,6 +281,9 @@ int snd_soc_component_set_pll(struct snd_soc_component *component, int pll_id,
 int snd_soc_component_set_jack(struct snd_soc_component *component,
 			       struct snd_soc_jack *jack, void *data);
 
+void snd_soc_component_seq_notifier(struct snd_soc_component *component,
+				    enum snd_soc_dapm_type type, int subseq);
+
 #ifdef CONFIG_REGMAP
 void snd_soc_component_init_regmap(struct snd_soc_component *component,
 				   struct regmap *regmap);
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 6c6694160130..a03db6f8faa8 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -661,8 +661,6 @@ struct snd_soc_dapm_context {
 	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
 	/* Go to BIAS_OFF in suspend if the DAPM context is idle */
 	unsigned int suspend_bias_off:1;
-	void (*seq_notifier)(struct snd_soc_dapm_context *,
-			     enum snd_soc_dapm_type, int);
 
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_component *component; /* parent component */
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index de1bc5196f67..ca0b28b1d918 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -52,6 +52,13 @@ int snd_soc_component_set_pll(struct snd_soc_component *component, int pll_id,
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_set_pll);
 
+void snd_soc_component_seq_notifier(struct snd_soc_component *component,
+				    enum snd_soc_dapm_type type, int subseq)
+{
+	if (component->driver->seq_notifier)
+		component->driver->seq_notifier(component, type, subseq);
+}
+
 int snd_soc_component_enable_pin(struct snd_soc_component *component,
 				 const char *pin)
 {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2f068c239f34..c618fecc3d45 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2646,14 +2646,6 @@ int snd_soc_register_dai(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_dai);
 
-static void snd_soc_component_seq_notifier(struct snd_soc_dapm_context *dapm,
-	enum snd_soc_dapm_type type, int subseq)
-{
-	struct snd_soc_component *component = dapm->component;
-
-	component->driver->seq_notifier(component, type, subseq);
-}
-
 static int snd_soc_component_stream_event(struct snd_soc_dapm_context *dapm,
 	int event)
 {
@@ -2690,8 +2682,6 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	dapm->bias_level = SND_SOC_BIAS_OFF;
 	dapm->idle_bias_off = !driver->idle_bias_on;
 	dapm->suspend_bias_off = driver->suspend_bias_off;
-	if (driver->seq_notifier)
-		dapm->seq_notifier = snd_soc_component_seq_notifier;
 	if (driver->stream_event)
 		dapm->stream_event = snd_soc_component_stream_event;
 	if (driver->set_bias_level)
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d93c1038fab0..0b60f688b433 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1611,12 +1611,12 @@ static void dapm_seq_run(struct snd_soc_card *card,
 			if (!list_empty(&pending))
 				dapm_seq_run_coalesced(card, &pending);
 
-			if (cur_dapm && cur_dapm->seq_notifier) {
+			if (cur_dapm && cur_dapm->component) {
 				for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
 					if (sort[i] == cur_sort)
-						cur_dapm->seq_notifier(cur_dapm,
-								       i,
-								       cur_subseq);
+						snd_soc_component_seq_notifier(
+							cur_dapm->component,
+							i, cur_subseq);
 			}
 
 			if (cur_dapm && w->dapm != cur_dapm)
@@ -1674,11 +1674,12 @@ static void dapm_seq_run(struct snd_soc_card *card,
 	if (!list_empty(&pending))
 		dapm_seq_run_coalesced(card, &pending);
 
-	if (cur_dapm && cur_dapm->seq_notifier) {
+	if (cur_dapm && cur_dapm->component) {
 		for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
 			if (sort[i] == cur_sort)
-				cur_dapm->seq_notifier(cur_dapm,
-						       i, cur_subseq);
+				snd_soc_component_seq_notifier(
+					cur_dapm->component,
+					i, cur_subseq);
 	}
 
 	list_for_each_entry(d, &card->dapm_list, list) {
-- 
2.20.1
