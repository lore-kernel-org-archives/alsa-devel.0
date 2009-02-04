From: Kusanagi Kouichi <slash@ma.neweb.ne.jp>
Subject: [PATCH] hda: Add digital beep generator support for
	Realtek codecs.
Date: Thu, 5 Feb 2009 00:00:58 +0900
Message-ID: <200902041500590837730006MA75@nm06mta.auone-net.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nmomta.auone-net.jp (nm06omta07.auone-net.jp [219.125.112.24])
	by alsa0.perex.cz (Postfix) with SMTP id 1965324133
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 16:01:00 +0100 (CET)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

A digital beep generator can be used via input layer.

Signed-off-by: Kusanagi Kouichi <slash@ma.neweb.ne.jp>
---
 sound/pci/hda/hda_beep.h      |    2 +-
 sound/pci/hda/patch_realtek.c |   62 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/hda_beep.h b/sound/pci/hda/hda_beep.h
index b9679f0..51bf6a5 100644
--- a/sound/pci/hda/hda_beep.h
+++ b/sound/pci/hda/hda_beep.h
@@ -39,7 +39,7 @@ struct hda_beep {
 int snd_hda_attach_beep_device(struct hda_codec *codec, int nid);
 void snd_hda_detach_beep_device(struct hda_codec *codec);
 #else
-#define snd_hda_attach_beep_device(...)
+#define snd_hda_attach_beep_device(...)		0
 #define snd_hda_detach_beep_device(...)
 #endif
 #endif
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7884a4e..956b327 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -30,6 +30,7 @@
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
+#include "hda_beep.h"
 
 #define ALC880_FRONT_EVENT		0x01
 #define ALC880_DCVOL_EVENT		0x02
@@ -3160,6 +3161,7 @@ static void alc_free(struct hda_codec *codec)
 
 	alc_free_kctls(codec);
 	kfree(spec);
+	snd_hda_detach_beep_device(codec);
 	codec->spec = NULL; /* to be sure */
 }
 
@@ -4328,6 +4330,12 @@ static int patch_alc880(struct hda_codec *codec)
 		}
 	}
 
+	err = snd_hda_attach_beep_device(codec, 0x1);
+	if (err < 0) {
+		alc_free(codec);
+		return err;
+	}
+
 	if (board_config != ALC880_AUTO)
 		setup_preset(spec, &alc880_presets[board_config]);
 
@@ -5855,6 +5863,12 @@ static int patch_alc260(struct hda_codec *codec)
 		}
 	}
 
+	err = snd_hda_attach_beep_device(codec, 0x1);
+	if (err < 0) {
+		alc_free(codec);
+		return err;
+	}
+
 	if (board_config != ALC260_AUTO)
 		setup_preset(spec, &alc260_presets[board_config]);
 
@@ -7050,6 +7064,12 @@ static int patch_alc882(struct hda_codec *codec)
 		}
 	}
 
+	err = snd_hda_attach_beep_device(codec, 0x1);
+	if (err < 0) {
+		alc_free(codec);
+		return err;
+	}
+
 	if (board_config != ALC882_AUTO)
 		setup_preset(spec, &alc882_presets[board_config]);
 
@@ -9024,6 +9044,12 @@ static int patch_alc883(struct hda_codec *codec)
 		}
 	}
 
+	err = snd_hda_attach_beep_device(codec, 0x1);
+	if (err < 0) {
+		alc_free(codec);
+		return err;
+	}
+
 	if (board_config != ALC883_AUTO)
 		setup_preset(spec, &alc883_presets[board_config]);
 
@@ -10844,6 +10870,12 @@ static int patch_alc262(struct hda_codec *codec)
 		}
 	}
 
+	err = snd_hda_attach_beep_device(codec, 0x1);
+	if (err < 0) {
+		alc_free(codec);
+		return err;
+	}
+
 	if (board_config != ALC262_AUTO)
 		setup_preset(spec, &alc262_presets[board_config]);
 
@@ -11896,6 +11928,12 @@ static int patch_alc268(struct hda_codec *codec)
 		}
 	}
 
+	err = snd_hda_attach_beep_device(codec, 0x1);
+	if (err < 0) {
+		alc_free(codec);
+		return err;
+	}
+
 	if (board_config != ALC268_AUTO)
 		setup_preset(spec, &alc268_presets[board_config]);
 
@@ -12730,6 +12768,12 @@ static int patch_alc269(struct hda_codec *codec)
 		}
 	}
 
+	err = snd_hda_attach_beep_device(codec, 0x1);
+	if (err < 0) {
+		alc_free(codec);
+		return err;
+	}
+
 	if (board_config != ALC269_AUTO)
 		setup_preset(spec, &alc269_presets[board_config]);
 
@@ -13823,6 +13867,12 @@ static int patch_alc861(struct hda_codec *codec)
 		}
 	}
 
+	err = snd_hda_attach_beep_device(codec, 0x23);
+	if (err < 0) {
+		alc_free(codec);
+		return err;
+	}
+
 	if (board_config != ALC861_AUTO)
 		setup_preset(spec, &alc861_presets[board_config]);
 
@@ -14769,6 +14819,12 @@ static int patch_alc861vd(struct hda_codec *codec)
 		}
 	}
 
+	err = snd_hda_attach_beep_device(codec, 0x23);
+	if (err < 0) {
+		alc_free(codec);
+		return err;
+	}
+
 	if (board_config != ALC861VD_AUTO)
 		setup_preset(spec, &alc861vd_presets[board_config]);
 
@@ -16578,6 +16634,12 @@ static int patch_alc662(struct hda_codec *codec)
 		}
 	}
 
+	err = snd_hda_attach_beep_device(codec, 0x1);
+	if (err < 0) {
+		alc_free(codec);
+		return err;
+	}
+
 	if (board_config != ALC662_AUTO)
 		setup_preset(spec, &alc662_presets[board_config]);
 
-- 
1.5.6.5
