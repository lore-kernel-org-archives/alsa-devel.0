From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add Component level set_bias_level" to
	the asoc tree
Date: Wed, 27 Sep 2017 18:13:50 +0100 (BST)
Message-ID: <20170927171350.5E600440053@finisterre.ee.mobilebroadband>
References: <87y3pzm1nl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 57534266DE1
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 19:14:24 +0200 (CEST)
In-Reply-To: <87y3pzm1nl.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add Component level set_bias_level

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

>From 7ba236ce58bd7ac8e360de81f834d9c446f7b063 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 26 Sep 2017 01:01:10 +0000
Subject: [PATCH] ASoC: add Component level set_bias_level

In current ALSA SoC, Codec only has set_bias_level feature.
Codec will be merged into Component in next generation ALSA SoC,
thus current Codec specific feature need to be merged into it.
This is glue patch for it.

Codec driver has .idle_bias_off for dapm bias. But Component
driver doesn't have it, and dapm->idle_bias_off is set as "true".
To keep compatibility, this patch adds "idle_bias_on" instead of
".idle_bias_off" on Component driver.
dapm->idle_bias_off will be set by inverted idle_bias_on.

When we replace Codec to Component, the driver which has
".idle_bias_off = true" is just remove it,
and the driver which doesn't have it will have new
".idle_bias_on = true".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  8 ++++++++
 sound/soc/soc-core.c | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c2278614e5bf..d776cdee30d7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -816,10 +816,16 @@ struct snd_soc_component_driver {
 	void (*seq_notifier)(struct snd_soc_component *, enum snd_soc_dapm_type,
 		int subseq);
 	int (*stream_event)(struct snd_soc_component *, int event);
+	int (*set_bias_level)(struct snd_soc_component *component,
+			      enum snd_soc_bias_level level);
 
 	/* probe ordering - for components with runtime dependencies */
 	int probe_order;
 	int remove_order;
+
+	/* bits */
+	unsigned int idle_bias_on:1;
+	unsigned int suspend_bias_off:1;
 };
 
 struct snd_soc_component {
@@ -885,6 +891,8 @@ struct snd_soc_component {
 		       int source, unsigned int freq_in, unsigned int freq_out);
 	int (*set_jack)(struct snd_soc_component *component,
 			struct snd_soc_jack *jack,  void *data);
+	int (*set_bias_level)(struct snd_soc_component *component,
+			      enum snd_soc_bias_level level);
 
 	/* machine specific init */
 	int (*init)(struct snd_soc_component *component);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index faed564670cd..fb3435121172 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3270,6 +3270,14 @@ static void snd_soc_component_drv_pcm_free(struct snd_soc_component *component,
 		component->driver->pcm_free(pcm);
 }
 
+static int snd_soc_component_set_bias_level(struct snd_soc_dapm_context *dapm,
+					enum snd_soc_bias_level level)
+{
+	struct snd_soc_component *component = dapm->component;
+
+	return component->driver->set_bias_level(component, level);
+}
+
 static int snd_soc_component_initialize(struct snd_soc_component *component,
 	const struct snd_soc_component_driver *driver, struct device *dev)
 {
@@ -3297,11 +3305,14 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	dapm->dev = dev;
 	dapm->component = component;
 	dapm->bias_level = SND_SOC_BIAS_OFF;
-	dapm->idle_bias_off = true;
+	dapm->idle_bias_off = !driver->idle_bias_on;
+	dapm->suspend_bias_off = driver->suspend_bias_off;
 	if (driver->seq_notifier)
 		dapm->seq_notifier = snd_soc_component_seq_notifier;
 	if (driver->stream_event)
 		dapm->stream_event = snd_soc_component_stream_event;
+	if (driver->set_bias_level)
+		dapm->set_bias_level = snd_soc_component_set_bias_level;
 
 	INIT_LIST_HEAD(&component->dai_list);
 	mutex_init(&component->io_mutex);
-- 
2.14.1
