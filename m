From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/10] soc - DAPM - Bulk route registration
Date: Tue, 13 May 2008 12:40:08 +0100
Message-ID: <1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C75B24AE9
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:40:18 +0200 (CEST)
In-Reply-To: <1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Graeme Gregory <graeme@openmoko.org>, Richard Purdie <rpurdie@rpsys.net>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

ASoC codecs and machine drivers that use DAPM routes all cut'n'paste a
loop iterating over a null terminated array of routes.  Factor out this
into a bulk registration function, improving the error reporting for
most users, and deprecate the old API to help out of tree users pick up
the changes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Graeme Gregory <graeme@openmoko.org>
Cc: Frank Mandarino <fmandarino@endrelia.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
---
 include/sound/soc-dapm.h |   17 ++++++++++-
 sound/soc/soc-dapm.c     |   72 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 1f30616..bf4cf0c 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -193,6 +193,7 @@ struct snd_soc_dapm_widget;
 enum snd_soc_dapm_type;
 struct snd_soc_dapm_path;
 struct snd_soc_dapm_pin;
+struct snd_soc_dapm_route;
 
 /* dapm controls */
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
@@ -210,10 +211,12 @@ int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 	int num);
 
 /* dapm path setup */
-int snd_soc_dapm_connect_input(struct snd_soc_codec *codec,
+int  __deprecated snd_soc_dapm_connect_input(struct snd_soc_codec *codec,
 	const char *sink_name, const char *control_name, const char *src_name);
 int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec);
 void snd_soc_dapm_free(struct snd_soc_device *socdev);
+int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
+			    const struct snd_soc_dapm_route *route, int num);
 
 /* dapm events */
 int snd_soc_dapm_stream_event(struct snd_soc_codec *codec, char *stream,
@@ -250,6 +253,18 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_post,			/* machine specific post widget - exec last */
 };
 
+/*
+ * DAPM audio route definition.
+ *
+ * Defines an audio route originating at source via control and finishing
+ * at sink.
+ */
+struct snd_soc_dapm_route {
+	const char *sink;
+	const char *control;
+	const char *source;
+};
+
 /* dapm audio path between two widgets */
 struct snd_soc_dapm_path {
 	char *name;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 811d652..1ef6d94 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -841,21 +841,8 @@ int snd_soc_dapm_sync_endpoints(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync_endpoints);
 
-/**
- * snd_soc_dapm_connect_input - connect dapm widgets
- * @codec: audio codec
- * @sink: name of target widget
- * @control: mixer control name
- * @source: name of source name
- *
- * Connects 2 dapm widgets together via a named audio path. The sink is
- * the widget receiving the audio signal, whilst the source is the sender
- * of the audio signal.
- *
- * Returns 0 for success else error.
- */
-int snd_soc_dapm_connect_input(struct snd_soc_codec *codec, const char *sink,
-	const char * control, const char *source)
+static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
+	const char *sink, const char *control, const char *source)
 {
 	struct snd_soc_dapm_path *path;
 	struct snd_soc_dapm_widget *wsource = NULL, *wsink = NULL, *w;
@@ -957,9 +944,64 @@ err:
 	kfree(path);
 	return ret;
 }
+
+/**
+ * snd_soc_dapm_connect_input - connect dapm widgets
+ * @codec: audio codec
+ * @sink: name of target widget
+ * @control: mixer control name
+ * @source: name of source name
+ *
+ * Connects 2 dapm widgets together via a named audio path. The sink is
+ * the widget receiving the audio signal, whilst the source is the sender
+ * of the audio signal.
+ *
+ * This function has been deprecated in favour of snd_soc_dapm_add_routes().
+ *
+ * Returns 0 for success else error.
+ */
+int snd_soc_dapm_connect_input(struct snd_soc_codec *codec, const char *sink,
+	const char *control, const char *source)
+{
+	return snd_soc_dapm_add_route(codec, sink, control, source);
+}
 EXPORT_SYMBOL_GPL(snd_soc_dapm_connect_input);
 
 /**
+ * snd_soc_dapm_add_routes - Add routes between DAPM widgets
+ * @codec: codec
+ * @route: audio routes
+ * @num: number of routes
+ *
+ * Connects 2 dapm widgets together via a named audio path. The sink is
+ * the widget receiving the audio signal, whilst the source is the sender
+ * of the audio signal.
+ *
+ * Returns 0 for success else error. On error all resources can be freed
+ * with a call to snd_soc_card_free().
+ */
+int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
+			    const struct snd_soc_dapm_route *route, int num)
+{
+	int i, ret;
+
+	for (i = 0; i < num; i++) {
+		ret = snd_soc_dapm_add_route(codec, route->sink,
+					     route->control, route->source);
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to add route %s->%s\n",
+			       route->source,
+			       route->sink);
+			return ret;
+		}
+		route++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
+
+/**
  * snd_soc_dapm_new_widgets - add new dapm widgets
  * @codec: audio codec
  *
-- 
1.5.5.1
