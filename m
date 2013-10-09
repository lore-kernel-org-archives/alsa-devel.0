From: Markus Pargmann <mpa@pengutronix.de>
Subject: [RFC v2] ASoC: pcm: Store component running state
Date: Wed,  9 Oct 2013 16:31:16 +0200
Message-ID: <1381329076-12022-1-git-send-email-mpa@pengutronix.de>
References: <20131009141242.GE19005@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4360D2654C5
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 16:32:30 +0200 (CEST)
In-Reply-To: <20131009141242.GE19005@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Store the state of the components to detect not matching START/STOP
command pairs. Otherwise a component's trigger function may be called
twice with the same command which can lead to problems.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

This is a patch which stores the state of platform, cpu_dai and codec_dai to
call their trigger functions only if they are not already in the correct state.

Regards,

Markus


 include/sound/soc.h | 12 +++++++++++
 sound/soc/soc-pcm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d22cb0a..3b42b99 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1053,6 +1053,13 @@ struct snd_soc_card {
 	void *drvdata;
 };
 
+enum soc_pcm_cmd_state {
+	SOC_PCM_STOPPED,
+	SOC_PCM_RUNNING,
+	SOC_PCM_PAUSED,
+	SOC_PCM_SUSPENDED,
+};
+
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
 struct snd_soc_pcm_runtime {
 	struct device *dev;
@@ -1079,6 +1086,11 @@ struct snd_soc_pcm_runtime {
 	struct snd_soc_dai *cpu_dai;
 
 	struct delayed_work delayed_work;
+
+	enum soc_pcm_cmd_state cmd_platform_state;
+	enum soc_pcm_cmd_state cmd_cpu_dai_state;
+	enum soc_pcm_cmd_state cmd_codec_dai_state;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dpcm_root;
 	struct dentry *debugfs_dpcm_state;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 330c9a6..f10bd8d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -610,6 +610,51 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int soc_pcm_cmd_check(enum soc_pcm_cmd_state state, int cmd)
+{
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (state == SOC_PCM_RUNNING)
+			return 0;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		if (state == SOC_PCM_STOPPED)
+			return 0;
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		if (state == SOC_PCM_SUSPENDED)
+			return 0;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (state == SOC_PCM_PAUSED)
+			return 0;
+		break;
+	}
+	return 1;
+}
+
+static void soc_pcm_cmd_state_update(enum soc_pcm_cmd_state *state, int cmd)
+{
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		*state = SOC_PCM_RUNNING;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		*state = SOC_PCM_STOPPED;
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		*state = SOC_PCM_SUSPENDED;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		*state = SOC_PCM_PAUSED;
+		break;
+	}
+}
+
 static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -618,22 +663,28 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	if (codec_dai->driver->ops->trigger) {
+	if (codec_dai->driver->ops->trigger &&
+			soc_pcm_cmd_check(rtd->cmd_codec_dai_state, cmd)) {
 		ret = codec_dai->driver->ops->trigger(substream, cmd, codec_dai);
 		if (ret < 0)
 			return ret;
+		soc_pcm_cmd_state_update(&rtd->cmd_codec_dai_state, cmd);
 	}
 
-	if (platform->driver->ops && platform->driver->ops->trigger) {
+	if (platform->driver->ops && platform->driver->ops->trigger &&
+			soc_pcm_cmd_check(rtd->cmd_platform_state, cmd)) {
 		ret = platform->driver->ops->trigger(substream, cmd);
 		if (ret < 0)
 			return ret;
+		soc_pcm_cmd_state_update(&rtd->cmd_platform_state, cmd);
 	}
 
-	if (cpu_dai->driver->ops->trigger) {
+	if (cpu_dai->driver->ops->trigger &&
+			soc_pcm_cmd_check(rtd->cmd_cpu_dai_state, cmd)) {
 		ret = cpu_dai->driver->ops->trigger(substream, cmd, cpu_dai);
 		if (ret < 0)
 			return ret;
+		soc_pcm_cmd_state_update(&rtd->cmd_cpu_dai_state, cmd);
 	}
 	return 0;
 }
-- 
1.8.4.rc3
