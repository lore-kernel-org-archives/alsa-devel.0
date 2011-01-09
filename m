From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: =?utf-8?q?=5BPATCH_-_RME_MADI/RayDAT/AIO_support_1/1?=
	=?utf-8?q?=5D_Add_support_for_RME_MADI=2C_RayDAT_and_AIO?=
Date: Sun,  9 Jan 2011 19:42:59 +0100
Message-ID: <1294598579-6392-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3816867493195009512=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id B3E9924425
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2011 21:21:39 +0100 (CET)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id 45A911AC63E
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2011 21:21:37 +0100 (CET)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pRSAQdpNp+ig for <alsa-devel@alsa-project.org>;
	Sun,  9 Jan 2011 21:21:19 +0100 (CET)
Resent-Message-ID: <20110109202119.GS2250@ltw.loris.tv>
Resent-To: alsa-devel@alsa-project.org
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============3816867493195009512==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged the work by Florian Faber that's distributed separately as
hdspmixer64.

Code taken from http://wiki.linuxproaudio.org/index.php/App:hdspmixer_64

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerAboutText.cxx b/hdspmixer/src/HDSPMix=
erAboutText.cxx
index e0168ed..d628d00 100644
--- a/hdspmixer/src/HDSPMixerAboutText.cxx
+++ b/hdspmixer/src/HDSPMixerAboutText.cxx
@@ -23,7 +23,7 @@
=20
 HDSPMixerAboutText::HDSPMixerAboutText(int x, int y, int w, int h):Fl_Wi=
dget(x, y, w, h, "About Text")
 {
-	text =3D "HDSPMixer " VERSION " (C) 2003 Thomas Charbonnel <thomas@@und=
ata.org>\n\n"
+	text =3D "HDSPMixer " VERSION " (C) 2003 Thomas Charbonnel <thomas@@und=
ata.org>\n (C) 2009 Florian Faber <faber@@faberman.de>\n (C) 2011 Adrian =
Knoth <adi@@drcomp.erfurt.thur.de>\n\n"
 	       "Bitmaps by Ralf Brunner\n"
 	       "Many thanks to Martin Bj=F6rnsen, Matthias Carstens and Paul Da=
vis\n\n"
 	       "This Program is free software; you can redistribute it and/or m=
odify\n"
diff --git a/hdspmixer/src/HDSPMixerCard.cxx b/hdspmixer/src/HDSPMixerCar=
d.cxx
index 38548f1..5f923ac 100644
--- a/hdspmixer/src/HDSPMixerCard.cxx
+++ b/hdspmixer/src/HDSPMixerCard.cxx
@@ -45,6 +45,66 @@ static char channel_map_ds[26] =3D {
     -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
 };
=20
+static char dest_map_madi_ss[32] =3D {
+  0,  2,  4,  6,  8, 10, 12, 14,
+ 16, 18, 20, 22, 24, 26, 28, 30,
+ 32, 34, 36, 38, 40, 42, 44, 46,
+ 48, 50, 52, 54, 56, 58, 60, 62
+};
+
+
+static char dest_map_raydat_ss[18] =3D {
+   4,  6,  8, 10,=20
+  12, 14, 16, 18,=20
+  20, 22, 24, 26,=20
+  28, 30, 32, 34,
+   0,  2
+};
+
+static char dest_map_raydat_ds[10] =3D {
+   4,  6,=20
+   8, 10,=20
+  12, 14,=20
+  16, 18,
+   0,  2
+};
+
+static char dest_map_raydat_qs[6] =3D {
+   4, =20
+   6,
+   8,
+  10,
+   0,  2
+};
+
+
+
+static char dest_map_aio_ss[8] =3D {
+   0, // Analogue
+   8, // AES=20
+  10, // SPDIF
+  12, 14, 16, 18, // ADAT
+   6  // Phones=20
+};
+
+
+static char dest_map_aio_ds[6] =3D {
+   0, // Analogue=20
+   8, // AES
+  10, // SPDIF
+  12, 16, // ADAT
+   6  // Phones
+};
+
+static char dest_map_aio_qs[5] =3D {
+   0, // Analogue=20
+   8, // AES
+  10, // SPDIF
+  12, // ADAT
+   6  // Phone
+};
+
+
 static char dest_map_mf_ss[10] =3D {
     0, 2, 4, 6, 16, 18, 20, 22, 24, 26=20
 };
@@ -181,8 +241,10 @@ int HDSPMixerCard::getSpeed()
     snd_ctl_elem_value_t *elemval;
     snd_ctl_elem_id_t * elemid;
     snd_ctl_t *handle;
+   =20
     snd_ctl_elem_value_alloca(&elemval);
     snd_ctl_elem_id_alloca(&elemid);
+
     if ((err =3D snd_ctl_open(&handle, name, SND_CTL_NONBLOCK)) < 0) {
 	fprintf(stderr, "Error accessing ctl interface on card %s\n.", name);
 	return -1;=20
@@ -198,6 +260,7 @@ int HDSPMixerCard::getSpeed()
     }
     val =3D snd_ctl_elem_value_get_enumerated(elemval, 0);
     snd_ctl_close(handle);
+
     switch (val) {
     case 0:
 	/* Autosync mode : We need to determine sample rate */
@@ -225,7 +288,7 @@ int HDSPMixerCard::getSpeed()
     return 0;   =20
 }
=20
-HDSPMixerCard::HDSPMixerCard(HDSP_IO_Type cardtype, int id)
+HDSPMixerCard::HDSPMixerCard(int cardtype, int id)
 {
     type =3D cardtype;
     card_id =3D id;
@@ -238,6 +301,7 @@ HDSPMixerCard::HDSPMixerCard(HDSP_IO_Type cardtype, i=
nt id)
     } else {
 	playbacks_offset =3D 26;
     }
+
     speed_mode =3D getSpeed();
     if (speed_mode < 0) {
 	fprintf(stderr, "Error trying to determine speed mode for card %s, exit=
ing.\n", name);
@@ -271,18 +335,18 @@ void HDSPMixerCard::adjustSettings() {
     if (type =3D=3D Multiface) {
 	switch (speed_mode) {
 	case 0:
-	    channels =3D 18;
-	    channel_map =3D channel_map_mf_ss;
+	    channels_input =3D 18;
+	    channels_playback =3D 20;
+	    channel_map_input =3D channel_map_playback =3D channel_map_mf_ss;
 	    dest_map =3D dest_map_mf_ss;
-	    meter_map =3D channel_map_mf_ss;
-	    lineouts =3D 2;
+	    meter_map_input =3D meter_map_playback =3D channel_map_mf_ss;
 	    break;
 	case 1:
-	    channels =3D 14;
-	    channel_map =3D meter_map_ds;
+	    channels_input =3D 14;
+	    channels_playback =3D 16;
+	    channel_map_input =3D channel_map_playback =3D meter_map_ds;
 	    dest_map =3D dest_map_ds;
-	    meter_map =3D meter_map_ds;
-	    lineouts =3D 2;
+	    meter_map_input =3D meter_map_playback =3D meter_map_ds;
 	    break;
 	case 2:
 	    /* should never happen */
@@ -291,18 +355,16 @@ void HDSPMixerCard::adjustSettings() {
     } else if (type =3D=3D Digiface) {
 	switch (speed_mode) {
 	case 0:
-	    channels =3D 26;
-	    channel_map =3D channel_map_df_ss;
+	    channels_input =3D channels_playback =3D 26;
+	    channel_map_input =3D channel_map_playback =3D channel_map_df_ss;
 	    dest_map =3D dest_map_df_ss;
-	    meter_map =3D channel_map_df_ss;
-	    lineouts =3D 2;
+	    meter_map_input =3D meter_map_playback =3D channel_map_df_ss;
 	    break;
 	case 1:
-	    channels =3D 14;
-	    channel_map =3D meter_map_ds;
+	    channels_input =3D channels_playback =3D 14;
+	    channel_map_input =3D channel_map_playback =3D meter_map_ds;
 	    dest_map =3D dest_map_ds;
-	    meter_map =3D meter_map_ds;
-	    lineouts =3D 2;
+	    meter_map_input =3D meter_map_playback =3D meter_map_ds;
 	    break;
 	case 2:
 	    /* should never happen */
@@ -311,18 +373,16 @@ void HDSPMixerCard::adjustSettings() {
     } else if (type =3D=3D H9652) {
 	switch (speed_mode) {
 	case 0:
-	    channels =3D 26;
-	    channel_map =3D channel_map_df_ss;
+	    channels_input =3D channels_playback =3D 26;
+	    channel_map_input =3D channel_map_playback =3D channel_map_df_ss;
 	    dest_map =3D dest_map_h9652_ss;
-	    meter_map =3D channel_map_df_ss;
-	    lineouts =3D 0;
+	    meter_map_input =3D meter_map_playback =3D channel_map_df_ss;
 	    break;
 	case 1:
-	    channels =3D 14;
-	    channel_map =3D channel_map_ds;
+	    channels_input =3D channels_playback =3D 14;
+	    channel_map_input =3D channel_map_playback =3D channel_map_ds;
 	    dest_map =3D dest_map_h9652_ds;
-	    meter_map =3D meter_map_ds;
-	    lineouts =3D 0;
+	    meter_map_input =3D meter_map_playback =3D meter_map_ds;
 	    break;
 	case 2:
 	    /* should never happen */
@@ -331,29 +391,111 @@ void HDSPMixerCard::adjustSettings() {
     } else if (type =3D=3D H9632) {
 	switch (speed_mode) {
 	case 0:
-	    channels =3D 12 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
-	    channel_map =3D channel_map_h9632_ss;
+	    channels_input =3D channels_playback =3D 12 + ((h9632_aeb.aebi || h=
9632_aeb.aebo) ? 4 : 0);
+	    channel_map_input =3D channel_map_playback =3D channel_map_h9632_ss=
;
 	    dest_map =3D dest_map_h9632_ss;
-	    meter_map =3D channel_map_h9632_ss;
-	    lineouts =3D 0;
+	    meter_map_input =3D meter_map_playback =3D channel_map_h9632_ss;
 	    break;
 	case 1:
-	    channels =3D 8 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
-	    channel_map =3D channel_map_h9632_ds;
+	    channels_input =3D channels_playback =3D 8 + ((h9632_aeb.aebi || h9=
632_aeb.aebo) ? 4 : 0);
+	    channel_map_input =3D channel_map_playback =3D channel_map_h9632_ds=
;
 	    dest_map =3D dest_map_h9632_ds;
-	    meter_map =3D channel_map_h9632_ds;
-	    lineouts =3D 0;
+	    meter_map_input =3D meter_map_playback =3D channel_map_h9632_ds;
 	    break;
 	case 2:
-	    channels =3D 4 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
-	    channel_map =3D channel_map_h9632_qs;
+	    channels_input =3D channels_playback =3D 4 + ((h9632_aeb.aebi || h9=
632_aeb.aebo) ? 4 : 0);
+	    channel_map_input =3D channel_map_playback =3D channel_map_h9632_qs=
;
 	    dest_map =3D dest_map_h9632_qs;
-	    meter_map =3D channel_map_h9632_qs;
-	    lineouts =3D 0;
+	    meter_map_input =3D meter_map_playback =3D channel_map_h9632_qs;
 	    break;
 	}
+    } else if (HDSPeMADI =3D=3D type) {
+      playbacks_offset =3D 64;
+
+      switch (speed_mode) {
+      case 0: // SS
+	channels_input =3D channels_playback =3D 64;
+	channel_map_input =3D channel_map_playback =3D channel_map_unity_ss;
+	dest_map =3D dest_map_madi_ss;
+	meter_map_input =3D meter_map_playback =3D channel_map_unity_ss;
+	break;
+      case 1: // DS
+	channels_input =3D channels_playback =3D 32;
+	channel_map_input =3D channel_map_playback =3D channel_map_unity_ss;
+	dest_map =3D dest_map_madi_ss;
+	meter_map_input =3D meter_map_playback =3D channel_map_unity_ss;
+	break;
+      case 2: // QS
+	channels_input =3D channels_playback =3D 16;
+	channel_map_input =3D channel_map_playback =3D channel_map_unity_ss;
+	dest_map =3D dest_map_madi_ss;
+	meter_map_input =3D meter_map_playback =3D channel_map_unity_ss;
+	break;
+      }
+
+    } else if (HDSPeAIO =3D=3D type) {
+      playbacks_offset =3D 64;
+
+      switch (speed_mode) {
+      case 0: // SS
+	channels_input =3D 14;
+	channels_playback =3D 16;
+	channel_map_input =3D channel_map_aio_in_ss;
+	channel_map_playback =3D channel_map_aio_out_ss;
+	dest_map =3D dest_map_aio_ss;
+	meter_map_input =3D channel_map_aio_in_ss;
+	meter_map_playback =3D channel_map_aio_out_ss;
+	break;
+      case 1: // DS
+	channels_input =3D 10;
+	channels_playback =3D 12;
+	channel_map_input =3D channel_map_aio_in_ds;
+	channel_map_playback =3D channel_map_aio_out_ds;
+	dest_map =3D dest_map_aio_ds;
+	meter_map_input =3D channel_map_aio_in_ds;
+	meter_map_playback =3D channel_map_aio_out_ds;
+	break;
+      case 2: // QS
+	channels_input =3D 8;
+	channels_playback =3D10;
+	channel_map_input =3D channel_map_aio_in_qs;
+	channel_map_playback =3D channel_map_aio_out_qs;
+	dest_map =3D dest_map_aio_qs;
+	meter_map_input =3D channel_map_aio_in_qs;
+	meter_map_playback =3D channel_map_aio_out_qs;
+	break;
+      }
+
+    } else if (HDSPeRayDAT =3D=3D type) {
+      playbacks_offset =3D 64;
+
+      switch (speed_mode) {
+      case 0: // SS
+	channels_input =3D 36;
+	channels_playback =3D 36;
+	channel_map_input =3D channel_map_playback =3D channel_map_raydat_ss;
+	dest_map =3D dest_map_raydat_ss;
+	meter_map_input =3D meter_map_playback =3D channel_map_raydat_ss;
+	break;
+      case 1: // DS
+	channels_input =3D 20;
+	channels_playback =3D 20;
+	channel_map_input =3D channel_map_playback =3D channel_map_raydat_ds;
+	dest_map =3D dest_map_raydat_ds;
+	meter_map_input =3D meter_map_playback =3D channel_map_raydat_ds;
+	break;
+      case 2: // QS
+	channels_input =3D 12;
+	channels_playback =3D12;
+	channel_map_input =3D channel_map_playback =3D channel_map_raydat_qs;
+	dest_map =3D dest_map_raydat_qs;
+	meter_map_input =3D meter_map_playback =3D channel_map_raydat_qs;
+	break;
+      }
+
     }
-    window_width =3D (channels+2)*STRIP_WIDTH;
+
+    window_width =3D (channels_playback+2)*STRIP_WIDTH;
     window_height =3D FULLSTRIP_HEIGHT*2+SMALLSTRIP_HEIGHT+MENU_HEIGHT;
 }=20
=20
@@ -363,28 +505,28 @@ void HDSPMixerCard::setMode(int mode)
     adjustSettings();
     actualizeStrips();
=20
-    for (int i =3D 0; i < channels; ++i) {
-	basew->inputs->strips[i]->targets->setLabels();
-	basew->playbacks->strips[i]->targets->setLabels();
-	basew->outputs->strips[i]->setLabels();
+    for (int i =3D 0; i < channels_input; ++i) {
+      basew->inputs->strips[i]->targets->setLabels();
     }
-    for (int i =3D channels; i < channels+lineouts; ++i) {
-	basew->outputs->strips[i]->setLabels();   =20
+    for (int i =3D 0; i < channels_playback; ++i) {
+      basew->playbacks->strips[i]->targets->setLabels();
+      basew->outputs->strips[i]->setLabels();   =20
     }
+
     if (h9632_aeb.aebo && !h9632_aeb.aebi) {
-	basew->inputs->empty_aebi[0]->position(STRIP_WIDTH*(channels-4), basew-=
>inputs->empty_aebi[0]->y());
-	basew->inputs->empty_aebi[1]->position(STRIP_WIDTH*(channels-2), basew-=
>inputs->empty_aebi[1]->y());
+	basew->inputs->empty_aebi[0]->position(STRIP_WIDTH*(channels_input-4), =
basew->inputs->empty_aebi[0]->y());
+	basew->inputs->empty_aebi[1]->position(STRIP_WIDTH*(channels_input-2), =
basew->inputs->empty_aebi[1]->y());
     } else if (h9632_aeb.aebi && !h9632_aeb.aebo) {
-	basew->playbacks->empty_aebo[0]->position(STRIP_WIDTH*(channels-4), bas=
ew->playbacks->empty_aebo[0]->y());
-	basew->playbacks->empty_aebo[1]->position(STRIP_WIDTH*(channels-2), bas=
ew->playbacks->empty_aebo[1]->y());
-	basew->outputs->empty_aebo[0]->position(STRIP_WIDTH*(channels-4), basew=
->outputs->empty_aebo[0]->y());
-	basew->outputs->empty_aebo[1]->position(STRIP_WIDTH*(channels-2), basew=
->outputs->empty_aebo[1]->y());
+	basew->playbacks->empty_aebo[0]->position(STRIP_WIDTH*(channels_playbac=
k-4), basew->playbacks->empty_aebo[0]->y());
+	basew->playbacks->empty_aebo[1]->position(STRIP_WIDTH*(channels_playbac=
k-2), basew->playbacks->empty_aebo[1]->y());
+	basew->outputs->empty_aebo[0]->position(STRIP_WIDTH*(channels_playback-=
4), basew->outputs->empty_aebo[0]->y());
+	basew->outputs->empty_aebo[1]->position(STRIP_WIDTH*(channels_playback-=
2), basew->outputs->empty_aebo[1]->y());
     }
-    basew->inputs->buttons->position(STRIP_WIDTH*channels, basew->inputs=
->buttons->y());
+    basew->inputs->buttons->position(STRIP_WIDTH*channels_input, basew->=
inputs->buttons->y());
     basew->inputs->init_sizes();
-    basew->playbacks->empty->position(STRIP_WIDTH*channels, basew->playb=
acks->empty->y());
+    basew->playbacks->empty->position(STRIP_WIDTH*channels_playback, bas=
ew->playbacks->empty->y());
     basew->playbacks->init_sizes();
-    basew->outputs->empty->position(STRIP_WIDTH*(channels+lineouts), bas=
ew->outputs->empty->y());   =20
+    basew->outputs->empty->position(STRIP_WIDTH*(channels_playback), bas=
ew->outputs->empty->y());   =20
     basew->outputs->init_sizes();
     basew->inputs->size(window_width, basew->inputs->h());
     basew->playbacks->size(window_width, basew->playbacks->h());
@@ -401,20 +543,16 @@ void HDSPMixerCard::setMode(int mode)
 void HDSPMixerCard::actualizeStrips()
 {
     for (int i =3D 0; i < HDSP_MAX_CHANNELS; ++i) {
-	if (i < channels) {
+	if (i < channels_input) {
 	    basew->inputs->strips[i]->show();
-	    basew->playbacks->strips[i]->show();
-	    basew->outputs->strips[i]->show();
 	} else {
 	    basew->inputs->strips[i]->hide();
-	    basew->playbacks->strips[i]->hide();
-	    basew->outputs->strips[i]->hide();
 	}
-    }
-    for (int i =3D channels; i < channels+2; ++i) {
-	if (i < channels+lineouts) {
+	if (i < channels_playback) {
+	    basew->playbacks->strips[i]->show();
 	    basew->outputs->strips[i]->show();
 	} else {
+	    basew->playbacks->strips[i]->hide();
 	    basew->outputs->strips[i]->hide();
 	}
     }
@@ -424,7 +562,7 @@ void HDSPMixerCard::actualizeStrips()
 	    basew->playbacks->empty_aebo[i]->show();
 	    basew->outputs->empty_aebo[i]->show();
 	}
-	for (int i =3D channels-4; i < channels; ++i) {
+	for (int i =3D channels_playback-4; i < channels_playback; ++i) {
 	    basew->playbacks->strips[i]->hide();
 	    basew->outputs->strips[i]->hide();
 	}
@@ -434,7 +572,7 @@ void HDSPMixerCard::actualizeStrips()
 	    basew->playbacks->empty_aebo[i]->hide();
 	    basew->outputs->empty_aebo[i]->hide();
 	}       =20
-	for (int i =3D channels-4; i < channels; ++i) {
+	for (int i =3D channels_input-4; i < channels_input; ++i) {
 	    basew->inputs->strips[i]->hide();
 	}
     } else {
diff --git a/hdspmixer/src/HDSPMixerCard.h b/hdspmixer/src/HDSPMixerCard.=
h
index a8ce108..9303d21 100644
--- a/hdspmixer/src/HDSPMixerCard.h
+++ b/hdspmixer/src/HDSPMixerCard.h
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <alsa/asoundlib.h>
 #include <alsa/sound/hdsp.h>
+#include <alsa/sound/hdspm.h>
 #include "defines.h"
 #include "HDSPMixerWindow.h"
=20
@@ -36,15 +37,16 @@ class HDSPMixerCard
 private:
     snd_ctl_t *cb_handle;
     snd_async_handler_t *cb_handler;
+
 public:
     HDSPMixerWindow *basew;
     char name[6];
-    HDSPMixerCard(HDSP_IO_Type cardtype, int id);
-    int channels, lineouts, window_width, window_height, card_id;
-    HDSP_IO_Type type;
-    char *channel_map;
+    HDSPMixerCard(int cardtype, int id);
+    int channels_input, channels_playback, window_width, window_height, =
card_id;
+    int type;
+    char *channel_map_input, *channel_map_playback;
     char *dest_map;
-    char *meter_map;
+    char *meter_map_input, *meter_map_playback;
     int speed_mode;
     int playbacks_offset;
     void setMode(int mode);
diff --git a/hdspmixer/src/HDSPMixerFader.cxx b/hdspmixer/src/HDSPMixerFa=
der.cxx
index 0441c51..a7f5015 100644
--- a/hdspmixer/src/HDSPMixerFader.cxx
+++ b/hdspmixer/src/HDSPMixerFader.cxx
@@ -31,7 +31,7 @@ HDSPMixerFader::HDSPMixerFader(int x, int y, double r, =
int id, int src):Fl_Widge
     ref =3D r;
     basew =3D (HDSPMixerWindow *)window();
     anchor =3D lastpos =3D lasty =3D drag =3D shift_orig =3D y_orig =3D =
0;
-    for (int i =3D 0; i < 14; i++) {
+    for (int i =3D 0; i < HDSP_MAX_DEST; i++) {
 	pos[i] =3D 0;
     }
 }
diff --git a/hdspmixer/src/HDSPMixerFader.h b/hdspmixer/src/HDSPMixerFade=
r.h
index 3090dfa..9a99d14 100644
--- a/hdspmixer/src/HDSPMixerFader.h
+++ b/hdspmixer/src/HDSPMixerFader.h
@@ -49,7 +49,7 @@ public:
     int posToInt(int p);
     int non_submix_dest;
     int dest;
-    int pos[14];
+    int pos[HDSP_MAX_DEST];
     HDSPMixerWindow *basew;
     HDSPMixerFader *relative;
     HDSPMixerGain *gain;
diff --git a/hdspmixer/src/HDSPMixerInputs.h b/hdspmixer/src/HDSPMixerInp=
uts.h
index 361b1da..a6c1740 100644
--- a/hdspmixer/src/HDSPMixerInputs.h
+++ b/hdspmixer/src/HDSPMixerInputs.h
@@ -35,7 +35,7 @@ class HDSPMixerInputs:public Fl_Group
 {
 public:
     HDSPMixerButtons *buttons;
-    HDSPMixerIOMixer *strips[26];
+    HDSPMixerIOMixer *strips[HDSP_MAX_CHANNELS];
     HDSPMixerInputs(int x, int y, int w, int h, int nchannels);
     HDSPMixerEmpty *empty_aebi[2];
 };
diff --git a/hdspmixer/src/HDSPMixerMaster.cxx b/hdspmixer/src/HDSPMixerM=
aster.cxx
index 9018856..77c4a28 100644
--- a/hdspmixer/src/HDSPMixerMaster.cxx
+++ b/hdspmixer/src/HDSPMixerMaster.cxx
@@ -61,8 +61,10 @@ int HDSPMixerMaster::handle(int e)
 		} else {
 		    mute =3D 1;
 		}
-		for (int i =3D 0; i < basew->cards[basew->current_card]->channels; i++=
) {
+		for (int i =3D 0; i < basew->cards[basew->current_card]->channels_inpu=
t; i++) {
 		    basew->inputs->strips[i]->mutesolo->redraw();
+		}
+		for (int i =3D 0; i < basew->cards[basew->current_card]->channels_play=
back; i++) {
 		    basew->playbacks->strips[i]->mutesolo->redraw();
 		}
 		basew->refreshMixer();
@@ -76,8 +78,10 @@ int HDSPMixerMaster::handle(int e)
 		} else {
 		    solo =3D 1;
 		}
-		for (int i =3D 0; i < basew->cards[basew->current_card]->channels; i++=
) {
+		for (int i =3D 0; i < basew->cards[basew->current_card]->channels_inpu=
t; i++) {
 		    basew->inputs->strips[i]->mutesolo->redraw();
+		}
+		for (int i =3D 0; i < basew->cards[basew->current_card]->channels_play=
back; i++) {
 		    basew->playbacks->strips[i]->mutesolo->redraw();
 		}
 		basew->refreshMixer();
diff --git a/hdspmixer/src/HDSPMixerMuteSolo.cxx b/hdspmixer/src/HDSPMixe=
rMuteSolo.cxx
index 3e738ca..3dcd1e6 100644
--- a/hdspmixer/src/HDSPMixerMuteSolo.cxx
+++ b/hdspmixer/src/HDSPMixerMuteSolo.cxx
@@ -129,8 +129,11 @@ int HDSPMixerMuteSolo::handle(int e)
=20
 void HDSPMixerMuteSolo::redraw_all()
 {
-    for (int i =3D 0; i < (basew->cards[basew->current_card]->channels);=
 ++i) {
+    for (int i =3D 0; i < (basew->cards[basew->current_card]->channels_i=
nput); ++i) {
 	basew->inputs->strips[i]->mutesolo->redraw();
+    }
+
+    for (int i =3D 0; i < (basew->cards[basew->current_card]->channels_p=
layback); ++i) {
 	basew->playbacks->strips[i]->mutesolo->redraw();=09
     }
 }
diff --git a/hdspmixer/src/HDSPMixerOutput.cxx b/hdspmixer/src/HDSPMixerO=
utput.cxx
index 0f70eca..9dc5457 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -21,6 +21,106 @@
 #pragma implementation
 #include "HDSPMixerOutput.h"
=20
+static char *labels_madi_ss[64] =3D {
+   "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",
+   "9", "10", "11", "12", "13", "14", "15", "16",=20
+  "17", "18", "19", "20", "21", "22", "23", "24",=20
+  "25", "26", "27", "28", "29", "30", "31", "32",=20
+  "33", "34", "35", "36", "37", "38", "39", "40",=20
+  "41", "42", "43", "44", "45", "46", "47", "48",=20
+  "49", "50", "51", "52", "53", "54", "55", "56",=20
+  "57", "58", "59", "60", "61", "62", "63", "64"
+};
+
+static char *labels_madi_ds[64] =3D {
+   "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",
+   "9", "10", "11", "12", "13", "14", "15", "16",=20
+  "17", "18", "19", "20", "21", "22", "23", "24",=20
+  "25", "26", "27", "28", "29", "30", "31", "32",=20
+};
+
+static char *labels_madi_qs[16] =3D {
+   "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",
+   "9", "10", "11", "12", "13", "14", "15", "16",=20
+};
+
+
+static char *labels_raydat_ss[36] =3D {
+  "A1.1", "A1.2", "A1.3", "A1.4", "A1.5", "A1.6", "A1.7", "A1.8",
+  "A2.1", "A2.2", "A2.3", "A2.4", "A2.5", "A2.6", "A2.7", "A2.8",
+  "A3.1", "A3.2", "A3.3", "A3.4", "A3.5", "A3.6", "A3.7", "A3.8",
+  "A4.1", "A4.2", "A4.3", "A4.4", "A4.5", "A4.6", "A4.7", "A4.8",
+  "AES.L", "AES.R",
+  "SP.L", "SP.R"
+};
+
+static char *labels_raydat_ds[20] =3D {
+  "A1.1", "A1.2", "A1.3", "A1.4",
+  "A2.1", "A2.2", "A2.3", "A2.4",
+  "A3.1", "A3.2", "A3.3", "A3.4",
+  "A4.1", "A4.2", "A4.3", "A4.4",
+  "AES.L", "AES.R",
+  "SP.L", "SP.R"
+};
+
+static char *labels_raydat_qs[12] =3D {
+  "A1.1", "A1.2",
+  "A2.1", "A2.2",
+  "A3.1", "A3.2",
+  "A4.1", "A4.2",
+  "AES.L", "AES.R",
+  "SP.L", "SP.R"
+};
+
+
+static char *labels_aio_ss_input[14] =3D {
+  "AN 1",  "AN 2",
+  "SP.L", "SP.R",
+  "AES.L",  "AES.R",
+  "A 1", "A 2", "A 3", "A 4",
+  "A 5", "A 6", "A 7", "A 8"
+};
+
+static char *labels_aio_ss_playback[16] =3D {
+  "AN 1",  "AN 2",
+  "SP.L", "SP.R",
+  "AES.L",  "AES.R",
+  "A 1", "A 2", "A 3", "A 4",
+  "A 5", "A 6", "A 7", "A 8",
+  "PH.L", "PH.R"
+};
+
+static char *labels_aio_ds_input[10] =3D {
+  "AN 1",  "AN 2", =20
+  "SP.L", "SP.R",
+  "AES.L",  "AES.R",
+  "A 1", "A 2", "A 3", "A 4"
+};
+
+static char *labels_aio_ds_playback[12] =3D {
+  "AN 1",  "AN 2", =20
+  "SP.L", "SP.R",
+  "AES.L",  "AES.R",
+  "A 1", "A 2", "A 3", "A 4",
+  "PH.L", "PH.R"
+ };
+
+static char *labels_aio_qs_input[8] =3D {
+  "AN 1",  "AN 2",
+  "SP.L", "SP.R",
+  "AES.L",  "AES.R",
+  "A 1", "A 2"
+};
+
+static char *labels_aio_qs_playback[10] =3D {
+  "AN 1",  "AN 2",
+  "SP.L", "SP.R",
+  "AES.L",  "AES.R",
+  "A 1", "A 2",
+  "PH.L", "PH.R",
+};
+
+
 static char *labels_mf_ss[20] =3D {
     "AN 1", "AN 2", "AN 3", "AN 4", "AN 5", "AN 6", "AN 7", "AN 8",
     "A 1", "A 2", "A 3", "A 4", "A 5", "A 6", "A 7", "A 8",
@@ -33,6 +133,7 @@ static char *labels_mf_ds[16] =3D {
     "SP.L", "SP.R", "AN.L", "AN.R"
 };
=20
+
 static char *labels_df_ss[28] =3D {
     "A1 1", "A1 2", "A1 3", "A1 4", "A1 5", "A1 6", "A1 7", "A1 8",
     "A2 1", "A2 2", "A2 3", "A2 4", "A2 5", "A2 6", "A2 7", "A2 8",
@@ -88,30 +189,72 @@ HDSPMixerOutput::HDSPMixerOutput(int x, int y, int w=
, int h, int num):Fl_Group(x
=20
 void HDSPMixerOutput::setLabels()
 {
-    HDSP_IO_Type type =3D basew->cards[basew->current_card]->type;
+    int type =3D basew->cards[basew->current_card]->type;
     int sm =3D basew->cards[basew->current_card]->speed_mode;
+
     if (type =3D=3D H9632) {
 	switch (sm) {
 	case 0:
-	    labels =3D labels_9632_ss;
+	    labels_input =3D labels_playback =3D labels_9632_ss;
 	    break;
 	case 1:
-	    labels =3D labels_9632_ds;
+	    labels_input =3D labels_playback =3D labels_9632_ds;
 	    break;=09
 	case 2:
-	    labels =3D labels_9632_qs;
+	    labels_input =3D labels_playback =3D labels_9632_qs;
 	    break;
 	}
     } else if (type =3D=3D Multiface) {
 	if (sm)
-	    labels =3D labels_mf_ds;
+	    labels_input =3D labels_playback =3D labels_mf_ds;
 	else=20
-	    labels =3D labels_mf_ss;
-    } else {
+	    labels_input =3D labels_playback =3D labels_mf_ss;
+	} else if (type =3D=3D Digiface) {
 	if (sm)
-	    labels =3D labels_df_ds;
+	    labels_input =3D labels_playback =3D labels_df_ds;
 	else
-	    labels =3D labels_df_ss;
+	    labels_input =3D labels_playback =3D labels_df_ss;
+    } else if (HDSPeMADI =3D=3D type) {
+      switch (sm) {
+	case 0:
+	    labels_input =3D labels_playback =3D labels_madi_ss;
+	    break;
+	case 1:
+	    labels_input =3D labels_playback =3D labels_madi_ds;
+	    break;=09
+	case 2:
+	    labels_input =3D labels_playback =3D labels_madi_qs;
+	    break;
+	}
+    } else if (HDSPeAIO =3D=3D type) {
+      	switch (sm) {
+	case 0:
+	    labels_input =3D labels_aio_ss_input;
+	    labels_playback =3D labels_aio_ss_playback;
+	    break;
+	case 1:
+	    labels_input =3D labels_aio_ds_input;
+	    labels_playback =3D labels_aio_ds_playback;
+	    break;=09
+	case 2:
+	    labels_input =3D labels_aio_qs_input;
+	    labels_playback =3D labels_aio_ds_playback;
+	    break;
+	}
+    } else if (HDSPeRayDAT =3D=3D type) {
+      switch (sm) {
+      case 0:
+	labels_input =3D labels_playback =3D labels_raydat_ss;
+	break;
+      case 1:
+	labels_input =3D labels_playback =3D labels_raydat_ds;
+	break;=09
+      case 2:
+	labels_input =3D labels_playback =3D labels_raydat_qs;
+	break;
+      }
+    } else {
+      fprintf(stderr, "Unknown card type for output labels\n");
     }
 }
=20
@@ -134,7 +277,7 @@ void HDSPMixerOutput::draw()
 	draw_background();
 	fl_color(FL_BLACK);
 	fl_font(FL_HELVETICA, 8);
-	fl_draw(labels[out_num], x()+4, y()+193, 27, 9, FL_ALIGN_CENTER);
+	fl_draw(labels_playback[out_num], x()+4, y()+193, 27, 9, FL_ALIGN_CENTE=
R);
 	for (int i=3Dchildren(); i--;) {
 	    Fl_Widget& o =3D **a++;
 	    draw_child(o);
diff --git a/hdspmixer/src/HDSPMixerOutput.h b/hdspmixer/src/HDSPMixerOut=
put.h
index 88c3583..2e7fb09 100644
--- a/hdspmixer/src/HDSPMixerOutput.h
+++ b/hdspmixer/src/HDSPMixerOutput.h
@@ -46,7 +46,7 @@ class HDSPMixerOutput:public Fl_Group
 {
 private:
     int out_num;
-    char **labels;
+    char **labels_input, **labels_playback;
     char **p_output_xpm;
     HDSPMixerPeak *peak;
     HDSPMixerWindow *basew;   =20
diff --git a/hdspmixer/src/HDSPMixerOutputs.h b/hdspmixer/src/HDSPMixerOu=
tputs.h
index d073a2f..e7527d0 100644
--- a/hdspmixer/src/HDSPMixerOutputs.h
+++ b/hdspmixer/src/HDSPMixerOutputs.h
@@ -35,7 +35,7 @@ class HDSPMixerOutputs:public Fl_Group
 public:
     HDSPMixerEmpty *empty_aebo[2];
     HDSPMixerEmpty *empty;
-    HDSPMixerOutput *strips[28];
+    HDSPMixerOutput *strips[HDSP_MAX_CHANNELS+2];
     HDSPMixerOutputs(int x, int y, int w, int h, int nchannels);
 };
=20
diff --git a/hdspmixer/src/HDSPMixerPan.cxx b/hdspmixer/src/HDSPMixerPan.=
cxx
index 5396614..c9feea4 100644
--- a/hdspmixer/src/HDSPMixerPan.cxx
+++ b/hdspmixer/src/HDSPMixerPan.cxx
@@ -27,7 +27,7 @@ HDSPMixerPan::HDSPMixerPan(int x, int y, int id, int sr=
c):Fl_Widget(x, y, 30, 13
     index =3D id;
     basew =3D (HDSPMixerWindow *)window();
     dest =3D  x_orig =3D shift_orig =3D lastpos =3D lastx =3D drag =3D 0=
;
-    for (int i =3D 0; i < 14; i++) {
+    for (int i =3D 0; i < HDSP_MAX_DEST; i++) {
 	pos[i] =3D 0;
     }
 }
diff --git a/hdspmixer/src/HDSPMixerPan.h b/hdspmixer/src/HDSPMixerPan.h
index 9a95acb..94f8ef2 100644
--- a/hdspmixer/src/HDSPMixerPan.h
+++ b/hdspmixer/src/HDSPMixerPan.h
@@ -28,6 +28,7 @@
 #include "HDSPMixerIOMixer.h"
 #include "HDSPMixerWindow.h"
 #include "pixmaps.h"
+#include "defines.h"
=20
 class HDSPMixerIOMixer;
 class HDSPMixerWindow;
@@ -39,7 +40,7 @@ private:
     void sendText();
     void panToText(char *s);
 public:
-    int pos[14];
+    int pos[HDSP_MAX_DEST];
     int dest;
     int index;
     int source;
diff --git a/hdspmixer/src/HDSPMixerPlaybacks.h b/hdspmixer/src/HDSPMixer=
Playbacks.h
index af776d0..1ef7768 100644
--- a/hdspmixer/src/HDSPMixerPlaybacks.h
+++ b/hdspmixer/src/HDSPMixerPlaybacks.h
@@ -34,7 +34,7 @@ class HDSPMixerPlaybacks:public Fl_Group
 public:
     HDSPMixerEmpty *empty_aebo[2];
     HDSPMixerEmpty *empty;
-    HDSPMixerIOMixer *strips[26];
+    HDSPMixerIOMixer *strips[HDSP_MAX_CHANNELS];
     HDSPMixerPlaybacks(int x, int y, int w, int h, int nchannels);
 };
=20
diff --git a/hdspmixer/src/HDSPMixerPresets.cxx b/hdspmixer/src/HDSPMixer=
Presets.cxx
index a403179..aeeb9c9 100644
--- a/hdspmixer/src/HDSPMixerPresets.cxx
+++ b/hdspmixer/src/HDSPMixerPresets.cxx
@@ -193,18 +193,21 @@ void HDSPMixerPresets::restore_preset(int prst) {
     basew->outputs->strips[HDSP_MAX_CHANNELS]->fader->pos[0] =3D basew->=
outputs->strips[HDSP_MAX_CHANNELS+1]->data[card][speed][p]->fader_pos;
     basew->outputs->strips[HDSP_MAX_CHANNELS+1]->fader->pos[0] =3D basew=
->outputs->strips[HDSP_MAX_CHANNELS+1]->data[card][speed][p]->fader_pos;
=20
-    for (int i =3D 0; i < basew->cards[card]->channels; ++i) {
+    for (int i =3D 0; i < basew->cards[card]->channels_input; ++i) {
 	basew->inputs->strips[i]->fader->sendGain();
 	basew->inputs->strips[i]->redraw();
+    }
+
+    for (int i =3D 0; i < basew->cards[card]->channels_playback; ++i) {
 	basew->playbacks->strips[i]->fader->sendGain();
 	basew->playbacks->strips[i]->redraw();
 	basew->outputs->strips[i]->fader->sendGain();
 	basew->outputs->strips[i]->redraw();
     }
-    basew->outputs->strips[basew->cards[card]->channels]->fader->sendGai=
n();
-    basew->outputs->strips[basew->cards[card]->channels]->redraw();
-    basew->outputs->strips[basew->cards[card]->channels+1]->fader->sendG=
ain();
-    basew->outputs->strips[basew->cards[card]->channels+1]->redraw();
+    basew->outputs->strips[basew->cards[card]->channels_playback]->fader=
->sendGain();
+    basew->outputs->strips[basew->cards[card]->channels_playback]->redra=
w();
+    basew->outputs->strips[basew->cards[card]->channels_playback+1]->fad=
er->sendGain();
+    basew->outputs->strips[basew->cards[card]->channels_playback+1]->red=
raw();
=20
     /* Global settings */
     basew->inputs->buttons->view->input =3D basew->data[card][speed][p]-=
>input;
diff --git a/hdspmixer/src/HDSPMixerSelector.cxx b/hdspmixer/src/HDSPMixe=
rSelector.cxx
index bf11db0..8ac0ad3 100644
--- a/hdspmixer/src/HDSPMixerSelector.cxx
+++ b/hdspmixer/src/HDSPMixerSelector.cxx
@@ -21,6 +21,83 @@
 #pragma implementation
 #include "HDSPMixerSelector.h"
=20
+static char *destinations_madi_ss[32] =3D {
+  "1+2", "3+4", "5+6", "7+8",
+  "9+10", "11+12", "13+14", "15+16",
+  "17+18", "19+20", "21+22", "23+24",
+  "25+26", "27+28", "29+30", "31+32",
+  "33+34", "35+36", "37+38", "39+40",
+  "41+42", "43+44", "45+46", "47+48",
+  "49+50", "51+52", "53+54", "55+56",
+  "57+58", "59+60", "61+62", "63+64"
+};
+
+static char *destinations_madi_ds[16] =3D {
+  "1+2", "3+4", "5+6", "7+8",
+  "9+10", "11+12", "13+14", "15+16",
+  "17+18", "19+20", "21+22", "23+24",
+  "25+26", "27+28", "29+30", "31+32",
+};
+
+static char *destinations_madi_qs[8] =3D {
+  "1+2", "3+4", "5+6", "7+8",
+  "9+10", "11+12", "13+14", "15+16",
+};
+
+
+static char *destinations_raydat_ss[18] =3D {
+
+  "A1 1+2", "A1 3+4", "A1 5+6", "A1 7+8",
+  "A2 1+2", "A2 3+4", "A2 5+6", "A2 7+8",
+  "A3 1+2", "A3 3+4", "A3 5+6", "A3 7+8",
+  "A4 1+2", "A4 3+4", "A4 5+6", "A4 7+8",
+  "AES",
+  "SPDIF"
+};
+
+static char *destinations_raydat_ds[10] =3D {
+  "A1 1+2", "A1 3+4",
+  "A2 1+2", "A2 3+4",
+  "A3 1+2", "A3 3+4",
+  "A4 1+2", "A4 3+4",
+  "AES",
+  "SPDIF"
+};
+
+static char *destinations_raydat_qs[6] =3D {
+  "A1 1+2",
+  "A2 1+2",
+  "A3 1+2",
+  "A4 1+2",
+  "AES",
+  "SPDIF"
+};
+
+
+static char *destinations_aio_ss[8] =3D {
+  "AN 1+2",
+  "AES",
+  "SPDIF",=20
+  "A 1+2", "A 3+4", "A 5+6", "A 7+8",
+  "Phones",
+};
+
+static char *destinations_aio_ds[6] =3D {
+  "AN 1+2",=20
+  "AES",
+  "SPDIF",=20
+  "A 1+2", "A 3+4"
+  "Phones",
+};
+
+static char *destinations_aio_qs[5] =3D {
+  "AN 1+2",
+  "AES",
+  "SPDIF",=20
+  "A 1+2"
+  "Phones",
+};
+
     static char *destinations_mf_ss[10] =3D {
 	"AN 1+2", "AN 3+4", "AN 5+6", "AN 7+8",
 	"A 1+2", "A 3+4", "A 5+6", "A 7+8",
@@ -135,7 +212,7 @@ int HDSPMixerSelector::handle(int e) {
=20
 void HDSPMixerSelector::setLabels()
 {
-    HDSP_IO_Type type;
+    int type;
     hdsp_9632_aeb_t *aeb;
     int sm;
     clear();
@@ -199,7 +276,54 @@ void HDSPMixerSelector::setLabels()
 	    destinations =3D destinations_h9632_qs;
 	    break;
 	}
+    } else if (HDSPeMADI =3D=3D type) {
+	switch (sm) {
+	case 0:
+	  max_dest =3D 32;
+	  destinations =3D destinations_madi_ss;
+	  break;
+	case 1:
+	  max_dest =3D 16;
+	  destinations =3D destinations_madi_ds;
+	  break;
+	case 2:
+	  max_dest =3D 8;
+	  destinations =3D destinations_madi_qs;
+	  break;
+	}
+    } else if (HDSPeAIO =3D=3D type) {
+	switch (sm) {
+	case 0:
+	  max_dest =3D 8;
+	  destinations =3D destinations_aio_ss;
+	  break;
+	case 1:
+	  max_dest =3D 6;
+	  destinations =3D destinations_aio_ds;
+	  break;
+	case 2:
+	  max_dest =3D 5;
+	  destinations =3D destinations_aio_qs;
+	  break;
+	}
+    } else if (HDSPeRayDAT =3D=3D type) {
+	switch (sm) {
+	case 0:
+	  max_dest =3D 18;
+	  destinations =3D destinations_raydat_ss;
+	  break;
+	case 1:
+	  max_dest =3D 10;
+	  destinations =3D destinations_raydat_ds;
+	  break;
+	case 2:
+	  max_dest =3D 6;
+	  destinations =3D destinations_raydat_qs;
+	  break;
+	}
+    =20
     }
+
    =20
     for (int i =3D 0; i < max_dest; ++i) {
 	add(destinations[i], 0, 0, 0, FL_MENU_TOGGLE);
diff --git a/hdspmixer/src/HDSPMixerStripData.h b/hdspmixer/src/HDSPMixer=
StripData.h
index 3d6cdb8..c74114c 100644
--- a/hdspmixer/src/HDSPMixerStripData.h
+++ b/hdspmixer/src/HDSPMixerStripData.h
@@ -22,14 +22,16 @@
 #ifndef HDSPMixerStripData_H
 #define HDSPMixerStripData_H
=20
+#include "defines.h"
+
=20
 class HDSPMixerStripData
 {
 public:
     int mute;
     int solo;
-    int pan_pos[14];
-    int fader_pos[14];
+    int pan_pos[HDSP_MAX_DEST];
+    int fader_pos[HDSP_MAX_DEST];
     int dest;
     HDSPMixerStripData();
 };
diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerW=
indow.cxx
index fb90130..e7d4e85 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -16,6 +16,10 @@
  *   You should have received a copy of the GNU General Public License
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * @version 04-12-2009 [FF]
+ *          - updated deprecated fl_ask calls
+ *=20
  */
=20
 #pragma implementation
@@ -25,7 +29,8 @@ static void readregisters_cb(void *arg)
 {
     int err;
     snd_hwdep_t *hw;
-    hdsp_peak_rms_t peak_rms;
+    hdsp_peak_rms_t hdsp_peak_rms;
+    struct hdspm_peak_rms hdspm_peak_rms;
    =20
     HDSPMixerWindow *w =3D (HDSPMixerWindow *)arg;
=20
@@ -39,49 +44,52 @@ static void readregisters_cb(void *arg)
 	return;
     }
=20
-    if ((err =3D snd_hwdep_ioctl(hw, SNDRV_HDSP_IOCTL_GET_PEAK_RMS, (voi=
d *)&peak_rms)) < 0) {
+    if ((HDSPeMADI =3D=3D w->cards[w->current_card]->type) ||
+	(HDSPeAIO =3D=3D w->cards[w->current_card]->type) ||
+	(HDSPeRayDAT =3D=3D w->cards[w->current_card]->type)) {
+      if ((err =3D snd_hwdep_ioctl(hw, SNDRV_HDSPM_IOCTL_GET_PEAK_RMS, (=
void *)&hdspm_peak_rms)) < 0) {
+	fprintf(stderr, "HwDep ioctl failed. Metering stopped\n");
+	snd_hwdep_close(hw);
+	return;
+      }     =20
+    } else {
+      if ((err =3D snd_hwdep_ioctl(hw, SNDRV_HDSP_IOCTL_GET_PEAK_RMS, (v=
oid *)&hdsp_peak_rms)) < 0) {
 	fprintf(stderr, "HwDep ioctl failed. Metering stopped\n");
 	snd_hwdep_close(hw);
 	return;
+      }
     }
-
     snd_hwdep_close(hw);
-   =20
+
+    // check for speed change
+    if (hdspm_peak_rms.speed !=3D w->cards[w->current_card]->speed_mode)=
 {
+      w->cards[w->current_card]->setMode(hdspm_peak_rms.speed);
+    }
+
     if (w->inputs->buttons->input) {
-	for (int i =3D 0; i < w->cards[w->current_card]->channels; ++i) {
-	    w->inputs->strips[i]->meter->update(peak_rms.input_peaks[(w->cards[=
w->current_card]->meter_map[i])] & 0xffffff00,
-						peak_rms.input_peaks[(w->cards[w->current_card]->meter_map[i])] & =
0xf,
-						peak_rms.input_rms[(w->cards[w->current_card]->meter_map[i])]);
-	}
+      for (int i =3D 0; i < w->cards[w->current_card]->channels_input; +=
+i) {
+	w->inputs->strips[i]->meter->update(hdspm_peak_rms.input_peaks[(w->card=
s[w->current_card]->meter_map_input[i])] & 0xffffff00,
+					    hdspm_peak_rms.input_peaks[(w->cards[w->current_card]->meter_ma=
p_input[i])] & 0xf,
+					    hdspm_peak_rms.input_rms[(w->cards[w->current_card]->meter_map_=
input[i])]);
+      }
     }
+    =20
     if (w->inputs->buttons->playback) {
-	for (int i =3D 0; i < w->cards[w->current_card]->channels; ++i) {
-	    w->playbacks->strips[i]->meter->update(peak_rms.playback_peaks[(w->=
cards[w->current_card]->meter_map[i])] & 0xffffff00,
-						   peak_rms.playback_peaks[(w->cards[w->current_card]->meter_map[i=
])] & 0xf,
-						   peak_rms.playback_rms[(w->cards[w->current_card]->meter_map[i])=
]);
-	}
+      for (int i =3D 0; i < w->cards[w->current_card]->channels_playback=
; ++i) {
+	w->playbacks->strips[i]->meter->update(hdspm_peak_rms.playback_peaks[(w=
->cards[w->current_card]->meter_map_playback[i])] & 0xffffff00,
+					       hdspm_peak_rms.playback_peaks[(w->cards[w->current_card]->me=
ter_map_playback[i])] & 0xf,
+					       hdspm_peak_rms.playback_rms[(w->cards[w->current_card]->mete=
r_map_playback[i])]);
+      }
     }
+
     if (w->inputs->buttons->output) {
-	if (w->cards[w->current_card]->type !=3D H9652) {
-	    for (int i =3D 0; i < w->cards[w->current_card]->channels; ++i) {
-		w->outputs->strips[i]->meter->update(peak_rms.output_peaks[(w->cards[w=
->current_card]->meter_map[i])] & 0xffffff00,
-						     peak_rms.output_peaks[(w->cards[w->current_card]->meter_map[i=
])] & 0xf,
-						     0 );
-	    }
-	    for (int i =3D 0; i < w->cards[w->current_card]->lineouts; ++i) {
-		w->outputs->strips[w->cards[w->current_card]->channels+i]->meter->upda=
te(peak_rms.output_peaks[26+i] & 0xffffff00,
-										         peak_rms.output_peaks[26+i] & 0xf,
-										         0 );
-	    }=20
-	} else {
-	    for (int i =3D 0; i < w->cards[w->current_card]->channels; ++i) {
-		w->outputs->strips[i]->meter->update(peak_rms.output_peaks[(w->cards[w=
->current_card]->meter_map[i])] & 0xffffff00,
-						     peak_rms.output_peaks[(w->cards[w->current_card]->meter_map[i=
])] & 0xf,
-						     peak_rms.output_rms[(w->cards[w->current_card]->meter_map[i])=
] );
-	    }
-	}
+      for (int i =3D 0; i < w->cards[w->current_card]->channels_playback=
; ++i) {
+	w->outputs->strips[i]->meter->update(hdspm_peak_rms.output_peaks[(w->ca=
rds[w->current_card]->meter_map_playback[i])] & 0xffffff00,
+					     hdspm_peak_rms.output_peaks[(w->cards[w->current_card]->meter_=
map_playback[i])] & 0xf,
+					     hdspm_peak_rms.output_rms[(w->cards[w->current_card]->meter_ma=
p_playback[i])]);
+      }
     }
-   =20
+
     Fl::add_timeout(0.03, readregisters_cb, w);
 }
=20
@@ -90,7 +98,7 @@ static void exit_cb(Fl_Widget *widget, void *arg)
 {
     HDSPMixerWindow *w =3D (HDSPMixerWindow *)arg;
     if (w->dirty) {
-	if (!fl_ask("There are unsaved changes, quit anyway ?")) return;
+      if (!fl_choice("There are unsaved changes, quit anyway ?", "Return=
", "Quit", NULL)) return;
     }
     exit(EXIT_SUCCESS);
 }
@@ -202,7 +210,7 @@ static void restore_defaults_cb(Fl_Widget *widget, vo=
id *arg)
     HDSPMixerWindow *w =3D (HDSPMixerWindow *)arg;
     int i =3D 0;
     if (w->dirty) {
-	if (!fl_ask("There are unsaved changes, restore factory settings anyway=
 ?")) return;
+      if (!fl_choice("There are unsaved changes, restore factory setting=
s anyway ?", "Don't restore", "Restore them", NULL)) return;
     }
     w->prefs->deleteEntry("default_file");
     w->prefs->flush();
@@ -228,7 +236,7 @@ static void atclose_cb(Fl_Window *w, void *arg)
 {
     if (strncmp("HDSPMixer", w->label(), 9) =3D=3D 0) {
 	if (((HDSPMixerWindow *)w)->dirty) {
-	    if (!fl_ask("There are unsaved changes, quit anyway ?")) return;
+	  if (!fl_choice("There are unsaved changes, quit anyway ?", "Don't qui=
t", "Quit", NULL)) return;
 	}
 	exit(EXIT_SUCCESS);
     }=20
@@ -254,7 +262,7 @@ static int handler_cb(int event)
     case FL_SHORTCUT:
 	if (key =3D=3D FL_Escape) {
 	    if (w->dirty) {
-		if (!fl_ask("There are unsaved changes, quit anyway ?")) return 1;
+	      if (!fl_choice("There are unsaved changes, quit anyway ?", "Don't=
 quit", "Quit", NULL)) return 1;
 	    }
 	    exit(EXIT_SUCCESS);
 	}
@@ -495,7 +503,6 @@ load_error:
=20
 void HDSPMixerWindow::restoreDefaults(int card)
 {
-    int phones;
     int chnls[3];
     int maxdest[3];
     int h9632_spdif_submix[3];
@@ -508,21 +515,18 @@ void HDSPMixerWindow::restoreDefaults(int card)
 	chnls[1] =3D 14;
 	maxdest[0] =3D 10;
 	maxdest[1] =3D 8;
-	phones =3D 1;
 	break;
     case Digiface:
 	chnls[0] =3D 26;
 	chnls[1] =3D 14;
 	maxdest[0] =3D 14;
 	maxdest[1] =3D 8;
-	phones =3D 1;
 	break;
     case H9652:
 	chnls[0] =3D 26;
 	chnls[1] =3D 14;
 	maxdest[0] =3D 13;
 	maxdest[1] =3D 7;
-	phones =3D 0;
 	break;
     case H9632:
 	chnls[0] =3D 16;
@@ -538,8 +542,35 @@ void HDSPMixerWindow::restoreDefaults(int card)
 	h9632_an12_submix[1] =3D 3;
 	h9632_an12_submix[2] =3D 1;
 	num_modes =3D 3;
-	phones =3D 0;
 	break;
+    case HDSPeMADI:
+      chnls[0] =3D 64;
+      chnls[1] =3D 32;
+      chnls[2] =3D 16;
+      maxdest[0] =3D 32;
+      maxdest[1] =3D 16;
+      maxdest[2] =3D 8;
+      num_modes =3D 3;
+      break;
+     case HDSPeAIO:
+      chnls[0] =3D 14;
+      chnls[1] =3D 10;
+      chnls[2] =3D 8;
+      maxdest[0] =3D 8;
+      maxdest[1] =3D 6;
+      maxdest[2] =3D 5;
+      num_modes =3D 3;
+      break;
+    case HDSPeRayDAT:
+      chnls[0] =3D 36;
+      chnls[1] =3D 20;
+      chnls[2] =3D 12;
+      maxdest[0] =3D 18;
+      maxdest[1] =3D 10;
+      maxdest[2] =3D 6;
+      num_modes =3D 3;
+      break;
+
     default:
 	/* should never happen */
 	return;
@@ -560,13 +591,13 @@ void HDSPMixerWindow::restoreDefaults(int card)
 			((preset =3D=3D 1 && z =3D=3D h9632_an12_submix[speed]) || i =3D=3D z=
*2 || (preset =3D=3D 5 && z =3D=3D h9632_spdif_submix[speed])) ? ndb : 0;
 		    } else {
 			inputs->strips[i]->data[card][speed][preset]->fader_pos[z] =3D =20
-			((preset =3D=3D 6 && z =3D=3D (maxdest[speed]-phones-1)) || (i =3D=3D=
 z*2 && (preset > 1 && preset < 4)) || (((preset > 0 && preset < 4) || pr=
eset =3D=3D 7) && phones && (z =3D=3D maxdest[speed]-1))) ? ndb : 0;
+			((preset =3D=3D 6 && z =3D=3D (maxdest[speed]-1)) || (i =3D=3D z*2 &&=
 (preset > 1 && preset < 4)) || (((preset > 0 && preset < 4) || preset =3D=
=3D 7) && (z =3D=3D maxdest[speed]-1))) ? ndb : 0;
 			inputs->strips[i+1]->data[card][speed][preset]->fader_pos[z] =3D=20
-			((preset =3D=3D 6 && z =3D=3D (maxdest[speed]-phones-1)) || (i =3D=3D=
 z*2 && (preset > 1 && preset < 4)) || (((preset > 0 && preset < 4) || pr=
eset =3D=3D 7) && phones && (z =3D=3D maxdest[speed]-1))) ? ndb : 0;
+			((preset =3D=3D 6 && z =3D=3D (maxdest[speed]-1)) || (i =3D=3D z*2 &&=
 (preset > 1 && preset < 4)) || (((preset > 0 && preset < 4) || preset =3D=
=3D 7) && (z =3D=3D maxdest[speed]-1))) ? ndb : 0;
 			playbacks->strips[i]->data[card][speed][preset]->fader_pos[z] =3D=20
-			((preset > 4 && preset < 7 && z =3D=3D (maxdest[speed]-phones-1)) || =
i =3D=3D z*2 || (phones && (z =3D=3D maxdest[speed]-1))) ? ndb : 0;
+			((preset > 4 && preset < 7 && z =3D=3D (maxdest[speed]-1)) || i =3D=3D=
 z*2 || ((z =3D=3D maxdest[speed]-1))) ? ndb : 0;
 			playbacks->strips[i+1]->data[card][speed][preset]->fader_pos[z] =3D=20
-			((preset > 4 && preset < 7 && z =3D=3D (maxdest[speed]-phones-1)) || =
i =3D=3D z*2 || (phones && (z =3D=3D maxdest[speed]-1))) ? ndb : 0;
+			((preset > 4 && preset < 7 && z =3D=3D (maxdest[speed]-1)) || i =3D=3D=
 z*2 || ((z =3D=3D maxdest[speed]-1))) ? ndb : 0;
 		    }
 		    /* Pan setup */
 		    inputs->strips[i]->data[card][speed][preset]->pan_pos[z] =3D 0;
@@ -604,7 +635,7 @@ void HDSPMixerWindow::restoreDefaults(int card)
 		    data[card][speed][preset]->submix =3D 0;
 		}
 	    } else if (preset > 4 && preset < 7) {
-		data[card][speed][preset]->submix_value =3D maxdest[speed]-phones-1;
+		data[card][speed][preset]->submix_value =3D maxdest[speed]-1;
 		if (preset =3D=3D 5) {
 		    outputs->strips[chnls[speed]-2]->data[card][speed][preset]->fader_=
pos =3D ndb;
 		    outputs->strips[chnls[speed]-1]->data[card][speed][preset]->fader_=
pos =3D ndb;   =20
@@ -615,10 +646,6 @@ void HDSPMixerWindow::restoreDefaults(int card)
 	    if (preset =3D=3D 3 || preset =3D=3D 7) {
 		data[card][speed][preset]->mute =3D 1;
 	    }
-	    if (phones) {
-		outputs->strips[chnls[speed]]->data[card][speed][preset]->fader_pos =3D=
 (preset !=3D 4) ? ndb : 0;
-		outputs->strips[chnls[speed]+1]->data[card][speed][preset]->fader_pos =
=3D (preset !=3D 4) ? ndb : 0;=09
-	    }
 	}
     }
 }
@@ -669,13 +696,13 @@ HDSPMixerWindow::HDSPMixerWindow(int x, int y, int =
w, int h, const char *label,
     menubar->add("&View/Submix", 's', (Fl_Callback *)submix_cb, (void *)=
this, FL_MENU_TOGGLE|FL_MENU_VALUE);
     menubar->add("&Options/Level Meter Setup", 'm', (Fl_Callback *)setup=
_cb, (void *)this);
     menubar->add("&?/About", 0, (Fl_Callback *)about_cb, (void *)this);
-    inputs =3D new HDSPMixerInputs(0, MENU_HEIGHT, w, FULLSTRIP_HEIGHT, =
cards[0]->channels);
+    inputs =3D new HDSPMixerInputs(0, MENU_HEIGHT, w, FULLSTRIP_HEIGHT, =
cards[0]->channels_input);
     inputs->buttons->input =3D 1;
     inputs->buttons->output =3D 1;
     inputs->buttons->submix =3D 1;
     inputs->buttons->playback =3D 1;
-    playbacks =3D new HDSPMixerPlaybacks(0, MENU_HEIGHT+FULLSTRIP_HEIGHT=
, w, FULLSTRIP_HEIGHT, cards[0]->channels);
-    outputs =3D new HDSPMixerOutputs(0, MENU_HEIGHT+FULLSTRIP_HEIGHT*2, =
w, SMALLSTRIP_HEIGHT, cards[0]->channels);
+    playbacks =3D new HDSPMixerPlaybacks(0, MENU_HEIGHT+FULLSTRIP_HEIGHT=
, w, FULLSTRIP_HEIGHT, cards[0]->channels_playback);
+    outputs =3D new HDSPMixerOutputs(0, MENU_HEIGHT+FULLSTRIP_HEIGHT*2, =
w, SMALLSTRIP_HEIGHT, cards[0]->channels_playback);
     scroll->end();
     end();
     setup =3D new HDSPMixerSetup(400, 260, "Level Meters Setup", this);
@@ -791,11 +818,7 @@ void HDSPMixerWindow::checkState()
 	if (outputs->strips[i]->data[current_card][speed][p]->fader_pos !=3D ou=
tputs->strips[i]->fader->pos[0])
 	    corrupt++;
     }
-    /* Line outs */
-    if (outputs->strips[HDSP_MAX_CHANNELS]->data[current_card][speed][p]=
->fader_pos !=3D outputs->strips[HDSP_MAX_CHANNELS]->fader->pos[0])
-	corrupt++;
-    if (outputs->strips[HDSP_MAX_CHANNELS+1]->data[current_card][speed][=
p]->fader_pos !=3D outputs->strips[HDSP_MAX_CHANNELS+1]->fader->pos[0])
-	corrupt++;
+
     /* Global settings */
     if (data[current_card][speed][p]->mute !=3D inputs->buttons->master-=
>mute)
 	corrupt++;
@@ -839,7 +862,7 @@ void HDSPMixerWindow::checkState()
=20
 void HDSPMixerWindow::setSubmix(int submix_value)
 {
-    for (int i =3D 0; i < cards[current_card]->channels; i++) {
+    for (int i =3D 0; i < cards[current_card]->channels_playback; i++) {
 	inputs->strips[i]->targets->value(submix_value);
 	inputs->strips[i]->targets->redraw();
 	inputs->strips[i]->fader->dest =3D submix_value;
@@ -859,7 +882,7 @@ void HDSPMixerWindow::setSubmix(int submix_value)
=20
 void HDSPMixerWindow::unsetSubmix()
 {
-    for (int i =3D 0; i < cards[current_card]->channels; i++) {
+    for (int i =3D 0; i < cards[current_card]->channels_input; i++) {
 	inputs->strips[i]->targets->value(inputs->strips[i]->targets->selected)=
;
 	inputs->strips[i]->targets->redraw();
 	inputs->strips[i]->fader->dest =3D inputs->strips[i]->targets->selected=
;
@@ -881,7 +904,7 @@ void HDSPMixerWindow::unsetSubmix()
 void HDSPMixerWindow::refreshMixer()
 {
     int i, j;
-    for (i =3D 1; i <=3D cards[current_card]->channels; ++i) {
+    for (i =3D 1; i <=3D cards[current_card]->channels_input; ++i) {
 	for (j =3D 0; j < inputs->strips[0]->targets->max_dest; ++j) {
 	    setMixer(i, 0, j);
 	    setMixer(i, 1, j);
@@ -901,7 +924,7 @@ void HDSPMixerWindow::resetMixer()
 {
     int i, j;
     for (i =3D 0; i < (cards[current_card]->playbacks_offset*2) ; ++i) {
-	for (j =3D 0; j < (cards[current_card]->playbacks_offset+cards[current_=
card]->lineouts); ++j) {
+	for (j =3D 0; j < (cards[current_card]->playbacks_offset); ++j) {
 	    setGain(i, j, 0);
 	}
     }
@@ -917,6 +940,8 @@ void HDSPMixerWindow::setGain(int in, int out, int va=
lue)
     snd_ctl_elem_id_t *id;
     snd_ctl_elem_value_t *ctl;
     snd_ctl_t *handle;
+
+    //printf("setGain(%d, %d, %d)\n", in, out, value);
    =20
     snd_ctl_elem_value_alloca(&ctl);
     snd_ctl_elem_id_alloca(&id);
@@ -927,7 +952,7 @@ void HDSPMixerWindow::setGain(int in, int out, int va=
lue)
     snd_ctl_elem_value_set_id(ctl, id);
=20
     if ((err =3D snd_ctl_open(&handle, cards[current_card]->name, SND_CT=
L_NONBLOCK)) < 0) {
-        fprintf(stderr, "Alsa error: %s\n", snd_strerror(err));
+        fprintf(stderr, "Alsa error 1: %s\n", snd_strerror(err));
         return;
     }
=20
@@ -935,7 +960,7 @@ void HDSPMixerWindow::setGain(int in, int out, int va=
lue)
     snd_ctl_elem_value_set_integer(ctl, 1, out);
     snd_ctl_elem_value_set_integer(ctl, 2, value);
     if ((err =3D snd_ctl_elem_write(handle, ctl)) < 0) {
-        fprintf(stderr, "Alsa error: %s\n", snd_strerror(err));
+        fprintf(stderr, "Alsa error 2: %s\n", snd_strerror(err));
         snd_ctl_close(handle);
         return;
     }
@@ -955,6 +980,17 @@ void HDSPMixerWindow::setMixer(int idx, int src, int=
 dst)
     snd_ctl_elem_value_t *ctl;
     snd_ctl_t *handle;
=20
+    char *channel_map;
+   =20
+    switch (src) {
+    case 0:
+      channel_map =3D cards[current_card]->channel_map_input;
+      break;
+    case 1:
+    case 2:
+      channel_map =3D cards[current_card]->channel_map_playback;
+    }
+
     gsolo_active =3D inputs->buttons->master->solo_active;
     gmute_active =3D inputs->buttons->master->mute_active;
     gsolo =3D inputs->buttons->master->solo;
@@ -973,7 +1009,7 @@ void HDSPMixerWindow::setMixer(int idx, int src, int=
 dst)
 	snd_ctl_elem_value_set_id(ctl, id);
    =20
 	if ((err =3D snd_ctl_open(&handle, cards[current_card]->name, SND_CTL_N=
ONBLOCK)) < 0) {
-	    fprintf(stderr, "Alsa error: %s\n", snd_strerror(err));
+	    fprintf(stderr, "Alsa error 3: %s\n", snd_strerror(err));
 	    return;
 	}
=20
@@ -1003,19 +1039,20 @@ void HDSPMixerWindow::setMixer(int idx, int src, =
int dst)
 	right_val =3D attenuation_r* vol * pan;
=20
 muted: =09
-	snd_ctl_elem_value_set_integer(ctl, 0, src*cards[current_card]->playbac=
ks_offset+cards[current_card]->channel_map[idx-1]);
+	snd_ctl_elem_value_set_integer(ctl, 0, src*cards[current_card]->playbac=
ks_offset+channel_map[idx-1]);
 	snd_ctl_elem_value_set_integer(ctl, 1, cards[current_card]->dest_map[ds=
t]);
 	snd_ctl_elem_value_set_integer(ctl, 2, (int)left_val);
 	if ((err =3D snd_ctl_elem_write(handle, ctl)) < 0) {
-	    fprintf(stderr, "Alsa error: %s\n", snd_strerror(err));
+	    fprintf(stderr, "Alsa error 4: %s\n", snd_strerror(err));
 	    snd_ctl_close(handle);
 	    return;
 	}
-	snd_ctl_elem_value_set_integer(ctl, 0, src*cards[current_card]->playbac=
ks_offset+cards[current_card]->channel_map[idx-1]);
+
+	snd_ctl_elem_value_set_integer(ctl, 0, src*cards[current_card]->playbac=
ks_offset+channel_map[idx-1]);
 	snd_ctl_elem_value_set_integer(ctl, 1, cards[current_card]->dest_map[ds=
t]+1);
 	snd_ctl_elem_value_set_integer(ctl, 2, (int)right_val);
 	if ((err =3D snd_ctl_elem_write(handle, ctl)) < 0) {
-	    fprintf(stderr, "Alsa error: %s\n", snd_strerror(err));
+	    fprintf(stderr, "Alsa error 5: %s\n", snd_strerror(err));
 	    snd_ctl_close(handle);
 	    return;
 	}
@@ -1026,10 +1063,13 @@ muted:
 =09
 	dest =3D (int)floor((idx-1)/2);
 =09
-	for (i =3D 0; i < cards[current_card]->channels; ++i) {
+	for (i =3D 0; i < cards[current_card]->channels_input; ++i) {
 	    if ((vol =3D inputs->strips[i]->fader->posToInt(inputs->strips[i]->=
fader->pos[dest])) !=3D 0) {
 		setMixer(i+1, 0, dest);
 	    }
+	}
+
+	for (i =3D 0; i < cards[current_card]->channels_playback; ++i) {
 	    if ((vol =3D playbacks->strips[i]->fader->posToInt(playbacks->strip=
s[i]->fader->pos[dest])) !=3D 0) {
 		setMixer(i+1, 1, dest);
 	    }
diff --git a/hdspmixer/src/defines.h b/hdspmixer/src/defines.h
index 1aefb7a..33559ab 100644
--- a/hdspmixer/src/defines.h
+++ b/hdspmixer/src/defines.h
@@ -24,8 +24,12 @@
 /* Uncomment this to make the setup window non-modal */
 //#define NON_MODAL_SETUP 1
=20
-#define HDSP_MAX_CHANNELS 26
-#define HDSP_MAX_DEST	  14
+#define HDSPeMADI 10
+#define HDSPeRayDAT 11
+#define HDSPeAIO 12
+
+#define HDSP_MAX_CHANNELS 64
+#define HDSP_MAX_DEST	  32
=20
 #define STRIP_WIDTH 	  36
 #define FULLSTRIP_HEIGHT  253
diff --git a/hdspmixer/src/hdspmixer.cxx b/hdspmixer/src/hdspmixer.cxx
index dfb13ea..7fd50e9 100644
--- a/hdspmixer/src/hdspmixer.cxx
+++ b/hdspmixer/src/hdspmixer.cxx
@@ -44,28 +44,28 @@ int main(int argc, char **argv)
     printf("\nHDSPMixer %s - Copyright (C) 2003 Thomas Charbonnel <thoma=
s@undata.org>\n", VERSION);
     printf("This program comes with ABSOLUTELY NO WARRANTY\n");
     printf("HDSPMixer is free software, see the file COPYING for details=
\n\n");
-    printf("Looking for HDSP cards :\n");
+    printf("Looking for RME cards :\n");
     while (snd_card_next(&card) >=3D 0) {
 	if (card < 0) {
 	    break;
 	} else {
 	    snd_card_get_longname(card, &name);
 	    printf("Card %d : %s\n", card, name);
-	    if (!strncmp(name, "RME Hammerfall DSP + Multiface", 30)) {
-		printf("Multiface found !\n");
-		hdsp_cards[cards] =3D new HDSPMixerCard(Multiface, card);
+	    if (!strncmp(name, "RME MADIface", 12)) {
+		printf("RME MADIface found !\n");
+		hdsp_cards[cards] =3D new HDSPMixerCard(HDSPeMADI, card);
 		cards++;
-	    } else if (!strncmp(name, "RME Hammerfall DSP + Digiface", 29)) {
-		printf("Digiface found !\n");
-		hdsp_cards[cards] =3D new HDSPMixerCard(Digiface, card);
+	    } else if (!strncmp(name, "RME MADI", 8)) {
+		printf("RME MADI found !\n");
+		hdsp_cards[cards] =3D new HDSPMixerCard(HDSPeMADI, card);
 		cards++;
-	    } else if (!strncmp(name, "RME Hammerfall HDSP 9652", 24)) {
-		printf("HDSP 9652 found !\n");
-		hdsp_cards[cards] =3D new HDSPMixerCard(H9652, card);
+	    } else if (!strncmp(name, "RME RayDAT", 10)) {
+		printf("RME RayDAT found !\n");
+		hdsp_cards[cards] =3D new HDSPMixerCard(HDSPeRayDAT, card);
 		cards++;
-	    } else if (!strncmp(name, "RME Hammerfall HDSP 9632", 24)) {
-		printf("HDSP 9632 found !\n");
-		hdsp_cards[cards] =3D new HDSPMixerCard(H9632, card);
+	    } else if (!strncmp(name, "RME AIO", 7)) {
+		printf("RME AIO found !\n");
+		hdsp_cards[cards] =3D new HDSPMixerCard(HDSPeAIO, card);
 		cards++;
 	    } else if (!strncmp(name, "RME Hammerfall DSP", 18)) {
 		printf("Uninitialized HDSP card found.\nUse hdsploader to upload confi=
guration data to the card.\n");
@@ -74,13 +74,13 @@ int main(int argc, char **argv)
     }
     free(name);
     if (!cards) {
-	printf("No Hammerfall DSP card found.\n");
+	printf("No RME cards found.\n");
 	exit(EXIT_FAILURE);
     }
     for (int i =3D cards; i < 3; ++i) {
 	hdsp_cards[i] =3D NULL;
     }
-    printf("%d Hammerfall DSP %s found.\n", cards, (cards > 1) ? "cards"=
 : "card");
+    printf("%d RME cards %s found.\n", cards, (cards > 1) ? "cards" : "c=
ard");
     window =3D new HDSPMixerWindow(0, 0, hdsp_cards[0]->window_width, hd=
sp_cards[0]->window_height, "HDSPMixer", hdsp_cards[0], hdsp_cards[1], hd=
sp_cards[2]);
     Fl::visual(FL_DOUBLE|FL_INDEX);
     window->show(argc, argv);
--=20
1.7.2.3


--===============3816867493195009512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3816867493195009512==--
