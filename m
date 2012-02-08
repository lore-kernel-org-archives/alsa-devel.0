From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Convert single bit wide bitfields
	into bools
Date: Wed,  8 Feb 2012 18:58:06 +0000
Message-ID: <1328727486-923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7818C103E96
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 19:58:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It's what they are, we've just been using these for historical reasons.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h  |   12 ++++++------
 include/sound/soc-dapm.h |   26 +++++++++++++-------------
 include/sound/soc.h      |   32 ++++++++++++++++----------------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 1a2b08c..53f9a1f 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -208,7 +208,7 @@ struct snd_soc_dai_driver {
 	/* DAI capabilities */
 	struct snd_soc_pcm_stream capture;
 	struct snd_soc_pcm_stream playback;
-	unsigned int symmetric_rates:1;
+	bool symmetric_rates;
 
 	/* probe ordering - for components with runtime dependencies */
 	int probe_order;
@@ -230,13 +230,13 @@ struct snd_soc_dai {
 	struct snd_soc_dai_driver *driver;
 
 	/* DAI runtime info */
-	unsigned int capture_active:1;		/* stream is in use */
-	unsigned int playback_active:1;		/* stream is in use */
-	unsigned int symmetric_rates:1;
+	bool capture_active;		/* stream is in use */
+	bool playback_active;		/* stream is in use */
+	bool symmetric_rates;
 	struct snd_pcm_runtime *runtime;
 	unsigned int active;
-	unsigned char pop_wait:1;
-	unsigned char probed:1;
+	bool pop_wait;
+	bool probed;
 
 	/* DAI DMA data */
 	void *playback_dma_data;
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index db8435a..99661c0 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -456,9 +456,9 @@ struct snd_soc_dapm_path {
 	struct snd_kcontrol *kcontrol;
 
 	/* status */
-	u32 connect:1;	/* source and sink widgets are connected */
-	u32 walked:1;	/* path has been walked */
-	u32 weak:1;	/* path ignored for power management */
+	bool connect;	/* source and sink widgets are connected */
+	bool walked;	/* path has been walked */
+	bool weak;	/* path ignored for power management */
 
 	int (*connected)(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink);
@@ -488,16 +488,16 @@ struct snd_soc_dapm_widget {
 	unsigned int mask;			/* non-shifted mask */
 	unsigned int on_val;			/* on state value */
 	unsigned int off_val;			/* off state value */
-	unsigned char power:1;			/* block power status */
-	unsigned char invert:1;			/* invert the power bit */
-	unsigned char active:1;			/* active stream on DAC, ADC's */
-	unsigned char connected:1;		/* connected codec pin */
-	unsigned char new:1;			/* cnew complete */
-	unsigned char ext:1;			/* has external widgets */
-	unsigned char force:1;			/* force state */
-	unsigned char ignore_suspend:1;         /* kept enabled over suspend */
-	unsigned char new_power:1;		/* power from this run */
-	unsigned char power_checked:1;		/* power checked this run */
+	bool power;				/* block power status */
+	bool invert;				/* invert the power bit */
+	bool active;				/* active stream on DAC, ADC's */
+	bool connected;				/* connected codec pin */
+	bool new;				/* cnew complete */
+	bool ext;				/* has external widgets */
+	bool force;				/* force state */
+	bool ignore_suspend;		        /* kept enabled over suspend */
+	bool new_power;				/* power from this run */
+	bool power_checked;			/* power checked this run */
 	int subseq;				/* sort within widget type */
 
 	int (*power_check)(struct snd_soc_dapm_widget *w);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index d1e7a6a..466b1f3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -571,14 +571,14 @@ struct snd_soc_codec {
 	/* runtime */
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
 	unsigned int active;
-	unsigned int cache_bypass:1; /* Suppress access to the cache */
-	unsigned int suspended:1; /* Codec is in suspend PM state */
-	unsigned int probed:1; /* Codec has been probed */
-	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
-	unsigned int ac97_created:1; /* Codec has been created by SoC */
-	unsigned int sysfs_registered:1; /* codec has been sysfs registered */
-	unsigned int cache_init:1; /* codec cache has been initialized */
-	unsigned int using_regmap:1; /* using regmap access */
+	bool cache_bypass; /* Suppress access to the cache */
+	bool suspended; /* Codec is in suspend PM state */
+	bool probed; /* Codec has been probed */
+	bool ac97_registered; /* Codec has been AC97 registered */
+	bool ac97_created; /* Codec has been created by SoC */
+	bool sysfs_registered; /* codec has been sysfs registered */
+	bool cache_init; /* codec cache has been initialized */
+	bool using_regmap; /* using regmap access */
 	u32 cache_only;  /* Suppress writes to hardware */
 	u32 cache_sync; /* Cache needs to be synced to hardware */
 
@@ -598,7 +598,7 @@ struct snd_soc_codec {
 
 	/* dapm */
 	struct snd_soc_dapm_context dapm;
-	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
+	bool ignore_pmdown_time; /* pmdown_time is ignored at stop */
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_codec_root;
@@ -712,8 +712,8 @@ struct snd_soc_platform {
 	struct device *dev;
 	struct snd_soc_platform_driver *driver;
 
-	unsigned int suspended:1; /* platform is suspended */
-	unsigned int probed:1;
+	bool suspended; /* platform is suspended */
+	bool probed;
 
 	struct snd_soc_card *card;
 	struct list_head list;
@@ -737,13 +737,13 @@ struct snd_soc_dai_link {
 	unsigned int dai_fmt;           /* format to set on init */
 
 	/* Keep DAI active over suspend */
-	unsigned int ignore_suspend:1;
+	bool ignore_suspend;
 
 	/* Symmetry requirements */
-	unsigned int symmetric_rates:1;
+	bool symmetric_rates;
 
 	/* pmdown_time is ignored at stop */
-	unsigned int ignore_pmdown_time:1;
+	bool ignore_pmdown_time;
 
 	/* codec/machine specific init - e.g. add machine controls */
 	int (*init)(struct snd_soc_pcm_runtime *rtd);
@@ -876,8 +876,8 @@ struct snd_soc_pcm_runtime {
 	enum snd_soc_pcm_subclass pcm_subclass;
 	struct snd_pcm_ops ops;
 
-	unsigned int complete:1;
-	unsigned int dev_registered:1;
+	bool complete;
+	bool dev_registered;
 
 	long pmdown_time;
 
-- 
1.7.9.rc1
