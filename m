From: =?UTF-8?Q?=C5=81ukasz_Wojni=C5=82owicz?= <lukasz.wojnilowicz@gmail.com>
Subject: ALSA: hda - add possibility to choose speakers
 configuration for 4930g
Date: Fri, 20 Nov 2009 19:39:08 +0100
Message-ID: <1258742348.2308.6.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-7E74M4PtbhpH8e7Un+Na"
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


--=-7E74M4PtbhpH8e7Un+Na
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

As in wrote title patch adds possibility to choose speakers
configuration for 4930g. This feature was available in ALSA 1.0.19 (or
even 1.0.20) but disappeared in 1.0.21

--=-7E74M4PtbhpH8e7Un+Na
Content-Disposition: attachment; filename="add const_channel_count.patch"
Content-Type: text/x-patch; name="add const_channel_count.patch"; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: =C5=81ukasz Wojni=C5=82owicz <lukasz.wojnilowicz@gmail.com>
Subject: ALSA: hda - add possibility to choose speakers configuration for=
 4930g

Now one can choose speaker configuration in e.g. PulseAudio mixer

Signed-off-by: =C5=81ukasz Wojni=C5=82owicz <lukasz.wojnilowicz@gmail.com=
>
---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
index eee3143..a009000 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9260,6 +9260,7 @@ static struct alc_config_preset alc882_presets[] =3D=
 {
 		.num_channel_mode =3D ARRAY_SIZE(alc883_3ST_6ch_modes),
 		.channel_mode =3D alc883_3ST_6ch_modes,
 		.need_dac_fix =3D 1,
+		.const_channel_count =3D 6,
 		.num_mux_defs =3D
 			ARRAY_SIZE(alc888_2_capture_sources),
 		.input_mux =3D alc888_2_capture_sources,

--=-7E74M4PtbhpH8e7Un+Na
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-7E74M4PtbhpH8e7Un+Na--
