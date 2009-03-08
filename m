From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/1] echomixer, fix vmixer GUI
Date: Sun, 8 Mar 2009 20:56:08 +0100
Message-ID: <20090308205608.02df2991.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out112.alice.it (smtp-out112.alice.it [85.37.17.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 62E5A24152
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 20:56:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch fixes several bugs in the vmixer GUI and removes the "misc"
button from the main window when the card has no global controls.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-tools-1.0.19/echomixer/echomixer.c__orig	2009-02-27 22:51:47.000000000 +0100
+++ alsa-tools-1.0.19/echomixer/echomixer.c	2009-03-01 16:29:42.000000000 +0100
@@ -129,38 +129,8 @@ struct mixel {
 snd_ctl_t *ctlhandle;
 
 
-#if __GNUC__ == 3		// gcc 2.x doesn't like unnamed unions inside structures
-
-struct mixerControl_s {
-  union {               // Currently selected channels
-    int vchannel;
-    int input;
-  };
-  union {               // Number of channels
-    int vchannels;
-    int inputs;
-  };
-  int output, outputs;
-  int id;
-  GtkWidget *window;
-  GtkWidget *volume[ECHO_MAXAUDIOOUTPUTS];
-  GtkWidget *label[ECHO_MAXAUDIOOUTPUTS];
-  GtkObject *adj[ECHO_MAXAUDIOOUTPUTS];
-  GtkWidget *outsel[ECHO_MAXAUDIOOUTPUTS];
-  union {
-    GtkWidget *inpsel[ECHO_MAXAUDIOINPUTS];
-    GtkWidget *vchsel[ECHO_MAXAUDIOOUTPUTS];
-  };
-  struct mixel mixer[ECHO_MAXAUDIOOUTPUTS][ECHO_MAXAUDIOOUTPUTS];
-} mixerControl, vmixerControl;
-
-#else
-
 struct mixerControl_s {
-  int vchannel;
-  int input;
-  int vchannels;
-  int inputs;
+  int input, inputs;
   int output, outputs;
   int id;
   GtkWidget *window;
@@ -173,9 +143,6 @@ struct mixerControl_s {
   struct mixel mixer[ECHO_MAXAUDIOOUTPUTS][ECHO_MAXAUDIOOUTPUTS];
 } mixerControl, vmixerControl;
 
-#endif
-
-
 struct VolumeControl_s {
   int input, output;				// Currently selected channels
   int inputs, outputs;
@@ -677,8 +644,8 @@ gint DrawMixer(gpointer unused) {
   gdk_draw_rectangle(Mixpixmap, gc, TRUE, XCELLTOT*(mixerControl.output+1), YCELLTOT*mixerControl.input, XCELLTOT, Mixheight);
   if (vmixerId) {
     gdk_gc_set_foreground(gc, &Hilight2);
-    gdk_draw_rectangle(Mixpixmap, gc, TRUE, 0, YCELLTOT*(GMixerSection.VmixerFirst+vmixerControl.vchannel), XCELLTOT*(vmixerControl.output+1), YCELLTOT);
-    gdk_draw_rectangle(Mixpixmap, gc, TRUE, XCELLTOT*(vmixerControl.output+1), YCELLTOT*(GMixerSection.VmixerFirst+vmixerControl.vchannel), XCELLTOT, Mixheight);
+    gdk_draw_rectangle(Mixpixmap, gc, TRUE, 0, YCELLTOT*(GMixerSection.VmixerFirst+vmixerControl.input), XCELLTOT*(vmixerControl.output+1), YCELLTOT);
+    gdk_draw_rectangle(Mixpixmap, gc, TRUE, XCELLTOT*(vmixerControl.output+1), YCELLTOT*(GMixerSection.VmixerFirst+vmixerControl.input), XCELLTOT, Mixheight);
   }
 
   // Draw the grid
@@ -720,7 +687,7 @@ gint DrawMixer(gpointer unused) {
 
   // Draw vchannels levels and peaks (Vmixer cards only)
   if (vmixerId) {
-    for (i=0; i<vmixerControl.vchannels; i++)
+    for (i=0; i<vmixerControl.inputs; i++)
       DrawBar(0, i+GMixerSection.VmixerFirst, VirLevel[i], VirPeak[i], DONT_DRAW);
   }
 
@@ -739,7 +706,7 @@ gint DrawMixer(gpointer unused) {
   // Draw vmixer elements (Vmixer cards only)
   if (vmixerId) {
     for (o=0; o<GMixerSection.Outputs; o++)
-      for (i=0; i<vmixerControl.vchannels; i++) {
+      for (i=0; i<vmixerControl.inputs; i++) {
         dB=Add_dB(vmixerControl.mixer[o][i].Gain, VirLevel[i]);
         DrawBar(o+1, i+GMixerSection.VmixerFirst, dB, DONT_DRAW, vmixerControl.mixer[o][i].Gain);
       }
@@ -945,7 +912,7 @@ static gint Gmixer_button_press(GtkWidge
   } else if (GMixerRow>=GMixerSection.VmixerFirst && GMixerRow<=GMixerSection.VmixerLast) {
     if (GMixerColumn!=vmixerControl.output)
       gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(vmixerControl.outsel[GMixerColumn]), TRUE);
-    if (GMixerRow!=vmixerControl.vchannel)
+    if (GMixerRow!=vmixerControl.input)
       gtk_widget_grab_focus(GTK_WIDGET(vmixerControl.volume[GMixerRow-GMixerSection.VmixerFirst]));
   }
 
@@ -967,13 +934,13 @@ static gint Gmixer_button_press(GtkWidge
     return TRUE;
 
   // See the note above
-  if (GMixerRow<GMixerSection.Inputs) {
+  if (GMixerRow<GMixerSection.VmixerFirst) {
     if (GMixerRow!=mixerControl.input)
       gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(mixerControl.inpsel[GMixerRow]), TRUE);
     if (GMixerColumn!=mixerControl.output)
       gtk_widget_grab_focus(GTK_WIDGET(mixerControl.volume[GMixerColumn]));
   } else if (GMixerRow>=GMixerSection.VmixerFirst && GMixerRow<=GMixerSection.VmixerLast) {
-    if (GMixerRow!=vmixerControl.vchannel)
+    if (GMixerRow!=vmixerControl.input+GMixerSection.VmixerFirst)
       gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(vmixerControl.vchsel[GMixerRow-GMixerSection.VmixerFirst]), TRUE);
     if (GMixerColumn!=vmixerControl.output)
       gtk_widget_grab_focus(GTK_WIDGET(vmixerControl.volume[GMixerColumn]));
@@ -1035,11 +1002,11 @@ static gint Gmixer_motion_notify(GtkWidg
     gtk_adjustment_set_value(GTK_ADJUSTMENT(mixerControl.adj[mixerControl.output]), (gfloat)val);
 #endif
   } else if (GMixerRow>=GMixerSection.VmixerFirst && GMixerRow<=GMixerSection.VmixerLast) {
-    val=INVERT(vmixerControl.mixer[vmixerControl.output][vmixerControl.vchannel].Gain);
+    val=INVERT(vmixerControl.mixer[vmixerControl.output][vmixerControl.input].Gain);
     val+=y-mouseY;
     mouseY=y;
 #ifdef REVERSE
-    gtk_adjustment_set_value(GTK_ADJUSTMENT(vmixerControl.adj[vmixerControl.vchannel]), (gfloat)val);
+    gtk_adjustment_set_value(GTK_ADJUSTMENT(vmixerControl.adj[vmixerControl.input]), (gfloat)val);
 #else
     gtk_adjustment_set_value(GTK_ADJUSTMENT(vmixerControl.adj[vmixerControl.output]), (gfloat)val);
 #endif
@@ -1259,7 +1226,7 @@ void Vmixer_volume_changed(GtkWidget *wi
   v=channel;
   o=vmixerControl.output;
 #else
-  v=vmixerControl.vchannel;
+  v=vmixerControl.input;
   o=channel;
 #endif
 
@@ -1281,8 +1248,8 @@ void Vmixer_volume_changed(GtkWidget *wi
 void Vmixer_volume_clicked(GtkWidget *widget, gpointer ch) {
 
 #ifdef REVERSE
-  vmixerControl.vchannel=(int)(long)ch;
-  UI_DEBUG(("Vmixer_volume_clicked vch=%d\n",vmixerControl.vchannel));
+  vmixerControl.input=(int)(long)ch;
+  UI_DEBUG(("Vmixer_volume_clicked vch=%d\n",vmixerControl.input));
 #else
   vmixerControl.output=(int)(long)ch;
   UI_DEBUG(("Vmixer_volume_clicked out=%d\n",vmixerControl.output));
@@ -1306,7 +1273,7 @@ void Vmixer_output_selector_clicked(GtkW
   snd_ctl_elem_id_alloca(&id);
   snd_ctl_elem_value_alloca(&control);
   snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
-  for (c=vmixerControl.vchannels-1; c>=0; c--) {
+  for (c=vmixerControl.inputs-1; c>=0; c--) {
     val=INVERT(vmixerControl.mixer[vmixerControl.output][c].Gain);
     gtk_adjustment_set_value(GTK_ADJUSTMENT(vmixerControl.adj[c]), (gfloat)val);
   }
@@ -1319,16 +1286,16 @@ void Vmixer_vchannel_selector_clicked(Gt
   snd_ctl_elem_id_t *id;
   snd_ctl_elem_value_t *control;
 
-  if (vmixerControl.vchannel==(int)(long)ch)
+  if (vmixerControl.input==(int)(long)ch)
     return;
-  vmixerControl.vchannel=(int)(long)ch;
+  vmixerControl.input=(int)(long)ch;
 
-  UI_DEBUG(("Vmixer_selector_clicked vch=%d\n",vmixerControl.vchannel));
+  UI_DEBUG(("Vmixer_selector_clicked vch=%d\n",vmixerControl.input));
   snd_ctl_elem_id_alloca(&id);
   snd_ctl_elem_value_alloca(&control);
   snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
   for (c=vmixerControl.outputs-1; c>=0; c--) {
-    val=INVERT(vmixerControl.mixer[c][vmixerControl.vchannel].Gain);
+    val=INVERT(vmixerControl.mixer[c][vmixerControl.input].Gain);
     gtk_adjustment_set_value(GTK_ADJUSTMENT(vmixerControl.adj[c]), (gfloat)val);
   }
 }
@@ -1722,7 +1689,7 @@ int OpenControls(const char *card, const
         vmixerId=vmixerControl.id=numid;
         CTLID_DEBUG(("First Vmixer id=%d\n", vmixerId));
         vmixerControl.outputs=snd_ctl_elem_info_get_dimension(info, 0);
-        vmixerControl.vchannels=snd_ctl_elem_info_get_dimension(info, 1);
+        vmixerControl.inputs=snd_ctl_elem_info_get_dimension(info, 1);
       }
     } else if (!strcmp("PCM Playback Volume", snd_ctl_elem_id_get_name(id))) {
       pcmoutId=pcmoutControl.id=numid;
@@ -1808,7 +1775,7 @@ int OpenControls(const char *card, const
 
 #ifndef REAL
 vmixerId=1000;
-vmixerControl.vchannels=12;
+vmixerControl.inputs=12;
 vmixerControl.outputs=mixerControl.outputs=nLOut=10;
 metersStreams=3;
 metersNumber=16;
@@ -1828,8 +1795,8 @@ printf("nIn=%d fdIn=%d nLOut=%d nPOut=%d
     printf("** Warning - Vmixer cards without LineOut volume control are not supported !\n");
 
   if (vmixerId) {
-    if (vmixerControl.vchannels!=nPOut || vmixerControl.outputs!=nLOut) {
-      printf("** Error - vmixer/channels mismatch:  vmp=%d npo=%d    vmo=%d nlo=%d !!\n", vmixerControl.vchannels, nPOut, vmixerControl.outputs, nLOut);
+    if (vmixerControl.inputs!=nPOut || vmixerControl.outputs!=nLOut) {
+      printf("** Error - vmixer/channels mismatch:  vmp=%d npo=%d    vmo=%d nlo=%d !!\n", vmixerControl.inputs, nPOut, vmixerControl.outputs, nLOut);
       return(1);
     }
   }
@@ -1850,7 +1817,7 @@ printf("nIn=%d fdIn=%d nLOut=%d nPOut=%d
 
   if (vmixerId)
     for (o=0, numid=vmixerId; o<vmixerControl.outputs; o++) {
-      for (i=0; i<vmixerControl.vchannels; i++) {
+      for (i=0; i<vmixerControl.inputs; i++) {
         vmixerControl.mixer[o][i].id=numid++;
       }
     }
@@ -1931,10 +1898,10 @@ printf("components = %s\n", snd_ctl_card
   Mixerw_geom.st=NOPOS;
   Vmixerw_geom.st=NOPOS;
   VUwindow=GMwindow=0;
-  GMixerSection.Inputs=fdIn+2;	// The correct value is set by Digital_mode_activate()
-  GMixerSection.Outputs=fdOut+2;
+  GMixerSection.Inputs=nIn;	// The correct value is set by Digital_mode_activate()
+  GMixerSection.Outputs=nLOut;
   GMixerSection.VmixerFirst=nIn;
-  GMixerSection.VmixerLast=nIn+vmixerControl.vchannels-1;
+  GMixerSection.VmixerLast=nIn+vmixerControl.inputs-1;
   GMixerSection.LineOut=GMixerSection.VmixerLast+1;
 
   // Read current mixer setting.
@@ -2523,7 +2490,7 @@ printf("components = %s\n", snd_ctl_card
     gtk_widget_show(hbox);
     gtk_container_add(GTK_CONTAINER(frame), hbox);
 
-    for (i=0; i<vmixerControl.vchannels; i++) {
+    for (i=0; i<vmixerControl.inputs; i++) {
       vbox=gtk_vbox_new(FALSE, 0);
       gtk_widget_show(vbox);
       gtk_container_add(GTK_CONTAINER(hbox), vbox);
@@ -2582,7 +2549,7 @@ printf("components = %s\n", snd_ctl_card
     gtk_container_add(GTK_CONTAINER(frame), vbsel);
 
     bgroup=0;
-    for (i=0; i<vmixerControl.vchannels; i++) {
+    for (i=0; i<vmixerControl.inputs; i++) {
       sprintf(str, "V%d", i);
       if (i)
         bgroup=gtk_radio_button_group(GTK_RADIO_BUTTON(vmixerControl.vchsel[i-1]));
@@ -2626,7 +2593,7 @@ printf("components = %s\n", snd_ctl_card
       gtk_box_pack_start(GTK_BOX(vbox), vmixerControl.label[i], FALSE, FALSE, 0);
     }
     gtk_widget_set_usize(GTK_WIDGET(vmixerControl.volume[0]), 0, 170);		// Set minimum y size
-    vmixerControl.vchannel=-1;
+    vmixerControl.input=-1;
     Vmixer_vchannel_selector_clicked(0, 0);
 #endif
   }
@@ -2693,13 +2660,15 @@ printf("components = %s\n", snd_ctl_card
     gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), TRUE);
 
   // Misc controls button
-  button=gtk_toggle_button_new_with_label("Misc");
-  gtk_widget_show(button);
-  gtk_box_pack_start(GTK_BOX(hbox), button, TRUE, TRUE, 1);
-  gtk_signal_connect(GTK_OBJECT(button), "toggled", ToggleWindow, (gpointer)Miscwindow);
-  Miscw_geom.toggler=button;
-  if (Miscw_geom.st==1)
-    gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), TRUE);
+  if (p4InId || p4OutId || phantomId || (dmodeId && ndmodes>1) || (clocksrcId && nclocksrc>1) || (spdifmodeId && nspdifmodes>1)) {
+    button=gtk_toggle_button_new_with_label("Misc");
+    gtk_widget_show(button);
+    gtk_box_pack_start(GTK_BOX(hbox), button, TRUE, TRUE, 1);
+    gtk_signal_connect(GTK_OBJECT(button), "toggled", ToggleWindow, (gpointer)Miscwindow);
+    Miscw_geom.toggler=button;
+    if (Miscw_geom.st==1)
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), TRUE);
+  }
 
   if (mixerId) {
     // Graphical mixer button



--
Giuliano.
