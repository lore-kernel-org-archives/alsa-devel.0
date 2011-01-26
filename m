From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add subsequence information to
	seq_notify callbacks
Date: Wed, 26 Jan 2011 21:41:56 +0000
Message-ID: <1296078116-28867-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E0FF245B0
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 22:41:59 +0100 (CET)
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

Allows drivers to distinguish which subsequence is being notified when
they get called back.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 +-
 include/sound/soc.h      |    2 +-
 sound/soc/soc-dapm.c     |    5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 6a25e69..979ed84 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -501,7 +501,7 @@ struct snd_soc_dapm_context {
 	struct snd_soc_dapm_update *update;
 
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
-			     enum snd_soc_dapm_type);
+			     enum snd_soc_dapm_type, int);
 
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_codec *codec; /* parent codec */
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 49a14da..ab0d5cd 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -554,7 +554,7 @@ struct snd_soc_codec_driver {
 			      enum snd_soc_bias_level level);
 
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
-			     enum snd_soc_dapm_type);
+			     enum snd_soc_dapm_type, int);
 };
 
 /* SoC platform interface */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 37b376f..0f94fd0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -899,7 +899,8 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 				for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
 					if (sort[i] == cur_sort)
 						cur_dapm->seq_notifier(cur_dapm,
-								       i);
+								       i,
+								       cur_subseq);
 			}
 
 			INIT_LIST_HEAD(&pending);
@@ -968,7 +969,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 		for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
 			if (sort[i] == cur_sort)
 				cur_dapm->seq_notifier(cur_dapm,
-						       i);
+						       i, cur_subseq);
 	}
 }
 
-- 
1.7.2.3
