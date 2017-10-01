From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>
Subject: [PATCH 01/18] sound: use ARRAY_SIZE
Date: Sun,  1 Oct 2017 15:30:39 -0400
Message-ID: <20171001193101.8898-2-jeremy.lefaure@lse.epita.fr>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Using the ARRAY_SIZE macro improves the readability of the code.

Found with Coccinelle with the following semantic patch:
@r depends on (org || report)@
type T;
T[] E;
position p;
@@
(
 (sizeof(E)@p /sizeof(*E))
|
 (sizeof(E)@p /sizeof(E[...]))
|
 (sizeof(E)@p /sizeof(T))
)

Signed-off-by: Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>
---
 sound/oss/ad1848.c           | 7 ++++---
 sound/pci/hda/patch_ca0132.c | 8 +++-----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index 2421f59cf279..7e495054b51c 100644
--- a/sound/oss/ad1848.c
+++ b/sound/oss/ad1848.c
@@ -49,6 +49,7 @@
 #include <linux/isapnp.h>
 #include <linux/pnp.h>
 #include <linux/spinlock.h>
+#include <linux/kernel.h>
 
 #include "sound_config.h"
 
@@ -797,7 +798,7 @@ static int ad1848_set_speed(int dev, int arg)
 
 	int i, n, selected = -1;
 
-	n = sizeof(speed_table) / sizeof(speed_struct);
+	n = ARRAY_SIZE(speed_table);
 
 	if (arg <= 0)
 		return portc->speed;
@@ -908,7 +909,7 @@ static unsigned int ad1848_set_bits(int dev, unsigned int arg)
 			AFMT_U16_BE, 0
 		}
 	};
-	int i, n = sizeof(format2bits) / sizeof(struct format_tbl);
+	int i;
 
 	if (arg == 0)
 		return portc->audio_format;
@@ -918,7 +919,7 @@ static unsigned int ad1848_set_bits(int dev, unsigned int arg)
 
 	portc->audio_format = arg;
 
-	for (i = 0; i < n; i++)
+	for (i = 0; i < ARRAY_SIZE(format2bits); i++)
 		if (format2bits[i].format == arg)
 		{
 			if ((portc->format_bits = format2bits[i].bits) == 0)
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 3e73d5c6ccfc..768ea8651993 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -27,6 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <linux/kernel.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
@@ -3605,8 +3606,7 @@ static int ca0132_vnode_switch_set(struct snd_kcontrol *kcontrol,
 static int ca0132_voicefx_info(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_info *uinfo)
 {
-	unsigned int items = sizeof(ca0132_voicefx_presets)
-				/ sizeof(struct ct_voicefx_preset);
+	unsigned int items = ARRAY_SIZE(ca0132_voicefx_presets);
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
@@ -3635,10 +3635,8 @@ static int ca0132_voicefx_put(struct snd_kcontrol *kcontrol,
 	struct ca0132_spec *spec = codec->spec;
 	int i, err = 0;
 	int sel = ucontrol->value.enumerated.item[0];
-	unsigned int items = sizeof(ca0132_voicefx_presets)
-				/ sizeof(struct ct_voicefx_preset);
 
-	if (sel >= items)
+	if (sel >= ARRAY_SIZE(ca0132_voicefx_presets))
 		return 0;
 
 	codec_dbg(codec, "ca0132_voicefx_put: sel=%d, preset=%s\n",
-- 
2.14.1
