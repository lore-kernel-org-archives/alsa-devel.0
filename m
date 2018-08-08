From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 03/11] ALSA: hda/ca0132 - Add alt_functions unsolicited response
Date: Wed,  8 Aug 2018 13:34:14 -0400
Message-ID: <1533749663-8200-4-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Connor McAdams <conmanx360@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes a previous oversight where the microphone unsolicited
response would use the wrong input selection function.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index b3c2cae..e2e1d29 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6745,7 +6745,12 @@ static void hp_callback(struct hda_codec *codec, struct hda_jack_callback *cb)
 
 static void amic_callback(struct hda_codec *codec, struct hda_jack_callback *cb)
 {
-	ca0132_select_mic(codec);
+	struct ca0132_spec *spec = codec->spec;
+
+	if (spec->use_alt_functions)
+		ca0132_alt_select_in(codec);
+	else
+		ca0132_select_mic(codec);
 }
 
 static void ca0132_init_unsol(struct hda_codec *codec)
-- 
2.7.4
