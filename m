From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Add support of ALC285 / ALC293
	codecs
Date: Thu, 24 Oct 2013 11:38:13 +0200
Message-ID: <1382607493-9326-2-git-send-email-tiwai@suse.de>
References: <1382607493-9326-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A80526160D
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 11:35:19 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 485CEA5ACE
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 11:35:19 +0200 (CEST)
In-Reply-To: <1382607493-9326-1-git-send-email-tiwai@suse.de>
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

Yet another variants of ALC269.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1c4f8c5..3016467c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2539,6 +2539,7 @@ enum {
 	ALC269_TYPE_ALC282,
 	ALC269_TYPE_ALC283,
 	ALC269_TYPE_ALC284,
+	ALC269_TYPE_ALC285,
 	ALC269_TYPE_ALC286,
 	ALC269_TYPE_ALC255,
 };
@@ -2559,6 +2560,7 @@ static int alc269_parse_auto_config(struct hda_codec *codec)
 	case ALC269_TYPE_ALC269VC:
 	case ALC269_TYPE_ALC280:
 	case ALC269_TYPE_ALC284:
+	case ALC269_TYPE_ALC285:
 		ssids = alc269va_ssids;
 		break;
 	case ALC269_TYPE_ALC269VB:
@@ -4101,6 +4103,10 @@ static int patch_alc269(struct hda_codec *codec)
 	case 0x10ec0292:
 		spec->codec_variant = ALC269_TYPE_ALC284;
 		break;
+	case 0x10ec0285:
+	case 0x10ec0293:
+		spec->codec_variant = ALC269_TYPE_ALC285;
+		break;
 	case 0x10ec0286:
 		spec->codec_variant = ALC269_TYPE_ALC286;
 		break;
@@ -4833,9 +4839,11 @@ static const struct hda_codec_preset snd_hda_preset_realtek[] = {
 	{ .id = 0x10ec0282, .name = "ALC282", .patch = patch_alc269 },
 	{ .id = 0x10ec0283, .name = "ALC283", .patch = patch_alc269 },
 	{ .id = 0x10ec0284, .name = "ALC284", .patch = patch_alc269 },
+	{ .id = 0x10ec0285, .name = "ALC285", .patch = patch_alc269 },
 	{ .id = 0x10ec0286, .name = "ALC286", .patch = patch_alc269 },
 	{ .id = 0x10ec0290, .name = "ALC290", .patch = patch_alc269 },
 	{ .id = 0x10ec0292, .name = "ALC292", .patch = patch_alc269 },
+	{ .id = 0x10ec0293, .name = "ALC293", .patch = patch_alc269 },
 	{ .id = 0x10ec0861, .rev = 0x100340, .name = "ALC660",
 	  .patch = patch_alc861 },
 	{ .id = 0x10ec0660, .name = "ALC660-VD", .patch = patch_alc861vd },
-- 
1.8.4
