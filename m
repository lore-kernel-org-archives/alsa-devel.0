From: Hector Martin <hector@marcansoft.com>
Subject: [PATCH] HDA: remove useless mixers on Aspire 8930G
Date: Sun, 20 Dec 2009 22:51:23 +0100
Message-ID: <4B2E9C5B.6040307@marcansoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080509020700010800050800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C35510384E
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 22:51:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080509020700010800050800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch removes some extra mixers that do nothing on the Acer Aspire
8930G.

The CD mixer is useless because the SATA DVD/Blu-Ray drive has no analog
audio output, and the Side mixer is useless because we max out at 6ch
anyway.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------080509020700010800050800
Content-Type: text/plain;
 name="aspire-8930g-remove-useless-mixers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aspire-8930g-remove-useless-mixers.patch"

Signed-off-by: Hector Martin <hector@marcansoft.com>

--- linux-2.6.32/sound/pci/hda/patch_realtek_orig.c	2009-12-20 19:31:08.940900751 +0100
+++ linux-2.6.32/sound/pci/hda/patch_realtek.c	2009-12-20 22:14:11.852025021 +0100
@@ -1780,6 +1782,25 @@
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc889_acer_aspire_8930g_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0,
+		HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	{ } /* end */
+};
+
+
 static void alc888_acer_aspire_4930g_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -9283,7 +9283,7 @@
 		.init_hook = alc_automute_amp,
 	},
 	[ALC888_ACER_ASPIRE_8930G] = {
-		.mixers = { alc888_base_mixer,
+		.mixers = { alc889_acer_aspire_8930g_mixer,
 				alc883_chmode_mixer },
 		.init_verbs = { alc883_init_verbs, alc880_gpio1_init_verbs,
 				alc889_acer_aspire_8930g_verbs },

--------------080509020700010800050800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080509020700010800050800--
