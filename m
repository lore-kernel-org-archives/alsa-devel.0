From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] ASoC: dapm_widget_show_codec: Use
	component instead of CODEC
Date: Mon,  6 Jul 2015 15:38:10 +0200
Message-ID: <1436189891-15343-5-git-send-email-lars@metafoo.de>
References: <1436189891-15343-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-092.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EFFC2606E8
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 15:38:23 +0200 (CEST)
In-Reply-To: <1436189891-15343-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Yang A Fang <yang.a.fang@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Kevin Cernekee <cernekee@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

There is nothing snd_soc_codec specific in this function, just use
snd_soc_component instead.

With this also the last reference of snd_soc_codec form soc-dapm.c.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a47a8ce..f7d93a8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2220,14 +2220,16 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mixer_update_power);
 
-static ssize_t dapm_widget_show_codec(struct snd_soc_codec *codec, char *buf)
+static ssize_t dapm_widget_show_component(struct snd_soc_component *cmpnt,
+	char *buf)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cmpnt);
 	struct snd_soc_dapm_widget *w;
 	int count = 0;
 	char *state = "not set";
 
-	list_for_each_entry(w, &codec->component.card->widgets, list) {
-		if (w->dapm != &codec->dapm)
+	list_for_each_entry(w, &cmpnt->card->widgets, list) {
+		if (w->dapm != dapm)
 			continue;
 
 		/* only display widgets that burnm power */
@@ -2255,7 +2257,7 @@ static ssize_t dapm_widget_show_codec(struct snd_soc_codec *codec, char *buf)
 		}
 	}
 
-	switch (codec->dapm.bias_level) {
+	switch (snd_soc_dapm_get_bias_level(dapm)) {
 	case SND_SOC_BIAS_ON:
 		state = "On";
 		break;
@@ -2282,8 +2284,9 @@ static ssize_t dapm_widget_show(struct device *dev,
 	int i, count = 0;
 
 	for (i = 0; i < rtd->num_codecs; i++) {
-		struct snd_soc_codec *codec = rtd->codec_dais[i]->codec;
-		count += dapm_widget_show_codec(codec, buf + count);
+		struct snd_soc_component *cmpnt = rtd->codec_dais[i]->component;
+
+		count += dapm_widget_show_component(cmpnt, buf + count);
 	}
 
 	return count;
-- 
2.1.4
