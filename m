From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: dapm: Fix widget double free with auto-disable DAPM kcontrol
Date: Tue, 15 Apr 2014 16:58:09 +0300
Message-ID: <1397570289-29215-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Commit 9e1fda4ae158 ("ASoC: dapm: Implement mixer input auto-disable") is trying to
free the widget it allocated by snd_soc_dapm_new_control() call in
dapm_kcontrol_data_alloc() by adding kfree(data->widget) to dapm_kcontrol_free().

This is causing a widget double free with auto-disabled DAPM kcontrols in sound card
unregistration because widgets are already freed before dapm_kcontrol_free() is
called.

Reason for that is all widgets are added into dapm->card->widgets list in
snd_soc_dapm_new_control() and freed in dapm_free_widgets() during execution of
snd_soc_dapm_free().

Now snd_soc_dapm_free() calls for different DAPM contexts happens before
snd_card_free() call from where the call chain to dapm_kcontrol_free() begins:

soc_cleanup_card_resources()
  soc_remove_dai_links()
    soc_remove_link_dais()
      snd_soc_dapm_free(&cpu_dai->dapm)
    soc_remove_link_components()
      soc_remove_platform()
        snd_soc_dapm_free(&platform->dapm)
      soc_remove_codec()
        snd_soc_dapm_free(&codec->dapm)
  snd_soc_dapm_free(&card->dapm)
  snd_card_free()
    snd_card_do_free()
      snd_device_free_all()
        snd_device_free()
          snd_ctl_dev_free()
            snd_ctl_remove()
              snd_ctl_free_one()
                dapm_kcontrol_free()

This wasn't making harm with ordinary DAPM kcontrols since data->widget is NULL for
them.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: stable <stable@vger.kernel.org> # 3.12+
---
 sound/soc/soc-dapm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c8a780d0d057..7769b0a2bc5a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -254,7 +254,6 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kctl);
-	kfree(data->widget);
 	kfree(data->wlist);
 	kfree(data);
 }
-- 
1.9.1
