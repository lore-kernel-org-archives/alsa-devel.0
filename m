From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] 2/5 echomixer autoclock
Date: Sun, 3 Apr 2005 15:42:25 +0200
Message-ID: <20050403154225.002ce24a.pochini@shiny.it>
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


This patch:

- Adds the "autoclock" feature. When it's enabled echomixer automatically
switches between external and internal clock source if the cards receives,
or it doesn't, a valid clock signal, respectively.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-tools/echomixer/echomixer.c__orig	Thu Mar 31 19:57:02 2005
+++ alsa-tools/echomixer/echomixer.c	Sat Mar  5 15:49:53 2005
@@ -95,7 +95,7 @@
 char NominalIn[ECHO_MAXAUDIOINPUTS], NominalOut[ECHO_MAXAUDIOOUTPUTS];
 int nLOut, nIn, fdIn, fdOut, nPOut, ClockMask;
 int ndmodes, nclocksrc, nspdifmodes;
-int GMixerRow, GMixerColumn, Gang;
+int GMixerRow, GMixerColumn, Gang, AutoClock;
 int lineinId, pcmoutId, lineoutId, mixerId, vmixerId, p4InId, p4OutId, dmodeId, clocksrcId, spdifmodeId, vuswitchId, vumetersId, channelsId, phantomId;
 int metersStreams, metersNumber, metersTypes;
 int outvolCount;
@@ -189,7 +189,7 @@
 
 GtkWidget *p4dbuOut[ECHO_MAXAUDIOOUTPUTS], *p4dbuIn[ECHO_MAXAUDIOINPUTS];	// +4dBu/-10dBV toggles
 GtkWidget *clocksrc_menuitem[ECHO_CLOCKS];
-GtkWidget *dmodeOpt, *clocksrcOpt, *spdifmodeOpt, *phantomChkbutton;
+GtkWidget *dmodeOpt, *clocksrcOpt, *spdifmodeOpt, *phantomChkbutton, *autoclockChkbutton;
 GtkWidget *window, *Mainwindow, *Miscwindow, *LVwindow, *VUwindow, *GMwindow;
 GtkWidget *VUdarea, *Mixdarea;
 gint VUtimer, Mixtimer, clocksrctimer;
@@ -199,6 +199,9 @@
 static GdkPixmap *Mixpixmap = NULL;
 GdkFont *fnt;
 
+void Clock_source_activate(GtkWidget *widget, gpointer clk);
+
+
 
 int CountBits(int n) {
   int c;
@@ -570,11 +573,27 @@
 
 // Read what input clocks are valid and (de)activate the pop-down menu items accordingly
 gint CheckInputs(gpointer unused) {
-  int i;
+  int clk, valid, source;
 
   GetChannels();
-  for (i=0; i<nclocksrc; i++)
-    gtk_widget_set_sensitive(clocksrc_menuitem[i], !!(ClockMask & (1<<i)));
+  source=-1;
+
+  // Switch to internal if the source is not available
+  if (AutoClock>=0 && !(ClockMask & (1<<clocksrcVal)))
+    source=0;
+
+  for (clk=0; clk<nclocksrc; clk++) {
+    valid=!!(ClockMask & (1<<clk));
+    gtk_widget_set_sensitive(clocksrc_menuitem[clk], valid);
+    if (clk==AutoClock && valid)
+      source=AutoClock;
+  }
+
+  if (source>=0 && source!=clocksrcVal) {
+    // Set the clock source, but do not change the value of AutoClock
+    Clock_source_activate(clocksrc_menuitem[source], (gpointer)(source|DONT_CHANGE));
+    gtk_option_menu_set_history(GTK_OPTION_MENU(clocksrcOpt), clocksrcVal);
+  }
   return(TRUE);
 }
 
@@ -1378,17 +1397,37 @@
 
 
 
+void AutoClock_toggled(GtkWidget *widget, gpointer unused) {
+  char str[32];
+
+  if (gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(widget))) {
+    AutoClock=clocksrcVal;
+    snprintf(str, 31, "Autoclock [%s]", clocksrcName[AutoClock]);
+    str[31]=0;
+    gtk_label_set_text(GTK_LABEL(GTK_BIN(widget)->child), str);
+  } else {
+    AutoClock=-1;
+    gtk_label_set_text(GTK_LABEL(GTK_BIN(widget)->child), "Autoclock");
+  }
+
+}
+
+
+
 void Digital_mode_activate(GtkWidget *widget, gpointer mode) {
   int adat;
 
-  if (SetEnum(dmodeId, (int)mode)<0)
+  if (SetEnum(dmodeId, (int)mode)<0) {
     // Restore old value if it failed
     gtk_option_menu_set_history(GTK_OPTION_MENU(dmodeOpt), dmodeVal);
-  else {
-    dmodeVal=(int)mode;
-    // When I change the digital mode, the clock source can change too
-    gtk_option_menu_set_history(GTK_OPTION_MENU(clocksrcOpt), clocksrcVal=GetEnum(clocksrcId));
+    return;
   }
+
+  dmodeVal=(int)mode;
+  // When I change the digital mode, the clock source can change too
+  clocksrcVal=GetEnum(clocksrcId);
+  gtk_option_menu_set_history(GTK_OPTION_MENU(clocksrcOpt), clocksrcVal);
+
   adat=!memcmp(dmodeName[dmodeVal], "ADAT", 4);
   SetSensitivity(adat);
   if (adat) {
@@ -1403,11 +1442,19 @@
 
 
 void Clock_source_activate(GtkWidget *widget, gpointer clk) {
+  unsigned int source;
 
-  if (SetEnum(clocksrcId, (int)clk)<0)
+  source=(unsigned int)clk & 0xff;
+  if (SetEnum(clocksrcId, source)<0) {
     gtk_option_menu_set_history(GTK_OPTION_MENU(clocksrcOpt), clocksrcVal);
-  else
-    clocksrcVal=(int)clk;
+  } else {
+    clocksrcVal=(int)clk & 0xff;
+    // Change only when the user triggers it
+    if (((int)clk & DONT_CHANGE)==0 && AutoClock>=0) {
+      AutoClock=clocksrcVal;
+      AutoClock_toggled(autoclockChkbutton, NULL);
+    }
+  }
 }
 
 
@@ -2144,7 +2191,7 @@
 
 
   // Switches
-  if (phantomId) {
+  if (phantomId || clocksrcId) {
     frame=gtk_frame_new("Switches");
     gtk_widget_show(frame);
     gtk_box_pack_start(GTK_BOX(mainbox), frame, TRUE, FALSE, 0);
@@ -2160,6 +2207,15 @@
       gtk_signal_connect(GTK_OBJECT(phantomChkbutton), "toggled", PhantomPower_toggled, NULL);
       InitPhantomPowerGUI(phantomId);
     }
+
+    // Auto clock switch
+    if (clocksrcId) {
+      autoclockChkbutton=gtk_check_button_new_with_label("Autoclock");
+      gtk_widget_show(autoclockChkbutton);
+      gtk_box_pack_start(GTK_BOX(hbox), autoclockChkbutton, TRUE, FALSE, 0);
+      gtk_signal_connect(GTK_OBJECT(autoclockChkbutton), "toggled", AutoClock_toggled, NULL);
+      AutoClock=-1;
+    }
   }
 
 

--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
