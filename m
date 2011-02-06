From: =?UTF-8?Q?=C5=81ukasz_Wojni=C5=82owicz?= <lukasz.wojnilowicz@gmail.com>
Subject: ALSA: hda - 4930g switch lfe with side in mixer
Date: Sun, 06 Feb 2011 13:15:40 +0100
Message-ID: <1296994540.2720.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-bQvwsv6xraRfUqJYCSX/"
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


--=-bQvwsv6xraRfUqJYCSX/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,
I'm sending patch that switches lfe with side in mixer for Acer Aspire
5930g.
Currently I use Alsa 1.0.24 and if I want to change the volume of
built-in subwoofer I have to adjust left channel of side in mixer, which
isn't correct. I'm sending patch which corrects this behavior.

BTW.
If someone would like to investigate more then acer-aspire-4930g is
ALC888S-VC.

Cheers

--=-bQvwsv6xraRfUqJYCSX/
Content-Disposition: attachment; filename="patch_realtek.patch"
Content-Type: text/x-patch; name="patch_realtek.patch"; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: =C5=81ukasz Wojni=C5=82owicz <lukasz.wojnilowicz@gmail.com>
Subject: ALSA: hda - switch lfe with side in mixer for 4930g

Built-in sub-woofer can now be controlled by lfe slider instead of side s=
lider on Acer Aspire 5930g

Signed-off-by: =C5=81ukasz Wojni=C5=82owicz <lukasz.wojnilowicz@gmail.com=
>

--- patch_realtek.c	2011-01-27 13:09:20.000000000 +0100
+++ patch_realtek.c	2011-02-06 12:59:42.892991050 +0100
@@ -2290,6 +2290,29 @@
 	{ } /* end */
 };
=20
+static struct snd_kcontrol_new alc888_acer_aspire_4930g_mixer[] =3D {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0f, 2, 0x0,
+		HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0f, 2, 2, HDA_INPUT),
+    HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0f, 1, 0x0, HDA_OUTPU=
T),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0f, 1, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Side Playback Volume", 0x0e, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Side Playback Switch", 0x0e, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	{ } /* end */
+};
+
+
 static struct snd_kcontrol_new alc889_acer_aspire_8930g_mixer[] =3D {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
@@ -10359,7 +10382,7 @@
 		.init_hook =3D alc_automute_amp,
 	},
 	[ALC888_ACER_ASPIRE_4930G] =3D {
-		.mixers =3D { alc888_base_mixer,
+		.mixers =3D { alc888_acer_aspire_4930g_mixer,
 				alc883_chmode_mixer },
 		.init_verbs =3D { alc883_init_verbs, alc880_gpio1_init_verbs,
 				alc888_acer_aspire_4930g_verbs },

--=-bQvwsv6xraRfUqJYCSX/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-bQvwsv6xraRfUqJYCSX/--
