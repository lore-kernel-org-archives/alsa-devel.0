From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 5/5] ASoC: tpa6130a2: Make DAPM registration
	optional, and direct interface
Date: Tue, 30 Nov 2010 16:00:04 +0200
Message-ID: <1291125604-10396-6-git-send-email-peter.ujfalusi@nokia.com>
References: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 40AC910398B
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 15:00:13 +0100 (CET)
In-Reply-To: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Users can choose to not add the DAPM routes provided by the
amp driver, but use the direct enable/disable interface
from machine driver with SND_SOC_DAPM_HP's event callback.
In some cases this method must be used to make the audio
path pop noise free.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |   30 +++++++++++++++++++++++++-----
 sound/soc/codecs/tpa6130a2.h |    3 ++-
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index c97badf..5a38372 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -377,7 +377,26 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"TPA6130A2 Headphone Stereo", NULL, "TPA6130A2 Enable"},
 };
 
-int tpa6130a2_add_controls(struct snd_soc_codec *codec)
+int tpa6130a2_stereo_enable(int enable)
+{
+	int ret = 0;
+	if (enable) {
+		ret = tpa6130a2_power(1);
+		if (ret < 0)
+			return ret;
+		tpa6130a2_channel_enable(TPA6130A2_HP_EN_R | TPA6130A2_HP_EN_L,
+					 1);
+	} else {
+		tpa6130a2_channel_enable(TPA6130A2_HP_EN_R | TPA6130A2_HP_EN_L,
+					 0);
+		ret = tpa6130a2_power(0);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tpa6130a2_stereo_enable);
+
+int tpa6130a2_add_controls(struct snd_soc_codec *codec, int with_dapm)
 {
 	struct	tpa6130a2_data *data;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
@@ -387,10 +406,11 @@ int tpa6130a2_add_controls(struct snd_soc_codec *codec)
 
 	data = i2c_get_clientdata(tpa6130a2_client);
 
-	snd_soc_dapm_new_controls(dapm, tpa6130a2_dapm_widgets,
-				ARRAY_SIZE(tpa6130a2_dapm_widgets));
-
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
+	if (with_dapm) {
+		snd_soc_dapm_new_controls(dapm, tpa6130a2_dapm_widgets,
+					ARRAY_SIZE(tpa6130a2_dapm_widgets));
+		snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
+	}
 
 	if (data->id == TPA6140A2)
 		return snd_soc_add_controls(codec, tpa6140a2_controls,
diff --git a/sound/soc/codecs/tpa6130a2.h b/sound/soc/codecs/tpa6130a2.h
index 57e867f..e3150d9 100644
--- a/sound/soc/codecs/tpa6130a2.h
+++ b/sound/soc/codecs/tpa6130a2.h
@@ -56,6 +56,7 @@
 /* TPA6130A2_REG_VERSION (0x04) */
 #define TPA6130A2_VERSION_MASK		(0x0f)
 
-extern int tpa6130a2_add_controls(struct snd_soc_codec *codec);
+extern int tpa6130a2_add_controls(struct snd_soc_codec *codec, int with_dapm);
+extern int tpa6130a2_stereo_enable(int enable);
 
 #endif /* __TPA6130A2_H__ */
-- 
1.7.3.2
