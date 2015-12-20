From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] ASoC: fsl-asoc-card: use different route map for AC'97 mode
Date: Sun, 20 Dec 2015 21:34:29 +0100
Message-ID: <567710D5.5040405@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

fsl_ssi uses different stream names ("AC97 Playback" / "AC97 Capture")
in AC'97 mode so in this case fsl-asoc-card route map should
also be using them.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl-asoc-card.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index c63d89da51f1..562b3bd22d9a 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -107,6 +107,13 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"CPU-Capture",  NULL, "Capture"},
 };
 
+static const struct snd_soc_dapm_route audio_map_ac97[] = {
+	{"AC97 Playback",  NULL, "ASRC-Playback"},
+	{"Playback",  NULL, "AC97 Playback"},
+	{"ASRC-Capture",  NULL, "AC97 Capture"},
+	{"AC97 Capture",  NULL, "Capture"},
+};
+
 /* Add all possible widgets into here without being redundant */
 static const struct snd_soc_dapm_widget fsl_asoc_card_dapm_widgets[] = {
 	SND_SOC_DAPM_LINE("Line Out Jack", NULL),
@@ -579,7 +586,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	priv->card.dev = &pdev->dev;
 	priv->card.name = priv->name;
 	priv->card.dai_link = priv->dai_link;
-	priv->card.dapm_routes = audio_map;
+	priv->card.dapm_routes = fsl_asoc_card_is_ac97(priv) ?
+				 audio_map_ac97 : audio_map;
 	priv->card.late_probe = fsl_asoc_card_late_probe;
 	priv->card.num_dapm_routes = ARRAY_SIZE(audio_map);
 	priv->card.dapm_widgets = fsl_asoc_card_dapm_widgets;
