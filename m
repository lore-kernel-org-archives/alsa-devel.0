From: =?UTF-8?Q?=C5=81ukasz_Wojni=C5=82owicz?= <lukasz.wojnilowicz@gmail.com>
Subject: ALSA: hda - 4930g add internal lfe slider
Date: Wed, 23 Feb 2011 18:50:20 +0100
Message-ID: <1298483420.2456.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xh+zD/dD9g2bzHiYW/Jd"
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


--=-xh+zD/dD9g2bzHiYW/Jd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
Lately I sent patch that switched lfe with side in mixer for
acer-aspire-4930g. Then I connected 5.1 speaker system and noticed that
lfe slider wasn't working and that old lfe slider worked. What I'm doing
now is:

- reverting old patch
- adding internal lfe slider
- removing side as it is superfluous (ALC888S-VC is 7.1 but in fact
laptop can only do 5.1 and it is so in drivers for MS Windows)

Cheers,
=C5=81ukasz


--=-xh+zD/dD9g2bzHiYW/Jd
Content-Disposition: attachment; filename="patch_realtek.patch"
Content-Type: text/x-patch; name="patch_realtek.patch"; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: =C5=81ukasz Wojni=C5=82owicz <lukasz.wojnilowicz@gmail.com>
Subject: ALSA: hda - 4930g add internal lfe slider

Signed-off-by: =C5=81ukasz Wojni=C5=82owicz <lukasz.wojnilowicz@gmail.com=
>

--- patch_realtek.c	2011-02-22 08:21:56.000000000 +0100
+++ patch_realtek.c	2011-02-23 18:19:19.203076469 +0100
@@ -2295,13 +2295,13 @@
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0f, 2, 0x0,
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0,
 		HDA_OUTPUT),
-	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0f, 2, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0f, 1, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0f, 1, 2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Side Playback Volume", 0x0e, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Side Playback Switch", 0x0e, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Internal LFE Playback Volume", 0x0f, 1, 0x0, HDA=
_OUTPUT),
+	HDA_BIND_MUTE_MONO("Internal LFE Playback Switch", 0x0f, 1, 2, HDA_INPU=
T),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
@@ -2312,7 +2312,6 @@
 	{ } /* end */
 };
=20
-
 static struct snd_kcontrol_new alc889_acer_aspire_8930g_mixer[] =3D {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),

--=-xh+zD/dD9g2bzHiYW/Jd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-xh+zD/dD9g2bzHiYW/Jd--
