From: Luca Bruno <lucab@debian.org>
Subject: [PATCH] ALSA: hda - Add quirk and model 'vaio' for
	ALC269-based Sony Vaio E Series
Date: Fri,  2 Apr 2010 15:54:02 +0200
Message-ID: <1270216442-5632-1-git-send-email-lucab@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.unstable.it (host-93-93-202-11.planetacomnetwork.com
	[93.93.202.11]) by alsa0.perex.cz (Postfix) with ESMTP id 61B04103800
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Apr 2010 15:54:06 +0200 (CEST)
Received: from localhost.localdomain
	(host4-195-dynamic.4-87-r.retail.telecomitalia.it [87.4.195.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.unstable.it (Postfix) with ESMTPSA id 1A4D9120089
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Apr 2010 15:54:26 +0200 (CEST)
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

Vaio E Series laptops need a slightly modified config for their ALC269.
This patch adds a new 'vaio' model, plus initial quirk for them.
It fixes alsa-bugs #4941, #4934 and #4945

Signed-off-by: Luca Bruno <lucab@debian.org>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
 sound/pci/hda/patch_realtek.c                |   24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 1d38b0d..416f1f5 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -87,6 +87,7 @@ ALC269
   eeepc-p901	ASUS Eeepc P901 S101
   fujitsu	FSC Amilo
   lifebook	Fujitsu Lifebook S6420
+  vaio		Sony Vaio (E Series)
   auto		auto-config reading BIOS (default)
 
 ALC662/663/272
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 22b7c94..c2b78a1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -137,6 +137,7 @@ enum {
 	ALC269VB_DMIC,
 	ALC269_FUJITSU,
 	ALC269_LIFEBOOK,
+	ALC269_VAIO,
 	ALC269_AUTO,
 	ALC269_MODEL_LAST /* last tag */
 };
@@ -13546,6 +13547,11 @@ static struct hda_verb alc269_quanta_fl1_verbs[] = {
 	{ }
 };
 
+static struct hda_verb alc269_vaio_verbs[] = {
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREFGRD},
+	{ }
+};
+
 static struct hda_verb alc269_lifebook_verbs[] = {
 	{0x15, AC_VERB_SET_CONNECT_SEL, 0x01},
 	{0x1a, AC_VERB_SET_CONNECT_SEL, 0x01},
@@ -14002,6 +14008,7 @@ static const char *alc269_models[ALC269_MODEL_LAST] = {
 	[ALC269_DMIC]			= "laptop-dmic",
 	[ALC269_FUJITSU]		= "fujitsu",
 	[ALC269_LIFEBOOK]		= "lifebook",
+	[ALC269_VAIO]			= "vaio",
 	[ALC269_AUTO]			= "auto",
 };
 
@@ -14051,7 +14058,7 @@ static struct snd_pci_quirk alc269_cfg_tbl[] = {
 		      ALC269_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005HA", ALC269_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS P1005HA", ALC269_DMIC),
-	SND_PCI_QUIRK(0x104d, 0x9071, "SONY XTB", ALC269_DMIC),
+	SND_PCI_QUIRK(0x104d, 0x9071, "SONY Vaio", ALC269_VAIO),
 	SND_PCI_QUIRK(0x10cf, 0x1475, "Lifebook ICH9M-based", ALC269_LIFEBOOK),
 	SND_PCI_QUIRK(0x152d, 0x1778, "Quanta ON1", ALC269_DMIC),
 	SND_PCI_QUIRK(0x1734, 0x115d, "FSC Amilo", ALC269_FUJITSU),
@@ -14073,6 +14080,21 @@ static struct alc_config_preset alc269_presets[] = {
 		.channel_mode = alc269_modes,
 		.input_mux = &alc269_capture_source,
 	},
+	[ALC269_VAIO] = {
+		.mixers = { alc269_laptop_mixer },
+		.cap_mixer = alc269_laptop_digital_capture_mixer,
+		.init_verbs = { alc269_init_verbs,
+				alc269_vaio_verbs,
+				alc269_laptop_dmic_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc269_dac_nids),
+		.dac_nids = alc269_dac_nids,
+		.hp_nid = 0x03,
+		.num_channel_mode = ARRAY_SIZE(alc269_modes),
+		.channel_mode = alc269_modes,
+		.unsol_event = alc269_laptop_unsol_event,
+		.setup = alc269_laptop_dmic_setup,
+		.init_hook = alc269_laptop_inithook,
+        },
 	[ALC269_QUANTA_FL1] = {
 		.mixers = { alc269_quanta_fl1_mixer },
 		.init_verbs = { alc269_init_verbs, alc269_quanta_fl1_verbs },
-- 
1.7.0.3
