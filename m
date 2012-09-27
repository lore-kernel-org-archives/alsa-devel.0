From: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
Subject: [PATCH] ALSA: hda/realtek - Fix detection of ALC271X
	codec
Date: Thu, 27 Sep 2012 10:38:14 -0300
Message-ID: <1348753094-15618-1-git-send-email-herton.krzesinski@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4963626164C
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 15:38:20 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

In commit af741c1 ("ALSA: hda/realtek - Call alc_auto_parse_customize_define()
always after fixup"), alc_auto_parse_customize_define was moved after
detection of ALC271X.

The problem is that detection of ALC271X relies on spec->cdefine.platform_type,
and it's set on alc_auto_parse_customize_define.

Move the alc_auto_parse_customize_define and its required fixup setup
before the block doing the ALC271X and other codec setup.

BugLink: https://bugs.launchpad.net/bugs/1006690
Signed-off-by: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

It looks safe to move the functions before the block
"if (codec->vendor_id == 0x10ec0269) {", as nothing on the fixups seems
to depend on what's done there. But if wanted we could just move the
detection/codec rename of ALC271X below too.

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c4c4b01..3b187e9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6273,6 +6273,12 @@ static int patch_alc269(struct hda_codec *codec)
 
 	spec = codec->spec;
 
+	alc_pick_fixup(codec, alc269_fixup_models,
+		       alc269_fixup_tbl, alc269_fixups);
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
+
+	alc_auto_parse_customize_define(codec);
+
 	if (codec->vendor_id == 0x10ec0269) {
 		spec->codec_variant = ALC269_TYPE_ALC269VA;
 		switch (alc_get_coef0(codec) & 0x00f0) {
@@ -6300,12 +6306,6 @@ static int patch_alc269(struct hda_codec *codec)
 		alc269_fill_coef(codec);
 	}
 
-	alc_pick_fixup(codec, alc269_fixup_models,
-		       alc269_fixup_tbl, alc269_fixups);
-	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
-
-	alc_auto_parse_customize_define(codec);
-
 	/* automatic parse from the BIOS config */
 	err = alc269_parse_auto_config(codec);
 	if (err < 0)
-- 
1.7.10.4
