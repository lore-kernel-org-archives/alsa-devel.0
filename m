From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: add support for jack detection on
	IDT/Sigmatel
Date: Wed, 15 Oct 2008 14:45:38 -0400
Message-ID: <48F63A52.4060608@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (unknown [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id A52EC243E5
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 20:46:07 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Added support for jack detection reporting to userspace for
IDT/Sigmatel codecs.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/Kconfig b/pci/Kconfig
index 7003711..7e40890 100644
--- a/pci/Kconfig
+++ b/pci/Kconfig
@@ -501,6 +501,7 @@ config SND_HDA_INTEL
 	tristate "Intel HD Audio"
 	select SND_PCM
 	select SND_VMASTER
+	select SND_JACK if INPUT=y || INPUT=SND
 	help
 	  Say Y here to include support for Intel "High Definition
 	  Audio" (Azalia) motherboard devices.
diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index a2ac720..f6c0b1d 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -30,6 +30,7 @@
 #include <linux/pci.h>
 #include <sound/core.h>
 #include <sound/asoundef.h>
+#include <sound/jack.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_patch.h"
@@ -216,6 +217,9 @@ struct sigmatel_spec {

 	struct hda_pcm pcm_rec[2];	/* PCM information */

+	/* jack detection */
+	struct snd_jack *jack;
+
 	/* dynamic controls and input_mux */
 	struct auto_pin_cfg autocfg;
 	unsigned int num_kctl_alloc, num_kctl_used;
@@ -3617,7 +3621,7 @@ static int stac92xx_init(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i;
+	int i, err;

 	snd_hda_sequence_write(codec, spec->init);

@@ -3639,6 +3643,12 @@ static int stac92xx_init(struct hda_codec *codec)
 		stac92xx_auto_set_pinctl(codec, spec->autocfg.line_out_pins[0],
 					 AC_PINCTL_OUT_EN);
 		stac92xx_auto_init_hp_out(codec);
+		/* jack detection */
+		err = snd_jack_new(codec->bus->card,
+			"Headphone Jack",
+			SND_JACK_HEADPHONE, &spec->jack);
+		if (err < 0)
+			return err;
 		/* fake event to set up pins */
 		codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
 	} else {
@@ -3796,6 +3806,8 @@ static void stac92xx_hp_detect(struct hda_codec *codec, unsigned int res)
 			break;
 		presence = get_hp_pin_presence(codec, cfg->hp_pins[i]);
 	}
+	snd_jack_report(spec->jack,
+		presence ? SND_JACK_HEADPHONE : 0);

 	if (presence) {
 		/* disable lineouts, enable hp */
