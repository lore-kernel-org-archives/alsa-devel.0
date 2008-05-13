From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 02/10] soc - DAPM - Add bulk control
	registration
Date: Tue, 13 May 2008 12:40:07 +0100
Message-ID: <1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B2EB024ACD
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:40:18 +0200 (CEST)
In-Reply-To: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Most SoC drivers cut'n'paste a loop iterating over an array to register
their DAPM controls.  Provide a function they can call instead.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Graeme Gregory <graeme@openmoko.org>
Cc: Frank Mandarino <fmandarino@endrelia.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
---
 include/sound/soc-dapm.h |    3 +++
 sound/soc/soc-dapm.c     |   27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 40cc695..1f30616 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -205,6 +205,9 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
 	const struct snd_soc_dapm_widget *widget);
+int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
+	const struct snd_soc_dapm_widget *widget,
+	int num);
 
 /* dapm path setup */
 int snd_soc_dapm_connect_input(struct snd_soc_codec *codec,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c60200c..811d652 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1234,6 +1234,33 @@ int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
 
 /**
+ * snd_soc_dapm_new_controls - create new dapm controls
+ * @codec: audio codec
+ * @widget: widget array
+ * @num: number of widgets
+ *
+ * Creates new DAPM controls based upon the templates.
+ *
+ * Returns 0 for success else error.
+ */
+int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
+	const struct snd_soc_dapm_widget *widget,
+	int num)
+{
+	int i, ret;
+
+	for (i = 0; i < num; i++) {
+		ret = snd_soc_dapm_new_control(codec, widget);
+		if (ret < 0)
+			return ret;
+		widget++;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
+
+
+/**
  * snd_soc_dapm_stream_event - send a stream event to the dapm core
  * @codec: audio codec
  * @stream: stream name
-- 
1.5.5.1
