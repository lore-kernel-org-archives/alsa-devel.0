From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 04/11] ASoC: Auto disconnect pins from all
	DAPM contexts
Date: Mon, 16 Jun 2014 18:13:04 +0200
Message-ID: <1402935191-18398-5-git-send-email-lars@metafoo.de>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id C1062265487
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 18:13:24 +0200 (CEST)
In-Reply-To: <1402935191-18398-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently only pins in CODEC DAPM contexts are automatically marked as
non-connected if the card has the fully_routed flag set. This makes sense since
widgets which qualify for auto-disconnection are only found in CODEC DAPM
contexts. But with componentisation this is going to change, so consider all
widgets for auto-disconnection.

Also it is probably faster to walk the widgets list only once rather than once
for each CODEC.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  2 +-
 sound/soc/soc-core.c     |  3 +--
 sound/soc/soc-dapm.c     | 27 +++++++++++----------------
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 6b59471..8db627c 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -431,7 +431,7 @@ int snd_soc_dapm_force_enable_pin_unlocked(struct snd_soc_dapm_context *dapm,
 					   const char *pin);
 int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 				const char *pin);
-void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec);
+void snd_soc_dapm_auto_nc_pins(struct snd_soc_card *card);
 
 /* Mostly internal - should not normally be used */
 void dapm_mark_io_dirty(struct snd_soc_dapm_context *dapm);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0944da6..bca8a71 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1928,8 +1928,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	if (card->fully_routed)
-		list_for_each_entry(codec, &card->codec_dev_list, card_list)
-			snd_soc_dapm_auto_nc_codec_pins(codec);
+		snd_soc_dapm_auto_nc_pins(card);
 
 	snd_soc_dapm_new_widgets(card);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f3ccf6d1..fab1a88 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3766,36 +3766,31 @@ static bool snd_soc_dapm_widget_in_card_paths(struct snd_soc_card *card,
 }
 
 /**
- * snd_soc_dapm_auto_nc_codec_pins - call snd_soc_dapm_nc_pin for unused pins
- * @codec: The codec whose pins should be processed
+ * snd_soc_dapm_auto_nc_pins - call snd_soc_dapm_nc_pin for unused pins
+ * @card: The card whose pins should be processed
  *
- * Automatically call snd_soc_dapm_nc_pin() for any external pins in the codec
- * which are unused. Pins are used if they are connected externally to the
- * codec, whether that be to some other device, or a loop-back connection to
- * the codec itself.
+ * Automatically call snd_soc_dapm_nc_pin() for any external pins in the card
+ * which are unused. Pins are used if they are connected externally to a
+ * component, whether that be to some other device, or a loop-back connection to
+ * the component itself.
  */
-void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec)
+void snd_soc_dapm_auto_nc_pins(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card = codec->card;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_dapm_widget *w;
 
-	dev_dbg(codec->dev, "ASoC: Auto NC: DAPMs: card:%p codec:%p\n",
-		&card->dapm, &codec->dapm);
+	dev_dbg(card->dev, "ASoC: Auto NC: DAPMs: card:%p\n", &card->dapm);
 
 	list_for_each_entry(w, &card->widgets, list) {
-		if (w->dapm != dapm)
-			continue;
 		switch (w->id) {
 		case snd_soc_dapm_input:
 		case snd_soc_dapm_output:
 		case snd_soc_dapm_micbias:
-			dev_dbg(codec->dev, "ASoC: Auto NC: Checking widget %s\n",
+			dev_dbg(card->dev, "ASoC: Auto NC: Checking widget %s\n",
 				w->name);
 			if (!snd_soc_dapm_widget_in_card_paths(card, w)) {
-				dev_dbg(codec->dev,
+				dev_dbg(card->dev,
 					"... Not in map; disabling\n");
-				snd_soc_dapm_nc_pin(dapm, w->name);
+				snd_soc_dapm_nc_pin(w->dapm, w->name);
 			}
 			break;
 		default:
-- 
1.8.0
