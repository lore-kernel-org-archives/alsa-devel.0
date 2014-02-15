From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: hda/realtek - Allow NULL bus->pci
Date: Sat, 15 Feb 2014 10:17:34 +0100
Message-ID: <1392455855-10594-2-git-send-email-tiwai@suse.de>
References: <1392455855-10594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 55B0726168D
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 10:17:36 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D648BABB3
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 09:17:35 +0000 (UTC)
In-Reply-To: <1392455855-10594-1-git-send-email-tiwai@suse.de>
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

Realtek codec driver contains some codes referring to the PCI
subdevice IDs, but most of them are optional, typically for checking
the codec name variants.  Add NULL checks appropriately so that it can
work without PCI assignment.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 86857b674302..c5405f319cfe 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -395,6 +395,8 @@ static int alc_auto_parse_customize_define(struct hda_codec *codec)
 		goto do_sku;
 	}
 
+	if (!codec->bus->pci)
+		return -1;
 	ass = codec->subsystem_id & 0xffff;
 	if (ass != codec->bus->pci->subsystem_device && (ass & 1))
 		goto do_sku;
@@ -483,7 +485,8 @@ static int alc_subsystem_id(struct hda_codec *codec, const hda_nid_t *ports)
 	}
 
 	ass = codec->subsystem_id & 0xffff;
-	if ((ass != codec->bus->pci->subsystem_device) && (ass & 1))
+	if (codec->bus->pci &&
+	    ass != codec->bus->pci->subsystem_device && (ass & 1))
 		goto do_sku;
 
 	/* invalid SSID, check the special NID pin defcfg instead */
@@ -966,6 +969,8 @@ static int alc_codec_rename_from_preset(struct hda_codec *codec)
 			return alc_codec_rename(codec, p->name);
 	}
 
+	if (!codec->bus->pci)
+		return 0;
 	for (q = rename_pci_tbl; q->codec_vendor_id; q++) {
 		if (q->codec_vendor_id != codec->vendor_id)
 			continue;
@@ -4502,13 +4507,15 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->codec_variant = ALC269_TYPE_ALC269VA;
 		switch (alc_get_coef0(codec) & 0x00f0) {
 		case 0x0010:
-			if (codec->bus->pci->subsystem_vendor == 0x1025 &&
+			if (codec->bus->pci &&
+			    codec->bus->pci->subsystem_vendor == 0x1025 &&
 			    spec->cdefine.platform_type == 1)
 				err = alc_codec_rename(codec, "ALC271X");
 			spec->codec_variant = ALC269_TYPE_ALC269VB;
 			break;
 		case 0x0020:
-			if (codec->bus->pci->subsystem_vendor == 0x17aa &&
+			if (codec->bus->pci &&
+			    codec->bus->pci->subsystem_vendor == 0x17aa &&
 			    codec->bus->pci->subsystem_device == 0x21f3)
 				err = alc_codec_rename(codec, "ALC3202");
 			spec->codec_variant = ALC269_TYPE_ALC269VC;
@@ -5309,7 +5316,7 @@ static int patch_alc662(struct hda_codec *codec)
 		spec->gen.beep_nid = 0x01;
 
 	if ((alc_get_coef0(codec) & (1 << 14)) &&
-	    codec->bus->pci->subsystem_vendor == 0x1025 &&
+	    codec->bus->pci && codec->bus->pci->subsystem_vendor == 0x1025 &&
 	    spec->cdefine.platform_type == 1) {
 		err = alc_codec_rename(codec, "ALC272X");
 		if (err < 0)
-- 
1.8.5.2
