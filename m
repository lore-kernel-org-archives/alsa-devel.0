From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: HDA: Rename "Ext Mic" and "External
	Mic" to "Mic"
Date: Mon, 20 Dec 2010 14:56:32 +0100
Message-ID: <4D0F6090.5010500@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010603050407030903010205"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DADC10389D
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 14:56:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010603050407030903010205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------010603050407030903010205
Content-Type: text/x-patch;
 name="0002-ALSA-HDA-Rename-Ext-Mic-and-External-Mic-to-Mic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ALSA-HDA-Rename-Ext-Mic-and-External-Mic-to-Mic.patch"

>From 60e3b9760dd1a3d3e310be964275ff838c075ece Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 20 Dec 2010 14:43:54 +0100
Subject: [PATCH 2/3] ALSA: HDA: Rename "Ext Mic" and "External Mic" to "Mic"

Usually external microphones are just labelled "Mic", so rename
"Ext Mic" and "External Mic" to "Mic" to clear up the namespace.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |   28 ++++++++++++++--------------
 sound/pci/hda/patch_realtek.c  |   26 +++++++++++++-------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 62acf10..74291f7 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -871,14 +871,14 @@ static void cxt5045_hp_unsol_event(struct hda_codec *codec,
 static struct snd_kcontrol_new cxt5045_mixers[] = {
 	HDA_CODEC_VOLUME("Internal Mic Capture Volume", 0x1a, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Capture Switch", 0x1a, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Ext Mic Capture Volume", 0x1a, 0x02, HDA_INPUT),
-	HDA_CODEC_MUTE("Ext Mic Capture Switch", 0x1a, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Capture Volume", 0x1a, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Capture Switch", 0x1a, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("PCM Playback Volume", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("PCM Playback Switch", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x17, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x17, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x17, 0x2, HDA_INPUT),
-	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x17, 0x2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x17, 0x2, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x17, 0x2, HDA_INPUT),
 	HDA_BIND_VOL("Master Playback Volume", &cxt5045_hp_bind_master_vol),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -912,14 +912,14 @@ static struct snd_kcontrol_new cxt5045_benq_mixers[] = {
 static struct snd_kcontrol_new cxt5045_mixers_hp530[] = {
 	HDA_CODEC_VOLUME("Internal Mic Capture Volume", 0x1a, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Capture Switch", 0x1a, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("Ext Mic Capture Volume", 0x1a, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("Ext Mic Capture Switch", 0x1a, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Capture Volume", 0x1a, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Capture Switch", 0x1a, 0x01, HDA_INPUT),
 	HDA_CODEC_VOLUME("PCM Playback Volume", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("PCM Playback Switch", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x17, 0x2, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x17, 0x2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x17, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x17, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x17, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x17, 0x1, HDA_INPUT),
 	HDA_BIND_VOL("Master Playback Volume", &cxt5045_hp_bind_master_vol),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -1796,8 +1796,8 @@ static struct snd_kcontrol_new cxt5051_playback_mixers[] = {
 static struct snd_kcontrol_new cxt5051_capture_mixers[] = {
 	HDA_CODEC_VOLUME("Internal Mic Volume", 0x14, 0x00, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Switch", 0x14, 0x00, HDA_INPUT),
-	HDA_CODEC_VOLUME("External Mic Volume", 0x14, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("External Mic Switch", 0x14, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Volume", 0x14, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Switch", 0x14, 0x01, HDA_INPUT),
 	HDA_CODEC_VOLUME("Docking Mic Volume", 0x15, 0x00, HDA_INPUT),
 	HDA_CODEC_MUTE("Docking Mic Switch", 0x15, 0x00, HDA_INPUT),
 	{}
@@ -1806,8 +1806,8 @@ static struct snd_kcontrol_new cxt5051_capture_mixers[] = {
 static struct snd_kcontrol_new cxt5051_hp_mixers[] = {
 	HDA_CODEC_VOLUME("Internal Mic Volume", 0x14, 0x00, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Switch", 0x14, 0x00, HDA_INPUT),
-	HDA_CODEC_VOLUME("External Mic Volume", 0x15, 0x00, HDA_INPUT),
-	HDA_CODEC_MUTE("External Mic Switch", 0x15, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Volume", 0x15, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Switch", 0x15, 0x00, HDA_INPUT),
 	{}
 };
 
@@ -1826,8 +1826,8 @@ static struct snd_kcontrol_new cxt5051_f700_mixers[] = {
 static struct snd_kcontrol_new cxt5051_toshiba_mixers[] = {
 	HDA_CODEC_VOLUME("Internal Mic Volume", 0x14, 0x00, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Switch", 0x14, 0x00, HDA_INPUT),
-	HDA_CODEC_VOLUME("External Mic Volume", 0x14, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("External Mic Switch", 0x14, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Volume", 0x14, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Switch", 0x14, 0x01, HDA_INPUT),
 	{}
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1506292..08c3d95 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2165,7 +2165,7 @@ static struct hda_input_mux alc888_acer_aspire_6530_sources[2] = {
 	{
 		.num_items = 5,
 		.items = {
-			{ "Ext Mic", 0x0 },
+			{ "Mic", 0x0 },
 			{ "Line In", 0x2 },
 			{ "CD", 0x4 },
 			{ "Input Mix", 0xa },
@@ -2175,7 +2175,7 @@ static struct hda_input_mux alc888_acer_aspire_6530_sources[2] = {
 	{
 		.num_items = 4,
 		.items = {
-			{ "Ext Mic", 0x0 },
+			{ "Mic", 0x0 },
 			{ "Line In", 0x2 },
 			{ "CD", 0x4 },
 			{ "Input Mix", 0xa },
@@ -2841,8 +2841,8 @@ static struct snd_kcontrol_new alc880_fujitsu_mixer[] = {
 	HDA_BIND_MUTE("Speaker Playback Switch", 0x0d, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
-	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
@@ -13247,7 +13247,7 @@ static struct snd_kcontrol_new alc267_quanta_il1_mixer[] = {
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Mic Capture Volume", 0x23, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Mic Capture Switch", 0x23, 2, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Ext Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
 	{ }
 };
@@ -16379,7 +16379,7 @@ static struct hda_input_mux alc861vd_capture_source = {
 static struct hda_input_mux alc861vd_dallas_capture_source = {
 	.num_items = 2,
 	.items = {
-		{ "Ext Mic", 0x0 },
+		{ "Mic", 0x0 },
 		{ "Internal Mic", 0x1 },
 	},
 };
@@ -16521,16 +16521,16 @@ static struct snd_kcontrol_new alc861vd_lenovo_mixer[] = {
 };
 
 /* Pin assignment: Speaker=0x14, HP = 0x15,
- *                 Ext Mic=0x18, Internal Mic = 0x19, CD = 0x1c, PC Beep = 0x1d
+ *                 Mic=0x18, Internal Mic = 0x19, CD = 0x1c, PC Beep = 0x1d
  */
 static struct snd_kcontrol_new alc861vd_dallas_mixer[] = {
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x02, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Speaker Playback Switch", 0x0c, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Headphone Playback Switch", 0x0d, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Ext Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
@@ -18546,9 +18546,9 @@ static struct snd_kcontrol_new alc272_nc10_mixer[] = {
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x21, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Ext Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
 
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
-- 
1.7.1


--------------010603050407030903010205
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010603050407030903010205--
