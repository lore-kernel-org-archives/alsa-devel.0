From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] 4/5 echomixer automute
Date: Sun, 3 Apr 2005 15:42:42 +0200
Message-ID: <20050403154242.73a2ac24.pochini@shiny.it>
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

- Adds support for the digital input automute control.

- Some minor cleanup.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-tools/echomixer/echomixer.c__orig	Sat Mar  5 17:37:56 2005
+++ alsa-tools/echomixer/echomixer.c	Thu Mar 31 20:40:29 2005
@@ -95,7 +95,8 @@
 int nLOut, nIn, fdIn, fdOut, nPOut, ClockMask;
 int ndmodes, nclocksrc, nspdifmodes;
 int GMixerRow, GMixerColumn, Gang, AutoClock;
-int lineinId, pcmoutId, lineoutId, mixerId, vmixerId, p4InId, p4OutId, dmodeId, clocksrcId, spdifmodeId, vuswitchId, vumetersId, channelsId, phantomId;
+int lineinId, pcmoutId, lineoutId, mixerId, vmixerId, p4InId, p4OutId, dmodeId;
+int clocksrcId, spdifmodeId, vuswitchId, vumetersId, channelsId, phantomId, automuteId;
 int metersStreams, metersNumber, metersTypes;
 int outvolCount;
 int mouseY, mouseButton;
@@ -193,6 +194,12 @@
   GtkWidget *Button[ECHO_MAXAUDIOINPUTS];
 } NominalIn, NominalOut;
 
+struct SwitchControl_s {
+  int id;
+  int value;
+  GtkWidget *Button;
+} PhantomPower, Automute;
+
 GtkWidget *clocksrc_menuitem[ECHO_CLOCKS];
 GtkWidget *dmodeOpt, *clocksrcOpt, *spdifmodeOpt, *phantomChkbutton, *autoclockChkbutton;
 GtkWidget *window, *Mainwindow, *Miscwindow, *LVwindow, *VUwindow, *GMwindow;
@@ -443,42 +450,25 @@
 
 
 
-// At startup this functions reads if the dithering is enabled sets the button accordingly.
-void InitPhantomPowerGUI(int numid) {
-  snd_ctl_elem_id_t *id;
-  snd_ctl_elem_value_t *control;
-  int err;
-
-  snd_ctl_elem_id_alloca(&id);
-  snd_ctl_elem_value_alloca(&control);
-  snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_CARD);
-  snd_ctl_elem_id_set_numid(id, phantomId);
-  snd_ctl_elem_value_set_id(control, id);
-  if ((err=snd_ctl_elem_read(ctlhandle, control))<0)
-    printf("Control %s element read error: %s\n", card, snd_strerror(err));
-  gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(phantomChkbutton), snd_ctl_elem_value_get_integer(control, 0));
-}
-
-
-
 // Read current control settings.
-void ReadControl(int *vol, int channels, int volId) {
+int ReadControl(int *vol, int channels, int numid, int iface) {
   snd_ctl_elem_id_t *id;
   snd_ctl_elem_value_t *control;
   int err, ch;
 
   snd_ctl_elem_id_alloca(&id);
   snd_ctl_elem_value_alloca(&control);
-  snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
-  snd_ctl_elem_id_set_numid(id, volId);
+  snd_ctl_elem_id_set_interface(id, iface);
+  snd_ctl_elem_id_set_numid(id, numid);
   snd_ctl_elem_value_set_id(control, id);
   if ((err=snd_ctl_elem_read(ctlhandle, control))<0) {
     printf("Control %s element read error: %s\n", card, snd_strerror(err));
-    return;
+    return(err);
   }
 
   for (ch=0; ch<channels; ch++)
     vol[ch]=snd_ctl_elem_value_get_integer(control, ch);
+  return(0);
 }
 
 
@@ -1378,22 +1368,22 @@
 
 
 
-void PhantomPower_toggled(GtkWidget *widget, gpointer unused) {
+void Switch_toggled(GtkWidget *widget, gpointer Ctl) {
   snd_ctl_elem_id_t *id;
   snd_ctl_elem_value_t *control;
-  int err, val;
+  int err;
+  struct SwitchControl_s *Switch=(struct SwitchControl_s *)Ctl;
 
   snd_ctl_elem_id_alloca(&id);
   snd_ctl_elem_value_alloca(&control);
 
-  val=gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(widget));
+  Switch->value=gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(widget));
   snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_CARD);
-  snd_ctl_elem_id_set_numid(id, phantomId);
+  snd_ctl_elem_id_set_numid(id, Switch->id);
   snd_ctl_elem_value_set_id(control, id);
-  snd_ctl_elem_value_set_integer(control, 0, val);
-  if ((err=snd_ctl_elem_write(ctlhandle, control))<0) {
+  snd_ctl_elem_value_set_integer(control, 0, Switch->value);
+  if ((err=snd_ctl_elem_write(ctlhandle, control))<0)
     printf("Control %s element write error: %s\n", card, snd_strerror(err));
-  }
 }
 
 
@@ -1789,8 +1779,11 @@
         CTLID_DEBUG(("S/PDIF Mode id=%d item #%u '%s'\n", numid, item, snd_ctl_elem_info_get_item_name(info)));
       }
     } else if (!strcmp("Phantom power Switch", snd_ctl_elem_id_get_name(id))) {
-      phantomId=numid;
+      phantomId=PhantomPower.id=numid;
       CTLID_DEBUG(("Phantom power Switch id=%d\n", numid));
+    } else if (!strcmp("Digital Capture Switch (automute)", snd_ctl_elem_id_get_name(id))) {
+      automuteId=Automute.id=numid;
+      CTLID_DEBUG(("Automute Switch id=%d\n", numid));
     } else if (!strcmp("VU-meters Switch", snd_ctl_elem_id_get_name(id))) {
       vuswitchId=numid;
       CTLID_DEBUG(("VU-meter switch id=%d\n", numid));
@@ -1948,11 +1941,11 @@
   if (vmixerId)
     ReadMixer(&vmixerControl);
   if (pcmoutId)
-    ReadControl(pcmoutControl.Gain, nPOut, pcmoutControl.id);
+    ReadControl(pcmoutControl.Gain, nPOut, pcmoutControl.id, SND_CTL_ELEM_IFACE_MIXER);
   if (lineinId)
-    ReadControl(lineinControl.Gain, nIn, lineinControl.id);
+    ReadControl(lineinControl.Gain, nIn, lineinControl.id, SND_CTL_ELEM_IFACE_MIXER);
   if (lineoutId)
-    ReadControl(lineoutControl.Gain, nLOut, lineoutId);
+    ReadControl(lineoutControl.Gain, nLOut, lineoutId, SND_CTL_ELEM_IFACE_MIXER);
   if (p4InId)
     ReadNominalLevels(&NominalIn);
   if (p4OutId)
@@ -2172,11 +2165,24 @@
 
     if (phantomId) {
       // Phantom power switch
-      phantomChkbutton=gtk_check_button_new_with_label("Phantom power");
-      gtk_widget_show(phantomChkbutton);
-      gtk_box_pack_start(GTK_BOX(hbox), phantomChkbutton, TRUE, FALSE, 0);
-      gtk_signal_connect(GTK_OBJECT(phantomChkbutton), "toggled", PhantomPower_toggled, NULL);
-      InitPhantomPowerGUI(phantomId);
+      button=gtk_check_button_new_with_label("Phantom power");
+      gtk_widget_show(button);
+      gtk_box_pack_start(GTK_BOX(hbox), button, TRUE, FALSE, 0);
+      ReadControl(&i, 1, PhantomPower.id, SND_CTL_ELEM_IFACE_MIXER);
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), i);
+      gtk_signal_connect(GTK_OBJECT(button), "toggled", Switch_toggled, (gpointer)&PhantomPower);
+      PhantomPower.Button=button;
+    }
+
+    if (automuteId) {
+      // Digital input automute switch
+      button=gtk_check_button_new_with_label("Automute");
+      gtk_widget_show(button);
+      gtk_box_pack_start(GTK_BOX(hbox), button, TRUE, FALSE, 0);
+      ReadControl(&i, 1, Automute.id, SND_CTL_ELEM_IFACE_CARD);
+      gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(button), i);
+      gtk_signal_connect(GTK_OBJECT(button), "toggled", Switch_toggled, (gpointer)&Automute);
+      Automute.Button=button;
     }
 
     // Auto clock switch


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
