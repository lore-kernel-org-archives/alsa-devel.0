From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Envy24control -DMX6fire specifics
Date: Mon, 5 Dec 2005 11:52:03 +0000
Message-ID: <200512051152.03090.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jnClD8W2VEGjYdS"
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


--Boundary-00=_jnClD8W2VEGjYdS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is the next envy24control patch for approval, to tidy up the DMX6fire 
specific controls.

Also, envy24control contains a lot of 
'if(card_eeprom.subvendor=ICE1712_SUBDEVICE_DMX6FIRE)'.  Originally I 
replaced these with a boolean (card_is_dmx6fire) variable for ease of reading 
but reverted for this patch.  It is a matter of alsa style and preference.  
Should I prepare a patch to do this or leave the explicit eeprom test?

On a similar matter, should tabs be used, prefered or avoided in the 
whitespace?  The envy24control files seem to contain a mixture which 
sometimes causes problems with diff and patch.


e24c-1.0.10-AHmod2.6d.patch:

Summary: Rationalise envy24control controls specific to Terratec DMX6fire

Remove separate 'breakbox led' selector and use led to indicate 'front line 
in' is selected (as it should be); combine digital input select to a 
one-of-three selector; change various labels; set default pcm mixer channels 
to 6.

Signed-off-by:  Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_jnClD8W2VEGjYdS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="e24c-1.0.10-AHmod2.6d.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e24c-1.0.10-AHmod2.6d.patch"

diff -ru Denvy24control/envy24control.c Aenvy24control/envy24control.c
--- Denvy24control/envy24control.c	2005-12-02 16:50:38.000000000 +0000
+++ Aenvy24control/envy24control.c	2005-12-05 10:40:08.000000000 +0000
@@ -156,9 +156,13 @@
 	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 14)) {
 		sprintf(str, "Line In R");
 	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 15)) {
-		sprintf(str, "Phono/Mic In L");
+		sprintf(str, "Phono/Mic L");
 	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 16)) {
-		sprintf(str, "Phono/Mic In R");
+		sprintf(str, "Phono/Mic R");
+	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 19)) {
+		sprintf(str, "Digital In L");
+	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 20)) {
+		sprintf(str, "Digital In R");
 	} else if (stream <= (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS)) {
 		sprintf(str, "H/W In %i", stream - (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS));
 	} else if (stream <= (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS + MAX_SPDIF_CHANNELS)) {
@@ -416,23 +420,33 @@
 
 	if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
 	{
-		table[2] = "CD In L";
+                table[0] = "Digital In L";
+                table[1] = "Digital In R";
+                table[2] = "CD In L";
                 table[3] = "CD In R";
                 table[4] = "Line In L";
                 table[5] = "Line In R";
-                table[6] = "Phono/Mic In L";
-                table[7] = "Phono/Mic In R";
+                table[6] = "Phono/Mic L";
+                table[7] = "Phono/Mic R";
 	}
 
 	if (stream <= MAX_OUTPUT_CHANNELS) {
 		sprintf(str, "H/W Out %i (%s)", stream, stream & 1 ? "L" : "R");
 	} else if (stream == (MAX_OUTPUT_CHANNELS + 1)) {
-		strcpy(str, "S/PDIF Out (L)");
+		if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) {
+				strcpy(str, "Digital Out (L)");
+			} else {
+				strcpy(str, "S/PDIF Out (L)");
+				}
 	} else if (stream == (MAX_OUTPUT_CHANNELS + 2)) {
-		strcpy(str, "S/PDIF Out (R)");
+		if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) {
+				strcpy(str, "Digital Out (R)");
+			} else {
+				strcpy(str, "S/PDIF Out (R)");
+				}
 	} else {
 		strcpy(str, "???");
-	}
+		}
 	if ((stream == MAX_PCM_OUTPUT_CHANNELS + 1) || (stream == MAX_PCM_OUTPUT_CHANNELS + 2)) {
 		sprintf(str1, "S/PDIF Out (%s)", stream & 1 ? "L" : "R");
 	} else { 
@@ -1193,95 +1207,20 @@
 			  (GtkSignalFunc)spdif_input_toggled, 
 			  (gpointer)"Optical");
 
-	if(hide)
-		gtk_widget_hide_all(frame);
-}
-
-static void create_spdif_on_off(GtkWidget *box)
-{
-        GtkWidget *frame;
-        GtkWidget *vbox;
-        GtkWidget *radiobutton;
-        GSList *group = NULL;
-        int hide = 1;
-
-        if( card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
-                hide = 0;
-
-        frame = gtk_frame_new("Digital Select");
-        gtk_widget_show(frame);
-        gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
-        gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
-
-        vbox = gtk_vbox_new(FALSE, 0);
-        gtk_widget_show(vbox);
-        gtk_container_add(GTK_CONTAINER(frame), vbox);
-        gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
-
-        radiobutton = gtk_radio_button_new_with_label(group, "Front Digital");
-        hw_spdif_switch_on_radio = radiobutton;
-        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
-        gtk_widget_show(radiobutton);
-        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
-        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
-                          (GtkSignalFunc)spdif_on_off_toggled,
-                          (gpointer)"On");
-
         radiobutton = gtk_radio_button_new_with_label(group, "Internal CD");
         hw_spdif_switch_off_radio = radiobutton;
         group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
-        gtk_widget_show(radiobutton);
+	if(card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
+	        gtk_widget_show(radiobutton);
         gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
         gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
-                          (GtkSignalFunc)spdif_on_off_toggled,
+                          (GtkSignalFunc)spdif_input_toggled,
                           (gpointer)"Off");
 
         if(hide)
                 gtk_widget_hide_all(frame);
 }
 
-static void create_breakbox_led(GtkWidget *box)
-{
-        GtkWidget *frame;
-        GtkWidget *vbox;
-        GtkWidget *radiobutton;
-        GSList *group = NULL;
-        int hide = 1;
-
-        if( card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
-                hide = 0;
-
-        frame = gtk_frame_new("Breakbox LED On/Off");
-        gtk_widget_show(frame);
-        gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
-        gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
-
-        vbox = gtk_vbox_new(FALSE, 0);
-        gtk_widget_show(vbox);
-        gtk_container_add(GTK_CONTAINER(frame), vbox);
-        gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
-
-        radiobutton = gtk_radio_button_new_with_label(group, "On");
-        hw_breakbox_led_on_radio = radiobutton;
-        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
-        gtk_widget_show(radiobutton);
-        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
-        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
-                          (GtkSignalFunc)breakbox_led_toggled,
-                          (gpointer)"On");
-
-        radiobutton = gtk_radio_button_new_with_label(group, "Off");
-        hw_breakbox_led_off_radio = radiobutton;
-        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
-        gtk_widget_show(radiobutton);
-        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
-        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
-                          (GtkSignalFunc)breakbox_led_toggled,
-                          (gpointer)"Off");
-
-        if(hide)
-                gtk_widget_hide_all(frame);
-}
 
 static void create_phono_input(GtkWidget *box)
 {
@@ -1374,7 +1313,7 @@
                           (GtkSignalFunc)analog_input_select_toggled,
                           (gpointer)"Rear Input");
 
-        radiobutton = gtk_radio_button_new_with_label(group, "Wave Table");
+        radiobutton = gtk_radio_button_new_with_label(group, "Wavetable");
         input_interface_wavetable = radiobutton;
         group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
         gtk_widget_show(radiobutton);
@@ -1423,9 +1362,7 @@
 
  	create_spdif_input_select(vbox2);
 	create_input_interface(vbox2);
-	create_breakbox_led(vbox2);
 	create_phono_input(vbox2);
-	create_spdif_on_off(vbox2);
 }
 
 static void create_about(GtkWidget *main, GtkWidget *notebook, int page)
@@ -1485,10 +1422,10 @@
 	static char* dmx6fire_inputs[6] = {
 		"CD In (L)",
 		"CD In (R)",
-		"Line In (L)",
-		"Line In (R)",
-		"Phono In (L)",
-		"Phono In (R)"
+		"Line  (L)",
+		"Line  (R)",
+		"Phono (L)",
+		"Phono (R)"
 	};
 	static char* dmx6fire_outputs[6] = {
 		"Front (L)",
@@ -1958,6 +1895,7 @@
 	int page;
 	int input_channels_set = 0;
 	int output_channels_set = 0;
+	int pcm_output_channels_set = 0;
 	static struct option long_options[] = {
 		{"device", 1, 0, 'D'},
 		{"card", 1, 0, 'c'},
@@ -2042,6 +1980,7 @@
 				fprintf(stderr, "envy24control: must have 0-%i pcm outputs\n", MAX_PCM_OUTPUT_CHANNELS);
 				exit(1);
 			}
+			pcm_output_channels_set = 1;
 			break;
 		case 's':
 			spdif_channels = atoi(optarg);
@@ -2120,6 +2059,12 @@
 		}
 	}
 
+	if(!pcm_output_channels_set) {
+		if(card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) {
+			pcm_output_channels = 6; /* PCMs 7&8 can be used -set using option -p8 */
+		}
+	}
+
 	/* Initialize code */
 	config_open();
 	level_meters_init();
diff -ru Denvy24control/hardware.c Aenvy24control/hardware.c
--- Denvy24control/hardware.c	2005-12-02 16:50:38.000000000 +0000
+++ Aenvy24control/hardware.c	2005-12-05 10:44:46.000000000 +0000
@@ -605,17 +605,29 @@
 void spdif_input_update(void)
 {
 	int err;
-	
+	int digoptical = FALSE;
+	int diginternal = FALSE;
+
 	if ((card_eeprom.subvendor != ICE1712_SUBDEVICE_DELTADIO2496) && (card_eeprom.subvendor != ICE1712_SUBDEVICE_DMX6FIRE))
 		return;
 	if ((err = snd_ctl_elem_read(ctl, spdif_input)) < 0)
 		g_print("Unable to read S/PDIF input switch: %s\n", snd_strerror(err));
-	if (snd_ctl_elem_value_get_boolean(spdif_input, 0)) {
+	if (snd_ctl_elem_value_get_boolean(spdif_input, 0))
+		digoptical = TRUE;
+	if (card_eeprom.subvendor = ICE1712_SUBDEVICE_DMX6FIRE) {
+        	if ((err = snd_ctl_elem_read(ctl, spdif_on_off)) < 0)
+			g_print("Unable to read S/PDIF on/off switch: %s\n", snd_strerror(err));
+	      	if (!(snd_ctl_elem_value_get_boolean(spdif_on_off, 0)))
+			diginternal = TRUE;
+	}
+	if (digoptical) {
 		toggle_set(hw_spdif_input_optical_radio, TRUE);
 	} else {
 		toggle_set(hw_spdif_input_coaxial_radio, TRUE);
 	}
-}
+	if (diginternal)
+		toggle_set(hw_spdif_switch_off_radio, TRUE);
+ }
 
 void spdif_input_toggled(GtkWidget *togglebutton, gpointer data)
 {
@@ -624,10 +636,18 @@
 	
 	if (!is_active(togglebutton))
 		return;
-	if (!strcmp(str, "Optical"))
-		snd_ctl_elem_value_set_boolean(spdif_input, 0, 1);
-	else
-		snd_ctl_elem_value_set_boolean(spdif_input, 0, 0);
+	if (!strcmp(str, "Off"))
+               	snd_ctl_elem_value_set_boolean(spdif_on_off, 0, 0);
+	else {
+		snd_ctl_elem_value_set_boolean(spdif_on_off, 0, 1);
+		if (!strcmp(str, "Optical"))
+			snd_ctl_elem_value_set_boolean(spdif_input, 0, 1);
+		else
+			if (!strcmp(str, "Coaxial"))
+				snd_ctl_elem_value_set_boolean(spdif_input, 0, 0);
+	}
+	if ((err = snd_ctl_elem_write(ctl, spdif_on_off)) < 0)
+               g_print("Unable to write S/PDIF on/off switch: %s\n", snd_strerror(err));
 	if ((err = snd_ctl_elem_write(ctl, spdif_input)) < 0)
 		g_print("Unable to write S/PDIF input switch: %s\n", snd_strerror(err));
 }
@@ -664,81 +684,27 @@
 void analog_input_select_toggled(GtkWidget *togglebutton, gpointer data)
 {
 	char *what = (char *) data;
+       int err;
 
         if (!is_active(togglebutton))
                 return;
         if (!strcmp(what, "Internal")) {
                 analog_input_select_set(0);
+               snd_ctl_elem_value_set_boolean(breakbox_led, 0, 0);
         } else if (!strcmp(what, "Front Input")) {
                 analog_input_select_set(1);
+               snd_ctl_elem_value_set_boolean(breakbox_led, 0, 1);
         } else if (!strcmp(what, "Rear Input")) {
                 analog_input_select_set(2);
+               snd_ctl_elem_value_set_boolean(breakbox_led, 0, 0);
         } else if (!strcmp(what, "Wave Table")) {
                 analog_input_select_set(3);
+               snd_ctl_elem_value_set_boolean(breakbox_led, 0, 0);
         } else {
                 g_print("analog_input_select_toggled: %s ???\n", what);
         }
-}
-
-
-void breakbox_led_update(void)
-{
-	int err;
-
-	 if (card_eeprom.subvendor != ICE1712_SUBDEVICE_DMX6FIRE)
-		return;
-	if ((err = snd_ctl_elem_read(ctl, breakbox_led)) < 0)
-		g_print("Unable to read breakbox LED switch: %s\n", snd_strerror(err));
-	if (snd_ctl_elem_value_get_boolean(breakbox_led, 0)) {
-		 toggle_set(hw_breakbox_led_on_radio, TRUE);
-	} else {
-		 toggle_set(hw_breakbox_led_off_radio, TRUE);
-	}
-}
-
-void breakbox_led_toggled(GtkWidget *togglebutton, gpointer data)
-{
-	int err;
-		char *str = (char *)data;
-
-	 if (!is_active(togglebutton))
-		return;
-	if (!strcmp(str, "On"))
-			snd_ctl_elem_value_set_boolean(breakbox_led, 0, 1);
-	else
-			snd_ctl_elem_value_set_boolean(breakbox_led, 0, 0);
-	if ((err = snd_ctl_elem_write(ctl, breakbox_led)) < 0)
-		g_print("Unable to write breakbox LED switch: %s\n", snd_strerror(err));
-}
-
-void spdif_on_off_update(void)
-{
-        int err;
-
-        if (card_eeprom.subvendor != ICE1712_SUBDEVICE_DMX6FIRE)
-                return;
-        if ((err = snd_ctl_elem_read(ctl, spdif_on_off)) < 0)
-                g_print("Unable to read S/PDIF on/off switch: %s\n", snd_strerror(err));
-        if (snd_ctl_elem_value_get_boolean(spdif_on_off, 0)) {
-                toggle_set(hw_spdif_switch_on_radio, TRUE);
-        } else {
-                toggle_set(hw_spdif_switch_off_radio, TRUE);
-        }
-}
-
-void spdif_on_off_toggled(GtkWidget *togglebutton, gpointer data)
-{
-        int err;
-        char *str = (char *) data;
-
-        if (!is_active(togglebutton))
-                return;
-        if (!strcmp(str, "On"))
-                snd_ctl_elem_value_set_boolean(spdif_on_off, 0, 1);
-        else
-                snd_ctl_elem_value_set_boolean(spdif_on_off, 0, 0);
-        if ((err = snd_ctl_elem_write(ctl, spdif_on_off)) < 0)
-                g_print("Unable to write S/PDIF on/off switch: %s\n", snd_strerror(err));
+       if ((err = snd_ctl_elem_write(ctl, breakbox_led)) < 0)
+               g_print("Unable to write breakbox LED switch: %s\n", snd_strerror(err));
 }
 
 void phono_input_update(void)
@@ -841,7 +807,5 @@
 	spdif_input_update();
 	spdif_output_update();
 	analog_input_select_update();
-	breakbox_led_update();
-	spdif_on_off_update();
 	phono_input_update();
 }

--Boundary-00=_jnClD8W2VEGjYdS--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
