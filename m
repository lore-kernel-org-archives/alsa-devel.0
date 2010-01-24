From: =?UTF-8?Q?=C5=81ukasz_Wojni=C5=82owicz?= <lukasz.wojnilowicz@gmail.com>
Subject: ALSA: hda - add possibility to choose speakers
 configuration for 4930g
Date: Sun, 24 Jan 2010 14:12:37 +0100
Message-ID: <1264338757.2456.7.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-dLr2uZwxl02nRoLmtlml"
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


--=-dLr2uZwxl02nRoLmtlml
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I've got such possibility on MS Windows XP with Realtek drivers (prove
is at http://img694.imageshack.us/i/choosechannelmod.png/ ) so I should
have possibility to do it also on Linux e.g. here
http://img704.imageshack.us/i/screenshotsoundpreferen.png/

Patch given in attachment should do the thing. patch_realtek.c was
downloaded from http://git.alsa-project.org/?p=alsa-kernel.git on Thu,
21 Jan 2010 13:58:25 +0000

--=-dLr2uZwxl02nRoLmtlml
Content-Disposition: attachment; filename="patch_realtek.patch"
Content-Type: text/x-patch; name="patch_realtek.patch"; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: =C5=81ukasz Wojni=C5=82owicz <lukasz.wojnilowicz@gmail.com>
Subject: ALSA: hda - add possibility to choose speakers configuration for=
 4930g

Now one can choose speaker configuration in e.g. PulseAudio mixer

Signed-off-by: =C5=81ukasz Wojni=C5=82owicz <lukasz.wojnilowicz@gmail.com=
>
---

--- patch_realtekc.c	2010-01-24 13:59:54.682214000 +0100
+++ patch_realtek.c	2010-01-24 14:00:50.044202925 +0100
@@ -9580,6 +9580,7 @@
 		.num_channel_mode =3D ARRAY_SIZE(alc883_3ST_6ch_modes),
 		.channel_mode =3D alc883_3ST_6ch_modes,
 		.need_dac_fix =3D 1,
+		.const_channel_count =3D 6,
 		.num_mux_defs =3D
 			ARRAY_SIZE(alc888_2_capture_sources),
 		.input_mux =3D alc888_2_capture_sources,

--=-dLr2uZwxl02nRoLmtlml
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-dLr2uZwxl02nRoLmtlml--
