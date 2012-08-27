From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: hda: Make core jack usage unconditional
Date: Mon, 27 Aug 2012 11:53:23 -0700
Message-ID: <1346093603-27675-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E6C7265EA6
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 20:53:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently the HDA drivers have a Kconfig variable SND_HDA_INPUT_JACK
which disables jack reporting via the ALSA core jack API. This is bad
since (modulo the current problems with the HDA-specific reporting
API) it means that all reporting mechanisms will get disabled, not just
input. It's also not good that this is open coded in an individual
driver - if it's useful to have this control it's going to be equally
useful for any driver with jack detection support so should be handled
in the core.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/pci/hda/Kconfig    |    9 +--------
 sound/pci/hda/hda_jack.c |    8 --------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 194d625..2c7f626 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -2,6 +2,7 @@ menuconfig SND_HDA_INTEL
 	tristate "Intel HD Audio"
 	select SND_PCM
 	select SND_VMASTER
+	select SND_JACK if INPUT=y || INPUT=SND
 	select SND_KCTL_JACK
 	help
 	  Say Y here to include support for Intel "High Definition
@@ -62,14 +63,6 @@ config SND_HDA_INPUT_BEEP_MODE
 	  Set 1 to always enable the digital beep interface for HD-audio by
 	  default.
 
-config SND_HDA_INPUT_JACK
-	bool "Support jack plugging notification via input layer"
-	depends on INPUT=y || INPUT=SND
-	select SND_JACK
-	help
-	  Say Y here to enable the jack plugging notification via
-	  input layer.
-
 config SND_HDA_PATCH_LOADER
 	bool "Support initialization patch loading for HD-audio"
 	depends on EXPERIMENTAL
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index aaccc02..0760d75 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -109,7 +109,6 @@ EXPORT_SYMBOL_HDA(snd_hda_jack_tbl_new);
 
 void snd_hda_jack_tbl_clear(struct hda_codec *codec)
 {
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 	/* free jack instances manually when clearing/reconfiguring */
 	if (!codec->bus->shutdown && codec->jacktbl.list) {
 		struct hda_jack_tbl *jack = codec->jacktbl.list;
@@ -119,7 +118,6 @@ void snd_hda_jack_tbl_clear(struct hda_codec *codec)
 				snd_device_free(codec->bus->card, jack->jack);
 		}
 	}
-#endif
 	snd_array_free(&codec->jacktbl);
 }
 
@@ -225,16 +223,13 @@ void snd_hda_jack_report_sync(struct hda_codec *codec)
 				continue;
 			state = get_jack_plug_state(jack->pin_sense);
 			snd_kctl_jack_report(codec->bus->card, jack->kctl, state);
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 			if (jack->jack)
 				snd_jack_report(jack->jack,
 						state ? jack->type : 0);
-#endif
 		}
 }
 EXPORT_SYMBOL_HDA(snd_hda_jack_report_sync);
 
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 /* guess the jack type from the pin-config */
 static int get_input_jack_type(struct hda_codec *codec, hda_nid_t nid)
 {
@@ -261,7 +256,6 @@ static void hda_free_jack_priv(struct snd_jack *jack)
 	jacks->nid = 0;
 	jacks->jack = NULL;
 }
-#endif
 
 /**
  * snd_hda_jack_add_kctl - Add a kctl for the given pin
@@ -292,7 +286,6 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 
 	state = snd_hda_jack_detect(codec, nid);
 	snd_kctl_jack_report(codec->bus->card, kctl, state);
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 	if (!phantom_jack) {
 		jack->type = get_input_jack_type(codec, nid);
 		err = snd_jack_new(codec->bus->card, name, jack->type,
@@ -303,7 +296,6 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 		jack->jack->private_free = hda_free_jack_priv;
 		snd_jack_report(jack->jack, state ? jack->type : 0);
 	}
-#endif
 	return 0;
 }
 
-- 
1.7.10.4
