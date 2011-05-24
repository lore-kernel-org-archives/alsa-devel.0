From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm - add method to get AIF widget from
	stream
Date: Tue, 24 May 2011 17:39:39 +0100
Message-ID: <1306255179-4557-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id EA658103984
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 18:39:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

In preparation for ASoC DSP support.

Provide a method to get the AIF widget name from the stream name.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    2 ++
 sound/soc/soc-dapm.c     |   17 +++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c46e7d8..f37c293 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -348,6 +348,8 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm);
 void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm);
 int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num);
+const char *snd_soc_dapm_get_aif(struct snd_soc_dapm_context *dapm,
+		const char *stream_name, enum snd_soc_dapm_type type);
 
 /* dapm events */
 int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c5d98e3..1b7f4ff 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1882,6 +1882,23 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
 
+const char *snd_soc_dapm_get_aif(struct snd_soc_dapm_context *dapm,
+		const char *stream_name, enum snd_soc_dapm_type type)
+{
+	struct snd_soc_dapm_widget *w;
+
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+
+		if (!w->sname)
+			continue;
+
+		if (w->id == type && strstr(w->sname, stream_name))
+			return w->name;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_get_aif);
+
 /**
  * snd_soc_dapm_get_volsw - dapm mixer get callback
  * @kcontrol: mixer control
-- 
1.7.4.1
