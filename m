From: yang.a.fang@intel.com
Subject: [PATCH 1/2] ASoC: extend seq_notifier callback
	interface
Date: Thu,  6 Aug 2015 16:15:44 -0700
Message-ID: <1438902946-49633-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F1960260653
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 01:16:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, Anish.Kumar@maximintegrated.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, ullysses.a.eoff@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

This is needed for some codec driver to know whether

it is power up/down sequence call from dapm

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 include/sound/soc-dapm.h  |    2 +-
 include/sound/soc.h       |    2 +-
 sound/soc/codecs/wm5100.c |    2 +-
 sound/soc/codecs/wm8903.c |    2 +-
 sound/soc/codecs/wm8996.c |    2 +-
 sound/soc/soc-dapm.c      |    5 ++---
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 37d95a8..1d017a3 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -607,7 +607,7 @@ struct snd_soc_dapm_context {
 	/* Go to BIAS_OFF in suspend if the DAPM context is idle */
 	unsigned int suspend_bias_off:1;
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
-			     enum snd_soc_dapm_type, int);
+			     enum snd_soc_dapm_type, int, bool);
 
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_component *component; /* parent component */
diff --git a/include/sound/soc.h b/include/sound/soc.h
index add5097..0072e21 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -875,7 +875,7 @@ struct snd_soc_codec_driver {
 	bool suspend_bias_off;
 
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
-			     enum snd_soc_dapm_type, int);
+			     enum snd_soc_dapm_type, int, bool);
 
 	bool ignore_pmdown_time;  /* Doesn't benefit from pmdown delay */
 };
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 8120b0c..6f4e6c3 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -733,7 +733,7 @@ WM5100_MIXER_CONTROLS("LHPF4", WM5100_HPLP4MIX_INPUT_1_SOURCE),
 };
 
 static void wm5100_seq_notifier(struct snd_soc_dapm_context *dapm,
-				enum snd_soc_dapm_type event, int subseq)
+			enum snd_soc_dapm_type event, int subseq, bool power_up)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
 	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index b011253..12da3b1 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -280,7 +280,7 @@ static int wm8903_dcs_event(struct snd_soc_dapm_widget *w,
 #define WM8903_DCS_MODE_START_STOP 2
 
 static void wm8903_seq_notifier(struct snd_soc_dapm_context *dapm,
-				enum snd_soc_dapm_type event, int subseq)
+			enum snd_soc_dapm_type event, int subseq, bool power_up)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 2a696db..f12a900 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -686,7 +686,7 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, u16 mask)
 }
 
 static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
-				enum snd_soc_dapm_type event, int subseq)
+			enum snd_soc_dapm_type event, int subseq, bool power_up)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1992568..ebea2d3 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1528,8 +1528,7 @@ static void dapm_seq_run(struct snd_soc_card *card,
 				for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
 					if (sort[i] == cur_sort)
 						cur_dapm->seq_notifier(cur_dapm,
-								       i,
-								       cur_subseq);
+						i, cur_subseq, power_up);
 			}
 
 			if (cur_dapm && w->dapm != cur_dapm)
@@ -1591,7 +1590,7 @@ static void dapm_seq_run(struct snd_soc_card *card,
 		for (i = 0; i < ARRAY_SIZE(dapm_up_seq); i++)
 			if (sort[i] == cur_sort)
 				cur_dapm->seq_notifier(cur_dapm,
-						       i, cur_subseq);
+						       i, cur_subseq, power_up);
 	}
 
 	list_for_each_entry(d, &card->dapm_list, list) {
-- 
1.7.9.5
