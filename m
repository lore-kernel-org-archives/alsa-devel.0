From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] soc - DAPM - add hook to read state of
	DAPM widget
Date: Wed, 30 Apr 2008 15:19:06 +0100
Message-ID: <1209565146-32393-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1209565146-32393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1209565146-32393-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1209565146-32393-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 647A9245F8
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 16:19:09 +0200 (CEST)
In-Reply-To: <1209565146-32393-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Graeme Gregory <graeme@openmoko.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Graeme Gregory <graeme@openmoko.org>

This adds a hook to read the power state of a DAPM widget, I use this
in the gta02 driver to expose certain DAPM widgets in the mixer for
ease of audio routing.

Signed-off-by: Graeme Gregory <graeme@openmoko.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 ++
 sound/soc/soc-dapm.c     |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a105b01..40cc695 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -223,6 +223,8 @@ int snd_soc_dapm_sys_add(struct device *dev);
 /* dapm audio endpoint control */
 int snd_soc_dapm_set_endpoint(struct snd_soc_codec *codec,
 	char *pin, int status);
+int snd_soc_dapm_get_endpoint_status(struct snd_soc_codec *codec,
+	char *pin);
 int snd_soc_dapm_sync_endpoints(struct snd_soc_codec *codec);
 
 /* dapm widget types */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index af3326c..9fd5ee8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1343,6 +1343,29 @@ int snd_soc_dapm_set_endpoint(struct snd_soc_codec *codec,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_set_endpoint);
 
 /**
+ * snd_soc_dapm_get_endpoint_status - get audio endpoint status
+ * @codec: audio codec
+ * @endpoint: audio signal endpoint (or start point)
+ *
+ * Get audio endpoint status - connected or disconnected.
+ *
+ * Returns status
+ */
+int snd_soc_dapm_get_endpoint_status(struct snd_soc_codec *codec,
+	char *endpoint)
+{
+	struct snd_soc_dapm_widget *w;
+
+	list_for_each_entry(w, &codec->dapm_widgets, list) {
+		if (!strcmp(w->name, endpoint))
+			return w->connected;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_get_endpoint);
+
+/**
  * snd_soc_dapm_free - free dapm resources
  * @socdev: SoC device
  *
-- 
1.5.5.1
