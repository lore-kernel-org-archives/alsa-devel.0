From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 08/11] ALSA: hda/ca0132 - Add DSP setup defaults for Recon3D
Date: Wed,  8 Aug 2018 13:34:19 -0400
Message-ID: <1533749663-8200-9-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Connor McAdams <conmanx360@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Recon3D can use many of the same functions as the Recon3Di, so many
of the r3di prefix function remain the same, but change their names to
the more generic r3d prefix. This patch does this, and adds quirk checks
for things specific to the Recon3Di.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index cb84648..0257fb9 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6224,10 +6224,10 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 }
 
 /*
- * Recon3Di r3di_setup_defaults sub functions.
+ * Recon3D r3d_setup_defaults sub functions.
  */
 
-static void r3di_dsp_scp_startup(struct hda_codec *codec)
+static void r3d_dsp_scp_startup(struct hda_codec *codec)
 {
 	unsigned int tmp;
 
@@ -6248,7 +6248,7 @@ static void r3di_dsp_scp_startup(struct hda_codec *codec)
 
 }
 
-static void r3di_dsp_initial_mic_setup(struct hda_codec *codec)
+static void r3d_dsp_initial_mic_setup(struct hda_codec *codec)
 {
 	unsigned int tmp;
 
@@ -6458,10 +6458,10 @@ static void ca0132_setup_defaults(struct hda_codec *codec)
 }
 
 /*
- * Setup default parameters for Recon3Di DSP.
+ * Setup default parameters for Recon3D/Recon3Di DSP.
  */
 
-static void r3di_setup_defaults(struct hda_codec *codec)
+static void r3d_setup_defaults(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 	unsigned int tmp;
@@ -6471,9 +6471,9 @@ static void r3di_setup_defaults(struct hda_codec *codec)
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-	r3di_dsp_scp_startup(codec);
+	r3d_dsp_scp_startup(codec);
 
-	r3di_dsp_initial_mic_setup(codec);
+	r3d_dsp_initial_mic_setup(codec);
 
 	/*remove DSP headroom*/
 	tmp = FLOAT_ZERO;
@@ -6487,7 +6487,8 @@ static void r3di_setup_defaults(struct hda_codec *codec)
 	/* Set speaker source? */
 	dspio_set_uint_param(codec, 0x32, 0x00, tmp);
 
-	r3di_gpio_dsp_status_set(codec, R3DI_DSP_DOWNLOADED);
+	if (spec->quirk == QUIRK_R3DI)
+		r3di_gpio_dsp_status_set(codec, R3DI_DSP_DOWNLOADED);
 
 	/* Setup effect defaults */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
@@ -6499,7 +6500,6 @@ static void r3di_setup_defaults(struct hda_codec *codec)
 					ca0132_effects[idx].def_vals[i]);
 		}
 	}
-
 }
 
 /*
@@ -7298,7 +7298,8 @@ static int ca0132_init(struct hda_codec *codec)
 
 	switch (spec->quirk) {
 	case QUIRK_R3DI:
-		r3di_setup_defaults(codec);
+	case QUIRK_R3D:
+		r3d_setup_defaults(codec);
 		break;
 	case QUIRK_SBZ:
 		sbz_setup_defaults(codec);
-- 
2.7.4
