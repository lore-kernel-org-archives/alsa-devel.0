From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA Codecs: add support for Toshiba Equium L30
Date: Thu, 06 Mar 2008 13:19:48 -0800
Message-ID: <1204838388.19690.121.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zyxkXjk8Z3lRQ/eKxiS7"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 22B5E244DA
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 22:19:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-zyxkXjk8Z3lRQ/eKxiS7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for the Toshiba Equium L30 laptop and renames
the mixer controls to match Laptop usages.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-zyxkXjk8Z3lRQ/eKxiS7
Content-Disposition: attachment; filename=Toshiba-Equium-4.patch
Content-Type: text/x-patch; name=Toshiba-Equium-4.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 72360e8993f7 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Thu Mar 06 16:58:35 2008 +0100
+++ b/pci/hda/patch_realtek.c	Thu Mar 06 13:14:19 2008 -0800
@@ -12054,11 +12054,10 @@ static struct hda_input_mux alc861vd_cap
 };
 
 static struct hda_input_mux alc861vd_dallas_capture_source = {
-	.num_items = 3,
+	.num_items = 2,
 	.items = {
-		{ "Front Mic", 0x0 },
-		{ "ATAPI Mic", 0x1 },
-		{ "Line In", 0x5 },
+		{ "Ext Mic", 0x0 },
+		{ "Int Mic", 0x1 },
 	},
 };
 
@@ -12228,20 +12227,22 @@ static struct snd_kcontrol_new alc861vd_
 	{ } /* end */
 };
 
-/* Pin assignment: Front=0x14, HP = 0x15,
- *                 Front Mic=0x18, ATAPI Mic = 0x19, Line In = 0x1d
+/* Pin assignment: Speaker=0x14, HP = 0x15,
+ *                 Ext Mic=0x18, Int Mic = 0x19, CD = 0x1c, PC Beep = 0x1d
  */
 static struct snd_kcontrol_new alc861vd_dallas_mixer[] = {
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x02, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x02, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Speaker Playback Switch", 0x0c, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Headphone Playback Switch", 0x0d, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("ATAPI Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("ATAPI Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x05, HDA_INPUT),
-	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x05, HDA_INPUT),
+	HDA_CODEC_VOLUME("Ext Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("PC Beep Volume", 0x0b, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("PC Beep Switch", 0x0b, 0x05, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -12542,6 +12543,7 @@ static struct snd_pci_quirk alc861vd_cfg
 	/*SND_PCI_QUIRK(0x1179, 0xff00, "DALLAS", ALC861VD_DALLAS),*/ /*lenovo*/
 	SND_PCI_QUIRK(0x1179, 0xff01, "DALLAS", ALC861VD_DALLAS),
 	SND_PCI_QUIRK(0x1179, 0xff03, "Toshiba P205", ALC861VD_LENOVO),
+	SND_PCI_QUIRK(0x1179, 0xff31, "Toshiba L30-149", ALC861VD_DALLAS),
 	SND_PCI_QUIRK(0x1565, 0x820d, "Biostar NF61S SE", ALC861VD_6ST_DIG),
 	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo", ALC861VD_LENOVO),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo 3000 C200", ALC861VD_LENOVO),

--=-zyxkXjk8Z3lRQ/eKxiS7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-zyxkXjk8Z3lRQ/eKxiS7--
