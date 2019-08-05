From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-component: move
	snd_soc_component_set_bias_level()" to the asoc tree
Date: Mon,  5 Aug 2019 17:09:57 +0100 (BST)
Message-ID: <20190805160957.957312742EB3@ypsilon.sirena.org.uk>
References: <87tvb94d0n.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7E17F8053B
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 18:09:58 +0200 (CEST)
In-Reply-To: <87tvb94d0n.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-component: move snd_soc_component_set_bias_level()

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

>From 7951b14611851bdae18e9bca18015b1d84731d0d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2019 13:51:43 +0900
Subject: [PATCH] ASoC: soc-component: move snd_soc_component_set_bias_level()

Current soc-dapm / soc-core are using a long way round to call
.set_bias_level.

	if (driver->set_bias_level)
		dapm->set_bias_level = ...;
	...
	if (dapm->set_bias_level)
		ret = dapm->set_bias_level(...);

We can directly call it via driver->set_bias_level.
One note here is that both Card and Component have dapm,
but, Card's dapm doesn't have dapm->component.
We need to check it.

This patch moves snd_soc_component_set_bias_level() to soc-component.c
and updates parameters.
dapm->set_bias_level is no longer needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87tvb94d0n.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-component.h |  2 ++
 include/sound/soc-dapm.h      |  3 ---
 sound/soc/soc-component.c     |  9 +++++++++
 sound/soc/soc-core.c          | 10 ----------
 sound/soc/soc-dapm.c          |  4 ++--
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 1f84f04e2670..2aaf12bbbed0 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -285,6 +285,8 @@ void snd_soc_component_seq_notifier(struct snd_soc_component *component,
 				    enum snd_soc_dapm_type type, int subseq);
 int snd_soc_component_stream_event(struct snd_soc_component *component,
 				   int event);
+int snd_soc_component_set_bias_level(struct snd_soc_component *component,
+				     enum snd_soc_bias_level level);
 
 #ifdef CONFIG_REGMAP
 void snd_soc_component_init_regmap(struct snd_soc_component *component,
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c2f14a335891..2aa73d6dd7be 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -670,9 +670,6 @@ struct snd_soc_dapm_context {
 	enum snd_soc_bias_level target_bias_level;
 	struct list_head list;
 
-	int (*set_bias_level)(struct snd_soc_dapm_context *dapm,
-			      enum snd_soc_bias_level level);
-
 	struct snd_soc_dapm_wcache path_sink_cache;
 	struct snd_soc_dapm_wcache path_source_cache;
 
diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index f33dda8023ec..cb63df6e46eb 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -68,6 +68,15 @@ int snd_soc_component_stream_event(struct snd_soc_component *component,
 	return 0;
 }
 
+int snd_soc_component_set_bias_level(struct snd_soc_component *component,
+				     enum snd_soc_bias_level level)
+{
+	if (component->driver->set_bias_level)
+		return component->driver->set_bias_level(component, level);
+
+	return 0;
+}
+
 int snd_soc_component_enable_pin(struct snd_soc_component *component,
 				 const char *pin)
 {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8cfbe5fb5921..0f75dac4bb26 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2646,14 +2646,6 @@ int snd_soc_register_dai(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_dai);
 
-static int snd_soc_component_set_bias_level(struct snd_soc_dapm_context *dapm,
-					enum snd_soc_bias_level level)
-{
-	struct snd_soc_component *component = dapm->component;
-
-	return component->driver->set_bias_level(component, level);
-}
-
 static int snd_soc_component_initialize(struct snd_soc_component *component,
 	const struct snd_soc_component_driver *driver, struct device *dev)
 {
@@ -2674,8 +2666,6 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	dapm->bias_level = SND_SOC_BIAS_OFF;
 	dapm->idle_bias_off = !driver->idle_bias_on;
 	dapm->suspend_bias_off = driver->suspend_bias_off;
-	if (driver->set_bias_level)
-		dapm->set_bias_level = snd_soc_component_set_bias_level;
 
 	INIT_LIST_HEAD(&component->dai_list);
 	mutex_init(&component->io_mutex);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9288b2b43f98..d09bdca63c62 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -684,8 +684,8 @@ int snd_soc_dapm_force_bias_level(struct snd_soc_dapm_context *dapm,
 {
 	int ret = 0;
 
-	if (dapm->set_bias_level)
-		ret = dapm->set_bias_level(dapm, level);
+	if (dapm->component)
+		ret = snd_soc_component_set_bias_level(dapm->component, level);
 
 	if (ret == 0)
 		dapm->bias_level = level;
-- 
2.20.1
