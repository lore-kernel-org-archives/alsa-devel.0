From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: dapm: Export
	dapm_kcontrol_set_value() so it can be used by drivers
Date: Tue, 27 May 2014 13:53:05 +0300
Message-ID: <1401187986-11059-2-git-send-email-peter.ujfalusi@ti.com>
References: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id D9E4D261691
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 12:53:15 +0200 (CEST)
In-Reply-To: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

Drivers needing special put dapm callbacks need to use this function to
update the state of the kcontrol associated with the widget.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc-dapm.h | 3 +++
 sound/soc/soc-dapm.c     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 6b59471cdf44..f31b323fe799 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -440,6 +440,9 @@ void dapm_mark_io_dirty(struct snd_soc_dapm_context *dapm);
 int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	struct snd_soc_dapm_widget_list **list);
 
+bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
+	unsigned int value);
+
 struct snd_soc_codec *snd_soc_dapm_kcontrol_codec(struct snd_kcontrol *kcontrol);
 
 /* dapm widget types */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a74b9bf23d9f..a3df05d1f22e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -333,7 +333,7 @@ static unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol)
 	return data->value;
 }
 
-static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
+bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
 	unsigned int value)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
@@ -348,6 +348,7 @@ static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(dapm_kcontrol_set_value);
 
 /**
  * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
-- 
1.9.3
