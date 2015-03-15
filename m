From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Make snd_soc_dapm_kcontrol_codec() inline
Date: Sun, 15 Mar 2015 10:27:20 +0100
Message-ID: <1426411641-23769-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-060.synserver.de (smtp-out-060.synserver.de
 [212.40.185.60])
 by alsa0.perex.cz (Postfix) with ESMTP id 043B32606D3
 for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2015 10:27:14 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

snd_soc_dapm_kcontrol_codec() is a extremely simple function and inlining it
typically results in less code than necessary for calling the non-inlined
version of the function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  1 -
 include/sound/soc.h      | 13 +++++++++++++
 sound/soc/soc-dapm.c     | 10 ----------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 8d7416e..78633ef 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -440,7 +440,6 @@ void dapm_mark_endpoints_dirty(struct snd_soc_card *card);
 int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	struct snd_soc_dapm_widget_list **list);
 
-struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol);
 struct snd_soc_dapm_context *snd_soc_dapm_kcontrol_dapm(
 	struct snd_kcontrol *kcontrol);
 
diff --git a/include/sound/soc.h b/include/sound/soc.h
index bc6cfab..92b92ac 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1268,6 +1268,19 @@ static inline struct snd_soc_dapm_context *snd_soc_component_get_dapm(
 	return component->dapm_ptr;
 }
 
+/**
+ * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
+ * @kcontrol: The kcontrol
+ *
+ * This function must only be used on DAPM contexts that are known to be part of
+ * a CODEC (e.g. in a CODEC driver). Otherwise the behavior is undefined.
+ */
+static inline struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(
+	struct snd_kcontrol *kcontrol)
+{
+	return snd_soc_dapm_to_codec(snd_soc_dapm_kcontrol_dapm(kcontrol));
+}
+
 /* codec IO */
 unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
 int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b6f8820..95337c8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -473,16 +473,6 @@ struct snd_soc_dapm_context *snd_soc_dapm_kcontrol_dapm(
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_dapm);
 
-/**
- * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
- * @kcontrol: The kcontrol
- */
-struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol)
-{
-	return snd_soc_dapm_to_codec(snd_soc_dapm_kcontrol_dapm(kcontrol));
-}
-EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_codec);
-
 static void dapm_reset(struct snd_soc_card *card)
 {
 	struct snd_soc_dapm_widget *w;
-- 
1.8.0
