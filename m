From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Remove snd_soc_dapm_connect_input()
Date: Thu, 16 Oct 2008 11:00:07 +0100
Message-ID: <1224151207-5496-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1224151207-5496-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71D3810381A
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Oct 2008 12:00:26 +0200 (CEST)
In-Reply-To: <1224151207-5496-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoffrey Wossum <geoffrey@pager.net>
List-Id: alsa-devel@alsa-project.org

This was marked as deprecated in 2.6.27 and all users except for
playpaq_wm8510 fixed in that release.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 --
 sound/soc/soc-dapm.c     |   22 ----------------------
 2 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index ca699a3..7ee2f70 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -221,8 +221,6 @@ int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 	int num);
 
 /* dapm path setup */
-int  __deprecated snd_soc_dapm_connect_input(struct snd_soc_codec *codec,
-	const char *sink_name, const char *control_name, const char *src_name);
 int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec);
 void snd_soc_dapm_free(struct snd_soc_device *socdev);
 int snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index efbd0b3..4060fc5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1007,28 +1007,6 @@ err:
 }
 
 /**
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
- * This function has been deprecated in favour of snd_soc_dapm_add_routes().
- *
- * Returns 0 for success else error.
- */
-int snd_soc_dapm_connect_input(struct snd_soc_codec *codec, const char *sink,
-	const char *control, const char *source)
-{
-	return snd_soc_dapm_add_route(codec, sink, control, source);
-}
-EXPORT_SYMBOL_GPL(snd_soc_dapm_connect_input);
-
-/**
  * snd_soc_dapm_add_routes - Add routes between DAPM widgets
  * @codec: codec
  * @route: audio routes
-- 
1.5.6.5
