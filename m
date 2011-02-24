From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: =?utf-8?q?=5BPATCH_1/6=5D_hdspmixer=3A_Improve_code_?=
	=?utf-8?q?coherency?=
Date: Thu, 24 Feb 2011 21:33:26 +0100
Message-ID: <1298579611-16573-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3494912822669240577=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, Fredrik Lingvall <fredrik.lingvall@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============3494912822669240577==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Move channelmappings into one place (channelmap.h). Also, use "aes32"
when referring to the card itself to avoid confusion and to be coherent
with the remaining naming scheme.

This work has mainly been done by Fredrik Lingvall.

Signed-off-by: Fredrik Lingvall <fredrik.lingvall@gmail.com>
Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerAboutText.cxx b/hdspmixer/src/HDSPMix=
erAboutText.cxx
index d628d00..40bd862 100644
--- a/hdspmixer/src/HDSPMixerAboutText.cxx
+++ b/hdspmixer/src/HDSPMixerAboutText.cxx
@@ -2,6 +2,9 @@
  *   HDSPMixer
  *   =20
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
+ *
+ *   Copyright (C) 2011 Adrian Knoth (adi@drcomp.erfurt.thur.de)
+ *                      Fredrik Lingvall (fredrik.lingvall@gmail.com)
  *   =20
  *   This program is free software; you can redistribute it and/or modif=
y
  *   it under the terms of the GNU General Public License as published b=
y
@@ -23,7 +26,10 @@
=20
 HDSPMixerAboutText::HDSPMixerAboutText(int x, int y, int w, int h):Fl_Wi=
dget(x, y, w, h, "About Text")
 {
-	text =3D "HDSPMixer " VERSION " (C) 2003 Thomas Charbonnel <thomas@@und=
ata.org>\n (C) 2009 Florian Faber <faber@@faberman.de>\n (C) 2011 Adrian =
Knoth <adi@@drcomp.erfurt.thur.de>\n\n"
+	text =3D "HDSPMixer " VERSION " (C) 2003 Thomas Charbonnel <thomas@@und=
ata.org>\n"
+		"(C) 2009 Florian Faber <faber@@faberman.de>\n"
+		"(C) 2011 Adrian Knoth <adi@@drcomp.erfurt.thur.de>\n"
+		"(C) 2011 Fredrik lingvall <fredrik.lingvall@@gmail.com>\n\n"
 	       "Bitmaps by Ralf Brunner\n"
 	       "Many thanks to Martin Bj=F6rnsen, Matthias Carstens and Paul Da=
vis\n\n"
 	       "This Program is free software; you can redistribute it and/or m=
odify\n"
diff --git a/hdspmixer/src/HDSPMixerCard.cxx b/hdspmixer/src/HDSPMixerCar=
d.cxx
index c0d38b8..eb51155 100644
--- a/hdspmixer/src/HDSPMixerCard.cxx
+++ b/hdspmixer/src/HDSPMixerCard.cxx
@@ -2,6 +2,9 @@
  *   HDSPMixer
  *   =20
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
+ *
+ *   Copyright (C) 2011 Adrian Knoth (adi@drcomp.erfurt.thur.de)
+ *                      Fredrik Lingvall (fredrik.lingvall@gmail.com)
  *   =20
  *   This program is free software; you can redistribute it and/or modif=
y
  *   it under the terms of the GNU General Public License as published b=
y
@@ -21,144 +24,6 @@
 #pragma implementation
 #include "HDSPMixerCard.h"
=20
-static char channel_map_df_ss[26] =3D {
-    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
-    18, 19, 20, 21, 22, 23, 24, 25
-};
-
-static char channel_map_mf_ss[26] =3D {
-    0, 1, 2, 3, 4, 5, 6, 7,
-    16, 17, 18, 19, 20, 21, 22, 23,=20
-    24, 25,
-    -1, -1, -1, -1, -1, -1, -1, -1
-};
-
-static char meter_map_ds[26] =3D {
-    0, 1, 2, 3, 8, 9, 10, 11, 16, 17, 18, 19,=20
-    24, 25,
-    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
-};
-
-static char channel_map_ds[26] =3D {
-    1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23,=20
-    24, 25,
-    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
-};
-
-static char dest_map_madi_ss[32] =3D {
-  0,  2,  4,  6,  8, 10, 12, 14,
- 16, 18, 20, 22, 24, 26, 28, 30,
- 32, 34, 36, 38, 40, 42, 44, 46,
- 48, 50, 52, 54, 56, 58, 60, 62
-};
-
-static char channel_map_aes[16] =3D {
-    0, 1, 2, 3, 4, 5, 6, 7,
-    9, 10, 11, 12, 13, 14, 15
-};
-
-
-static char dest_map_aes[8] =3D {
-  0,  2,  4,  6,  8, 10, 12, 14
-};
-
-
-static char dest_map_raydat_ss[18] =3D {
-   4,  6,  8, 10,=20
-  12, 14, 16, 18,=20
-  20, 22, 24, 26,=20
-  28, 30, 32, 34,
-   0,  2
-};
-
-static char dest_map_raydat_ds[10] =3D {
-   4,  6,=20
-   8, 10,=20
-  12, 14,=20
-  16, 18,
-   0,  2
-};
-
-static char dest_map_raydat_qs[6] =3D {
-   4, =20
-   6,
-   8,
-  10,
-   0,  2
-};
-
-
-
-static char dest_map_aio_ss[8] =3D {
-   0, // Analogue
-   8, // AES=20
-  10, // SPDIF
-  12, 14, 16, 18, // ADAT
-   6  // Phones=20
-};
-
-
-static char dest_map_aio_ds[6] =3D {
-   0, // Analogue=20
-   8, // AES
-  10, // SPDIF
-  12, 16, // ADAT
-   6  // Phones
-};
-
-static char dest_map_aio_qs[5] =3D {
-   0, // Analogue=20
-   8, // AES
-  10, // SPDIF
-  12, // ADAT
-   6  // Phone
-};
-
-
-static char dest_map_mf_ss[10] =3D {
-    0, 2, 4, 6, 16, 18, 20, 22, 24, 26=20
-};
-
-static char dest_map_ds[8] =3D {
-    0, 2, 8, 10, 16, 18, 24, 26=20
-};
-
-static char dest_map_df_ss[14] =3D {
-    0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26=20
-};
-
-static char dest_map_h9652_ss[13] =3D {
-    0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24=20
-};
-
-static char dest_map_h9652_ds[7] =3D {
-    0, 2, 8, 10, 16, 18, 24=20
-};
-
-static char dest_map_h9632_ss[8] =3D {
-    0, 2, 4, 6, 8, 10, 12, 14
-};
-
-static char dest_map_h9632_ds[6] =3D {
-    0, 2, 8, 10, 12, 14
-};
-
-static char dest_map_h9632_qs[4] =3D {
-    8, 10, 12, 14
-};
-
-static char channel_map_h9632_ss[16] =3D {
-    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
-};
-
-static char channel_map_h9632_ds[12] =3D {
-    0, 1, 2, 3, 8, 9, 10, 11, 12, 13, 14, 15
-};
-
-static char channel_map_h9632_qs[8] =3D {
-    8, 9, 10, 11, 12, 13, 14, 15
-};
-
 static void alsactl_cb(snd_async_handler_t *handler)
 {
     int err, clock_value;
@@ -426,19 +291,19 @@ void HDSPMixerCard::adjustSettings() {
       case 0: // SS
 	channels_input =3D channels_playback =3D 64;
 	channel_map_input =3D channel_map_playback =3D channel_map_unity_ss;
-	dest_map =3D dest_map_madi_ss;
+	dest_map =3D dest_map_unity;
 	meter_map_input =3D meter_map_playback =3D channel_map_unity_ss;
 	break;
       case 1: // DS
 	channels_input =3D channels_playback =3D 32;
 	channel_map_input =3D channel_map_playback =3D channel_map_unity_ss;
-	dest_map =3D dest_map_madi_ss;
+	dest_map =3D dest_map_unity;
 	meter_map_input =3D meter_map_playback =3D channel_map_unity_ss;
 	break;
       case 2: // QS
 	channels_input =3D channels_playback =3D 16;
 	channel_map_input =3D channel_map_playback =3D channel_map_unity_ss;
-	dest_map =3D dest_map_madi_ss;
+	dest_map =3D dest_map_unity;
 	meter_map_input =3D meter_map_playback =3D channel_map_unity_ss;
 	break;
       }
@@ -467,7 +332,7 @@ void HDSPMixerCard::adjustSettings() {
 	break;
       case 2: // QS
 	channels_input =3D 8;
-	channels_playback =3D10;
+	channels_playback =3D 10;
 	channel_map_input =3D channel_map_aio_in_qs;
 	channel_map_playback =3D channel_map_aio_out_qs;
 	dest_map =3D dest_map_aio_qs;
@@ -477,16 +342,16 @@ void HDSPMixerCard::adjustSettings() {
       }
=20
     } else if (HDSP_AES =3D=3D type) {
-      playbacks_offset =3D 64; /* FL not sure about this one? */
+      playbacks_offset =3D 64; /* not sure about this one? */
=20
       /* 16 channels for all modes */
       channels_input =3D 16;
       channels_playback =3D 16;
-      channel_map_input =3D channel_map_aes;
-      channel_map_playback =3D channel_map_aes;
-      dest_map =3D dest_map_aes;
-      meter_map_input =3D channel_map_aes;
-      meter_map_playback =3D channel_map_aes;
+      channel_map_input =3D channel_map_aes32;
+      channel_map_playback =3D channel_map_aes32;
+      dest_map =3D dest_map_aes32;
+      meter_map_input =3D channel_map_aes32;
+      meter_map_playback =3D channel_map_aes32;
=20
     } else if (HDSPeRayDAT =3D=3D type) {
       playbacks_offset =3D 64;
@@ -508,7 +373,7 @@ void HDSPMixerCard::adjustSettings() {
 	break;
       case 2: // QS
 	channels_input =3D 12;
-	channels_playback =3D12;
+	channels_playback =3D 12;
 	channel_map_input =3D channel_map_playback =3D channel_map_raydat_qs;
 	dest_map =3D dest_map_raydat_qs;
 	meter_map_input =3D meter_map_playback =3D channel_map_raydat_qs;
diff --git a/hdspmixer/src/HDSPMixerOutput.cxx b/hdspmixer/src/HDSPMixerO=
utput.cxx
index cd9122f..dd0c9f8 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -45,7 +45,7 @@ static char *labels_madi_qs[16] =3D {
 };
=20
=20
-static char *labels_aes[16] =3D {
+static char *labels_aes32[16] =3D {
   "AES 1", "AES 2", "AES 3", "AES 4", "AES 5", "AES 6", "AES 7", "AES 8"=
,
   "AES 9", "AES 10", "AES 11", "AES 12", "AES 13", "AES 14", "AES 15", "=
AES 16"
 };
@@ -232,7 +232,7 @@ void HDSPMixerOutput::setLabels()
 	    break;
 	}
     } else if (HDSP_AES =3D=3D type) {
-      labels_input =3D labels_playback =3D labels_aes;
+      labels_input =3D labels_playback =3D labels_aes32;
     } else if (HDSPeAIO =3D=3D type) {
       	switch (sm) {
 	case 0:
diff --git a/hdspmixer/src/HDSPMixerSelector.cxx b/hdspmixer/src/HDSPMixe=
rSelector.cxx
index bc18f60..a4156b0 100644
--- a/hdspmixer/src/HDSPMixerSelector.cxx
+++ b/hdspmixer/src/HDSPMixerSelector.cxx
@@ -3,6 +3,9 @@
  *   =20
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
  *   =20
+ *   Copyright (C) 2011 Adrian Knoth (adi@drcomp.erfurt.thur.de)
+ *                      Fredrik Lingvall (fredrik.lingvall@gmail.com)
+ *
  *   This program is free software; you can redistribute it and/or modif=
y
  *   it under the terms of the GNU General Public License as published b=
y
  *   the Free Software Foundation; either version 2 of the License, or
@@ -44,7 +47,7 @@ static char *destinations_madi_qs[8] =3D {
   "9+10", "11+12", "13+14", "15+16"
 };
=20
-static char *destinations_aes[8] =3D {
+static char *destinations_aes32[8] =3D {
   "AES 1+2", "AES 3+4", "AES 5+6", "AES 7+8",
   "AES 9+10", "AES 11+12", "AES 13+14", "AES 15+16",
 };
@@ -304,7 +307,7 @@ void HDSPMixerSelector::setLabels()
 	}
     } else if (HDSP_AES =3D=3D type) {
       max_dest =3D 8;
-      destinations =3D destinations_aes;
+      destinations =3D destinations_aes32;
     } else if (HDSPeAIO =3D=3D type) {
 	switch (sm) {
 	case 0:
diff --git a/hdspmixer/src/channelmap.h b/hdspmixer/src/channelmap.h
index de89140..8939b78 100644
--- a/hdspmixer/src/channelmap.h
+++ b/hdspmixer/src/channelmap.h
@@ -1,6 +1,132 @@
+/*
+ *   HDSPMixer
+ *
+ *   Copyright (C) 2011 Adrian Knoth (adi@drcomp.erfurt.thur.de)
+ *                      Fredrik Lingvall (fredrik.lingvall@gmail.com)
+ *
+ *   This program is free software; you can redistribute it and/or modif=
y
+ *   it under the terms of the GNU General Public License as published b=
y
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ */
+
+
 #ifndef channelmap_H
 #define channelmap_H
=20
+/***
+ *
+ * hdsp cards
+ *
+ ***/
+
+// Digiface
+
+static char dest_map_df_ss[14] =3D {
+	0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26
+};
+
+static char channel_map_df_ss[26] =3D {
+	0, 1, 2, 3, 4, 5, 6, 7,		/* ADAT 1 */
+	8, 9, 10, 11, 12, 13, 14, 15,	/* ADAT 2 */
+	16, 17, 18, 19, 20, 21, 22, 23, /* ADAT 3 */
+	24, 25				/* SPDIF */
+};
+
+// Multiface
+
+static char dest_map_mf_ss[10] =3D {
+	0, 2, 4, 6, 16, 18, 20, 22, 24, 26
+};
+
+static char channel_map_mf_ss[26] =3D {
+	0, 1, 2, 3, 4, 5, 6, 7,		/* Line in */
+	16, 17, 18, 19, 20, 21, 22, 23, /* ADAT */
+	24, 25,				/* SPDIF */
+	-1, -1, -1, -1, -1, -1, -1, -1
+};
+
+// Digiface/Multiface
+
+static char meter_map_ds[26] =3D {
+	0, 1, 2, 3, 8, 9, 10, 11, 16, 17, 18, 19,
+	24, 25,
+	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static char channel_map_ds[26] =3D {
+	1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23,
+	24, 25,
+	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static char dest_map_ds[8] =3D {
+	0, 2, 8, 10, 16, 18, 24, 26
+};
+
+// HDSP 9652
+
+static char dest_map_h9652_ss[13] =3D {
+	0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24
+};
+
+static char dest_map_h9652_ds[7] =3D {
+	0, 2, 8, 10, 16, 18, 24
+};
+
+// HDSP 9632
+
+static char dest_map_h9632_ss[8] =3D {
+	0, 2, 4, 6, 8, 10, 12, 14
+};
+
+static char dest_map_h9632_ds[6] =3D {
+	0, 2, 8, 10, 12, 14
+};
+
+static char dest_map_h9632_qs[4] =3D {
+	8, 10, 12, 14
+};
+
+static char channel_map_h9632_ss[16] =3D {
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
+};
+
+static char channel_map_h9632_ds[12] =3D {
+	0, 1, 2, 3, 8, 9, 10, 11, 12, 13, 14, 15
+};
+
+static char channel_map_h9632_qs[8] =3D {
+	8, 9, 10, 11, 12, 13, 14, 15
+};
+
+
+/***
+ *
+ * hdspm cards
+ *
+ ***/
+
+// HDSPe MADI and MADIface
+
+static char dest_map_unity[32] =3D {
+	0,  2,  4,  6,  8, 10, 12, 14,
+	16, 18, 20, 22, 24, 26, 28, 30,
+	32, 34, 36, 38, 40, 42, 44, 46,
+	48, 50, 52, 54, 56, 58, 60, 62
+};
+
 static char channel_map_unity_ss[HDSPM_MAX_CHANNELS] =3D {
 	0, 1, 2, 3, 4, 5, 6, 7,
 	8, 9, 10, 11, 12, 13, 14, 15,
@@ -34,6 +160,32 @@ static char channel_map_unity_qs[HDSPM_MAX_CHANNELS] =
=3D {
 	-1, -1, -1, -1, -1, -1, -1, -1,
 };
=20
+// HDSPe RayDAT
+
+static char dest_map_raydat_ss[18] =3D {
+	4,  6,  8, 10,
+	12, 14, 16, 18,
+	20, 22, 24, 26,
+	28, 30, 32, 34,
+	0,  2
+};
+
+static char dest_map_raydat_ds[10] =3D {
+	4,  6,
+	8, 10,
+	12, 14,
+	16, 18,
+	0,  2
+};
+
+static char dest_map_raydat_qs[6] =3D {
+	4,
+	6,
+	8,
+	10,
+	0,  2
+};
+
 static char channel_map_raydat_ss[HDSPM_MAX_CHANNELS] =3D {
 	4, 5, 6, 7, 8, 9, 10, 11,	/* ADAT 1 */
 	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT 2 */
@@ -78,10 +230,37 @@ static char channel_map_raydat_qs[HDSPM_MAX_CHANNELS=
] =3D {
 	-1, -1, -1, -1, -1, -1, -1, -1,
 };
=20
+// HDSPe AIO
+
+static char dest_map_aio_ss[8] =3D {
+   0, // Analogue
+   8, // AES
+  10, // SPDIF
+  12, 14, 16, 18, // ADAT
+   6  // Phones
+};
+
+
+static char dest_map_aio_ds[6] =3D {
+   0, // Analogue
+   8, // AES
+  10, // SPDIF
+  12, 16, // ADAT
+   6  // Phones
+};
+
+static char dest_map_aio_qs[5] =3D {
+   0, // Analogue
+   8, // AES
+  10, // SPDIF
+  12, // ADAT
+   6  // Phone
+};
+
 static char channel_map_aio_in_ss[HDSPM_MAX_CHANNELS] =3D {
 	0, 1,			/* line in */
-	8, 9,			/* aes in, */
-	10, 11,			/* spdif in */
+	8, 9,			/* AES in, */
+	10, 11,			/* SPDIF in */
 	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT in */
 	-1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -94,8 +273,8 @@ static char channel_map_aio_in_ss[HDSPM_MAX_CHANNELS] =
=3D {
=20
 static char channel_map_aio_out_ss[HDSPM_MAX_CHANNELS] =3D {
 	0, 1,			/* line out */
-	8, 9,			/* aes out */
-	10, 11,			/* spdif out */
+	8, 9,			/* AES out */
+	10, 11,			/* SPDIF out */
 	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT out */
 	6, 7,			/* phone out */
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -108,9 +287,9 @@ static char channel_map_aio_out_ss[HDSPM_MAX_CHANNELS=
] =3D {
=20
 static char channel_map_aio_in_ds[HDSPM_MAX_CHANNELS] =3D {
 	0, 1,			/* line in */
-	8, 9,			/* aes in */
-	10, 11,			/* spdif in */
-	12, 14, 16, 18,		/* adat in */
+	8, 9,			/* AES in */
+	10, 11,			/* SPDIF in */
+	12, 14, 16, 18,		/* ADAT in */
 	-1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -122,9 +301,9 @@ static char channel_map_aio_in_ds[HDSPM_MAX_CHANNELS]=
 =3D {
=20
 static char channel_map_aio_out_ds[HDSPM_MAX_CHANNELS] =3D {
 	0, 1,			/* line out */
-	8, 9,			/* aes out */
-	10, 11,			/* spdif out */
-	12, 14, 16, 18,		/* adat out */
+	8, 9,			/* AES out */
+	10, 11,			/* SPDIF out */
+	12, 14, 16, 18,		/* ADAT out */
 	6, 7,			/* phone out */
 	-1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -137,9 +316,9 @@ static char channel_map_aio_out_ds[HDSPM_MAX_CHANNELS=
] =3D {
=20
 static char channel_map_aio_in_qs[HDSPM_MAX_CHANNELS] =3D {
 	0, 1,			/* line in */
-	8, 9,			/* aes in */
-	10, 11,			/* spdif in */
-	12, 16,			/* adat in */
+	8, 9,			/* AES in */
+	10, 11,			/* SPDIF in */
+	12, 16,			/* ADAT in */
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -151,9 +330,9 @@ static char channel_map_aio_in_qs[HDSPM_MAX_CHANNELS]=
 =3D {
=20
 static char channel_map_aio_out_qs[HDSPM_MAX_CHANNELS] =3D {
 	0, 1,			/* line out */
-	8, 9,			/* aes out */
-	10, 11,			/* spdif out */
-	12, 16,			/* adat out */
+	8, 9,			/* AES out */
+	10, 11,			/* SPDIF out */
+	12, 16,			/* ADAT out */
 	6, 7,			/* phone out */
 	-1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -164,4 +343,27 @@ static char channel_map_aio_out_qs[HDSPM_MAX_CHANNEL=
S] =3D {
 	-1, -1, -1, -1, -1, -1, -1, -1
 };
=20
+// HDSP AES32 and HDSPe AES
+
+static char dest_map_aes32[8] =3D {
+  0,  2,  4,  6,  8, 10, 12, 14
+};
+
+static char channel_map_aes32[HDSPM_MAX_CHANNELS] =3D {
+	0, 1,			/* AES 1 */
+	2, 3,			/* AES 2 */
+	4, 5,			/* AES 3 */
+	6, 7,			/* AES 4 */
+	8, 9,			/* AES 5 */
+	10, 11,			/* AES 6 */
+	12, 13,			/* AES 7 */
+	14, 15,			/* AES 8 */
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1
+};
+
 #endif /* channelmap_H */
diff --git a/hdspmixer/src/defines.h b/hdspmixer/src/defines.h
index 7fcb4d3..2065620 100644
--- a/hdspmixer/src/defines.h
+++ b/hdspmixer/src/defines.h
@@ -27,7 +27,7 @@
 #define HDSPeMADI 10
 #define HDSPeRayDAT 11
 #define HDSPeAIO 12
-#define HDSP_AES 13 /* both AES32 and HDSPeAES? */
+#define HDSP_AES 13 /* both HDSP AES32 and HDSPe AES */
=20
 #define HDSP_MAX_CHANNELS 64
 #define HDSP_MAX_DEST	  32
diff --git a/hdspmixer/src/hdspmixer.cxx b/hdspmixer/src/hdspmixer.cxx
index a020b93..d57fe4c 100644
--- a/hdspmixer/src/hdspmixer.cxx
+++ b/hdspmixer/src/hdspmixer.cxx
@@ -3,6 +3,9 @@
  *   =20
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
  *   =20
+ *   Copyright (C) 2011 Adrian Knoth (adi@drcomp.erfurt.thur.de)
+ *                      Fredrik Lingvall (fredrik.lingvall@gmail.com)
+ *
  *   This program is free software; you can redistribute it and/or modif=
y
  *   it under the terms of the GNU General Public License as published b=
y
  *   the Free Software Foundation; either version 2 of the License, or
diff --git a/hdspmixer/src/mappings.h b/hdspmixer/src/mappings.h
deleted file mode 100644
index 9589a22..0000000
--- a/hdspmixer/src/mappings.h
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- *   HDSPMixer
- *   =20
- *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
- *   =20
- *   This program is free software; you can redistribute it and/or modif=
y
- *   it under the terms of the GNU General Public License as published b=
y
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef mappings_H
-#define mappings_H
-
-static char channel_map_df_ss[26] =3D {
-    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
-    18, 19, 20, 21, 22, 23, 24, 25
-};
-
-static char channel_map_mf_ss[26] =3D {
-    0, 1, 2, 3, 4, 5, 6, 7,
-    16, 17, 18, 19, 20, 21, 22, 23,=20
-    24, 25,
-    -1, -1, -1, -1, -1, -1, -1, -1
-};
-
-static char meter_map_ds[26] =3D {
-    0, 1, 2, 3, 8, 9, 10, 11, 16, 17, 18, 19,=20
-    24, 25,
-    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
-};
-
-static char channel_map_ds[26] =3D {
-    1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23,=20
-    24, 25,
-    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
-};
-
-static char dest_map_mf_ss[10] =3D {
-    0, 2, 4, 6, 16, 18, 20, 22, 24, 26=20
-};
-
-static char dest_map_ds[8] =3D {
-    0, 2, 8, 10, 16, 18, 24, 26=20
-};
-
-static char dest_map_df_ss[14] =3D {
-    0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26=20
-};
-
-static char dest_map_h9652_ss[13] =3D {
-    0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24=20
-};
-
-static char dest_map_h9652_ds[7] =3D {
-    0, 2, 8, 10, 16, 18, 24=20
-};
-
-static char dest_map_h9632_ss[8] =3D {
-    0, 2, 4, 6, 8, 10, 12, 14
-};
-
-static char dest_map_h9632_ds[6] =3D {
-    0, 2, 8, 10, 12, 14
-};
-
-static char dest_map_h9632_qs[4] =3D {
-    8, 10, 12, 14
-};
-
-static char channel_map_h9632_ss[16] =3D {
-    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
-};
-
-static char channel_map_h9632_ds[12] =3D {
-    0, 1, 2, 3, 8, 9, 10, 11, 12, 13, 14, 15
-};
-
-static char channel_map_h9632_qs[8] =3D {
-    8, 9, 10, 11, 12, 13, 14, 15
-};
-
-#endif
-
--=20
1.7.2.3


--===============3494912822669240577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3494912822669240577==--
