From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/7] ASoC: Move ignore_pmdown_time from CODEC
	to component
Date: Wed,  5 Mar 2014 13:17:48 +0100
Message-ID: <1394021868-11860-7-git-send-email-lars@metafoo.de>
References: <1394021868-11860-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id A88642650D4
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 13:17:23 +0100 (CET)
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

In preparation for componentization move the ignore_pmdown_time field from the
snd_soc_codec struct to the snd_soc_component struct. Set it to true for non
CODEC components for now.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  3 ++-
 sound/soc/soc-core.c |  4 +++-
 sound/soc/soc-pcm.c  | 10 ++--------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0495b4a..b14acd8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -663,6 +663,8 @@ struct snd_soc_component {
 
 	unsigned int active;
 
+	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
+
 	struct list_head list;
 
 	struct snd_soc_dai_driver *dai_drv;
@@ -715,7 +717,6 @@ struct snd_soc_codec {
 
 	/* dapm */
 	struct snd_soc_dapm_context dapm;
-	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_codec_root;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6401e97..18aecd2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4127,6 +4127,8 @@ int snd_soc_register_component(struct device *dev,
 		return -ENOMEM;
 	}
 
+	cmpnt->ignore_pmdown_time = true;
+
 	return __snd_soc_register_component(dev, cmpnt, cmpnt_drv,
 					    dai_drv, num_dai, true);
 }
@@ -4325,7 +4327,7 @@ int snd_soc_register_codec(struct device *dev,
 	codec->volatile_register = codec_drv->volatile_register;
 	codec->readable_register = codec_drv->readable_register;
 	codec->writable_register = codec_drv->writable_register;
-	codec->ignore_pmdown_time = codec_drv->ignore_pmdown_time;
+	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.dev = dev;
 	codec->dapm.codec = codec;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 98b4629..2cedf09 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -107,17 +107,11 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
  */
 bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
 {
-	bool ignore = true;
-
 	if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
 		return true;
 
-	if (rtd->cpu_dai->codec)
-		ignore &= rtd->cpu_dai->codec->ignore_pmdown_time;
-
-	ignore &= rtd->codec_dai->codec->ignore_pmdown_time;
-
-	return ignore;
+	return rtd->cpu_dai->component->ignore_pmdown_time &&
+			rtd->codec_dai->component->ignore_pmdown_time;
 }
 
 /**
-- 
1.8.0
