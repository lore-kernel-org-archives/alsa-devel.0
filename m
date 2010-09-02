From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Add a new hp-laptop model for Conexant 5066,
 tested on HP G60
Date: Thu, 02 Sep 2010 08:47:50 +0200
Message-ID: <4C7F4896.8020608@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090900030103090308050104"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 345401037F7
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 08:47:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090900030103090308050104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This new model adds the following functionality to HP G60:
- Automute of internal speakers
- Autoswitch of internal/external mics
- Remove SPDIF not physically present

BugLink: http://launchpad.net/bugs/587388
Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>

Alsa-info:
http://launchpadlibrarian.net/54727125/alsa-info.txt_internalmicworking

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------090900030103090308050104
Content-Type: text/x-patch;
 name="0001-Add-a-new-hp-laptop-model-for-Conexant-5066-tested-o.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-a-new-hp-laptop-model-for-Conexant-5066-tested-o.pa";
 filename*1="tch"

>From 26f4570c8f62991db2c934a82bc5d31ce9305efd Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 2 Sep 2010 08:35:47 +0200
Subject: [PATCH] Add a new hp-laptop model for Conexant 5066, tested on HP G60

This new model adds the following functionality to HP G60:
- Automute of internal speakers
- Autoswitch of internal/external mics
- Remove SPDIF not physically present

BugLink: http://launchpad.net/bugs/587388
Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
 sound/pci/hda/patch_conexant.c               |   55 ++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index ce46fa1..d30ba75 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -296,6 +296,7 @@ Conexant 5051
 Conexant 5066
 =============
   laptop	Basic Laptop config (default)
+  hp-laptop     HP laptops, e g G60
   dell-laptop	Dell laptops
   dell-vostro	Dell Vostro
   olpc-xo-1_5	OLPC XO 1.5
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5cdb80e..65de5fd 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -116,6 +116,7 @@ struct conexant_spec {
 	unsigned int dell_vostro:1;
 	unsigned int ideapad:1;
 	unsigned int thinkpad:1;
+	unsigned int hp_laptop:1;
 
 	unsigned int ext_mic_present;
 	unsigned int recording;
@@ -2299,6 +2300,17 @@ static void cxt5066_ideapad_automic(struct hda_codec *codec)
 	}
 }
 
+/* toggle input of built-in digital mic and mic jack appropriately */
+static void cxt5066_hp_laptop_automic(struct hda_codec *codec)
+{
+	unsigned int present;
+
+	present = snd_hda_jack_detect(codec, 0x1b);
+	snd_printdd("CXT5066: external microphone present=%d\n", present);
+	snd_hda_codec_write(codec, 0x17, 0, AC_VERB_SET_CONNECT_SEL, present ? 1 : 3);
+}
+
+
 /* toggle input of built-in digital mic and mic jack appropriately
    order is: external mic -> dock mic -> interal mic */
 static void cxt5066_thinkpad_automic(struct hda_codec *codec)
@@ -2408,6 +2420,20 @@ static void cxt5066_ideapad_event(struct hda_codec *codec, unsigned int res)
 }
 
 /* unsolicited event for jack sensing */
+static void cxt5066_hp_laptop_event(struct hda_codec *codec, unsigned int res)
+{
+	snd_printdd("CXT5066_hp_laptop: unsol event %x (%x)\n", res, res >> 26);
+	switch (res >> 26) {
+	case CONEXANT_HP_EVENT:
+		cxt5066_hp_automute(codec);
+		break;
+	case CONEXANT_MIC_EVENT:
+		cxt5066_hp_laptop_automic(codec);
+		break;
+	}
+}
+
+/* unsolicited event for jack sensing */
 static void cxt5066_thinkpad_event(struct hda_codec *codec, unsigned int res)
 {
 	snd_printdd("CXT5066_thinkpad: unsol event %x (%x)\n", res, res >> 26);
@@ -2989,6 +3015,14 @@ static struct hda_verb cxt5066_init_verbs_portd_lo[] = {
 	{ } /* end */
 };
 
+
+static struct hda_verb cxt5066_init_verbs_hp_laptop[] = {
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x0},
+	{0x19, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_MIC_EVENT},
+	{ } /* end */
+};
+
 /* initialize jack-sensing, too */
 static int cxt5066_init(struct hda_codec *codec)
 {
@@ -3004,6 +3038,8 @@ static int cxt5066_init(struct hda_codec *codec)
 			cxt5066_ideapad_automic(codec);
 		else if (spec->thinkpad)
 			cxt5066_thinkpad_automic(codec);
+		else if (spec->hp_laptop)
+			cxt5066_hp_laptop_automic(codec);
 	}
 	cxt5066_set_mic_boost(codec);
 	return 0;
@@ -3031,6 +3067,7 @@ enum {
 	CXT5066_DELL_VOSTO,	/* Dell Vostro 1015i */
 	CXT5066_IDEAPAD,	/* Lenovo IdeaPad U150 */
 	CXT5066_THINKPAD,	/* Lenovo ThinkPad T410s, others? */
+	CXT5066_HP_LAPTOP,      /* HP Laptop */
 	CXT5066_MODELS
 };
 
@@ -3041,6 +3078,7 @@ static const char *cxt5066_models[CXT5066_MODELS] = {
 	[CXT5066_DELL_VOSTO]    = "dell-vostro",
 	[CXT5066_IDEAPAD]	= "ideapad",
 	[CXT5066_THINKPAD]	= "thinkpad",
+	[CXT5066_HP_LAPTOP]	= "hp-laptop",
 };
 
 static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
@@ -3052,6 +3090,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x02d8, "Dell Vostro", CXT5066_DELL_VOSTO),
 	SND_PCI_QUIRK(0x1028, 0x0402, "Dell Vostro", CXT5066_DELL_VOSTO),
 	SND_PCI_QUIRK(0x1028, 0x0408, "Dell Inspiron One 19T", CXT5066_IDEAPAD),
+ 	SND_PCI_QUIRK(0x103c, 0x360b, "HP G60", CXT5066_HP_LAPTOP),
 	SND_PCI_QUIRK(0x1179, 0xff50, "Toshiba Satellite P500-PSPGSC-01800T", CXT5066_OLPC_XO_1_5),
 	SND_PCI_QUIRK(0x1179, 0xffe0, "Toshiba Satellite Pro T130-15F", CXT5066_OLPC_XO_1_5),
 	SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT5066_IDEAPAD),
@@ -3116,6 +3155,22 @@ static int patch_cxt5066(struct hda_codec *codec)
 		spec->num_init_verbs++;
 		spec->dell_automute = 1;
 		break;
+	case CXT5066_HP_LAPTOP:
+		codec->patch_ops.init = cxt5066_init;
+		codec->patch_ops.unsol_event = cxt5066_hp_laptop_event;
+		spec->init_verbs[spec->num_init_verbs] = cxt5066_init_verbs_hp_laptop;
+		spec->num_init_verbs++;
+		spec->hp_laptop = 1;
+		spec->mixers[spec->num_mixers++] = cxt5066_mixer_master;
+		spec->mixers[spec->num_mixers++] = cxt5066_mixers;
+		/* no S/PDIF out */
+		spec->multiout.dig_out_nid = 0;
+		/* input source automatically selected */
+		spec->input_mux = NULL;
+		spec->port_d_mode = 0;
+		spec->mic_boost = 3; /* default 30dB gain */
+		break;
+
 	case CXT5066_OLPC_XO_1_5:
 		codec->patch_ops.init = cxt5066_olpc_init;
 		codec->patch_ops.unsol_event = cxt5066_olpc_unsol_event;
-- 
1.7.0.4


--------------090900030103090308050104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090900030103090308050104--
