From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Provide per widget type callback
	when executing DAPM sequences
Date: Tue, 18 Jan 2011 16:20:14 +0000
Message-ID: <1295367614-12143-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1295367614-12143-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 75D0E103947
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 17:20:18 +0100 (CET)
In-Reply-To: <1295367614-12143-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Many modern devices have features such as DC servos which take time to start.
Currently these are handled by per-widget events but this makes it difficult
to paralleise operations on multiple widgets, meaning delays can end up
being needlessly serialised. By providing a callback to drivers when all
widgets of a given type have been handled during a DAPM sequence the core
allows drivers to start operations separately and wait for them to complete
much more simply.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    3 +++
 include/sound/soc.h      |    3 +++
 sound/soc/soc-core.c     |    1 +
 sound/soc/soc-dapm.c     |   16 +++++++++++++++-
 4 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a3760c9..6c9ae23 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -500,6 +500,9 @@ struct snd_soc_dapm_context {
 
 	struct snd_soc_dapm_update *update;
 
+	void (*seq_notifier)(struct snd_soc_dapm_context *,
+			     enum snd_soc_dapm_type);
+
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_codec *codec; /* parent codec */
 	struct snd_soc_card *card; /* parent card */
diff --git a/include/sound/soc.h b/include/sound/soc.h
index d824e70..c0d2f4b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -545,6 +545,9 @@ struct snd_soc_codec_driver {
 	/* codec bias level */
 	int (*set_bias_level)(struct snd_soc_codec *,
 			      enum snd_soc_bias_level level);
+
+	void (*seq_notifier)(struct snd_soc_dapm_context *,
+			     enum snd_soc_dapm_type);
 };
 
 /* SoC platform interface */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8305712..08d7b98 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3496,6 +3496,7 @@ int snd_soc_register_codec(struct device *dev,
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.dev = dev;
 	codec->dapm.codec = codec;
+	codec->dapm.seq_notifier = codec_drv->seq_notifier;
 	codec->dev = dev;
 	codec->driver = codec_drv;
 	codec->num_dai = num_dai;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index eb7436c..37b376f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -878,7 +878,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 	int cur_subseq = -1;
 	int cur_reg = SND_SOC_NOPM;
 	struct snd_soc_dapm_context *cur_dapm = NULL;
-	int ret;
+	int ret, i;
 	int *sort;
 
 	if (power_up)
@@ -895,6 +895,13 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 			if (!list_empty(&pending))
 				dapm_seq_run_coalesced(cur_dapm, &pending);
 
+			if (cur_dapm && cur_dapm->seq_notifier) {
+				for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
+					if (sort[i] == cur_sort)
+						cur_dapm->seq_notifier(cur_dapm,
+								       i);
+			}
+
 			INIT_LIST_HEAD(&pending);
 			cur_sort = -1;
 			cur_subseq = -1;
@@ -956,6 +963,13 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 
 	if (!list_empty(&pending))
 		dapm_seq_run_coalesced(dapm, &pending);
+
+	if (cur_dapm && cur_dapm->seq_notifier) {
+		for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
+			if (sort[i] == cur_sort)
+				cur_dapm->seq_notifier(cur_dapm,
+						       i);
+	}
 }
 
 static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
-- 
1.7.2.3
