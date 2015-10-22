From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Let snd_soc_limit_volume() take a
	snd_soc_card" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:34 +0900
Message-ID: <E1ZpOzG-0008Rl-9z@finisterre>
References: <1445180673-27790-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 815B6266B42
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:52 +0200 (CEST)
In-Reply-To: <1445180673-27790-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Let snd_soc_limit_volume() take a snd_soc_card

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 26d9ca3462df8f7e83fc372b23c8da5ed2b1c4f3 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 18 Oct 2015 17:04:33 +0200
Subject: [PATCH] ASoC: Let snd_soc_limit_volume() take a snd_soc_card

snd_soc_limit_volume() operates on a card and the CODEC that is passed in
is only used to look up the card. Let it directly take the card instead.
This makes it possible to use it when no snd_soc_codec is available.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h   | 2 +-
 sound/soc/omap/rx51.c | 2 +-
 sound/soc/soc-ops.c   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 884e728..71e0c05 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -591,7 +591,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
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
index 100d92b..20f702a 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -560,16 +560,16 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
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
@@ -579,7 +579,7 @@ int snd_soc_limit_volume(struct snd_soc_codec *codec,
 	if (unlikely(!name || max <= 0))
 		return -EINVAL;
 
-	list_for_each_entry(kctl, &card->controls, list) {
+	list_for_each_entry(kctl, &snd_card->controls, list) {
 		if (!strncmp(kctl->id.name, name, sizeof(kctl->id.name))) {
 			found = 1;
 			break;
-- 
2.6.1
