From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Let snd_soc_limit_volume() take a
	snd_soc_card
Date: Sun, 18 Oct 2015 17:04:33 +0200
Message-ID: <1445180673-27790-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id E59B72605CC
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 17:04:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

snd_soc_limit_volume() operates on a card and the CODEC that is passed in
is only used to look up the card. Let it directly take the card instead.
This makes it possible to use it when no snd_soc_codec is available.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h   | 2 +-
 sound/soc/omap/rx51.c | 2 +-
 sound/soc/soc-ops.c   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index bd85564..8b06678 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -612,7 +612,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_limit_volume(struct snd_soc_codec *codec,
+int snd_soc_limit_volume(struct snd_soc_card *card,
 	const char *name, int max);
 int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_info *uinfo);
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 3bebfb1..9953890 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -297,7 +297,7 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 		dev_err(card->dev, "Failed to add TPA6130A2 controls\n");
 		return err;
 	}
-	snd_soc_limit_volume(codec, "TPA6130A2 Headphone Playback Volume", 42);
+	snd_soc_limit_volume(card, "TPA6130A2 Headphone Playback Volume", 42);
 
 	err = omap_mcbsp_st_add_controls(rtd, 2);
 	if (err < 0) {
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 05977ae..ecd38e5 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -588,16 +588,16 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
 /**
  * snd_soc_limit_volume - Set new limit to an existing volume control.
  *
- * @codec: where to look for the control
+ * @card: where to look for the control
  * @name: Name of the control
  * @max: new maximum limit
  *
  * Return 0 for success, else error.
  */
-int snd_soc_limit_volume(struct snd_soc_codec *codec,
+int snd_soc_limit_volume(struct snd_soc_card *card,
 	const char *name, int max)
 {
-	struct snd_card *card = codec->component.card->snd_card;
+	struct snd_card *snd_card = card->snd_card;
 	struct snd_kcontrol *kctl;
 	struct soc_mixer_control *mc;
 	int found = 0;
@@ -607,7 +607,7 @@ int snd_soc_limit_volume(struct snd_soc_codec *codec,
 	if (unlikely(!name || max <= 0))
 		return -EINVAL;
 
-	list_for_each_entry(kctl, &card->controls, list) {
+	list_for_each_entry(kctl, &snd_card->controls, list) {
 		if (!strncmp(kctl->id.name, name, sizeof(kctl->id.name))) {
 			found = 1;
 			break;
-- 
2.1.4
