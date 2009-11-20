From: =?UTF-8?Q?=C5=81ukasz_Wojni=C5=82owicz?= <lukasz.wojnilowicz@gmail.com>
Subject: ALSA: hda - 4930g switch lfe with side in mixer
Date: Fri, 20 Nov 2009 15:27:54 +0100
Message-ID: <1258727274.2255.4.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-wAUrmajWXqOvaeNJ/KRz"
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-wAUrmajWXqOvaeNJ/KRz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Built-in sub-woofer can now be controlled by lfe slider instead of side
slider on Acer Aspire 5930g

--=-wAUrmajWXqOvaeNJ/KRz
Content-Disposition: attachment; filename="switch lfe with side.patch"
Content-Type: text/x-patch; name="switch lfe with side.patch"; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: =C5=81ukasz Wojni=C5=82owicz <lukasz.wojnilowicz@gmail.com>
Subject: ALSA: hda - switch lfe with side in mixer for 4930g

Built-in sub-woofer can now be controlled by lfe slider instead of side s=
lider on Acer Aspire 5930g

Signed-off-by: =C5=81ukasz Wojni=C5=82owicz <lukasz.wojnilowicz@gmail.com=
>
---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
index eee3143..1f03b4e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8042,6 +8042,28 @@ static struct snd_kcontrol_new alc883_acer_aspire_=
mixer[] =3D {
 	{ } /* end */
 };
=20
+static struct snd_kcontrol_new alc888_acer_aspire_4930_mixer[] =3D {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0,
+		HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0f, 1, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0f, 1, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Side Playback Volume", 0x0e, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Side Playback Switch", 0x0e, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	{ } /* end */
+};
+
 static struct snd_kcontrol_new alc888_acer_aspire_6530_mixer[] =3D {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
@@ -9247,7 +9269,7 @@ static struct alc_config_preset alc882_presets[] =3D=
 {
 		.init_hook =3D alc_automute_amp,
 	},
 	[ALC888_ACER_ASPIRE_4930G] =3D {
-		.mixers =3D { alc888_base_mixer,
+		.mixers =3D { alc888_acer_aspire_4930_mixer,
 				alc883_chmode_mixer },
 		.init_verbs =3D { alc883_init_verbs, alc880_gpio1_init_verbs,
 				alc888_acer_aspire_4930g_verbs },

--=-wAUrmajWXqOvaeNJ/KRz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-wAUrmajWXqOvaeNJ/KRz--
