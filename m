From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] 1/5 echomixer GUI changes
Date: Sun, 3 Apr 2005 15:42:10 +0200
Message-ID: <20050403154210.4eb3cc24.pochini@shiny.it>
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


The following patch:

- Adds a frame that will hold many switches.

- Replaces the phantom power toggle button with a checkbutton inside the
frame.



Signed-off-by: Giuliano Pochini <pochini@shiny.it>


--- alsa-tools/echomixer/echomixer.c__orig	Sat Mar  5 14:32:43 2005
+++ alsa-tools/echomixer/echomixer.c	Thu Mar 31 19:57:02 2005
@@ -104,6 +104,7 @@
 int VUwidth, VUheight, Mixwidth, Mixheight;
 
 #define DONT_DRAW (ECHOGAIN_MUTED-1)
+#define DONT_CHANGE (1<<31)
 #define NOPOS 999999
 struct geometry {
   int st;		// window status: 0 = hidden ; 1 = visible ; NOPOS = no stored setting
@@ -188,7 +189,7 @@
 
 GtkWidget *p4dbuOut[ECHO_MAXAUDIOOUTPUTS], *p4dbuIn[ECHO_MAXAUDIOINPUTS];	// +4dBu/-10dBV toggles
 GtkWidget *clocksrc_menuitem[ECHO_CLOCKS];
-GtkWidget *dmodeOpt, *clocksrcOpt, *spdifmodeOpt, *phantomToggle;
+GtkWidget *dmodeOpt, *clocksrcOpt, *spdifmodeOpt, *phantomChkbutton;
 GtkWidget *window, *Mainwindow, *Miscwindow, *LVwindow, *VUwindow, *GMwindow;
 GtkWidget *VUdarea, *Mixdarea;
 gint VUtimer, Mixtimer, clocksrctimer;
@@ -447,7 +448,7 @@
   snd_ctl_elem_value_set_id(control, id);
   if ((err=snd_ctl_elem_read(ctlhandle, control))<0)
     printf("Control %s element read error: %s\n", card, snd_strerror(err));
-  gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(phantomToggle), snd_ctl_elem_value_get_integer(control, 0));
+  gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(phantomChkbutton), snd_ctl_elem_value_get_integer(control, 0));
 }
 
 
@@ -2142,20 +2143,23 @@
   }
 
 
+  // Switches
   if (phantomId) {
-    // Phantom power switch
-    frame=gtk_frame_new("Phantom power");
+    frame=gtk_frame_new("Switches");
     gtk_widget_show(frame);
     gtk_box_pack_start(GTK_BOX(mainbox), frame, TRUE, FALSE, 0);
-    hbox=gtk_hbox_new(FALSE, 0);
+    hbox=gtk_vbox_new(FALSE, 0);
     gtk_widget_show(hbox);
     gtk_container_add(GTK_CONTAINER(frame), hbox);
 
-    phantomToggle=gtk_toggle_button_new_with_label("On");
-    gtk_widget_show(phantomToggle);
-    gtk_box_pack_start(GTK_BOX(hbox), phantomToggle, TRUE, FALSE, 0);
-    gtk_signal_connect(GTK_OBJECT(phantomToggle), "toggled", PhantomPower_toggled, (gpointer)0);
-    InitPhantomPowerGUI(phantomId);
+    if (phantomId) {
+      // Phantom power switch
+      phantomChkbutton=gtk_check_button_new_with_label("Phantom power");
+      gtk_widget_show(phantomChkbutton);
+      gtk_box_pack_start(GTK_BOX(hbox), phantomChkbutton, TRUE, FALSE, 0);
+      gtk_signal_connect(GTK_OBJECT(phantomChkbutton), "toggled", PhantomPower_toggled, NULL);
+      InitPhantomPowerGUI(phantomId);
+    }
   }
 
 



--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
