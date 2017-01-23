From: Darren Stevens <darren@stevens-zone.net>
Subject: [PATCH] ALSA: hda/patch_sigmatel: Add AmigaOne X1000
	pin configs
Date: Mon, 23 Jan 2017 19:43:29 +0000 (GMT)
Message-ID: <497a1dc45d9.2064992f@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="--=_BOUNDARY.6f0375006ce609d6.ae"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 514902667E7
 for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2017 20:43:31 +0100 (CET)
Received: from mintppc.lan ([86.156.215.177]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.163]) with ESMTPA (Nemesis) id 0Lg9w4-1c8nhe2Zsa-00nk8G
 for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2017 20:43:30 +0100
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

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6f0375006ce609d6.ae
Content-Type: text/plain

The AmigaOne X1000 has a Sigmatel STAC92HD700 attached to the HD Audio
on an ATI SB600. Add the required settings to enable sound.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

----=_BOUNDARY.6f0375006ce609d6.ae
Content-Type: text/plain;
	name="sigmatel.patch"
Content-Disposition: attachment;
	filename="sigmatel.patch";
	size=2636

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 37b70f8..51947a6 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -166,6 +166,7 @@ enum {
 	STAC_D965_VERBS,
 	STAC_DELL_3ST,
 	STAC_DELL_BIOS,
+	STAC_NEMO_DEFAULT,
 	STAC_DELL_BIOS_AMIC,
 	STAC_DELL_BIOS_SPDIF,
 	STAC_927X_DELL_DMIC,
@@ -1360,6 +1361,23 @@ static int stac_create_spdif_mux_ctls(struct hda_codec *codec)
 	{}
 };
 
+static const struct hda_pintbl nemo_pin_configs[] = {
+   { 0x0a, 0x02214020 },
+   { 0x0b, 0x02A19080 },
+   { 0x0c, 0x0181304E },
+   { 0x0d, 0x01014010 },
+   { 0x0e, 0x01A19040 },
+   { 0x0f, 0x01011012 },
+   { 0x10, 0x01016011 },
+   { 0x11, 0x01012014 },
+   { 0x12, 0x103301F0 },
+   { 0x13, 0x00000000 },
+   { 0x14, 0x00000000 },
+   { 0x21, 0x01442170 },
+   { 0x22, 0x00000000 },
+   { 0x23, 0x00000000 },
+   {}
+};
 
 static void stac9200_fixup_panasonic(struct hda_codec *codec,
 				     const struct hda_fixup *fix, int action)
@@ -3883,6 +3901,10 @@ static void stac927x_fixup_volknob(struct hda_codec *codec,
 		.type = HDA_FIXUP_PINS,
 		.v.pins = d965_5st_no_fp_pin_configs,
 	},
+	[STAC_NEMO_DEFAULT] = {
+       		.type = HDA_FIXUP_PINS,
+		.v.pins = nemo_pin_configs,
+	},
 	[STAC_DELL_3ST] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = dell_3st_pin_configs,
@@ -3939,6 +3961,7 @@ static void stac927x_fixup_volknob(struct hda_codec *codec,
 	{ .id = STAC_D965_5ST_NO_FP, .name = "5stack-no-fp" },
 	{ .id = STAC_DELL_3ST, .name = "dell-3stack" },
 	{ .id = STAC_DELL_BIOS, .name = "dell-bios" },
+	{ .id = STAC_NEMO_DEFAULT, .name = "nemo-default" },	
 	{ .id = STAC_DELL_BIOS_AMIC, .name = "dell-bios-amic" },
 	{ .id = STAC_927X_VOLKNOB, .name = "volknob" },
 	{}
@@ -3977,6 +4000,8 @@ static void stac927x_fixup_volknob(struct hda_codec *codec,
 			   "Intel D965", STAC_D965_5ST),
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_INTEL, 0xff00, 0x2500,
 			   "Intel D965", STAC_D965_5ST),
+	/* Nemo */
+	SND_PCI_QUIRK(0x1888, 0x1000, "AmigaOne X1000", STAC_NEMO_DEFAULT),
 	/* volume-knob fixes */
 	SND_PCI_QUIRK_VENDOR(0x10cf, "FSC", STAC_927X_VOLKNOB),
 	{} /* terminator */
@@ -5036,6 +5061,7 @@ static int patch_stac9872(struct hda_codec *codec)
 	HDA_CODEC_ENTRY(0x83847683, "STAC9221D A2", patch_stac922x),
 	HDA_CODEC_ENTRY(0x83847618, "STAC9227", patch_stac927x),
 	HDA_CODEC_ENTRY(0x83847619, "STAC9227", patch_stac927x),
+	HDA_CODEC_ENTRY(0x83847638, "STAC92HD700", patch_stac927x),
 	HDA_CODEC_ENTRY(0x83847616, "STAC9228", patch_stac927x),
 	HDA_CODEC_ENTRY(0x83847617, "STAC9228", patch_stac927x),
 	HDA_CODEC_ENTRY(0x83847614, "STAC9229", patch_stac927x),

----=_BOUNDARY.6f0375006ce609d6.ae
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


----=_BOUNDARY.6f0375006ce609d6.ae--
