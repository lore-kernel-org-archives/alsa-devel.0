From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Rename "Mic Boost" to "Mic Boost
	Volume"
Date: Tue, 04 Jan 2011 15:48:13 +0100
Message-ID: <4D23332D.6060806@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010704080104050600080505"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D216103914
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 15:48:16 +0100 (CET)
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
--------------010704080104050600080505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If the "Volume" suffix is not given, alsa-lib gets confused and
loses the dB information at the simple element level.

Boosts generally affects both playback and capture, as they are
applied early in the chain. Hence no "Playback" or "Capture" in
the suffix.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------010704080104050600080505
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Rename-Mic-Boost-to-Mic-Boost-Volume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Rename-Mic-Boost-to-Mic-Boost-Volume.patch"

>From 1dd9f0fa638d7a836ccb5b7dbd683a27db5cd128 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 4 Jan 2011 15:24:24 +0100
Subject: [PATCH] ALSA: HDA: Rename "Mic Boost" to "Mic Boost Volume"

BugLink: http://bugs.launchpad.net/bugs/697240

If the "Volume" suffix is not given, alsa-lib gets confused and
loses the dB information at the simple element level.

Boosts generally affects both playback and capture, as they are
applied early in the chain. Hence no "Playback" or "Capture" in
the suffix.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_analog.c   |   72 +++++++-------
 sound/pci/hda/patch_conexant.c |    2 +-
 sound/pci/hda/patch_realtek.c  |  222 ++++++++++++++++++++--------------------
 3 files changed, 148 insertions(+), 148 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index f7ff3f7..4678067 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -666,7 +666,7 @@ static struct snd_kcontrol_new ad1986a_mixers[] = {
 	HDA_CODEC_MUTE("Aux Playback Switch", 0x16, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x13, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x0f, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x0f, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Mono Playback Volume", 0x1e, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Mono Playback Switch", 0x1e, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x12, 0x0, HDA_OUTPUT),
@@ -729,7 +729,7 @@ static struct snd_kcontrol_new ad1986a_laptop_mixers[] = {
 	HDA_CODEC_MUTE("Aux Playback Switch", 0x16, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x13, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x0f, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x0f, 0x0, HDA_OUTPUT),
 	/* 
 	   HDA_CODEC_VOLUME("Mono Playback Volume", 0x1e, 0x0, HDA_OUTPUT),
 	   HDA_CODEC_MUTE("Mono Playback Switch", 0x1e, 0x0, HDA_OUTPUT), */
@@ -775,7 +775,7 @@ static struct snd_kcontrol_new ad1986a_laptop_eapd_mixers[] = {
 	HDA_CODEC_MUTE("PCM Playback Switch", 0x03, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x13, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x0f, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x0f, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x12, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x12, 0x0, HDA_OUTPUT),
 	{
@@ -1358,7 +1358,7 @@ static struct snd_kcontrol_new ad1983_mixers[] = {
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x12, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x13, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x15, 0x0, HDA_OUTPUT),
 	{
@@ -1515,8 +1515,8 @@ static struct snd_kcontrol_new ad1981_mixers[] = {
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x08, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x15, 0x0, HDA_OUTPUT),
 	{
@@ -1726,8 +1726,8 @@ static struct snd_kcontrol_new ad1981_hp_mixers[] = {
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x1d, 0x0, HDA_OUTPUT),
 #endif
-	HDA_CODEC_VOLUME("Mic Boost", 0x08, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x18, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x18, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x15, 0x0, HDA_OUTPUT),
 	{
@@ -1774,7 +1774,7 @@ static struct snd_kcontrol_new ad1981_thinkpad_mixers[] = {
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x12, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x08, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x15, 0x0, HDA_OUTPUT),
 	{
@@ -2160,8 +2160,8 @@ static struct snd_kcontrol_new ad1988_6stack_mixers2[] = {
 	HDA_CODEC_VOLUME("Analog Mix Playback Volume", 0x21, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Analog Mix Playback Switch", 0x21, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x39, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x3c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x39, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x3c, 0x0, HDA_OUTPUT),
 
 	{ } /* end */
 };
@@ -2203,8 +2203,8 @@ static struct snd_kcontrol_new ad1988_3stack_mixers2[] = {
 	HDA_CODEC_VOLUME("Analog Mix Playback Volume", 0x21, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Analog Mix Playback Switch", 0x21, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x39, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x3c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x39, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x3c, 0x0, HDA_OUTPUT),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Channel Mode",
@@ -2232,7 +2232,7 @@ static struct snd_kcontrol_new ad1988_laptop_mixers[] = {
 	HDA_CODEC_VOLUME("Analog Mix Playback Volume", 0x21, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Analog Mix Playback Switch", 0x21, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME("Mic Boost", 0x39, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x39, 0x0, HDA_OUTPUT),
 
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -2902,7 +2902,7 @@ static int new_analog_input(struct ad198x_spec *spec, hda_nid_t pin,
 		idx = ad1988_pin_idx(pin);
 		bnid = ad1988_boost_nids[idx];
 		if (bnid) {
-			sprintf(name, "%s Boost", ctlname);
+			sprintf(name, "%s Boost Volume", ctlname);
 			return add_control(spec, AD_CTL_WIDGET_VOL, name,
 					   HDA_COMPOSE_AMP_VAL(bnid, 3, idx, HDA_OUTPUT));
 
@@ -3300,8 +3300,8 @@ static struct snd_kcontrol_new ad1884_base_mixers[] = {
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x20, 0x01, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x20, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x20, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x15, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x14, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x15, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x14, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x0d, 0x0, HDA_OUTPUT),
@@ -3499,9 +3499,9 @@ static struct snd_kcontrol_new ad1984_thinkpad_mixers[] = {
 	HDA_CODEC_MUTE("Beep Playback Switch", 0x20, 0x03, HDA_INPUT),
 	HDA_CODEC_VOLUME("Docking Mic Playback Volume", 0x20, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("Docking Mic Playback Switch", 0x20, 0x04, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x14, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x15, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Docking Mic Boost", 0x25, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x14, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x15, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Dock Mic Boost Volume", 0x25, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x0d, 0x0, HDA_OUTPUT),
@@ -3560,8 +3560,8 @@ static struct snd_kcontrol_new ad1984_dell_desktop_mixers[] = {
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x20, 0x00, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line-In Playback Volume", 0x20, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Line-In Playback Switch", 0x20, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line-In Boost", 0x15, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x14, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line-In Boost Volume", 0x15, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x14, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x0d, 0x0, HDA_OUTPUT),
@@ -3745,9 +3745,9 @@ static struct snd_kcontrol_new ad1884a_base_mixers[] = {
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x20, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x20, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x20, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x14, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Boost", 0x15, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x25, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x14, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Boost Volume", 0x15, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x25, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x0d, 0x0, HDA_OUTPUT),
@@ -3888,9 +3888,9 @@ static struct snd_kcontrol_new ad1884a_laptop_mixers[] = {
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x20, 0x01, HDA_INPUT),
 	HDA_CODEC_VOLUME("Dock Mic Playback Volume", 0x20, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("Dock Mic Playback Switch", 0x20, 0x04, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x14, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x15, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Dock Mic Boost", 0x25, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x14, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x15, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Dock Mic Boost Volume", 0x25, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
 	{ } /* end */
@@ -4126,8 +4126,8 @@ static struct snd_kcontrol_new ad1984a_thinkpad_mixers[] = {
 	HDA_CODEC_MUTE("PCM Playback Switch", 0x20, 0x5, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x20, 0x00, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x20, 0x00, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x14, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x14, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
 	{
@@ -4255,8 +4255,8 @@ static struct snd_kcontrol_new ad1984a_touchsmart_mixers[] = {
 	HDA_CODEC_MUTE("PCM Playback Switch", 0x20, 0x5, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x25, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x25, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x17, 0x0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -4494,9 +4494,9 @@ static struct snd_kcontrol_new ad1882_base_mixers[] = {
 	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x13, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_MONO("Mono Playback Switch", 0x13, 1, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME("Mic Boost", 0x3c, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x39, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Line-In Boost", 0x3a, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x3c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x39, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Line-In Boost Volume", 0x3a, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x0d, 0x0, HDA_OUTPUT),
@@ -4547,7 +4547,7 @@ static struct snd_kcontrol_new ad1882a_loopback_mixers[] = {
 	HDA_CODEC_MUTE("Line Playback Switch", 0x20, 0x01, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x20, 0x06, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x20, 0x06, HDA_INPUT),
-	HDA_CODEC_VOLUME("Digital Mic Boost", 0x1f, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Digital Mic Boost Volume", 0x1f, 0x0, HDA_INPUT),
 	{ } /* end */
 };
 
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 74291f7..3396244 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1376,7 +1376,7 @@ static void cxt5047_hp_unsol_event(struct hda_codec *codec,
 static struct snd_kcontrol_new cxt5047_base_mixers[] = {
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x19, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x19, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x1a, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x1a, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x12, 0x03, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x12, 0x03, HDA_INPUT),
 	HDA_CODEC_VOLUME("PCM Volume", 0x10, 0x00, HDA_OUTPUT),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f39efa4..18d53d2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2232,7 +2232,7 @@ static struct snd_kcontrol_new alc888_base_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	{ } /* end */
 };
@@ -2250,7 +2250,7 @@ static struct snd_kcontrol_new alc889_acer_aspire_8930g_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	{ } /* end */
 };
@@ -7896,10 +7896,10 @@ static struct snd_kcontrol_new alc882_base_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -7923,8 +7923,8 @@ static struct snd_kcontrol_new alc885_mbp3_mixer[] = {
 	HDA_CODEC_MUTE  ("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x00, HDA_INPUT),
 	HDA_CODEC_MUTE  ("Mic Playback Switch", 0x0b, 0x00, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Boost", 0x1a, 0x00, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Boost Volume", 0x1a, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0x00, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -7941,8 +7941,8 @@ static struct snd_kcontrol_new alc885_mb5_mixer[] = {
 	HDA_CODEC_MUTE  ("Line Playback Switch", 0x0b, 0x07, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE  ("Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Boost", 0x15, 0x00, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x19, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Boost Volume", 0x15, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x19, 0x00, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -7957,7 +7957,7 @@ static struct snd_kcontrol_new alc885_macmini3_mixer[] = {
 	HDA_BIND_MUTE   ("Headphone Playback Switch", 0x0f, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x07, HDA_INPUT),
 	HDA_CODEC_MUTE  ("Line Playback Switch", 0x0b, 0x07, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Boost", 0x15, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Boost Volume", 0x15, 0x00, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -7976,7 +7976,7 @@ static struct snd_kcontrol_new alc882_w2jc_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	{ } /* end */
 };
@@ -7991,10 +7991,10 @@ static struct snd_kcontrol_new alc882_targa_mixer[] = {
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -8014,7 +8014,7 @@ static struct snd_kcontrol_new alc882_asus_a7j_mixer[] = {
 	HDA_CODEC_MUTE("Mobile Line Playback Switch", 0x0b, 0x03, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -8027,7 +8027,7 @@ static struct snd_kcontrol_new alc882_asus_a7m_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	{ } /* end */
 };
@@ -8808,10 +8808,10 @@ static struct snd_kcontrol_new alc883_mitac_mixer[] = {
 	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -8822,10 +8822,10 @@ static struct snd_kcontrol_new alc883_clevo_m720_mixer[] = {
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Speaker Playback Switch", 0x0d, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -8836,10 +8836,10 @@ static struct snd_kcontrol_new alc883_2ch_fujitsu_pi2515_mixer[] = {
 	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Speaker Playback Switch", 0x0d, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -8853,10 +8853,10 @@ static struct snd_kcontrol_new alc883_3ST_2ch_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -8876,10 +8876,10 @@ static struct snd_kcontrol_new alc883_3ST_6ch_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -8900,10 +8900,10 @@ static struct snd_kcontrol_new alc883_3ST_6ch_intel_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	{ } /* end */
 };
@@ -8924,10 +8924,10 @@ static struct snd_kcontrol_new alc885_8ch_intel_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x3, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x1b, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x1b, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x3, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	{ } /* end */
 };
@@ -8947,10 +8947,10 @@ static struct snd_kcontrol_new alc883_fivestack_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -8971,7 +8971,7 @@ static struct snd_kcontrol_new alc883_targa_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	{ } /* end */
 };
@@ -8984,10 +8984,10 @@ static struct snd_kcontrol_new alc883_targa_2ch_mixer[] = {
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -8996,7 +8996,7 @@ static struct snd_kcontrol_new alc883_targa_8ch_mixer[] = {
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -9008,7 +9008,7 @@ static struct snd_kcontrol_new alc883_lenovo_101e_2ch_mixer[] = {
 	HDA_BIND_MUTE("Speaker Playback Switch", 0x0d, 2, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -9069,7 +9069,7 @@ static struct snd_kcontrol_new alc883_acer_aspire_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	{ } /* end */
 };
@@ -9082,7 +9082,7 @@ static struct snd_kcontrol_new alc888_acer_aspire_6530_mixer[] = {
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	{ } /* end */
 };
@@ -9104,10 +9104,10 @@ static struct snd_kcontrol_new alc888_lenovo_sky_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -9128,8 +9128,8 @@ static struct snd_kcontrol_new alc889A_mb31_mixer[] = {
 	HDA_CODEC_MUTE("Enable Headphones", 0x15, 0x00, HDA_OUTPUT),
 	HDA_CODEC_MUTE_MONO("Enable LFE", 0x16, 2, 0x00, HDA_OUTPUT),
 	/* Boost mixers */
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0x00, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line Boost", 0x1a, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Boost Volume", 0x1a, 0x00, HDA_INPUT),
 	/* Input mixers */
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x00, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x00, HDA_INPUT),
@@ -9143,7 +9143,7 @@ static struct snd_kcontrol_new alc883_vaiott_mixer[] = {
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
@@ -9173,7 +9173,7 @@ static struct snd_kcontrol_new alc883_asus_eee1601_mixer[] = {
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 	{ } /* end */
 };
@@ -10834,7 +10834,7 @@ static int alc_auto_add_mic_boost(struct hda_codec *codec)
 				type_idx++;
 			else
 				type_idx = 0;
-			snprintf(label, sizeof(label), "%s Boost",
+			snprintf(label, sizeof(label), "%s Boost Volume",
 				 hda_get_autocfg_input_label(codec, cfg, i));
 			err = add_control(spec, ALC_CTL_WIDGET_VOL, label,
 					  type_idx,
@@ -11079,10 +11079,10 @@ static struct snd_kcontrol_new alc262_base_mixer[] = {
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x0D, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
@@ -11183,10 +11183,10 @@ static struct snd_kcontrol_new alc262_HP_BPC_mixer[] = {
 			    HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
@@ -11208,7 +11208,7 @@ static struct snd_kcontrol_new alc262_HP_BPC_WildWest_mixer[] = {
 			    HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x1a, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x1a, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
@@ -11219,7 +11219,7 @@ static struct snd_kcontrol_new alc262_HP_BPC_WildWest_mixer[] = {
 static struct snd_kcontrol_new alc262_HP_BPC_WildWest_option_mixer[] = {
 	HDA_CODEC_VOLUME("Rear Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Rear Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Rear Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Rear Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -11239,7 +11239,7 @@ static struct snd_kcontrol_new alc262_hp_t5735_mixer[] = {
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -11346,10 +11346,10 @@ static struct snd_kcontrol_new alc262_hippo_mixer[] = {
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
 	{ } /* end */
 };
@@ -11363,10 +11363,10 @@ static struct snd_kcontrol_new alc262_hippo1_mixer[] = {
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -11434,10 +11434,10 @@ static struct snd_kcontrol_new alc262_tyan_mixer[] = {
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -11621,7 +11621,7 @@ static struct snd_kcontrol_new alc262_nec_mixer[] = {
 
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
@@ -11828,10 +11828,10 @@ static struct snd_kcontrol_new alc262_fujitsu_mixer[] = {
 	},
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
@@ -11864,10 +11864,10 @@ static struct snd_kcontrol_new alc262_lenovo_3000_mixer[] = {
 	},
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
@@ -11878,10 +11878,10 @@ static struct snd_kcontrol_new alc262_toshiba_rx1_mixer[] = {
 	ALC262_HIPPO_MASTER_SWITCH,
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -11907,8 +11907,8 @@ static struct snd_kcontrol_new alc262_ultra_mixer[] = {
 	HDA_BIND_MUTE("Master Playback Switch", 0x0c, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Headphone Mic Boost", 0x15, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Headphone Mic Boost Volume", 0x15, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -12985,9 +12985,9 @@ static struct snd_kcontrol_new alc268_base_mixer[] = {
 	HDA_CODEC_MUTE("Front Playback Switch", 0x14, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x3, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line In Boost", 0x1a, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line In Boost Volume", 0x1a, 0, HDA_INPUT),
 	{ }
 };
 
@@ -12996,9 +12996,9 @@ static struct snd_kcontrol_new alc268_toshiba_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x2, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x3, 0x0, HDA_OUTPUT),
 	ALC262_HIPPO_MASTER_SWITCH,
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line In Boost", 0x1a, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line In Boost Volume", 0x1a, 0, HDA_INPUT),
 	{ }
 };
 
@@ -13102,9 +13102,9 @@ static struct snd_kcontrol_new alc268_acer_mixer[] = {
 		.put = alc268_acer_master_sw_put,
 		.private_value = HDA_COMPOSE_AMP_VAL(0x14, 3, 0, HDA_OUTPUT),
 	},
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line In Boost", 0x1a, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line In Boost Volume", 0x1a, 0, HDA_INPUT),
 	{ }
 };
 
@@ -13120,8 +13120,8 @@ static struct snd_kcontrol_new alc268_acer_dmic_mixer[] = {
 		.put = alc268_acer_master_sw_put,
 		.private_value = HDA_COMPOSE_AMP_VAL(0x14, 3, 0, HDA_OUTPUT),
 	},
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line In Boost", 0x1a, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line In Boost Volume", 0x1a, 0, HDA_INPUT),
 	{ }
 };
 
@@ -13213,8 +13213,8 @@ static struct snd_kcontrol_new alc268_dell_mixer[] = {
 	HDA_CODEC_MUTE("Speaker Playback Switch", 0x14, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	{ }
 };
 
@@ -13247,8 +13247,8 @@ static struct snd_kcontrol_new alc267_quanta_il1_mixer[] = {
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Mic Capture Volume", 0x23, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Mic Capture Switch", 0x23, 2, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	{ }
 };
 
@@ -14071,10 +14071,10 @@ static struct snd_kcontrol_new alc269_base_mixer[] = {
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_MONO("Mono Playback Switch", 0x16, 2, 0x0, HDA_OUTPUT),
 	{ } /* end */
@@ -14094,10 +14094,10 @@ static struct snd_kcontrol_new alc269_quanta_fl1_mixer[] = {
 	},
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	{ }
 };
 
@@ -14115,13 +14115,13 @@ static struct snd_kcontrol_new alc269_lifebook_mixer[] = {
 	},
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Dock Mic Playback Volume", 0x0b, 0x03, HDA_INPUT),
 	HDA_CODEC_MUTE("Dock Mic Playback Switch", 0x0b, 0x03, HDA_INPUT),
-	HDA_CODEC_VOLUME("Dock Mic Boost", 0x1b, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Dock Mic Boost Volume", 0x1b, 0, HDA_INPUT),
 	{ }
 };
 
@@ -14151,30 +14151,30 @@ static struct snd_kcontrol_new alc269_asus_mixer[] = {
 static struct snd_kcontrol_new alc269_laptop_analog_capture_mixer[] = {
 	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("IntMic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	{ } /* end */
 };
 
 static struct snd_kcontrol_new alc269_laptop_digital_capture_mixer[] = {
 	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	{ } /* end */
 };
 
 static struct snd_kcontrol_new alc269vb_laptop_analog_capture_mixer[] = {
 	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("IntMic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	{ } /* end */
 };
 
 static struct snd_kcontrol_new alc269vb_laptop_digital_capture_mixer[] = {
 	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x09, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -16473,11 +16473,11 @@ static struct snd_kcontrol_new alc861vd_6st_mixer[] = {
 
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 
@@ -16496,11 +16496,11 @@ static struct snd_kcontrol_new alc861vd_3st_mixer[] = {
 
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 
@@ -16520,11 +16520,11 @@ static struct snd_kcontrol_new alc861vd_lenovo_mixer[] = {
 
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 
@@ -16542,10 +16542,10 @@ static struct snd_kcontrol_new alc861vd_dallas_mixer[] = {
 	HDA_BIND_MUTE("Speaker Playback Switch", 0x0c, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Headphone Playback Switch", 0x0d, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
@@ -17547,11 +17547,11 @@ static struct snd_kcontrol_new alc662_eeepc_p701_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0x02, 0x0, HDA_OUTPUT),
 	ALC262_HIPPO_MASTER_SWITCH,
 
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
@@ -18543,11 +18543,11 @@ static struct snd_kcontrol_new alc662_ecs_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0x02, 0x0, HDA_OUTPUT),
 	ALC262_HIPPO_MASTER_SWITCH,
 
-	HDA_CODEC_VOLUME("Mic/LineIn Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic/LineIn Boost Volume", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic/LineIn Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic/LineIn Playback Switch", 0x0b, 0x0, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
@@ -18562,11 +18562,11 @@ static struct snd_kcontrol_new alc272_nc10_mixer[] = {
 
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
 
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x19, 0, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -19609,9 +19609,9 @@ static struct snd_kcontrol_new alc680_base_mixer[] = {
 	HDA_CODEC_MUTE("Front Playback Switch", 0x14, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x4, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x16, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Internal Mic Boost", 0x12, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Line In Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x12, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line In Boost Volume", 0x19, 0, HDA_INPUT),
 	{ }
 };
 
-- 
1.7.1


--------------010704080104050600080505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010704080104050600080505--
