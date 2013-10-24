From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Add support of ALC255 codecs
Date: Thu, 24 Oct 2013 11:38:12 +0200
Message-ID: <1382607493-9326-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 74A972608D8
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 11:35:19 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4789BA5AA4
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 11:35:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Kailang Yang <kailang@realtek.com>

It's just another variant of ALC269 & co.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 52c26d3..1c4f8c5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2540,6 +2540,7 @@ enum {
 	ALC269_TYPE_ALC283,
 	ALC269_TYPE_ALC284,
 	ALC269_TYPE_ALC286,
+	ALC269_TYPE_ALC255,
 };
 
 /*
@@ -2565,6 +2566,7 @@ static int alc269_parse_auto_config(struct hda_codec *codec)
 	case ALC269_TYPE_ALC282:
 	case ALC269_TYPE_ALC283:
 	case ALC269_TYPE_ALC286:
+	case ALC269_TYPE_ALC255:
 		ssids = alc269_ssids;
 		break;
 	default:
@@ -4102,6 +4104,9 @@ static int patch_alc269(struct hda_codec *codec)
 	case 0x10ec0286:
 		spec->codec_variant = ALC269_TYPE_ALC286;
 		break;
+	case 0x10ec0255:
+		spec->codec_variant = ALC269_TYPE_ALC255;
+		break;
 	}
 
 	if (snd_hda_codec_read(codec, 0x51, 0, AC_VERB_PARAMETERS, 0) == 0x10ec5505) {
@@ -4814,6 +4819,7 @@ static int patch_alc680(struct hda_codec *codec)
 static const struct hda_codec_preset snd_hda_preset_realtek[] = {
 	{ .id = 0x10ec0221, .name = "ALC221", .patch = patch_alc269 },
 	{ .id = 0x10ec0233, .name = "ALC233", .patch = patch_alc269 },
+	{ .id = 0x10ec0255, .name = "ALC255", .patch = patch_alc269 },
 	{ .id = 0x10ec0260, .name = "ALC260", .patch = patch_alc260 },
 	{ .id = 0x10ec0262, .name = "ALC262", .patch = patch_alc262 },
 	{ .id = 0x10ec0267, .name = "ALC267", .patch = patch_alc268 },
-- 
1.8.4
