From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] 3/5 echomixer cleanup
Date: Sun, 3 Apr 2005 15:42:33 +0200
Message-ID: <20050403154233.14a83d7d.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: Quoted-Printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


This patch:

- Cleans up the mess about nominal level switches.

- Removes some old unused code.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-tools/echomixer/echomixer.c__orig	Sat Mar  5 15:49:53 2005
+++ alsa-tools/echomixer/echomixer.c	Sat Mar  5 17:37:56 2005
@@ -92,7 +92,6 @@
=20
 char card[64], cardId[16];
 char dmodeName[DIGITAL_MODES][64], clocksrcName[DIGITAL_MODES][64], spdi=
fmodeName[DIGITAL_MODES][64];
-char NominalIn[ECHO_MAXAUDIOINPUTS], NominalOut[ECHO_MAXAUDIOOUTPUTS];
 int nLOut, nIn, fdIn, fdOut, nPOut, ClockMask;
 int ndmodes, nclocksrc, nspdifmodes;
 int GMixerRow, GMixerColumn, Gang, AutoClock;
@@ -176,7 +175,7 @@
 #endif
=20
=20
-struct VolumeControl {
+struct VolumeControl_s {
   int input, output;				// Currently selected channels
   int inputs, outputs;
   int id;
@@ -187,7 +186,13 @@
   int Gain[ECHO_MAXAUDIOOUTPUTS];
 } lineinControl, lineoutControl, pcmoutControl;
=20
-GtkWidget *p4dbuOut[ECHO_MAXAUDIOOUTPUTS], *p4dbuIn[ECHO_MAXAUDIOINPUTS]=
;	// +4dBu/-10dBV toggles
+struct NominalLevelControl_s {
+  int id;
+  int Channels;
+  char Level[ECHO_MAXAUDIOINPUTS];
+  GtkWidget *Button[ECHO_MAXAUDIOINPUTS];
+} NominalIn, NominalOut;
+
 GtkWidget *clocksrc_menuitem[ECHO_CLOCKS];
 GtkWidget *dmodeOpt, *clocksrcOpt, *spdifmodeOpt, *phantomChkbutton, *au=
toclockChkbutton;
 GtkWidget *window, *Mainwindow, *Miscwindow, *LVwindow, *VUwindow, *GMwi=
ndow;
@@ -478,22 +483,20 @@
=20
=20
=20
-void ReadNominalLevels(char *NominalLevel, int numid) {
+void ReadNominalLevels(struct NominalLevelControl_s *NominalLevel) {
   snd_ctl_elem_id_t *id;
   snd_ctl_elem_value_t *control;
-  int err, i, n;
+  int err, i;
=20
   snd_ctl_elem_id_alloca(&id);
   snd_ctl_elem_value_alloca(&control);
-
   snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
-  n=3D(numid=3D=3Dp4InId) ? fdIn : fdOut;
-  snd_ctl_elem_id_set_numid(id, numid);
+  snd_ctl_elem_id_set_numid(id, NominalLevel->id);
   snd_ctl_elem_value_set_id(control, id);
   if ((err=3Dsnd_ctl_elem_read(ctlhandle, control))<0)
     printf("Control %s element read error: %s\n", card, snd_strerror(err=
));
-  for (i=3D0; i<n; i++)
-    NominalLevel[i]=3Dsnd_ctl_elem_value_get_integer(control, i);
+  for (i=3D0; i<NominalLevel->Channels; i++)
+    NominalLevel->Level[i]=3Dsnd_ctl_elem_value_get_integer(control, i);
 }
=20
=20
@@ -1120,7 +1123,7 @@
   snd_ctl_elem_value_t *control;
   char str[16];
   int err, channel, val, rval;
-  struct VolumeControl *vol;
+  struct VolumeControl_s *vol;
=20
   snd_ctl_elem_id_alloca(&id);
   snd_ctl_elem_value_alloca(&control);
@@ -1345,26 +1348,24 @@
 void Nominal_level_toggled(GtkWidget *widget, gpointer ch) {
   snd_ctl_elem_id_t *id;
   snd_ctl_elem_value_t *control;
-  GtkWidget **button;
   int err, val, channel;
+  struct NominalLevelControl_s *NominalLevel;
=20
   snd_ctl_elem_id_alloca(&id);
   snd_ctl_elem_value_alloca(&control);
+  snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
=20
   val=3Dgtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(widget));
-
-  snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
   if ((int)ch<ECHO_MAXAUDIOINPUTS) {
     channel=3D(int)ch;
-    button=3Dp4dbuIn;
-    NominalIn[channel]=3D!val;
-    snd_ctl_elem_id_set_numid(id, p4InId);
+    NominalLevel=3D&NominalIn;
   } else {
     channel=3D(int)ch-ECHO_MAXAUDIOINPUTS;
-    button=3Dp4dbuOut;
-    NominalOut[channel]=3D!val;
-    snd_ctl_elem_id_set_numid(id, p4OutId);
+    NominalLevel=3D&NominalOut;
   }
+  NominalLevel->Level[channel]=3D!val;
+
+  snd_ctl_elem_id_set_numid(id, NominalLevel->id);
   snd_ctl_elem_value_set_id(control, id);
   if ((err=3Dsnd_ctl_elem_read(ctlhandle, control))<0)
     printf("Control %s element read error: %s\n", card, snd_strerror(err=
));
@@ -1372,7 +1373,7 @@
   if ((err=3Dsnd_ctl_elem_write(ctlhandle, control))<0)
     printf("Control %s element write error: %s\n", card, snd_strerror(er=
r));
   if (Gang)
-    gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button[channel^1]), v=
al);
+    gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(NominalLevel->Button[=
channel^1]), val);
 }
=20
=20
@@ -1680,39 +1681,7 @@
=20
=20
=20
-/*
-int LockControls(snd_ctl_elem_id_t *id, int first_id, int num) {
-  int i, err;
-
-  for (i=3D0; i<num; i++) {
-    snd_ctl_elem_id_set_numid(id, first_id+i);
-    err=3Dsnd_ctl_elem_lock(ctlhandle, id);
-    if (err)
-      return(err);
-  }
-  return(0);
-}
-
-int LockControls(int first_id, int num) {
-  int i, err;
-  snd_ctl_elem_id_t *id;
-
-  snd_ctl_elem_id_alloca(&id);
-  snd_ctl_elem_id_set_interface(id, first_id=3D=3DclocksrcId ? SND_CTL_E=
LEM_IFACE_PCM : SND_CTL_ELEM_IFACE_CARD);
-
-  for (i=3D0; i<num; i++) {
-    snd_ctl_elem_id_set_numid(id, first_id+i);
-    err=3Dsnd_ctl_elem_lock(ctlhandle, id);
-    if (err)
-      return(err);
-  }
-  return(0);
-}
-*/
-
-
-
-// Scan all controls and store their ID's for later use.
+// Scan all controls and sets up the structures needed to access them.
 int OpenControls(const char *card, const char *cardname) {
   int err, i, o;
   int numid, count, items, item;
@@ -1724,9 +1693,9 @@
   pcmoutId=3DlineoutId=3DvmixerId=3Dp4InId=3Dp4OutId=3DdmodeId=3Dclocksr=
cId=3DspdifmodeId=3DvuswitchId=3DvumetersId=3DmixerId=3D0;
   memset(&vmixerControl, 0, sizeof(vmixerControl));
   memset(&mixerControl, 0, sizeof(mixerControl));
-  memset(&lineoutControl, 0, sizeof(struct VolumeControl));
-  memset(&lineinControl, 0, sizeof(struct VolumeControl));
-  memset(&pcmoutControl, 0, sizeof(struct VolumeControl));
+  memset(&lineoutControl, 0, sizeof(struct VolumeControl_s));
+  memset(&lineinControl, 0, sizeof(struct VolumeControl_s));
+  memset(&pcmoutControl, 0, sizeof(struct VolumeControl_s));
   ndmodes=3Dnclocksrc=3Dnspdifmodes=3D0;
   snd_ctl_elem_id_alloca(&id);
   snd_ctl_elem_info_alloca(&info);
@@ -1765,8 +1734,6 @@
       }
     } else if (!strcmp("PCM Playback Volume", snd_ctl_elem_id_get_name(i=
d))) {
       pcmoutId=3DpcmoutControl.id=3Dnumid;
-//printf("*** %d\n", LockControls(id, numid, 1));
-//#warning ************* usare id gi=E0 pronto ?  controllo errori, eccc=
=2E
       CTLID_DEBUG(("PCM Playback Volume id=3D%d [%d]\n", pcmoutId, count=
));
     } else if (!strcmp("Line Playback Volume", snd_ctl_elem_id_get_name(=
id))) {
       lineoutId=3Dnumid;
@@ -1775,10 +1742,10 @@
       lineinId=3DlineinControl.id=3Dnumid;
       CTLID_DEBUG(("Capture Volume id=3D%d [%d]\n", lineinId, count));
     } else if (!strcmp("Line Playback Switch (-10dBV)", snd_ctl_elem_id_=
get_name(id))) {
-      p4OutId=3Dnumid;
+      p4OutId=3DNominalOut.id=3Dnumid;
       CTLID_DEBUG(("Playback nominal id=3D%d [%d]\n", p4OutId, count));
     } else if (!strcmp("Line Capture Switch (-10dBV)", snd_ctl_elem_id_g=
et_name(id))) {
-      p4InId=3Dnumid;
+      p4InId=3DNominalIn.id=3Dnumid;
       CTLID_DEBUG(("Capture nominal id=3D%d [%d]\n", p4InId, count));
     } else if (!strcmp("Digital mode Switch", snd_ctl_elem_id_get_name(i=
d))) {
       dmodeId=3Dnumid;
@@ -1872,6 +1839,12 @@
     }
   }
=20
+  if (p4InId)
+    NominalIn.Channels=3DfdIn;
+
+  if (p4OutId)
+    NominalOut.Channels=3DfdOut;
+
   //@ Assumes all mixer and vmixer controls are contiguous
   if (mixerId)
     for (o=3D0, numid=3DmixerId; o<nLOut; o++) {
@@ -1968,8 +1941,6 @@
   GMixerSection.VmixerFirst=3DnIn;
   GMixerSection.VmixerLast=3DnIn+vmixerControl.vchannels-1;
   GMixerSection.LineOut=3DGMixerSection.VmixerLast+1;
-  memset(NominalIn, 0, sizeof(NominalIn));
-  memset(NominalOut, 0, sizeof(NominalOut));
=20
   // Read current mixer setting.
   if (mixerId)
@@ -1983,9 +1954,9 @@
   if (lineoutId)
     ReadControl(lineoutControl.Gain, nLOut, lineoutId);
   if (p4InId)
-    ReadNominalLevels(NominalIn, p4InId);
+    ReadNominalLevels(&NominalIn);
   if (p4OutId)
-    ReadNominalLevels(NominalOut, p4OutId);
+    ReadNominalLevels(&NominalOut);
=20
   //@@ check the values
   if (load) {
@@ -2010,11 +1981,11 @@
         } else if (!strncmp("NominalOut ", str, 11)) {
           sscanf(str+11, "%d %d", &o, &n);
           if (o>=3D0 && o<fdOut)
-            NominalOut[o]=3D!!n;
+            NominalOut.Level[o]=3D!!n;
         } else if (!strncmp("NominalIn ", str, 10)) {
           sscanf(str+10, "%d %d", &i, &n);
           if (i>=3D0 && i<fdIn)
-            NominalIn[i]=3D!!n;
+            NominalIn.Level[i]=3D!!n;
         } else if (!strncmp("Mixer ", str, 6)) {
           sscanf(str+6, "%d %d %d", &o, &i, &n);
           if (o>=3D0 && o<nLOut && i>=3D0 && i<nIn)
@@ -2082,12 +2053,12 @@
=20
     for (i=3D0; i<fdIn; i++) {
       sprintf(str, "%d", i);
-      p4dbuIn[i]=3Dgtk_toggle_button_new_with_label(str);
-      gtk_box_pack_start(GTK_BOX(hbox), p4dbuIn[i], TRUE, FALSE, 1);
-      gtk_widget_show(p4dbuIn[i]);
-      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(p4dbuIn[i]), Nomina=
lIn[i]);	// Forces handler call
-      gtk_signal_connect(GTK_OBJECT(p4dbuIn[i]), "toggled", GTK_SIGNAL_F=
UNC(Nominal_level_toggled), (gpointer)i);
-      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(p4dbuIn[i]), !Nomin=
alIn[i]);
+      button=3DNominalIn.Button[i]=3Dgtk_toggle_button_new_with_label(st=
r);
+      gtk_box_pack_start(GTK_BOX(hbox), button, TRUE, FALSE, 1);
+      gtk_widget_show(button);
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), NominalIn.=
Level[i]);	// Forces handler call
+      gtk_signal_connect(GTK_OBJECT(button), "toggled", GTK_SIGNAL_FUNC(=
Nominal_level_toggled), (gpointer)i);
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), !NominalIn=
.Level[i]);
     }
   }
=20
@@ -2103,12 +2074,12 @@
=20
     for (i=3D0; i<fdOut; i++) {
       sprintf(str, "%d", i);
-      p4dbuOut[i]=3Dgtk_toggle_button_new_with_label(str);
-      gtk_box_pack_start(GTK_BOX(hbox), p4dbuOut[i], TRUE, FALSE, 1);
-      gtk_widget_show(p4dbuOut[i]);
-      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(p4dbuOut[i]), Nomin=
alOut[i]);
-      gtk_signal_connect(GTK_OBJECT(p4dbuOut[i]), "toggled", GTK_SIGNAL_=
FUNC(Nominal_level_toggled), (gpointer)(i+ECHO_MAXAUDIOINPUTS));
-      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(p4dbuOut[i]), !Nomi=
nalOut[i]);
+      button=3DNominalOut.Button[i]=3Dgtk_toggle_button_new_with_label(s=
tr);
+      gtk_box_pack_start(GTK_BOX(hbox), button, TRUE, FALSE, 1);
+      gtk_widget_show(button);
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), NominalOut=
.Level[i]);
+      gtk_signal_connect(GTK_OBJECT(button), "toggled", GTK_SIGNAL_FUNC(=
Nominal_level_toggled), (gpointer)(i+ECHO_MAXAUDIOINPUTS));
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), !NominalOu=
t.Level[i]);
     }
   }
=20
@@ -2792,12 +2763,12 @@
         if (p4InId) {
           fprintf(f, "-- NominalIn <channel> <consumer level enabled>\n"=
);
           for (i=3D0; i<fdIn; i++)
-            fprintf(f, "NominalIn %2d %d\n", i, NominalIn[i]);
+            fprintf(f, "NominalIn %2d %d\n", i, NominalIn.Level[i]);
         }
         if (p4OutId) {
           fprintf(f, "-- NominalOut <channel> <consumer level enabled>\n=
");
           for (o=3D0; o<fdOut; o++)
-            fprintf(f, "NominalOut %2d %d\n", o, NominalOut[o]);
+            fprintf(f, "NominalOut %2d %d\n", o, NominalOut.Level[o]);
         }
         if (mixerId) {
           fprintf(f, "-- Mixer <output> <input> <gain>\n");

--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
