From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/1] echomixer: Fix echomixer to work with the
	new drivers
Date: Sun, 15 Mar 2009 21:35:09 +0100
Message-ID: <20090315213509.76f05f29.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out28.alice.it (smtp-out28.alice.it [85.33.2.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FE621037EA
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 21:35:00 +0100 (CET)
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

There is a long standing bug in the drivers for cards with a vmixer because
I overlooked a detail in the c++ generic driver by echoaudio. Those cards
do not have a line-out volume control. It is a virtual control provided by
the generic driver. The bug is harmless because the DSP just ignores the
command to change the volume.
Since that control has been removed, echomixer must be updated. With this
patch it uses the vmixer to fake the line-out volume.


This patch makes echomixer work with the new drivers.

Signed-off-by Giuliano Pochini <pochini@shiny.it>

--- alsa-tools-1.0.19/echomixer/echomixer.c__orig2	2009-03-15 19:03:24.000000000 +0100
+++ alsa-tools-1.0.19/echomixer/echomixer.c	2009-03-15 19:36:23.000000000 +0100
@@ -1178,6 +1178,29 @@ void UpdateMixerVolume(int outchannel) {
 
 
 
+// Changes the vmixer volume according to the current Line-out volume for vmixer cards.
+void UpdateVMixerVolume(int outchannel) {
+  snd_ctl_elem_id_t *id;
+  snd_ctl_elem_value_t *control;
+  int err, val, ch;
+
+  snd_ctl_elem_id_alloca(&id);
+  snd_ctl_elem_value_alloca(&control);
+  snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
+
+  for (ch=0; ch<nPOut; ch++) {
+    val=Add_dB(vmixerControl.mixer[outchannel][ch].Gain, lineoutControl.Gain[outchannel]);
+    ClampOutputVolume(&val);
+    snd_ctl_elem_id_set_numid(id, vmixerControl.mixer[outchannel][ch].id);
+    snd_ctl_elem_value_set_id(control, id);
+    snd_ctl_elem_value_set_integer(control, 0, val);
+    if ((err = snd_ctl_elem_write(ctlhandle, control)) < 0)
+      printf("Control %s element write error: %s\n", card, snd_strerror(err));
+  }
+}
+
+
+
 void LineOut_volume_changed(GtkWidget *widget, gpointer ch) {
   char str[16];
   int err, channel, val;
@@ -1204,6 +1227,9 @@ void LineOut_volume_changed(GtkWidget *w
      snd_ctl_elem_value_set_integer(control, channel, val);
      if ((err=snd_ctl_elem_write(ctlhandle, control))<0)
        printf("Control %s element write error: %s\n", card, snd_strerror(err));
+  } else if (vmixerId) {
+    UpdateVMixerVolume(channel);
+    UpdateMixerVolume(channel);
   } else {		// Otherwise we have to emulate it.
     UpdatePCMVolume(channel);
     UpdateMixerVolume(channel);
@@ -1217,10 +1243,11 @@ void LineOut_volume_changed(GtkWidget *w
 
 void Vmixer_volume_changed(GtkWidget *widget, gpointer ch) {
   char str[16];
-  int val, channel;
+  int val, rval, channel;
   int o, v;
 
   channel=(int)(long)ch;
+  val=INVERT((int)GTK_ADJUSTMENT(widget)->value);
 
 #ifdef REVERSE
   v=channel;
@@ -1230,13 +1257,17 @@ void Vmixer_volume_changed(GtkWidget *wi
   o=channel;
 #endif
 
-  val=INVERT((int)GTK_ADJUSTMENT(widget)->value);
+  // Emulate the line-out volume if this card can't do it in hw.
+  if (!lineoutId) {
+    rval=Add_dB(val, lineoutControl.Gain[o]);
+    ClampOutputVolume(&rval);
+  }
 
-  SetMixerGain(&vmixerControl.mixer[o][v], val);
+  SetMixerGain(&vmixerControl.mixer[o][v], rval);
   vmixerControl.mixer[o][v].Gain=val;
 
   if (Gang) {
-    SetMixerGain(&vmixerControl.mixer[o^1][v^1], val);
+    SetMixerGain(&vmixerControl.mixer[o^1][v^1], rval);
     vmixerControl.mixer[o^1][v^1].Gain=val;
   }
   


--
Giuliano.
