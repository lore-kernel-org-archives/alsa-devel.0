From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH] ALSA: hda/ca0132 - Actually fix microphone
	issue
Date: Sun, 21 Oct 2018 13:53:03 -0400
Message-ID: <1540144385-27454-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 19F242677D1
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2018 19:53:32 +0200 (CEST)
Received: by mail-qk1-f196.google.com with SMTP id y8-v6so23957867qka.11
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2018 10:53:32 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>, Takashi Iwai <tiwai@suse.com>, conmanx360@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch fixes the microphone issue for all cards. The previous fix
worked on the ZxR, but not on the AE-5 or Z. This patch has been tested
to work for all cards.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 73 ++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 1a13cea..f0ef52e 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6983,37 +6983,44 @@ static void sbz_chipio_startup_data(struct hda_codec *codec)
 static void ca0132_alt_dsp_scp_startup(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
-	unsigned int tmp;
+	unsigned int tmp, i;
 
-	switch (spec->quirk) {
-	case QUIRK_SBZ:
-	case QUIRK_AE5:
-		tmp = 0x00000003;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		tmp = 0x00000000;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
-		tmp = 0x00000001;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
-		tmp = 0x00000004;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		tmp = 0x00000005;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		tmp = 0x00000000;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		break;
-	case QUIRK_R3D:
-	case QUIRK_R3DI:
-		tmp = 0x00000000;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
-		tmp = 0x00000001;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
-		tmp = 0x00000004;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		tmp = 0x00000005;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		tmp = 0x00000000;
-		dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-		break;
+	/*
+	 * Gotta run these twice, or else mic works inconsistently. Not clear
+	 * why this is, but multiple tests have confirmed it.
+	 */
+	for (i = 0; i < 2; i++) {
+		switch (spec->quirk) {
+		case QUIRK_SBZ:
+		case QUIRK_AE5:
+			tmp = 0x00000003;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			tmp = 0x00000000;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
+			tmp = 0x00000001;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
+			tmp = 0x00000004;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			tmp = 0x00000005;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			tmp = 0x00000000;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			break;
+		case QUIRK_R3D:
+		case QUIRK_R3DI:
+			tmp = 0x00000000;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
+			tmp = 0x00000001;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
+			tmp = 0x00000004;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			tmp = 0x00000005;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			tmp = 0x00000000;
+			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
+			break;
+		}
+		msleep(100);
 	}
 }
 
@@ -7246,8 +7253,6 @@ static void r3d_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
-	msleep(100);
-
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
@@ -7292,8 +7297,6 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
-	msleep(100);
-
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
@@ -7351,8 +7354,6 @@ static void ae5_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
-	msleep(100);
-
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-- 
2.7.4
