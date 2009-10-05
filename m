From: Li Bo <liboat@gmail.com>
Subject: [PATCH 13/31] HDA patch_via.c: Refresh front playback
	mute if hp plug-in mutes speaker.
Date: Mon, 5 Oct 2009 22:27:16 +0800
Message-ID: <16685ee0910050727k72411ca7kd80cbb8eb6771f6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id D2500103844
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:27:16 +0200 (CEST)
Received: by fxm8 with SMTP id 8so2792157fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:27:16 -0700 (PDT)
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Refresh front playback mute if hp plug-in mutes speaker.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:10:13.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:10:22.000000000 +0800
@@ -1346,14 +1346,26 @@
 /* mute internal speaker if HP is plugged */
 static void via_hp_automute(struct hda_codec *codec)
 {
-	unsigned int present;
+	unsigned int present = 0;
 	struct via_spec *spec = codec->spec;
+	char name[32] = "Front Playback Switch";

 	present = snd_hda_codec_read(codec, spec->autocfg.hp_pins[0], 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
-	snd_hda_codec_amp_stereo(codec, spec->autocfg.line_out_pins[0],
-				 HDA_OUTPUT, 0, HDA_AMP_MUTE,
-				 present ? HDA_AMP_MUTE : 0);
+
+	if (!spec->hp_independent_mode) {
+		struct snd_card *card = codec->bus->card;
+		struct snd_kcontrol *kctl;
+		/* auto mute */
+		snd_hda_codec_amp_stereo(
+			codec, spec->autocfg.line_out_pins[0], HDA_OUTPUT, 0,
+			HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+		/* notify change */
+		list_for_each_entry(kctl, &card->controls, list)
+			if (strcmp(kctl->id.name, name) == 0)
+				snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+					       &kctl->id);
+	}
 }

 static void via_gpio_control(struct hda_codec *codec)
