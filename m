From: Daniel Ankers <dan_a@manx.net>
Subject: [patch] Envy24control access to 6Fire controls
Date: Wed, 29 Oct 2003 23:22:57 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031029232257.7fabac62.dan_a@manx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
This patch against the stable version of envy24control gives access to most of the Terratec DMX 6Fire mixer controls.  It also changes the lables on the inputs in the monitor mixer to be more useful.  It should have no effect on your envy24control if you are using a card other than the 6Fire.

Note that I'm not a programmer, so there might be huge errors in this...
Dan

diff -ubr alsa-tools-0.9.8/envy24control/envy24control.c alsa-tools-0.9.8-6fire/envy24control/envy24control.c
--- alsa-tools-0.9.8/envy24control/envy24control.c	2003-10-10 08:47:38.000000000 +0100
+++ alsa-tools-0.9.8-6fire/envy24control/envy24control.c	2003-10-29 22:57:30.000000000 +0000
@@ -94,6 +94,20 @@
 GtkWidget *hw_spdif_input_coaxial_radio;
 GtkWidget *hw_spdif_input_optical_radio;
 
+GtkWidget *input_interface_internal;
+GtkWidget *input_interface_front_input;
+GtkWidget *input_interface_rear_input;
+GtkWidget *input_interface_wavetable;
+
+GtkWidget *hw_breakbox_led_on_radio;
+GtkWidget *hw_breakbox_led_off_radio;
+
+GtkWidget *hw_phono_input_on_radio;
+GtkWidget *hw_phono_input_off_radio;
+
+GtkWidget *hw_spdif_switch_on_radio;
+GtkWidget *hw_spdif_switch_off_radio;
+
 GtkObject *av_dac_volume_adj[10];
 GtkObject *av_adc_volume_adj[10];
 GtkObject *av_ipga_volume_adj[10];
@@ -119,6 +133,18 @@
 
 	if (stream <= 10) {
 		sprintf(str, "PCM Out %i", stream);
+	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 11)) {
+		sprintf(str, "CD In L");
+	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 12)) {
+		sprintf(str, "CD In R");
+	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 13)) {
+		sprintf(str, "Line In L");
+	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 14)) {
+		sprintf(str, "Line In R");
+	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 15)) {
+		sprintf(str, "Phono/Mic In L");
+	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 16)) {
+		sprintf(str, "Phono/Mic In R");
 	} else if (stream <= 18) {
 		sprintf(str, "H/W In %i", stream - 10);
 	} else if (stream == 19) {
@@ -1092,7 +1118,7 @@
 	GSList *group = NULL;
 	int hide = 1;
 
-	if(card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTADIO2496)
+	if((card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTADIO2496) || (card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE))
 		hide = 0;
 
 	frame = gtk_frame_new("S/PDIF Input");
@@ -1127,11 +1153,202 @@
 		gtk_widget_hide_all(frame);
 }
 
+static void create_spdif_on_off(GtkWidget *box)
+{
+        GtkWidget *frame;
+        GtkWidget *vbox;
+        GtkWidget *radiobutton;
+        GSList *group = NULL;
+        int hide = 1;
+
+        if( card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
+                hide = 0;
+
+        frame = gtk_frame_new("S/PDIF On/Off");
+        gtk_widget_show(frame);
+        gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
+        gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
+
+        vbox = gtk_vbox_new(FALSE, 0);
+        gtk_widget_show(vbox);
+        gtk_container_add(GTK_CONTAINER(frame), vbox);
+        gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+
+        radiobutton = gtk_radio_button_new_with_label(group, "On");
+        hw_spdif_switch_on_radio = radiobutton;
+        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
+        gtk_widget_show(radiobutton);
+        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
+        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
+                          (GtkSignalFunc)spdif_on_off_toggled,
+                          (gpointer)"On");
+
+        radiobutton = gtk_radio_button_new_with_label(group, "Off");
+        hw_spdif_switch_off_radio = radiobutton;
+        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
+        gtk_widget_show(radiobutton);
+        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
+        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
+                          (GtkSignalFunc)spdif_on_off_toggled,
+                          (gpointer)"Off");
+
+        if(hide)
+                gtk_widget_hide_all(frame);
+}
+
+static void create_breakbox_led(GtkWidget *box)
+{
+        GtkWidget *frame;
+        GtkWidget *vbox;
+        GtkWidget *radiobutton;
+        GSList *group = NULL;
+        int hide = 1;
+
+        if( card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
+                hide = 0;
+
+        frame = gtk_frame_new("Breakbox LED On/Off");
+        gtk_widget_show(frame);
+        gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
+        gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
+
+        vbox = gtk_vbox_new(FALSE, 0);
+        gtk_widget_show(vbox);
+        gtk_container_add(GTK_CONTAINER(frame), vbox);
+        gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+
+        radiobutton = gtk_radio_button_new_with_label(group, "On");
+        hw_breakbox_led_on_radio = radiobutton;
+        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
+        gtk_widget_show(radiobutton);
+        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
+        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
+                          (GtkSignalFunc)breakbox_led_toggled,
+                          (gpointer)"On");
+
+        radiobutton = gtk_radio_button_new_with_label(group, "Off");
+        hw_breakbox_led_off_radio = radiobutton;
+        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
+        gtk_widget_show(radiobutton);
+        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
+        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
+                          (GtkSignalFunc)breakbox_led_toggled,
+                          (gpointer)"Off");
+
+        if(hide)
+                gtk_widget_hide_all(frame);
+}
+
+static void create_phono_input(GtkWidget *box)
+{
+        GtkWidget *frame;
+        GtkWidget *vbox;
+        GtkWidget *radiobutton;
+        GSList *group = NULL;
+        int hide = 1;
+
+        if( card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
+                hide = 0;
+
+        frame = gtk_frame_new("Phono Input Switch");
+        gtk_widget_show(frame);
+        gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
+        gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
+
+        vbox = gtk_vbox_new(FALSE, 0);
+        gtk_widget_show(vbox);
+        gtk_container_add(GTK_CONTAINER(frame), vbox);
+        gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+
+        radiobutton = gtk_radio_button_new_with_label(group, "Phono");
+        hw_phono_input_on_radio = radiobutton;
+        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
+        gtk_widget_show(radiobutton);
+        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
+        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
+                          (GtkSignalFunc)phono_input_toggled,
+                          (gpointer)"Phono");
+
+        radiobutton = gtk_radio_button_new_with_label(group, "Mic");
+        hw_phono_input_off_radio = radiobutton;
+        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
+        gtk_widget_show(radiobutton);
+        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
+        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
+                          (GtkSignalFunc)phono_input_toggled,
+                          (gpointer)"Mic");
+
+        if(hide)
+                gtk_widget_hide_all(frame);
+}
+
+static void create_input_interface(GtkWidget *box)
+{
+        GtkWidget *frame;
+        GtkWidget *vbox;
+        GtkWidget *radiobutton;
+        GSList *group = NULL;
+        int hide = 1;
+
+        if( card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
+                hide = 0;
+
+        frame = gtk_frame_new("Line In Selector");
+        gtk_widget_show(frame);
+        gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
+        gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
+
+        vbox = gtk_vbox_new(FALSE, 0);
+        gtk_widget_show(vbox);
+        gtk_container_add(GTK_CONTAINER(frame), vbox);
+        gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+
+        radiobutton = gtk_radio_button_new_with_label(group, "Internal");
+        input_interface_internal = radiobutton;
+        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
+        gtk_widget_show(radiobutton);
+        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
+        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
+                          (GtkSignalFunc)analog_input_select_toggled,
+                          (gpointer)"Internal");
+
+        radiobutton = gtk_radio_button_new_with_label(group, "Front Input");
+        input_interface_front_input = radiobutton;
+        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
+        gtk_widget_show(radiobutton);
+        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
+        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
+                          (GtkSignalFunc)analog_input_select_toggled,
+                          (gpointer)"Front Input");
+
+        radiobutton = gtk_radio_button_new_with_label(group, "Rear Input");
+        input_interface_rear_input = radiobutton;
+        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
+        gtk_widget_show(radiobutton);
+        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
+        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
+                          (GtkSignalFunc)analog_input_select_toggled,
+                          (gpointer)"Rear Input");
+
+        radiobutton = gtk_radio_button_new_with_label(group, "Wave Table");
+        input_interface_wavetable = radiobutton;
+        group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
+        gtk_widget_show(radiobutton);
+        gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
+        gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
+                          (GtkSignalFunc)analog_input_select_toggled,
+                          (gpointer)"Wave Table");
+
+        if(hide)
+                gtk_widget_hide_all(frame);
+}
+
 static void create_hardware(GtkWidget *main, GtkWidget *notebook, int page)
 {
 	GtkWidget *label;
 	GtkWidget *hbox;
 	GtkWidget *vbox;
+	GtkWidget *vbox2;
 
 	hbox = gtk_hbox_new(FALSE, 0);
 	gtk_widget_show(hbox);
@@ -1148,6 +1365,11 @@
 	gtk_box_pack_start(GTK_BOX(hbox), vbox, FALSE, TRUE, 0);
 	gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
 
+	vbox2 = gtk_vbox_new(FALSE, 0);
+	gtk_widget_show(vbox2);
+	gtk_box_pack_end(GTK_BOX(hbox),vbox2, FALSE, FALSE, 0);
+	gtk_container_set_border_width(GTK_CONTAINER(vbox2), 6);
+
 	create_master_clock(vbox);
 	create_rate_state(vbox);
 	create_actual_rate(vbox);
@@ -1155,7 +1377,11 @@
 
  	create_spdif_output_settings(hbox); 
 
- 	create_spdif_input_select(hbox); 
+ 	create_spdif_input_select(vbox2);
+	create_input_interface(vbox2);
+	create_breakbox_led(vbox2);
+	create_phono_input(vbox2);
+	create_spdif_on_off(vbox2);
 }
 
 static void create_about(GtkWidget *main, GtkWidget *notebook, int page)
diff -ubr alsa-tools-0.9.8/envy24control/envy24control.h alsa-tools-0.9.8-6fire/envy24control/envy24control.h
--- alsa-tools-0.9.8/envy24control/envy24control.h	2003-03-25 17:32:51.000000000 +0000
+++ alsa-tools-0.9.8-6fire/envy24control/envy24control.h	2003-10-29 15:08:47.000000000 +0000
@@ -109,6 +109,19 @@
 extern GtkWidget *hw_spdif_input_coaxial_radio;
 extern GtkWidget *hw_spdif_input_optical_radio;
 
+extern GtkWidget *hw_breakbox_led_on_radio;
+extern GtkWidget *hw_breakbox_led_off_radio;
+
+extern GtkWidget *hw_phono_input_on_radio;
+extern GtkWidget *hw_phono_input_off_radio;
+
+extern GtkWidget *hw_spdif_switch_on_radio;
+extern GtkWidget *hw_spdif_switch_off_radio;
+
+extern GtkWidget *input_interface_internal;
+extern GtkWidget *input_interface_front_input;
+extern GtkWidget *input_interface_rear_input;
+extern GtkWidget *input_interface_wavetable;
 extern GtkObject *av_dac_volume_adj[];
 extern GtkObject *av_adc_volume_adj[];
 extern GtkObject *av_ipga_volume_adj[];
@@ -158,6 +171,11 @@
 void spdif_output_toggled(GtkWidget *togglebutton, gpointer data);
 void spdif_input_update(void);
 void spdif_input_toggled(GtkWidget *togglebutton, gpointer data);
+void analog_input_select_toggled(GtkWidget *togglebutton, gpointer data);
+void breakbox_led_toggled(GtkWidget *togglebutton, gpointer data);
+void spdif_on_off_toggled(GtkWidget *togglebutton, gpointer data);
+void phono_input_toggled(GtkWidget *togglebutton, gpointer data);
+
 void hardware_init(void);
 void hardware_postinit(void);
 void analog_volume_init(void);
diff -ubr alsa-tools-0.9.8/envy24control/hardware.c alsa-tools-0.9.8-6fire/envy24control/hardware.c
--- alsa-tools-0.9.8/envy24control/hardware.c	2002-12-03 17:10:38.000000000 +0000
+++ alsa-tools-0.9.8-6fire/envy24control/hardware.c	2003-10-29 15:08:47.000000000 +0000
@@ -26,6 +26,10 @@
 static snd_ctl_elem_value_t *volume_rate;
 static snd_ctl_elem_value_t *spdif_input;
 static snd_ctl_elem_value_t *spdif_output;
+static snd_ctl_elem_value_t *analog_input_select;
+static snd_ctl_elem_value_t *breakbox_led;
+static snd_ctl_elem_value_t *spdif_on_off;
+static snd_ctl_elem_value_t *phono_input;
 
 #define toggle_set(widget, state) \
 	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(widget), state);
@@ -553,7 +557,7 @@
 {
 	int err;
 	
-	if (card_eeprom.subvendor != ICE1712_SUBDEVICE_DELTADIO2496)
+	if ((card_eeprom.subvendor != ICE1712_SUBDEVICE_DELTADIO2496) && (card_eeprom.subvendor != ICE1712_SUBDEVICE_DMX6FIRE))
 		return;
 	if ((err = snd_ctl_elem_read(ctl, spdif_input)) < 0)
 		g_print("Unable to read S/PDIF input switch: %s\n", snd_strerror(err));
@@ -579,6 +583,145 @@
 		g_print("Unable to write S/PDIF input switch: %s\n", snd_strerror(err));
 }
 
+void analog_input_select_update(void)
+{
+	int err, input_interface;
+
+	if (card_eeprom.subvendor != ICE1712_SUBDEVICE_DMX6FIRE)
+		return;
+	if ((err = snd_ctl_elem_read(ctl, analog_input_select)) < 0)
+		g_print("Unable to read analog input switch: %s\n", snd_strerror(err));
+	input_interface = snd_ctl_elem_value_get_enumerated(analog_input_select, 0);
+	switch (input_interface) {
+	case 0: toggle_set(input_interface_internal, TRUE); break;
+	case 1: toggle_set(input_interface_front_input, TRUE); break;
+	case 2: toggle_set(input_interface_rear_input, TRUE); break;
+	case 3: toggle_set(input_interface_wavetable, TRUE); break;
+	default:
+		g_print("Error in analogue input: %d\n", input_interface);
+		break;
+	}
+}
+
+void analog_input_select_set(int value)
+{
+	int err;
+
+        snd_ctl_elem_value_set_enumerated(analog_input_select, 0, value);
+        if ((err = snd_ctl_elem_write(ctl, analog_input_select)) < 0)
+                g_print("Unable to write analog input selection: %s\n", snd_strerror(err));
+}
+
+void analog_input_select_toggled(GtkWidget *togglebutton, gpointer data)
+{
+	char *what = (char *) data;
+
+        if (!is_active(togglebutton))
+                return;
+        if (!strcmp(what, "Internal")) {
+                analog_input_select_set(0);
+        } else if (!strcmp(what, "Front Input")) {
+                analog_input_select_set(1);
+        } else if (!strcmp(what, "Rear Input")) {
+                analog_input_select_set(2);
+        } else if (!strcmp(what, "Wave Table")) {
+                analog_input_select_set(3);
+        } else {
+                g_print("analog_input_select_toggled: %s ???\n", what);
+        }
+}
+
+
+void breakbox_led_update(void)
+{
+	int err;
+
+	 if (card_eeprom.subvendor != ICE1712_SUBDEVICE_DMX6FIRE)
+		return;
+	if ((err = snd_ctl_elem_read(ctl, breakbox_led)) < 0)
+		g_print("Unable to read breakbox LED switch: %s\n", snd_strerror(err));
+	if (snd_ctl_elem_value_get_boolean(breakbox_led, 0)) {
+		 toggle_set(hw_breakbox_led_on_radio, TRUE);
+	} else {
+		 toggle_set(hw_breakbox_led_off_radio, TRUE);
+	}
+}
+
+void breakbox_led_toggled(GtkWidget *togglebutton, gpointer data)
+{
+	int err;
+		char *str = (char *)data;
+
+	 if (!is_active(togglebutton))
+		return;
+	if (!strcmp(str, "On"))
+			snd_ctl_elem_value_set_boolean(breakbox_led, 0, 1);
+	else
+			snd_ctl_elem_value_set_boolean(breakbox_led, 0, 0);
+	if ((err = snd_ctl_elem_write(ctl, breakbox_led)) < 0)
+		g_print("Unable to write breakbox LED switch: %s\n", snd_strerror(err));
+}
+
+void spdif_on_off_update(void)
+{
+        int err;
+
+        if (card_eeprom.subvendor != ICE1712_SUBDEVICE_DMX6FIRE)
+                return;
+        if ((err = snd_ctl_elem_read(ctl, spdif_on_off)) < 0)
+                g_print("Unable to read S/PDIF on/off switch: %s\n", snd_strerror(err));
+        if (snd_ctl_elem_value_get_boolean(spdif_on_off, 0)) {
+                toggle_set(hw_spdif_switch_on_radio, TRUE);
+        } else {
+                toggle_set(hw_spdif_switch_off_radio, TRUE);
+        }
+}
+
+void spdif_on_off_toggled(GtkWidget *togglebutton, gpointer data)
+{
+        int err;
+        char *str = (char *) data;
+
+        if (!is_active(togglebutton))
+                return;
+        if (!strcmp(str, "On"))
+                snd_ctl_elem_value_set_boolean(spdif_input, 0, 1);
+        else
+                snd_ctl_elem_value_set_boolean(spdif_input, 0, 0);
+        if ((err = snd_ctl_elem_write(ctl, spdif_input)) < 0)
+                g_print("Unable to write S/PDIF on/off switch: %s\n", snd_strerror(err));
+}
+
+void phono_input_update(void)
+{
+        int err;
+
+        if (card_eeprom.subvendor != ICE1712_SUBDEVICE_DMX6FIRE)
+                return;
+        if ((err = snd_ctl_elem_read(ctl, phono_input)) < 0)
+                g_print("Unable to read phono input switch: %s\n", snd_strerror(err));
+        if (snd_ctl_elem_value_get_boolean(phono_input, 0)) {
+                toggle_set(hw_phono_input_on_radio, TRUE);
+        } else {
+                toggle_set(hw_phono_input_off_radio, TRUE);
+        }
+}
+
+void phono_input_toggled(GtkWidget *togglebutton, gpointer data)
+{
+        int err;
+        char *str = (char *) data;
+
+        if (!is_active(togglebutton))
+                return;
+        if (!strcmp(str, "On"))
+                snd_ctl_elem_value_set_boolean(phono_input, 0, 1);
+        else
+                snd_ctl_elem_value_set_boolean(phono_input, 0, 0);
+        if ((err = snd_ctl_elem_write(ctl, phono_input)) < 0)
+                g_print("Unable to write phono input switch: %s\n", snd_strerror(err));
+}
+
 void hardware_init(void)
 {
 	if (snd_ctl_elem_value_malloc(&internal_clock) < 0 ||
@@ -587,7 +730,11 @@
 	    snd_ctl_elem_value_malloc(&rate_reset) < 0 ||
 	    snd_ctl_elem_value_malloc(&volume_rate) < 0 ||
 	    snd_ctl_elem_value_malloc(&spdif_input) < 0 ||
-	    snd_ctl_elem_value_malloc(&spdif_output) < 0) {
+	    snd_ctl_elem_value_malloc(&spdif_output) < 0 ||
+	    snd_ctl_elem_value_malloc(&analog_input_select) < 0 ||
+	    snd_ctl_elem_value_malloc(&breakbox_led) < 0 ||
+	    snd_ctl_elem_value_malloc(&spdif_on_off) < 0 ||
+	    snd_ctl_elem_value_malloc(&phono_input) < 0) {
 		g_print("Cannot allocate memory\n");
 		exit(1);
 	}
@@ -607,11 +754,29 @@
 	snd_ctl_elem_value_set_interface(volume_rate, SND_CTL_ELEM_IFACE_MIXER);
 	snd_ctl_elem_value_set_name(volume_rate, "Multi Track Volume Rate");
 
+	if(card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE){
+		snd_ctl_elem_value_set_interface(spdif_input, SND_CTL_ELEM_IFACE_MIXER);
+		snd_ctl_elem_value_set_name(spdif_input, "Optical Digital Input Switch");
+	} else {
 	snd_ctl_elem_value_set_interface(spdif_input, SND_CTL_ELEM_IFACE_PCM);
 	snd_ctl_elem_value_set_name(spdif_input, "IEC958 Input Optical");
+	}
 
 	snd_ctl_elem_value_set_interface(spdif_output, SND_CTL_ELEM_IFACE_PCM);
 	snd_ctl_elem_value_set_name(spdif_output, "IEC958 Playback Default");
+
+	snd_ctl_elem_value_set_interface(analog_input_select, SND_CTL_ELEM_IFACE_MIXER);
+	snd_ctl_elem_value_set_name(analog_input_select, "Analog Input Select");
+
+	snd_ctl_elem_value_set_interface(breakbox_led, SND_CTL_ELEM_IFACE_MIXER);
+	snd_ctl_elem_value_set_name(breakbox_led, "Breakbox LED");
+
+	snd_ctl_elem_value_set_interface(spdif_on_off, SND_CTL_ELEM_IFACE_MIXER);
+	snd_ctl_elem_value_set_name(spdif_on_off, "Front Digital Input Switch");
+
+	snd_ctl_elem_value_set_interface(phono_input, SND_CTL_ELEM_IFACE_MIXER);
+	snd_ctl_elem_value_set_name(phono_input, "Phono Analog Input Switch");
+
 }
 
 void hardware_postinit(void)
@@ -622,4 +787,8 @@
 	volume_change_rate_update();
 	spdif_input_update();
 	spdif_output_update();
+	analog_input_select_update();
+	breakbox_led_update();
+	spdif_on_off_update();
+	phono_input_update();
 }


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
