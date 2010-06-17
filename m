From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - add ideapad model for Conexant
	5051 codec
Date: Thu, 17 Jun 2010 14:15:06 -0300
Message-ID: <201006171415.07101.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 41F0D10394E
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jun 2010 19:18:35 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Lenovo IdeaPad Y430 has an additional subwoofer connected at pin 0x1b,
which isn't muted when headphone is plugged in. This adds additional
support to the extra subwoofer via new ideapad model.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
 sound/pci/hda/patch_conexant.c               |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt 
b/Documentation/sound/alsa/HD-Audio-Models.txt
index 1d38b0d..84e81ad 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -282,6 +282,7 @@ Conexant 5051
   hp		HP Spartan laptop
   hp-dv6736	HP dv6736
   hp-f700	HP Compaq Presario F700
+  ideapad	Lenovo IdeaPad laptop
   lenovo-x200	Lenovo X200 laptop
   toshiba	Toshiba Satellite M300
 
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 2bf2cb5..54f7419 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1632,6 +1632,11 @@ static void cxt5051_update_speaker(struct hda_codec 
*codec)
 	pinctl = (!spec->hp_present && spec->cur_eapd) ? PIN_OUT : 0;
 	snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
 			    pinctl);
+	/* on ideapad there is an aditional speaker (subwoofer) to mute */
+	if (spec->ideapad)
+		snd_hda_codec_write(codec, 0x1b, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    pinctl);
 }
 
 /* turn on/off EAPD (+ mute HP) as a master switch */
@@ -1888,6 +1893,13 @@ static void cxt5051_init_mic_port(struct hda_codec 
*codec, hda_nid_t nid,
 #endif
 }
 
+static struct hda_verb cxt5051_ideapad_init_verbs[] = {
+	/* Subwoofer */
+	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x1b, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{ } /* end */
+};
+
 /* initialize jack-sensing, too */
 static int cxt5051_init(struct hda_codec *codec)
 {
@@ -1917,6 +1929,7 @@ enum {
 	CXT5051_LENOVO_X200,	/* Lenovo X200 laptop, also used for Advanced Mini 
Dock 250410 */
 	CXT5051_F700,       /* HP Compaq Presario F700 */
 	CXT5051_TOSHIBA,	/* Toshiba M300 & co */
+	CXT5051_IDEAPAD,	/* Lenovo IdeaPad Y430 */
 	CXT5051_MODELS
 };
 
@@ -1927,6 +1940,7 @@ static const char *cxt5051_models[CXT5051_MODELS] = {
 	[CXT5051_LENOVO_X200]	= "lenovo-x200",
 	[CXT5051_F700]          = "hp-700",
 	[CXT5051_TOSHIBA]	= "toshiba",
+	[CXT5051_IDEAPAD]	= "ideapad",
 };
 
 static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
@@ -1938,6 +1952,7 @@ static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
 		      CXT5051_LAPTOP),
 	SND_PCI_QUIRK(0x14f1, 0x5051, "HP Spartan 1.1", CXT5051_HP),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo X200", CXT5051_LENOVO_X200),
+	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo IdeaPad", CXT5051_IDEAPAD),
 	{}
 };
 
@@ -1999,6 +2014,11 @@ static int patch_cxt5051(struct hda_codec *codec)
 		spec->mixers[0] = cxt5051_toshiba_mixers;
 		spec->auto_mic = AUTO_MIC_PORTB;
 		break;
+	case CXT5051_IDEAPAD:
+		spec->init_verbs[spec->num_init_verbs++] =
+			cxt5051_ideapad_init_verbs;
+		spec->ideapad = 1;
+		break;
 	}
 
 	return 0;
-- 
1.7.1
