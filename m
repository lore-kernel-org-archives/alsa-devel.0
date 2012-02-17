From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/8] ASoC: dapm: Constify lots of names that
	are never modified
Date: Thu, 16 Feb 2012 21:56:07 -0800
Message-ID: <1329458170-22119-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1498E103A4A
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 06:56:17 +0100 (CET)
In-Reply-To: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Neater and avoids warnings when used in other places where const strings
are desired.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    8 ++++----
 include/sound/soc.h      |    2 +-
 sound/soc/soc-core.c     |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c32c521..91eb812 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -445,8 +445,8 @@ struct snd_soc_dapm_route {
 
 /* dapm audio path between two widgets */
 struct snd_soc_dapm_path {
-	char *name;
-	char *long_name;
+	const char *name;
+	const char *long_name;
 
 	/* source (input) and sink (output) widgets */
 	struct snd_soc_dapm_widget *source;
@@ -469,8 +469,8 @@ struct snd_soc_dapm_path {
 /* dapm widget */
 struct snd_soc_dapm_widget {
 	enum snd_soc_dapm_type id;
-	char *name;		/* widget name */
-	char *sname;	/* stream name */
+	const char *name;		/* widget name */
+	const char *sname;	/* stream name */
 	struct snd_soc_codec *codec;
 	struct snd_soc_platform *platform;
 	struct list_head list;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index a1da298..b78f84d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -373,7 +373,7 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
  *Controls
  */
 struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
-				  void *data, char *long_name,
+				  void *data, const char *long_name,
 				  const char *prefix);
 int snd_soc_add_codec_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 87a3c5c..bfcf5d7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2018,7 +2018,7 @@ EXPORT_SYMBOL_GPL(snd_soc_set_runtime_hwparams);
  * Returns 0 for success, else error.
  */
 struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
-				  void *data, char *long_name,
+				  void *data, const char *long_name,
 				  const char *prefix)
 {
 	struct snd_kcontrol_new template;
-- 
1.7.9.rc1
