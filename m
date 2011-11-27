From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Log automatic pin disconnection per
	CODEC rather than per card
Date: Sun, 27 Nov 2011 19:42:54 +0000
Message-ID: <1322422974-976-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B9FBE103839
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 20:42:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This makes the output a bit less confusing on multi-CODEC systems as the
same pin may appear in multiple CODECs.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 81f91f1..c3cde81 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3002,7 +3002,7 @@ void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_dapm_widget *w;
 
-	dev_dbg(card->dev, "Auto NC: DAPMs: card:%p codec:%p\n",
+	dev_dbg(codec->dev, "Auto NC: DAPMs: card:%p codec:%p\n",
 		&card->dapm, &codec->dapm);
 
 	list_for_each_entry(w, &card->widgets, list) {
@@ -3012,10 +3012,10 @@ void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec)
 		case snd_soc_dapm_input:
 		case snd_soc_dapm_output:
 		case snd_soc_dapm_micbias:
-			dev_dbg(card->dev, "Auto NC: Checking widget %s\n",
+			dev_dbg(codec->dev, "Auto NC: Checking widget %s\n",
 				w->name);
 			if (!snd_soc_dapm_widget_in_card_paths(card, w)) {
-				dev_dbg(card->dev,
+				dev_dbg(codec->dev,
 					"... Not in map; disabling\n");
 				snd_soc_dapm_nc_pin(dapm, w->name);
 			}
-- 
1.7.7.3
