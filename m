From: Giuliano Pochini <pochini@shiny.it>
Subject: echomixer patch
Date: Sun, 9 Jan 2005 19:54:16 +0100
Message-ID: <20050109195416.29d8cd78.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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



- Big cleanup in the matrix mixer drawing code. It make is way
smaller and readable.

- New feature: echomixer can load and restore the status of nominal level
switches.

- Version number bumped to 1.0.3.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- x/ad/alsa-tools/echomixer/configure.in	Wed Dec 29 14:02:53 2004
+++ alsa-tools/echomixer/configure.in	Sun Jan  9 19:27:23 2005
@@ -1,6 +1,6 @@
 dnl Process this file with autoconf to produce a configure script.
 AC_INIT(echomixer.c)
-AM_INIT_AUTOMAKE(echomixer, 1.0.2)
+AM_INIT_AUTOMAKE(echomixer, 1.0.3)
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
--- x/alsa-tools/echomixer/configure.in-gtk2	Wed Dec 29 14:02:53 2004
+++ alsa-tools/echomixer/configure.in-gtk2	Sun Jan  9 19:28:55 2005
@@ -1,5 +1,5 @@
 AC_INIT(echomixer.c)
-AM_INIT_AUTOMAKE(echomixer, 0.5.0)
+AM_INIT_AUTOMAKE(echomixer, 1.0.3)
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
--- x/alsa-tools/echomixer/echomixer.c	Wed Dec 29 14:02:53 2004
+++ alsa-tools/echomixer/echomixer.c	Sun Jan  9 19:25:13 2005
@@ -16,7 +16,7 @@
  *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, =
USA.
  */
=20
-#define EM_VERSION "%s Echomixer v1.0.2"
+#define EM_VERSION "%s Echomixer v" VERSION
=20
=20
 /*******
@@ -75,8 +75,8 @@
 // REAL is for debugging only.
 #define REAL
=20
-#define CTLID_DEBUG(x) printf x
-//#define CTLID_DEBUG(x)
+//#define CTLID_DEBUG(x) printf x
+#define CTLID_DEBUG(x)
=20
 #define UI_DEBUG(x)
 //#define UI_DEBUG(x) printf x
@@ -92,6 +92,7 @@
=20
 char card[64], cardId[16];
 char dmodeName[DIGITAL_MODES][64], clocksrcName[DIGITAL_MODES][64], spdifm=
odeName[DIGITAL_MODES][64];
+char NominalIn[ECHO_MAXAUDIOINPUTS], NominalOut[ECHO_MAXAUDIOOUTPUTS];
 int nLOut, nIn, fdIn, fdOut, nPOut, ClockMask;
 int ndmodes, nclocksrc, nspdifmodes;
 int GMixerRow, GMixerColumn, Gang;
@@ -102,6 +103,7 @@
 int dmodeVal, clocksrcVal, spdifmodeVal;
 int VUwidth, VUheight, Mixwidth, Mixheight;
=20
+#define DONT_DRAW (ECHOGAIN_MUTED-1)
 #define NOPOS 999999
 struct geometry {
   int st;		// window status: 0 =3D hidden ; 1 =3D visible ; NOPOS =3D no s=
tored setting
@@ -358,8 +360,8 @@
     }
 #else
     for (i=3D0; i<nPOut; i++) {
-      VirLevel[i]=3D-20;
-      VirPeak[i]=3D-10;
+      VirLevel[i]=3Di*5-100;
+      VirPeak[i]=3Di*5-90;
     }
 #endif
   }
@@ -436,34 +438,6 @@
 #endif // REVERSE
=20
=20
-// At startup this functions reads the current nominal levels and sets the=
 switches accordingly.
-void InitNominalLevelGUI(int numid) {
-  snd_ctl_elem_id_t *id;
-  snd_ctl_elem_value_t *control;
-  int err, i, n;
-  GtkWidget **w;
-
-  snd_ctl_elem_id_alloca(&id);
-  snd_ctl_elem_value_alloca(&control);
-
-  snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
-  if (numid=3D=3Dp4InId) {
-    snd_ctl_elem_id_set_numid(id, p4InId);
-    n=3DfdIn;
-    w=3Dp4dbuIn;
-  } else {
-    snd_ctl_elem_id_set_numid(id, p4OutId);
-    n=3DfdOut;
-    w=3Dp4dbuOut;
-  }
-  snd_ctl_elem_value_set_id(control, id);
-  if ((err=3Dsnd_ctl_elem_read(ctlhandle, control))<0)
-    printf("Control %s element read error: %s\n", card, snd_strerror(err));
-  for (i=3D0; i<n; i++)
-    gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(w[i]), !snd_ctl_elem_va=
lue_get_integer(control, i));	// FALSE is +4 here
-}
-
-
=20
 // At startup this functions reads if the dithering is enabled sets the bu=
tton accordingly.
 void InitPhantomPowerGUI(int numid) {
@@ -505,6 +479,26 @@
=20
=20
=20
+void ReadNominalLevels(char *NominalLevel, int numid) {
+  snd_ctl_elem_id_t *id;
+  snd_ctl_elem_value_t *control;
+  int err, i, n;
+
+  snd_ctl_elem_id_alloca(&id);
+  snd_ctl_elem_value_alloca(&control);
+
+  snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
+  n=3D(numid=3D=3Dp4InId) ? fdIn : fdOut;
+  snd_ctl_elem_id_set_numid(id, numid);
+  snd_ctl_elem_value_set_id(control, id);
+  if ((err=3Dsnd_ctl_elem_read(ctlhandle, control))<0)
+    printf("Control %s element read error: %s\n", card, snd_strerror(err));
+  for (i=3D0; i<n; i++)
+    NominalLevel[i]=3Dsnd_ctl_elem_value_get_integer(control, i);
+}
+
+
+
 int SetMixerGain(struct mixel *mxl, int Gain) {
   snd_ctl_elem_id_t *id;
   snd_ctl_elem_value_t *control;
@@ -578,7 +572,7 @@
=20
=20
=20
-// Read what input clocks are valid and sets the pop-down menu accordingly
+// Read what input clocks are valid and (de)activate the pop-down menu ite=
ms accordingly
 gint CheckInputs(gpointer unused) {
   int i;
=20
@@ -590,6 +584,48 @@
=20
=20
=20
+void DrawBar(int x, int y, int level, int peak, int gain) {
+  GdkColor Bars=3D{0x00FF00, 0, 0, 0};
+  GdkColor Bars1=3D{0x000000, 0, 0, 0};
+  GdkColor Peak=3D{0x1BABFF, 0, 0, 0};
+  GdkColor Level=3D{0xC0B000, 0, 0, 0};
+  int db;
+
+  x=3DXMETER+XCELLTOT*x;
+  y=3DYCELLTOT*y+YCELLBORDER;
+
+  if (level>ECHOGAIN_MUTED) {
+    // Draw the "integer" part of the bar
+    db=3Dlevel>>2;
+    gdk_gc_set_foreground(gc, &Bars);
+    gdk_draw_rectangle(Mixpixmap, gc, TRUE, x, y-db, GM_BARWIDTH, YCELLDIM=
+db);
+
+    // Draw the antialiased part
+    Bars1.pixel=3D(level&3) << (6 + 8);	// 4 levels (256/4=3D=3D64=3D=3D2^=
6) of green (2^8)
+    if (Bars1.pixel) {
+      gdk_gc_set_foreground(gc, &Bars1);
+      gdk_draw_rectangle(Mixpixmap, gc, TRUE, x, y-db-1, GM_BARWIDTH, 1);
+    }
+  }
+
+  // Draw the peak
+  if (peak>ECHOGAIN_MUTED) {
+    db=3Dpeak>>2;
+    gdk_gc_set_foreground(gc, &Peak);
+    gdk_draw_rectangle(Mixpixmap, gc, TRUE, x, y-db, GM_BARWIDTH, 1);
+  }
+
+  // Draw the mixer gain
+  if (gain>=3DECHOGAIN_MUTED) {
+    db=3Dgain>>2;
+    gdk_gc_set_foreground(gc, &Level);
+    gdk_draw_rectangle(Mixpixmap, gc, TRUE, x-XMETER+XVOLUME, y, 1, YCELLD=
IM);
+    gdk_draw_rectangle(Mixpixmap, gc, TRUE, x-XMETER+XVOLUME-2, y-db, 5, 1=
);
+  }
+}
+
+
+
 // Draw the matrix mixer
 gint DrawMixer(gpointer unused) {
   GdkRectangle update_rect;
@@ -597,18 +633,14 @@
   int InPeak[ECHO_MAXAUDIOINPUTS];
   int OutLevel[ECHO_MAXAUDIOOUTPUTS];
   int OutPeak[ECHO_MAXAUDIOOUTPUTS];
-  int VirLevel[ECHO_MAXAUDIOOUTPUTS];//maxpipes
+  int VirLevel[ECHO_MAXAUDIOOUTPUTS];
   int VirPeak[ECHO_MAXAUDIOOUTPUTS];
   static int InClip[ECHO_MAXAUDIOINPUTS];
   static int OutClip[ECHO_MAXAUDIOOUTPUTS];
   char str[8];
-  int i, o, y, dB, db, inchannels, outchannels;
+  int i, o, dB, inchannels, outchannels;
   GdkColor Grid=3D{0x787878, 0, 0, 0};
   GdkColor Labels=3D{0x9694C4, 0, 0, 0};
-  GdkColor Bars=3D{0x00FF00, 0, 0, 0};
-  GdkColor Bars1=3D{0x000000, 0, 0, 0};
-  GdkColor Peak=3D{0x1BABFF, 0, 0, 0};
-  GdkColor Level=3D{0xC0B000, 0, 0, 0};
   GdkColor Hilight=3D{0x000078, 0, 0, 0};
   GdkColor Hilight2=3D{0x600000, 0, 0, 0};
=20
@@ -650,6 +682,7 @@
   }
=20
   // Draw the grid
+
   gdk_gc_set_font(gc, fnt);
   // Horizontal lines and input channel labels
   for (i=3D0; i<GMixerSection.LineOut; i++) {
@@ -664,6 +697,7 @@
     gdk_gc_set_foreground(gc, &Labels);
     gdk_draw_string(Mixpixmap, fnt, gc, 1, YCELLTOT*i+(YCELLTOT/2)+4, str);
   }
+
   // Vertical lines and output channel labels
   for (o=3D0; o<nLOut; o++) {
     gdk_gc_set_foreground(gc, &Grid);
@@ -681,107 +715,32 @@
   gdk_draw_rectangle(Mixpixmap, gc, TRUE, 0, YCELLTOT*(GMixerSection.LineO=
ut+1)-1, Mixwidth, 1);
=20
   // Draw input levels and peaks
-  for (i=3D0; i<inchannels; i++) {
-    y=3DYCELLTOT*i+YCELLBORDER;
-    dB=3DInLevel[i];
-    db=3DdB>>2;
-    gdk_gc_set_foreground(gc, &Bars);
-    gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER, y-db, GM_BARWIDTH, YCE=
LLDIM+db);
-    if ((Bars1.pixel=3D(((dB&3)*0x40)<<8))) {
-      gdk_gc_set_foreground(gc, &Bars1);
-      gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER, y-db-1, GM_BARWIDTH,=
 1);
-    }
-  }
-  gdk_gc_set_foreground(gc, &Peak);
-  for (i=3D0; i<inchannels; i++) {
-    db=3DInPeak[i]>>2;
-    gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER, YCELLTOT*i+YCELLBORDER=
-db, GM_BARWIDTH, 1);
-  }
+  for (i=3D0; i<inchannels; i++)
+    DrawBar(0, i, InLevel[i], InPeak[i], DONT_DRAW);
=20
   // Draw vchannels levels and peaks (Vmixer cards only)
   if (vmixerId) {
-    for (i=3D0; i<vmixerControl.vchannels; i++) {
-      y=3DYCELLTOT*(i+GMixerSection.VmixerFirst)+YCELLBORDER;
-      dB=3DVirLevel[i];
-      db=3DdB>>2;
-      gdk_gc_set_foreground(gc, &Bars);
-      gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER, y-db, GM_BARWIDTH, Y=
CELLDIM+db);
-      if ((Bars1.pixel=3D(((dB&3)*0x40)<<8))) {
-        gdk_gc_set_foreground(gc, &Bars1);
-        gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER, y-db-1, GM_BARWIDT=
H, 1);
-      }
-    }
-    gdk_gc_set_foreground(gc, &Peak);
-    for (i=3D0; i<vmixerControl.vchannels; i++) {
-      db=3DVirPeak[i]>>2;
-      gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER, YCELLTOT*(i+GMixerSe=
ction.VmixerFirst)+YCELLBORDER-db, GM_BARWIDTH, 1);
-    }
+    for (i=3D0; i<vmixerControl.vchannels; i++)
+      DrawBar(0, i+GMixerSection.VmixerFirst, VirLevel[i], VirPeak[i], DON=
T_DRAW);
   }
=20
   // Draw output levels, peaks and volumes
-  y=3DYCELLTOT*GMixerSection.LineOut+YCELLBORDER;
-  for (o=3D0; o<outchannels; o++) {
-    dB=3DOutLevel[o];
-    db=3DdB>>2;
-    gdk_gc_set_foreground(gc, &Bars);
-    gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER+XCELLTOT*(o+1), y-db, G=
M_BARWIDTH, YCELLDIM+db);
-    if ((Bars1.pixel=3D(((dB&3)*0x40)<<8))) {
-      gdk_gc_set_foreground(gc, &Bars1);
-      gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER+XCELLTOT*(o+1), y-db-=
1, GM_BARWIDTH, 1);
-    }
-    db=3DOutPeak[o]>>2;
-    gdk_gc_set_foreground(gc, &Peak);
-    gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER+XCELLTOT*(o+1), y-db, G=
M_BARWIDTH, 1);
-    gdk_gc_set_foreground(gc, &Level);
-    gdk_draw_rectangle(Mixpixmap, gc, TRUE, XVOLUME+XCELLTOT*(o+1), y, 1, =
YCELLDIM);
-    db=3DlineoutControl.Gain[o]>>2;
-    gdk_draw_rectangle(Mixpixmap, gc, TRUE, XVOLUME-2+XCELLTOT*(o+1), y-db=
, 5, 1);
-  }
+  for (o=3D0; o<outchannels; o++)
+    DrawBar(o+1, GMixerSection.LineOut, OutLevel[o], OutPeak[o], lineoutCo=
ntrol.Gain[o]);
=20
   // Draw monitor mixer elements
   for (o=3D0; o<outchannels; o++) {
     for (i=3D0; i<inchannels; i++) {
-      y=3DYCELLTOT*i+YCELLBORDER;
       dB=3DAdd_dB(mixerControl.mixer[o][i].Gain, InLevel[i]);
-      db=3DdB>>2;
-      if (db<-YCELLDIM)
-        db=3D-YCELLDIM;
-      gdk_gc_set_foreground(gc, &Bars);
-      gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER+XCELLTOT*(o+1), y-db,=
 GM_BARWIDTH, YCELLDIM+db);
-      if (dB>-(YCELLDIM<<2))
-        if ((Bars1.pixel=3D(((dB&3)*0x40)<<8))) {
-          gdk_gc_set_foreground(gc, &Bars1);
-          gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER+XCELLTOT*(o+1), y=
-db-1, GM_BARWIDTH, 1);
-        }
-      gdk_gc_set_foreground(gc, &Level);
-      gdk_draw_rectangle(Mixpixmap, gc, TRUE, XVOLUME+XCELLTOT*(o+1), y, 1=
, YCELLDIM);
-      db=3DmixerControl.mixer[o][i].Gain>>2;
-      gdk_draw_rectangle(Mixpixmap, gc, TRUE, XVOLUME-2+XCELLTOT*(o+1), y-=
db, 5, 1);
+      DrawBar(o+1, i, dB, DONT_DRAW, mixerControl.mixer[o][i].Gain);
     }
   }
=20
-  // Draw vmixer elements
+  // Draw vmixer elements (Vmixer cards only)
   if (vmixerId) {
-    for (o=3D0; o<outchannels; o++) {
-      for (i=3D0; i<vmixerControl.vchannels; i++) {
-        y=3DYCELLTOT*(i+GMixerSection.VmixerFirst)+YCELLBORDER;
-        dB=3DAdd_dB(vmixerControl.mixer[o][i].Gain, VirLevel[i]);
-        db=3DdB>>2;
-        if (db<-YCELLDIM)
-          db=3D-YCELLDIM;
-        gdk_gc_set_foreground(gc, &Bars);
-        gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER+XCELLTOT*(o+1), y-d=
b, GM_BARWIDTH, YCELLDIM+db);
-        if (dB>-(YCELLDIM<<2))
-          if ((Bars1.pixel=3D(((dB&3)*0x40)<<8))) {
-            gdk_gc_set_foreground(gc, &Bars1);
-            gdk_draw_rectangle(Mixpixmap, gc, TRUE, XMETER+XCELLTOT*(o+1),=
 y-db-1, GM_BARWIDTH, 1);
-          }
-        gdk_gc_set_foreground(gc, &Level);
-        gdk_draw_rectangle(Mixpixmap, gc, TRUE, XVOLUME+XCELLTOT*(o+1), y,=
 1, YCELLDIM);
-        db=3DvmixerControl.mixer[o][i].Gain>>2;
-        gdk_draw_rectangle(Mixpixmap, gc, TRUE, XVOLUME-2+XCELLTOT*(o+1), =
y-db, 5, 1);
-      }
-    }
+    for (o=3D0; o<outchannels; o++)
+      for (i=3D0; i<vmixerControl.vchannels; i++)
+        DrawBar(o+1, i+GMixerSection.VmixerFirst, VirLevel[i], DONT_DRAW, =
vmixerControl.mixer[o][i].Gain);
   }
=20
   gtk_widget_draw(Mixdarea, &update_rect);
@@ -797,7 +756,7 @@
   int InPeak[ECHO_MAXAUDIOINPUTS];
   int OutLevel[ECHO_MAXAUDIOOUTPUTS];
   int OutPeak[ECHO_MAXAUDIOOUTPUTS];
-  int VirLevel[ECHO_MAXAUDIOOUTPUTS];//maxpipes
+  int VirLevel[ECHO_MAXAUDIOOUTPUTS];
   int VirPeak[ECHO_MAXAUDIOOUTPUTS];
   static int InClip[ECHO_MAXAUDIOINPUTS];
   static int OutClip[ECHO_MAXAUDIOOUTPUTS];
@@ -1393,10 +1352,12 @@
   if ((int)ch<ECHO_MAXAUDIOINPUTS) {
     channel=3D(int)ch;
     button=3Dp4dbuIn;
+    NominalIn[channel]=3D!val;
     snd_ctl_elem_id_set_numid(id, p4InId);
   } else {
     channel=3D(int)ch-ECHO_MAXAUDIOINPUTS;
     button=3Dp4dbuOut;
+    NominalOut[channel]=3D!val;
     snd_ctl_elem_id_set_numid(id, p4OutId);
   }
   snd_ctl_elem_value_set_id(control, id);
@@ -1497,7 +1458,7 @@
=20
 // Create a new backing pixmap of the appropriate size
 static gint Gmixer_configure_event(GtkWidget *widget, GdkEventConfigure *e=
vent) {
- =20
+
   if (Mixpixmap)
     gdk_pixmap_unref(Mixpixmap);
   Mixpixmap=3Dgdk_pixmap_new(widget->window, widget->allocation.width, wid=
get->allocation.height, -1);
@@ -1971,6 +1932,9 @@
   GMixerSection.VmixerFirst=3DnIn;
   GMixerSection.VmixerLast=3DnIn+vmixerControl.vchannels-1;
   GMixerSection.LineOut=3DGMixerSection.VmixerLast+1;
+  memset(NominalIn, 0, sizeof(NominalIn));
+  memset(NominalOut, 0, sizeof(NominalOut));
+
   // Read current mixer setting.
   if (mixerId)
     ReadMixer(&mixerControl);
@@ -1982,6 +1946,10 @@
     ReadControl(lineinControl.Gain, nIn, lineinControl.id);
   if (lineoutId)
     ReadControl(lineoutControl.Gain, nLOut, lineoutId);
+  if (p4InId)
+    ReadNominalLevels(NominalIn, p4InId);
+  if (p4OutId)
+    ReadNominalLevels(NominalOut, p4OutId);
=20
   //@@ check the values
   if (load) {
@@ -2003,6 +1971,14 @@
           sscanf(str+7, "%d %d", &o, &n);
           if (o>=3D0 && o<nPOut)
             pcmoutControl.Gain[o]=3Dn;
+        } else if (!strncmp("NominalOut ", str, 11)) {
+          sscanf(str+11, "%d %d", &o, &n);
+          if (o>=3D0 && o<fdOut)
+            NominalOut[o]=3D!!n;
+        } else if (!strncmp("NominalIn ", str, 10)) {
+          sscanf(str+10, "%d %d", &i, &n);
+          if (i>=3D0 && i<fdIn)
+            NominalIn[i]=3D!!n;
         } else if (!strncmp("Mixer ", str, 6)) {
           sscanf(str+6, "%d %d %d", &o, &i, &n);
           if (o>=3D0 && o<nLOut && i>=3D0 && i<nIn)
@@ -2074,8 +2050,8 @@
       gtk_box_pack_start(GTK_BOX(hbox), p4dbuIn[i], TRUE, FALSE, 1);
       gtk_widget_show(p4dbuIn[i]);
       gtk_signal_connect(GTK_OBJECT(p4dbuIn[i]), "toggled", GTK_SIGNAL_FUN=
C(Nominal_level_toggled), (gpointer)i);
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(p4dbuIn[i]), !Nominal=
In[i]);
     }
-    InitNominalLevelGUI(p4InId);
   }
=20
=20
@@ -2094,8 +2070,8 @@
       gtk_box_pack_start(GTK_BOX(hbox), p4dbuOut[i], TRUE, FALSE, 1);
       gtk_widget_show(p4dbuOut[i]);
       gtk_signal_connect(GTK_OBJECT(p4dbuOut[i]), "toggled", GTK_SIGNAL_FU=
NC(Nominal_level_toggled), (gpointer)(i+ECHO_MAXAUDIOINPUTS));
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(p4dbuOut[i]), !Nomina=
lOut[i]);
     }
-    InitNominalLevelGUI(p4OutId);
   }
=20
=20
@@ -2760,15 +2736,28 @@
         fprintf(f, "-- PcmOut <channel> <gain>\n");
         for (i=3D0; i<nPOut; i++)
           fprintf(f, "PcmOut %2d %d\n", i, pcmoutControl.Gain[i]);
-        fprintf(f, "-- Mixer <output> <input> <gain>\n");
-        for (o=3D0; o<nLOut; o++)
-          for (i=3D0; i<nIn; i++)
-            fprintf(f, "Mixer %2d %2d %d\n", o, i, mixerControl.mixer[o][i=
].Gain);
-        fprintf(f, "-- Vmixer <output> <vchannel> <gain>\n");
-        if (vmixerId)
+        if (p4InId) {
+          fprintf(f, "-- NominalIn <channel> <consumer level enabled>\n");
+          for (i=3D0; i<fdIn; i++)
+            fprintf(f, "NominalIn %2d %d\n", i, NominalIn[i]);
+        }
+        if (p4OutId) {
+          fprintf(f, "-- NominalOut <channel> <consumer level enabled>\n");
+          for (o=3D0; o<fdOut; o++)
+            fprintf(f, "NominalOut %2d %d\n", o, NominalOut[o]);
+        }
+        if (mixerId) {
+          fprintf(f, "-- Mixer <output> <input> <gain>\n");
+          for (o=3D0; o<nLOut; o++)
+            for (i=3D0; i<nIn; i++)
+              fprintf(f, "Mixer %2d %2d %d\n", o, i, mixerControl.mixer[o]=
[i].Gain);
+        }
+        if (vmixerId) {
+          fprintf(f, "-- Vmixer <output> <vchannel> <gain>\n");
           for (o=3D0; o<nLOut; o++)
             for (i=3D0; i<nPOut; i++)
               fprintf(f, "Vmixer %2d %2d %d\n", o, i, vmixerControl.mixer[=
o][i].Gain);
+        }
         fprintf(f, "-- xxWindow <x> <y> <width> <height> <visible>\n");
         fprintf(f, "MainWindow %d %d %d %d\n", Mainw_geom.x, Mainw_geom.y,=
 Mainw_geom.w, Mainw_geom.h);
         if (VUwindow)
@@ -2826,10 +2815,3 @@
   return(0);
 }
=20
-/*
-TODO:
-non controlla se c'=E8 mixerId e forse altri
-controllare tutorial su GdkColor e tracciamento
-*/
-
-


--
Giuliano.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
