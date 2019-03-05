From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda: set the 2nd headphone's name to be Headphone2
Date: Tue,  5 Mar 2019 22:09:10 +0800
Message-ID: <20190305140910.25615-1-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Recently I saw two Headphones on some HP machines, the 1st Headphone
comes from the Front Headphone Jack, the 2nd one comes from the Front
Headset Jack, and the current HDA driver will set the same name to
them and with different index, just like below:
'Headphone Playback Volume'
'Headphone Playback Switch'
'Headphone Playback Volume' index 1
'Headphone Playback Switch' index 1
'Front Headphone Jack'
'Front Headphone Jack' index 1

This can't be handled by pulseaudio, and pulseaduio already has a
path analog-output-headphones-2.conf to handle the 2nd headphone, now
we set the 2nd headphone's name to "Headphone2", leave the other
headphones unchanged.

The change of hda_auto_parser.c will change the name of Jack.

The change of hda_generic.c will change the name of Volume and Switch.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
The alsa-info.txt before applying this patch:
https://pastebin.ubuntu.com/p/CrPrHRykgT/

The alsa-info.txt after applying this patch:
https://pastebin.ubuntu.com/p/9VbkyvMBkW/

sound/pci/hda/hda_auto_parser.c | 11 +++++++++--
 sound/pci/hda/hda_generic.c     |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index df0d636145f8..748c62a9c5eb 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -714,6 +714,8 @@ int snd_hda_get_pin_label(struct hda_codec *codec, hda_nid_t nid,
 	unsigned int def_conf = snd_hda_codec_get_pincfg(codec, nid);
 	const char *name = NULL;
 	int i;
+	int ret;
+	int index;
 	bool hdmi;
 
 	if (indexp)
@@ -729,8 +731,13 @@ int snd_hda_get_pin_label(struct hda_codec *codec, hda_nid_t nid,
 		return fill_audio_out_name(codec, nid, cfg, "Speaker",
 					   label, maxlen, indexp);
 	case AC_JACK_HP_OUT:
-		return fill_audio_out_name(codec, nid, cfg, "Headphone",
-					   label, maxlen, indexp);
+		ret = fill_audio_out_name(codec, nid, cfg, "Headphone",
+					   label, maxlen, &index);
+		if (index == 1)
+			snprintf(label, maxlen, "%s", "Headphone2");
+		if (indexp)
+			*indexp = index;
+		return ret;
 	case AC_JACK_SPDIF_OUT:
 	case AC_JACK_DIG_OTHER_OUT:
 		hdmi = is_hdmi_cfg(def_conf);
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 4095cd7c56c6..2a34e8a6e2e1 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2175,6 +2175,8 @@ static int create_extra_outs(struct hda_codec *codec, int num_pins,
 
 		if (num_pins == 2 && i == 1 && !strcmp(pfx, "Speaker"))
 			name = "Bass Speaker";
+		else if (num_pins == 2 && i == 1 && !strcmp(pfx, "Headphone"))
+			name = "Headphone2";
 		else if (num_pins >= 3) {
 			snprintf(tmp, sizeof(tmp), "%s %s",
 				 pfx, channel_name[i]);
-- 
2.17.1
