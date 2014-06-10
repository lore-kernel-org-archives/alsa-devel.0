From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Power both channels for
	differential mono output
Date: Tue, 10 Jun 2014 18:41:02 +0100
Message-ID: <1402422062-7162-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A84A9265527
 for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2014 19:48:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On the wm5110 CODEC both the left and right channel must be powered
when an output is being used as a mono output, although no audio is
routed to the right output channel. This patch adds additional DAPM
routes to link the right channel to the left in the case where an output
is marked as mono. Audio must always be brought in on the left channel
for mono operation.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   25 +++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |    1 +
 sound/soc/codecs/wm5110.c  |    1 +
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 41b56ee..d441d80 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -243,6 +243,31 @@ int arizona_init_spk(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(arizona_init_spk);
 
+static const struct snd_soc_dapm_route arizona_mono_routes[] = {
+	{ "OUT1R", NULL, "OUT1L" },
+	{ "OUT2R", NULL, "OUT2L" },
+	{ "OUT3R", NULL, "OUT3L" },
+	{ "OUT4R", NULL, "OUT4L" },
+	{ "OUT5R", NULL, "OUT5L" },
+	{ "OUT6R", NULL, "OUT6L" },
+};
+
+int arizona_init_mono(struct snd_soc_codec *codec)
+{
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
+	int i;
+
+	for (i = 0; i < ARIZONA_MAX_OUTPUT; ++i) {
+		if (arizona->pdata.out_mono[i])
+			snd_soc_dapm_add_routes(&codec->dapm,
+						&arizona_mono_routes[i], 1);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_init_mono);
+
 int arizona_init_gpio(struct snd_soc_codec *codec)
 {
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 05ae17f..942cfb1 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -249,6 +249,7 @@ extern int arizona_set_fll(struct arizona_fll *fll, int source,
 
 extern int arizona_init_spk(struct snd_soc_codec *codec);
 extern int arizona_init_gpio(struct snd_soc_codec *codec);
+extern int arizona_init_mono(struct snd_soc_codec *codec);
 
 extern int arizona_init_dai(struct arizona_priv *priv, int dai);
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 2e5fcb5..62ef544 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1596,6 +1596,7 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
+	arizona_init_mono(codec);
 
 	ret = snd_soc_add_codec_controls(codec, wm_adsp2_fw_controls, 8);
 	if (ret != 0)
-- 
1.7.2.5
