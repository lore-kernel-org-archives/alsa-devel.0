From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echomixer update 3/4
Date: Sun, 16 Jan 2005 20:01:25 +0100
Message-ID: <20050116200125.225e730f.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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



- Code cleanup: remove some redundant variables.

- Enhancement: The matrix mixer ignores mouse clicks that don't fall inside
enabled mixer cells.



Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-tools/echomixer/echomixer.c_old	Sat Jan 15 17:43:54 2005
+++ alsa-tools/echomixer/echomixer.c	Sun Jan 16 19:30:50 2005
@@ -114,9 +114,10 @@
 
 // This structure contains the first and the last row of each section of the graphic mixer window
 struct {
-  int Monitor;	// The first is always 0
-  int VmixerFirst, VmixerLast;
-  int LineOut;	// There is only one row
+  int VmixerFirst, VmixerLast;	// Rows
+  int LineOut;			// There is only one row
+  int Inputs;			// Rows
+  int Outputs;			// Columns
 } GMixerSection;
 
 struct mixel {
@@ -255,12 +256,6 @@
 
 
 
-int ADATmode() {
-  return(!memcmp(dmodeName[dmodeVal], "ADAT", 4));
-}
-
-
-
 // Write an enumerated ALSA control
 int SetEnum(int numid, int val) {
   int err;
@@ -638,20 +633,12 @@
   static int InClip[ECHO_MAXAUDIOINPUTS];
   static int OutClip[ECHO_MAXAUDIOOUTPUTS];
   char str[8];
-  int i, o, dB, inchannels, outchannels;
+  int i, o, dB;
   GdkColor Grid={0x787878, 0, 0, 0};
   GdkColor Labels={0x9694C4, 0, 0, 0};
   GdkColor Hilight={0x000078, 0, 0, 0};
   GdkColor Hilight2={0x600000, 0, 0, 0};
 
-  if (ADATmode()) {
-    inchannels=nIn;
-    outchannels=nLOut;
-  } else {
-    inchannels=fdIn+2;
-    outchannels=fdOut+2;
-  }
-
   if (!Mixpixmap)
     return(TRUE);
 
@@ -715,7 +702,7 @@
   gdk_draw_rectangle(Mixpixmap, gc, TRUE, 0, YCELLTOT*(GMixerSection.LineOut+1)-1, Mixwidth, 1);
 
   // Draw input levels and peaks
-  for (i=0; i<inchannels; i++)
+  for (i=0; i<GMixerSection.Inputs; i++)
     DrawBar(0, i, InLevel[i], InPeak[i], DONT_DRAW);
 
   // Draw vchannels levels and peaks (Vmixer cards only)
@@ -725,12 +712,12 @@
   }
 
   // Draw output levels, peaks and volumes
-  for (o=0; o<outchannels; o++)
+  for (o=0; o<GMixerSection.Outputs; o++)
     DrawBar(o+1, GMixerSection.LineOut, OutLevel[o], OutPeak[o], lineoutControl.Gain[o]);
 
   // Draw monitor mixer elements
-  for (o=0; o<outchannels; o++) {
-    for (i=0; i<inchannels; i++) {
+  for (o=0; o<GMixerSection.Outputs; o++) {
+    for (i=0; i<GMixerSection.Inputs; i++) {
       dB=Add_dB(mixerControl.mixer[o][i].Gain, InLevel[i]);
       DrawBar(o+1, i, dB, DONT_DRAW, mixerControl.mixer[o][i].Gain);
     }
@@ -738,7 +725,7 @@
 
   // Draw vmixer elements (Vmixer cards only)
   if (vmixerId) {
-    for (o=0; o<outchannels; o++)
+    for (o=0; o<GMixerSection.Outputs; o++)
       for (i=0; i<vmixerControl.vchannels; i++)
         DrawBar(o+1, i+GMixerSection.VmixerFirst, VirLevel[i], DONT_DRAW, vmixerControl.mixer[o][i].Gain);
   }
@@ -926,24 +913,23 @@
   GMixerRow=(int)event->y/YCELLTOT;
   GMixerColumn=(int)event->x/XCELLTOT-1;
 
+  if (GMixerColumn<0 || GMixerColumn>=GMixerSection.Outputs)
+    return TRUE;
+
   /* grab_focus must follow set_active because the latter causes
      Vmixer_*_selector_clicked() to be called and, in turn,
      Vmixer_volume_changed() which changes mixerControl.input
      (or .output in non-reverse mode). grab_focus then causes
      Vmixer_volume_clicked() to be called and that event handler
      finally sets the correct value of mixerControl.input */
-  if (GMixerRow<=GMixerSection.Monitor) {
-    if (GMixerColumn!=mixerControl.output && GMixerColumn>=0) {
-      if (GMixerColumn<fdOut+2 || (ADATmode() && GMixerColumn<nLOut))
-        gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(mixerControl.outsel[GMixerColumn]), TRUE);
-    }
+  if (GMixerRow<GMixerSection.Inputs) {
+    if (GMixerColumn!=mixerControl.output)
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(mixerControl.outsel[GMixerColumn]), TRUE);
     if (GMixerRow!=mixerControl.input)
       gtk_widget_grab_focus(GTK_WIDGET(mixerControl.volume[GMixerRow]));
   } else if (GMixerRow>=GMixerSection.VmixerFirst && GMixerRow<=GMixerSection.VmixerLast) {
-    if (GMixerColumn!=vmixerControl.output && GMixerColumn>=0) {
-      if (GMixerColumn<fdOut+2 || (ADATmode() && GMixerColumn<vmixerControl.outputs))
-        gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(vmixerControl.outsel[GMixerColumn]), TRUE);
-    }
+    if (GMixerColumn!=vmixerControl.output)
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(vmixerControl.outsel[GMixerColumn]), TRUE);
     if (GMixerRow!=vmixerControl.vchannel)
       gtk_widget_grab_focus(GTK_WIDGET(vmixerControl.volume[GMixerRow-GMixerSection.VmixerFirst]));
   }
@@ -962,21 +948,20 @@
   GMixerRow=(int)event->y/YCELLTOT;
   GMixerColumn=(int)event->x/XCELLTOT-1;
 
+  if (GMixerColumn<0 || GMixerColumn>=GMixerSection.Outputs)
+    return TRUE;
+
   // See the note above
-  if (GMixerRow<=GMixerSection.Monitor) {
+  if (GMixerRow<GMixerSection.Inputs) {
     if (GMixerRow!=mixerControl.input)
       gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(mixerControl.inpsel[GMixerRow]), TRUE);
-    if (GMixerColumn!=mixerControl.output && GMixerColumn>=0) {
-      if (GMixerColumn<fdOut+2 || (ADATmode() && GMixerColumn<nLOut))
-        gtk_widget_grab_focus(GTK_WIDGET(mixerControl.volume[GMixerColumn]));
-    }
+    if (GMixerColumn!=mixerControl.output)
+      gtk_widget_grab_focus(GTK_WIDGET(mixerControl.volume[GMixerColumn]));
   } else if (GMixerRow>=GMixerSection.VmixerFirst && GMixerRow<=GMixerSection.VmixerLast) {
     if (GMixerRow!=vmixerControl.vchannel)
       gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(vmixerControl.vchsel[GMixerRow-GMixerSection.VmixerFirst]), TRUE);
-    if (GMixerColumn!=vmixerControl.output && GMixerColumn>=0) {
-      if (GMixerColumn<fdOut+2 || (ADATmode() && GMixerColumn<vmixerControl.outputs))
-        gtk_widget_grab_focus(GTK_WIDGET(vmixerControl.volume[GMixerColumn]));
-    }
+    if (GMixerColumn!=vmixerControl.output)
+      gtk_widget_grab_focus(GTK_WIDGET(vmixerControl.volume[GMixerColumn]));
   }
 
   if (event->button==1) {
@@ -999,6 +984,8 @@
 
 
 
+// Gets how many pixels the mouse pointer was moved of and updates
+// the currently active mixer/vmixer/line_out control.
 static gint Gmixer_motion_notify(GtkWidget *widget, GdkEventMotion *event) {
   int x, y;
   GdkModifierType state;
@@ -1012,42 +999,40 @@
     state=event->state;
   }
 
-  // Check if the button is still pressed because the release event can fall in another window, so we may miss it.
-  if (!(state & GDK_BUTTON1_MASK))
+  // Check if the button is still pressed because the release event can
+  // fall in another window, so we may miss it. Ignore the event if there
+  // isn't a backing pixmap or the user clicked an invalid cell. We also
+  // have to check mouseButton because the button_press event may arrive
+  // after the respective motion_notify event.
+  if (!(state & GDK_BUTTON1_MASK) || !mouseButton || !Mixpixmap || GMixerColumn<0 || GMixerColumn>=GMixerSection.Outputs) {
     mouseButton=0;
+    return(TRUE);
+  }
 
-  if (GMixerRow<=GMixerSection.Monitor) {
-    if (mouseButton && Mixpixmap != NULL) {
-      val=INVERT(mixerControl.mixer[mixerControl.output][mixerControl.input].Gain);
-      val+=y-mouseY;
-      mouseY=y;
-      // Gtk already limits the range of "val"
+  if (GMixerRow<GMixerSection.Inputs) {
+    val=INVERT(mixerControl.mixer[mixerControl.output][mixerControl.input].Gain);
+    val+=y-mouseY;
+    mouseY=y;
+    // Gtk already limits the range of "val"
 #ifdef REVERSE
-      gtk_adjustment_set_value(GTK_ADJUSTMENT(mixerControl.adj[mixerControl.input]), (gfloat)val);
+    gtk_adjustment_set_value(GTK_ADJUSTMENT(mixerControl.adj[mixerControl.input]), (gfloat)val);
 #else
-      gtk_adjustment_set_value(GTK_ADJUSTMENT(mixerControl.adj[mixerControl.output]), (gfloat)val);
+    gtk_adjustment_set_value(GTK_ADJUSTMENT(mixerControl.adj[mixerControl.output]), (gfloat)val);
 #endif
-    }
   } else if (GMixerRow>=GMixerSection.VmixerFirst && GMixerRow<=GMixerSection.VmixerLast) {
-    if (mouseButton && Mixpixmap != NULL) {
-      val=INVERT(vmixerControl.mixer[vmixerControl.output][vmixerControl.vchannel].Gain);
-      val+=y-mouseY;
-      mouseY=y;
-      // Gtk already limits the range of "val"
+    val=INVERT(vmixerControl.mixer[vmixerControl.output][vmixerControl.vchannel].Gain);
+    val+=y-mouseY;
+    mouseY=y;
 #ifdef REVERSE
-      gtk_adjustment_set_value(GTK_ADJUSTMENT(vmixerControl.adj[vmixerControl.vchannel]), (gfloat)val);
+    gtk_adjustment_set_value(GTK_ADJUSTMENT(vmixerControl.adj[vmixerControl.vchannel]), (gfloat)val);
 #else
-      gtk_adjustment_set_value(GTK_ADJUSTMENT(vmixerControl.adj[vmixerControl.output]), (gfloat)val);
+    gtk_adjustment_set_value(GTK_ADJUSTMENT(vmixerControl.adj[vmixerControl.output]), (gfloat)val);
 #endif
-    }
   } else if (GMixerRow==GMixerSection.LineOut) {
-    if (mouseButton && Mixpixmap != NULL) {
-      val=INVERT(lineoutControl.Gain[GMixerColumn]);
-      val+=y-mouseY;
-      mouseY=y;
-      // Gtk already limits the range of "val"
-      gtk_adjustment_set_value(GTK_ADJUSTMENT(lineoutControl.adj[GMixerColumn]), (gfloat)val);
-    }
+    val=INVERT(lineoutControl.Gain[GMixerColumn]);
+    val+=y-mouseY;
+    mouseY=y;
+    gtk_adjustment_set_value(GTK_ADJUSTMENT(lineoutControl.adj[GMixerColumn]), (gfloat)val);
   }
 
   return(TRUE);
@@ -1403,12 +1388,15 @@
     // When I change the digital mode, the clock source can change too
     gtk_option_menu_set_history(GTK_OPTION_MENU(clocksrcOpt), clocksrcVal=GetEnum(clocksrcId));
   }
-  adat=ADATmode();
+  adat=!memcmp(dmodeName[dmodeVal], "ADAT", 4);
   SetSensitivity(adat);
-  if (adat)
-    GMixerSection.Monitor=nIn-1;
-  else
-    GMixerSection.Monitor=fdIn+2-1;	// S/PDIF has only 2 channels
+  if (adat) {
+    GMixerSection.Inputs=nIn;
+    GMixerSection.Outputs=nLOut;
+  } else {
+    GMixerSection.Inputs=fdIn+2;	// S/PDIF has only 2 channels
+    GMixerSection.Outputs=fdOut+2;
+  }
 }
 
 
@@ -1811,12 +1799,11 @@
 #ifndef REAL
 vmixerId=1000;
 vmixerControl.vchannels=12;
-vmixerControl.outputs=mixerControl.outputs=10;
+vmixerControl.outputs=mixerControl.outputs=nLOut=10;
 metersStreams=3;
 metersNumber=16;
 metersTypes=2;
 nPOut=12;
-nLOut=10;
 fdOut=2;
 nIn=10;
 fdIn=2;
@@ -1928,7 +1915,8 @@
   Mixerw_geom.st=NOPOS;
   Vmixerw_geom.st=NOPOS;
   VUwindow=GMwindow=0;
-  GMixerSection.Monitor=fdIn+2-1;	// The correct value is set by Digital_mode_activate()
+  GMixerSection.Inputs=fdIn+2;	// The correct value is set by Digital_mode_activate()
+  GMixerSection.Outputs=fdOut+2;
   GMixerSection.VmixerFirst=nIn;
   GMixerSection.VmixerLast=nIn+vmixerControl.vchannels-1;
   GMixerSection.LineOut=GMixerSection.VmixerLast+1;





--
Giuliano.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
