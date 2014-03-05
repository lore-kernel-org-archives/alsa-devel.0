From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] ASoC: Move active count from CODEC to
	component
Date: Wed,  5 Mar 2014 13:17:47 +0100
Message-ID: <1394021868-11860-6-git-send-email-lars@metafoo.de>
References: <1394021868-11860-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id E2A0F2650D1
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 13:17:22 +0100 (CET)
In-Reply-To: <1394021868-11860-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

There is no reason why active count tracking should only be done for CODECs but
not for other components. Moving the active count from the snd_soc_codec struct
to the snd_soc_component struct reduces the differences between CODECs and other
components and will eventually allow component to component DAI links (Which is
a prerequisite for converting CODECs to components).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 12 ++++++++++--
 sound/soc/soc-pcm.c | 10 ++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5c2b4f4..0495b4a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -660,6 +660,9 @@ struct snd_soc_component {
 	const char *name;
 	int id;
 	struct device *dev;
+
+	unsigned int active;
+
 	struct list_head list;
 
 	struct snd_soc_dai_driver *dai_drv;
@@ -687,7 +690,6 @@ struct snd_soc_codec {
 
 	/* runtime */
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
-	unsigned int active;
 	unsigned int cache_bypass:1; /* Suppress access to the cache */
 	unsigned int suspended:1; /* Codec is in suspend PM state */
 	unsigned int probed:1; /* Codec has been probed */
@@ -1172,9 +1174,15 @@ static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
 	return 1;
 }
 
+static inline bool snd_soc_component_is_active(
+	struct snd_soc_component *component)
+{
+	return component->active != 0;
+}
+
 static inline bool snd_soc_codec_is_active(struct snd_soc_codec *codec)
 {
-	return codec->active != 0;
+	return snd_soc_component_is_active(&codec->component);
 }
 
 int snd_soc_util_init(void);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 71a01dd..98b4629 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -61,9 +61,8 @@ void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
 
 	cpu_dai->active++;
 	codec_dai->active++;
-	if (cpu_dai->codec)
-		cpu_dai->codec->active++;
-	codec_dai->codec->active++;
+	cpu_dai->component->active++;
+	codec_dai->component->active++;
 }
 
 /**
@@ -93,9 +92,8 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
 
 	cpu_dai->active--;
 	codec_dai->active--;
-	if (cpu_dai->codec)
-		cpu_dai->codec->active--;
-	codec_dai->codec->active--;
+	cpu_dai->component->active--;
+	codec_dai->component->active--;
 }
 
 /**
-- 
1.8.0
