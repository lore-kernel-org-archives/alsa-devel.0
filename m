From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Envy24control with DMX6fire 'digital in' patch
Date: Thu, 24 Nov 2005 22:57:34 +0000
Message-ID: <200511242257.34121.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eVkhDiGjILmw/BN"
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_eVkhDiGjILmw/BN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is the first of my patches to envy24control.  Apart from a simple typo 
fix, I took the liberty of renaming the screen controls to make them clearer, 
as the DMX6fire front box uses 'Digital' rather than 'S/PDIF', and the 
on-board SPDIF input is only suitable for CD input.

Summary: Fix envy24control digital input on Terratec DMX6fire

This patch fixes typo in hardware.c that prevented front digital inputs being 
selected on the Terratec DMX6fire.  Also renames the digital input controls 
for greater clarity with this card.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_eVkhDiGjILmw/BN
Content-Type: text/x-diff;
  charset="us-ascii";
  name="e24c-1.0.10-AHmod1.4d.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e24c-1.0.10-AHmod1.4d.patch"

diff -ru envy24control/envy24control.c Aenvy24control/envy24control.c
--- envy24control/envy24control.c	2005-08-04 17:01:10.000000000 +0100
+++ Aenvy24control/envy24control.c	2005-11-24 22:03:54.000000000 +0000
@@ -1165,7 +1165,7 @@
 	if((card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTADIO2496) || (card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE))
 		hide = 0;
 
-	frame = gtk_frame_new("S/PDIF Input");
+	frame = gtk_frame_new("Digital Input");
 	gtk_widget_show(frame);
 	gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
 	gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
@@ -1208,7 +1208,7 @@
         if( card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
                 hide = 0;
 
-        frame = gtk_frame_new("S/PDIF On/Off");
+        frame = gtk_frame_new("Digital Select");
         gtk_widget_show(frame);
         gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
         gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
@@ -1218,7 +1218,7 @@
         gtk_container_add(GTK_CONTAINER(frame), vbox);
         gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
 
-        radiobutton = gtk_radio_button_new_with_label(group, "On");
+        radiobutton = gtk_radio_button_new_with_label(group, "Front Digital");
         hw_spdif_switch_on_radio = radiobutton;
         group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
         gtk_widget_show(radiobutton);
@@ -1227,7 +1227,7 @@
                           (GtkSignalFunc)spdif_on_off_toggled,
                           (gpointer)"On");
 
-        radiobutton = gtk_radio_button_new_with_label(group, "Off");
+        radiobutton = gtk_radio_button_new_with_label(group, "Internal CD");
         hw_spdif_switch_off_radio = radiobutton;
         group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
         gtk_widget_show(radiobutton);
diff -ru envy24control/hardware.c Aenvy24control/hardware.c
--- envy24control/hardware.c	2004-04-16 14:09:35.000000000 +0100
+++ Aenvy24control/hardware.c	2005-11-24 21:01:31.000000000 +0000
@@ -734,10 +734,10 @@
         if (!is_active(togglebutton))
                 return;
         if (!strcmp(str, "On"))
-                snd_ctl_elem_value_set_boolean(spdif_input, 0, 1);
+                snd_ctl_elem_value_set_boolean(spdif_on_off, 0, 1);
         else
-                snd_ctl_elem_value_set_boolean(spdif_input, 0, 0);
-        if ((err = snd_ctl_elem_write(ctl, spdif_input)) < 0)
+                snd_ctl_elem_value_set_boolean(spdif_on_off, 0, 0);
+        if ((err = snd_ctl_elem_write(ctl, spdif_on_off)) < 0)
                 g_print("Unable to write S/PDIF on/off switch: %s\n", snd_strerror(err));
 }

--Boundary-00=_eVkhDiGjILmw/BN--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
