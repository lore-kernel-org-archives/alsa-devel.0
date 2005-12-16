From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Envy24control -changes on screen
Date: Fri, 16 Dec 2005 19:24:01 +0000
Message-ID: <200512161901.46162.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RRxoDV5GJlFYR9Z"
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


--Boundary-00=_RRxoDV5GJlFYR9Z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch file provides a 'makeover' for envy24control, motivated by 
a desire to reduce the minimum on-screen size and improve usability.  A few 
users have been trying this arrangement from an original posting in July and 
have encouraged me to offer it to alsa mainstream.

The patch is large, but is mainly moving sections of code arround, adding 
scroll windows, and re-arranging the controls on screen, plus options -w to 
set initial window size, and -t to increase mixer height (tall).  If the file 
is too large it may be possible to split it up.

The levelmeters part is to prevent a problem with redraw of un-configured 
pixmaps at start-up.

It is possible that this patch will clash with Dirk Jagdmann's recent midi 
option posting as the same lines are changed, but I have posted now so 
evaluation can start.

Summary: Change on-screen appearance of envy24control

Re-arrange envy24control on-screen; put digital mixer meter in outer frame; 
split input and pcm mixer meters; add scroll windows on all notebook pages; 
re-layout button boxes; add options -w and -t; add rt-click menu; add pixmap 
test to levelmeters.c

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>



--Boundary-00=_RRxoDV5GJlFYR9Z
Content-Type: text/x-diff;
  charset="us-ascii";
  name="e24c-1.0.10-AHmod3.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e24c-1.0.10-AHmod3.6.patch"

diff -ru Denvy24control/envy24control.c Aenvy24control/envy24control.c
--- Denvy24control/envy24control.c	2005-12-12 23:09:39.000000000 +0000
+++ Aenvy24control/envy24control.c	2005-12-16 17:08:44.000000000 +0000
@@ -1,10 +1,17 @@
 /*****************************************************************************
    envy24control.c - Env24 chipset (ICE1712) control utility
-   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz>
+   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz> **AHmod3.6 16.12.05
 
    (2003/03/22) Changed to hbox/vbox layout.
    Copyright (C) 2003 by S??ren Wedel Nielsen
    
+   (16.12.2005)  Re-worked user interface -digital mixer display permanently
+   visible; pcms split to another page; controls re-arranged and all pages
+   scrollable for min window size and greater flexibility; pop-up menu enabled.
+   Changes to levelmeters.c to prevent invalid redraws.
+   New options added: 'w' to set initial window pixel width and 't' for tall equal mixer height style.
+   Copyright (C) 2005 by Alan Horstmann
+
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
@@ -27,7 +34,7 @@
 #include <getopt.h>
 
 int input_channels, output_channels, pcm_output_channels, spdif_channels, view_spdif_playback, card_number;
-int card_is_dmx6fire = FALSE;
+int card_is_dmx6fire = FALSE, tall_equal_mixer_ht = 0;
 char *profiles_file_name, *default_profile;
 
 ice1712_eeprom_t card_eeprom;
@@ -147,7 +154,7 @@
 	if (stream <= MAX_PCM_OUTPUT_CHANNELS) {
 		sprintf(str, "PCM Out %i", stream);
 	} else if (stream <= (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS)) {
-		sprintf(str, "S/PDIF Out %s", stream & 1 ? "L": "R");
+		sprintf(str, "SPDIF Out %s", stream & 1 ? "L": "R");
 	} else if (card_is_dmx6fire) {
 		switch (stream) {
 		case 11: sprintf(str, "CD In L");break;
@@ -163,7 +170,7 @@
 	} else if (stream <= (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS)) {
 		sprintf(str, "H/W In %i", stream - (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS));
 	} else if (stream <= (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS + MAX_SPDIF_CHANNELS)) {
-		sprintf(str, "S/PDIF In %s", stream & 1 ? "L": "R");
+		sprintf(str, "SPDIF In %s", stream & 1 ? "L": "R");
 	} else {
 		strcpy(str, "???");
 	}
@@ -171,12 +178,12 @@
 	frame = gtk_frame_new(str);
 	gtk_widget_show(frame);
 	gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
-	gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
+	gtk_container_set_border_width(GTK_CONTAINER(frame), 2);
 
 	vbox = gtk_vbox_new(FALSE, 6);
 	gtk_widget_show(vbox);
 	gtk_container_add(GTK_CONTAINER(frame), vbox);
-	gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+	gtk_container_set_border_width(GTK_CONTAINER(vbox), 2);
 
 	hbox = gtk_hbox_new(FALSE, 2);
 	gtk_widget_show(hbox);
@@ -208,7 +215,7 @@
 	gtk_signal_connect(GTK_OBJECT(drawing), "configure_event",
 			   GTK_SIGNAL_FUNC(level_meters_configure_event), NULL);
 	gtk_widget_set_events(drawing, GDK_EXPOSURE_MASK);
-	gtk_widget_set_usize(drawing, 45, 202);
+	gtk_widget_set_usize(drawing, 36, (60 * tall_equal_mixer_ht + 204));
 	gtk_box_pack_start(GTK_BOX(vbox1), drawing, FALSE, FALSE, 1);
 
 	label = gtk_label_new("");
@@ -272,10 +279,10 @@
 			   (gpointer)(long)((stream << 16) + 1));
 }
 
-static void create_mixer(GtkWidget *main, GtkWidget *notebook, int page)
+
+static void create_inputs_mixer(GtkWidget *main, GtkWidget *notebook, int page)
 {
         GtkWidget *hbox;
-        GtkWidget *hbox1;
         GtkWidget *vbox;
 
 	GtkWidget *label;
@@ -290,67 +297,64 @@
 	gtk_widget_show(hbox);
 	gtk_container_add(GTK_CONTAINER(notebook), hbox);
 
-        label = gtk_label_new("Monitor Mixer");
+        label = gtk_label_new("Monitor Inputs");
         gtk_widget_show(label);
 	gtk_notebook_set_tab_label(GTK_NOTEBOOK(notebook), 
 				   gtk_notebook_get_nth_page(GTK_NOTEBOOK(notebook),page), 
 				   label);
 
-	/* create digital mixer frame */
-	vbox = gtk_vbox_new(FALSE, 1);
-	gtk_widget_show(vbox);
-	gtk_box_pack_start(GTK_BOX(hbox), vbox, FALSE, FALSE, 0);
-
-	frame = gtk_frame_new("Digital Mixer");
-	gtk_widget_show(frame);
-	gtk_box_pack_start(GTK_BOX(vbox), frame, FALSE, TRUE, 0);
-	gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
-
+	/* build scrolling area */
+	scrolledwindow = gtk_scrolled_window_new(NULL, NULL);
+	gtk_widget_show(scrolledwindow);
+	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
+	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow),
+					GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
 
-	/* create controls in the digital mixer frame */
+	viewport = gtk_viewport_new(NULL, NULL);
+	gtk_widget_show(viewport);
+	gtk_container_add(GTK_CONTAINER(scrolledwindow), viewport);
 
 	vbox = gtk_vbox_new(FALSE, 0);
 	gtk_widget_show(vbox);
-	gtk_container_add(GTK_CONTAINER(frame), vbox);	
-
-	hbox1 = gtk_hbox_new(FALSE, 0);
-	gtk_widget_show(hbox1);
-	gtk_box_pack_start(GTK_BOX(vbox), hbox1, FALSE, FALSE, 6);
+	gtk_container_add(GTK_CONTAINER(viewport), vbox);
 
-	drawing = gtk_drawing_area_new();
-	mixer_mix_drawing = drawing;
-	gtk_widget_set_name(drawing, "DigitalMixer");
-	gtk_box_pack_start(GTK_BOX(hbox1), drawing, TRUE, FALSE, 6);
-	gtk_widget_set_usize(drawing, 98, 276);
-	gtk_signal_connect(GTK_OBJECT(drawing), "expose_event",
-			   (GtkSignalFunc)level_meters_expose_event, NULL);
-	gtk_signal_connect(GTK_OBJECT(drawing), "configure_event",
-			   (GtkSignalFunc)level_meters_configure_event, NULL);
-	gtk_widget_set_events(drawing, GDK_EXPOSURE_MASK);
-	gtk_widget_show(drawing);
+	hbox = gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox);
+	gtk_box_pack_start(GTK_BOX(vbox), hbox, FALSE, TRUE, 0);
 
-	hbox1 = gtk_hbox_new(TRUE, 0);
-	gtk_widget_show(hbox1);
-	gtk_box_pack_start(GTK_BOX(vbox), hbox1, TRUE, FALSE, 0);
-	gtk_container_set_border_width(GTK_CONTAINER(hbox1), 6);
+	for(stream = (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + 1); \
+		stream <= input_channels + (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS); stream ++) {
+		if (mixer_stream_is_active(stream))
+			create_mixer_frame(hbox, stream);
+	}
+	for(stream = (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS + 1); \
+		stream <= spdif_channels + (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS); stream ++) {
+		if (mixer_stream_is_active(stream))
+			create_mixer_frame(hbox, stream);
+	}
+}
 
-	label = gtk_label_new("Left");
-	gtk_misc_set_alignment(GTK_MISC(label), 0, 0.5);
-	gtk_widget_show(label);
-	gtk_box_pack_start(GTK_BOX(hbox1), label, FALSE, TRUE, 0);
+static void create_pcms_mixer(GtkWidget *main, GtkWidget *notebook, int page)
+{
+        GtkWidget *hbox;
+        GtkWidget *vbox;
 
-	label = gtk_label_new("Right");
-	gtk_misc_set_alignment(GTK_MISC(label), 1, 0.5);
-	gtk_widget_show(label);
-	gtk_box_pack_start(GTK_BOX(hbox1), label, FALSE, TRUE, 0);
+	GtkWidget *label;
+	GtkWidget *frame;
+	GtkWidget *drawing;
+	GtkWidget *scrolledwindow;
+	GtkWidget *viewport;
+	int stream;
 
+	hbox = gtk_hbox_new(FALSE, 3);
+	gtk_widget_show(hbox);
+	gtk_container_add(GTK_CONTAINER(notebook), hbox);
 
-	mixer_clear_peaks_button = gtk_button_new_with_label("Reset Peaks");
-	gtk_widget_show(mixer_clear_peaks_button);
-	gtk_box_pack_start(GTK_BOX(vbox), mixer_clear_peaks_button, TRUE, FALSE, 0);
-	gtk_container_set_border_width(GTK_CONTAINER(mixer_clear_peaks_button), 6);
-	gtk_signal_connect(GTK_OBJECT(mixer_clear_peaks_button), "clicked",
-			   GTK_SIGNAL_FUNC(level_meters_reset_peaks), NULL);
+        label = gtk_label_new("Monitor PCMs");
+        gtk_widget_show(label);
+	gtk_notebook_set_tab_label(GTK_NOTEBOOK(notebook),
+				   gtk_notebook_get_nth_page(GTK_NOTEBOOK(notebook),page),
+				   label);
 
 	/* build scrolling area */
 	scrolledwindow = gtk_scrolled_window_new(NULL, NULL);
@@ -380,16 +384,7 @@
 		if (mixer_stream_is_active(stream) && view_spdif_playback)
 			create_mixer_frame(hbox, stream);
 	}
-	for(stream = (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + 1); \
-		stream <= input_channels + (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS); stream ++) {
-		if (mixer_stream_is_active(stream))
-			create_mixer_frame(hbox, stream);
-	}
-	for(stream = (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS + 1); \
-		stream <= spdif_channels + (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS); stream ++) {
-		if (mixer_stream_is_active(stream))
-			create_mixer_frame(hbox, stream);
-	}
+
 }
 
 static void create_router_frame(GtkWidget *box, int stream, int pos)
@@ -452,7 +447,7 @@
 
 	frame = gtk_frame_new(str);
 	gtk_widget_show(frame);
-	gtk_box_pack_start (GTK_BOX(box), frame, FALSE, TRUE, 0);
+	gtk_box_pack_start (GTK_BOX(box), frame, FALSE, FALSE, 0);
 	gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
 
 
@@ -566,7 +561,7 @@
 
 	frame = gtk_frame_new("Master Clock");
 	gtk_widget_show(frame);
-	gtk_box_pack_start(GTK_BOX(box), frame, TRUE, TRUE, 0);
+	gtk_box_pack_start(GTK_BOX(box), frame, FALSE, FALSE, 4);
 
 
 	vbox = gtk_vbox_new(FALSE, 0);
@@ -1232,7 +1227,7 @@
 
         frame = gtk_frame_new("Phono Input Switch");
         gtk_widget_show(frame);
-        gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
+        gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 7);
         gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
 
         vbox = gtk_vbox_new(FALSE, 0);
@@ -1275,8 +1270,8 @@
 
         frame = gtk_frame_new("Line In Selector");
         gtk_widget_show(frame);
-        gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 0);
-        gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
+        gtk_box_pack_start(GTK_BOX(box), frame, FALSE, TRUE, 4);
+        //gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
 
         vbox = gtk_vbox_new(FALSE, 0);
         gtk_widget_show(vbox);
@@ -1327,50 +1322,84 @@
 {
 	GtkWidget *label;
 	GtkWidget *hbox;
+	GtkWidget *hbox1;
+	GtkWidget *hbox2;
 	GtkWidget *vbox;
+	GtkWidget *vbox1;
 	GtkWidget *vbox2;
+	GtkWidget *scrolledwindow;
+	GtkWidget *viewport;
+	GtkWidget *hseparator;
 
 	hbox = gtk_hbox_new(FALSE, 0);
 	gtk_widget_show(hbox);
 	gtk_container_add(GTK_CONTAINER(notebook), hbox);
+
 	label = gtk_label_new("Hardware Settings");
 	gtk_widget_show(label);
 	gtk_notebook_set_tab_label(GTK_NOTEBOOK(notebook), 
 				   gtk_notebook_get_nth_page(GTK_NOTEBOOK(notebook), page), 
 				   label);
 
+	/* Build scrolling area */
+	scrolledwindow = gtk_scrolled_window_new(NULL, NULL);
+	gtk_widget_show(scrolledwindow);
+	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
+	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow),
+					GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
+
+	viewport = gtk_viewport_new(NULL, NULL);
+	gtk_widget_show(viewport);
+	gtk_container_add(GTK_CONTAINER(scrolledwindow), viewport);
+
+	/* Outer box */
+	hbox = gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox);
+	gtk_container_add(GTK_CONTAINER(viewport), hbox);
 
+	/* Create boxes for controls */
 	vbox = gtk_vbox_new(FALSE, 0);
 	gtk_widget_show(vbox);
-	gtk_box_pack_start(GTK_BOX(hbox), vbox, FALSE, TRUE, 0);
-	gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+	gtk_box_pack_start(GTK_BOX(hbox), vbox, FALSE, FALSE, 6);
 
-	vbox2 = gtk_vbox_new(FALSE, 0);
-	gtk_widget_show(vbox2);
-	gtk_box_pack_end(GTK_BOX(hbox),vbox2, FALSE, FALSE, 0);
-	gtk_container_set_border_width(GTK_CONTAINER(vbox2), 6);
+	hbox1 = gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox1);
+	gtk_box_pack_start(GTK_BOX(vbox), hbox1, FALSE, FALSE, 0);
+
+	hseparator = gtk_hseparator_new();
+	gtk_widget_show(hseparator);
+	gtk_box_pack_start(GTK_BOX(vbox), hseparator, FALSE, FALSE, 2);
+
+	hbox2 = gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox2);
+	gtk_box_pack_start(GTK_BOX(vbox), hbox2, FALSE, FALSE, 0);
+
+	create_master_clock(hbox1);
 
-	create_master_clock(vbox);
-	create_rate_state(vbox);
-	create_actual_rate(vbox);
-	create_volume_change(vbox);
-
- 	create_spdif_output_settings(hbox); 
-
- 	create_spdif_input_select(vbox2);
-	create_input_interface(vbox2);
-	create_phono_input(vbox2);
+	vbox1 = gtk_vbox_new(FALSE, 0);
+	gtk_widget_show(vbox1);
+	gtk_box_pack_start(GTK_BOX(hbox1), vbox1, FALSE, FALSE, 20);
+
+	create_rate_state(vbox1);
+	create_actual_rate(vbox1);
+	create_volume_change(vbox1);
+	create_input_interface(hbox2);
+	create_phono_input(hbox2);
+	create_spdif_input_select(hbox2);
+	create_spdif_output_settings(hbox);
 }
 
 static void create_about(GtkWidget *main, GtkWidget *notebook, int page)
 {
 	GtkWidget *label;
 	GtkWidget *vbox;
+	GtkWidget *hbox;
+	GtkWidget *scrolledwindow;
+	GtkWidget *viewport;
 
-	vbox = gtk_vbox_new(FALSE, 0);
-	gtk_widget_show(vbox);
-	gtk_container_add(GTK_CONTAINER(notebook), vbox);
-	gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+	hbox = gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox);
+	gtk_container_add(GTK_CONTAINER(notebook), hbox);
 
         label = gtk_label_new("About");
         gtk_widget_show(label);
@@ -1378,12 +1407,31 @@
 				   gtk_notebook_get_nth_page(GTK_NOTEBOOK(notebook), page), 
 				   label);
 
+	/* build scrolling area */
+	scrolledwindow = gtk_scrolled_window_new(NULL, NULL);
+	gtk_widget_show(scrolledwindow);
+	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
+	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow),
+					GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
+
+	viewport = gtk_viewport_new(NULL, NULL);
+	gtk_widget_show(viewport);
+	gtk_container_add(GTK_CONTAINER(scrolledwindow), viewport);
+
+
+	vbox = gtk_vbox_new(FALSE, 0);
+	gtk_widget_show(vbox);
+	gtk_container_add(GTK_CONTAINER(viewport), vbox);
+	gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+
+
+	/* Create text as labels */
 	label = gtk_label_new("");
         gtk_widget_show(label);
 	gtk_box_pack_start(GTK_BOX(vbox), label, TRUE, TRUE, 6);
 
 	/* create first line */
-	label = gtk_label_new("Envy24 Control Utility " VERSION);
+	label = gtk_label_new("Envy24 Control Utility APH MOD 3.6-16.12.05 v" VERSION);
         gtk_widget_show(label);
 	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, TRUE, 6);
 
@@ -1762,24 +1810,26 @@
 {
 	GtkWidget *label;
 	GtkWidget *label_card_nr;
-	GtkWidget *vbox;
 	GtkWidget *vbox1;
+	GtkWidget *vbox2;
+	GtkWidget *hbox;
 	GtkWidget *hbox1;
-	GtkWidget *hbox2;
 	GtkWidget *save_button;
 	GtkWidget *delete_button;
 	GtkObject *card_button_adj;
 	GtkWidget *card_button;
+	GtkWidget *scrolledwindow;
+	GtkWidget *viewport;
 	gint index;
 	gint profile_number;
 	gchar *profile_name;
 	gint max_profiles;
 	gint max_digits;
 
-	vbox = gtk_vbox_new(FALSE, 0);
-	gtk_widget_show(vbox);
-	gtk_container_add(GTK_CONTAINER(notebook), vbox);
-	gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+	hbox = gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox);
+	gtk_container_add(GTK_CONTAINER(notebook), hbox);
+
 
         label = gtk_label_new("Profiles");
         gtk_widget_show(label);
@@ -1787,56 +1837,73 @@
 				   gtk_notebook_get_nth_page(GTK_NOTEBOOK(notebook), page), 
 				   label);
 
+	/* build scrolling area */
+	scrolledwindow = gtk_scrolled_window_new(NULL, NULL);
+	gtk_widget_show(scrolledwindow);
+	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
+	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow),
+					GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
+
+	viewport = gtk_viewport_new(NULL, NULL);
+	gtk_widget_show(viewport);
+	gtk_container_add(GTK_CONTAINER(scrolledwindow), viewport);
+
+	hbox = gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox);
+	gtk_container_add(GTK_CONTAINER(viewport), hbox);
+	gtk_container_set_border_width(GTK_CONTAINER(hbox), 0);
+
+
+	/* Create button boxes */
 	vbox1 = gtk_vbutton_box_new();
 
-	for (index = 0; index < MAX_PROFILES; index++)
-	{
+	gtk_vbutton_box_set_spacing_default(0);
+	for (index = 0; index < MAX_PROFILES; index++)	{
 		profile_name = get_profile_name(index + 1, card_number, profiles_file_name);
 		profiles_toggle_buttons[index].toggle_button = toggle_button_entry(window, profile_name, index);
-		gtk_box_pack_start(GTK_BOX (vbox1), profiles_toggle_buttons[index].toggle_button, FALSE, FALSE, 20);
+		gtk_box_pack_start(GTK_BOX (vbox1), profiles_toggle_buttons[index].toggle_button, FALSE, FALSE, 0);
 	}
-
 	gtk_widget_show(vbox1);
-	gtk_container_border_width(GTK_CONTAINER(vbox1), 20);
+	gtk_container_border_width(GTK_CONTAINER(vbox1), 6);
 
-	hbox1 = gtk_hbutton_box_new();
-	gtk_widget_show(hbox1);
-	gtk_container_border_width(GTK_CONTAINER(hbox1), 20);
+	vbox2 = gtk_vbutton_box_new();
+	gtk_widget_show(vbox2);
+	gtk_container_border_width(GTK_CONTAINER(vbox2), 50);
 
-	hbox2 = gtk_hbox_new(FALSE, 0);
-	gtk_widget_show(hbox2);
-	gtk_box_pack_start(GTK_BOX (hbox1), hbox2, FALSE, FALSE, 20);
+	hbox1 = gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox1);
+	gtk_box_pack_start(GTK_BOX(vbox2), hbox1, FALSE, FALSE, 20);
 
         label_card_nr = gtk_label_new("Card Number:");
         gtk_widget_show(label_card_nr);
-	gtk_box_pack_start(GTK_BOX (hbox2), label_card_nr, FALSE, FALSE, 20);
-	gtk_label_set_justify(GTK_LABEL (label_card_nr), GTK_JUSTIFY_LEFT);
+	gtk_box_pack_start(GTK_BOX(hbox1), label_card_nr, FALSE, FALSE, 20);
+	gtk_label_set_justify(GTK_LABEL(label_card_nr), GTK_JUSTIFY_LEFT);
 
 	card_button_adj = gtk_adjustment_new(16, 0, MAX_CARD_NUMBERS - 1, 1, 10, 10);
 	card_number_adj = card_button_adj;
 	card_button = gtk_spin_button_new(GTK_ADJUSTMENT (card_button_adj), 1, 0);
 	gtk_widget_show(card_button);
-	gtk_box_pack_start(GTK_BOX (hbox2), card_button, TRUE, FALSE, 0);
+	gtk_box_pack_start(GTK_BOX (hbox1), card_button, TRUE, FALSE, 0);
 	gtk_spin_button_set_numeric(GTK_SPIN_BUTTON (card_button), TRUE);
 	gtk_adjustment_set_value(GTK_ADJUSTMENT (card_button_adj), card_number);
 
 	delete_button = gtk_toggle_button_new_with_label("Delete card from profiles");
 	gtk_widget_show(delete_button);
-	gtk_box_pack_start(GTK_BOX (hbox1), delete_button, FALSE, FALSE, 20);
+	gtk_box_pack_start(GTK_BOX (vbox2), delete_button, FALSE, FALSE, 20);
 	gtk_signal_connect(GTK_OBJECT (delete_button), "toggled",
 			 GTK_SIGNAL_FUNC (delete_card_number),
 			 NULL);
 
 	save_button = gtk_toggle_button_new_with_label("Save active profile");
 	gtk_widget_show(save_button);
-	gtk_box_pack_end(GTK_BOX (hbox1), save_button, FALSE, FALSE, 20);
+	gtk_box_pack_end(GTK_BOX (vbox2), save_button, FALSE, FALSE, 20);
 	gtk_signal_connect(GTK_OBJECT (save_button), "toggled",
 			 GTK_SIGNAL_FUNC (save_active_profile),
 			 NULL);
 
-	gtk_container_add(GTK_CONTAINER (vbox), vbox1);
-	gtk_container_add(GTK_CONTAINER (vbox), hbox1);
-	gtk_widget_show(vbox);
+	gtk_container_add(GTK_CONTAINER(hbox), vbox1);
+	gtk_container_add(GTK_CONTAINER(hbox), vbox2);
+
 	if (default_profile != NULL)
 	{
 		/*
@@ -1865,9 +1932,102 @@
 	}
 }
 
+static void create_outer(GtkWidget *main)
+{
+        GtkWidget *hbox;
+        GtkWidget *hbox1;
+        GtkWidget *vbox;
+
+	GtkWidget *label;
+	GtkWidget *frame;
+	GtkWidget *drawing;
+
+	/* Create digital mixer frame */
+	vbox = gtk_vbox_new(FALSE, 1);
+	gtk_widget_show(vbox);
+	gtk_box_pack_start(GTK_BOX(main), vbox, FALSE, FALSE, 0);
+
+	label = gtk_label_new(" Rt-clk Menu >>");
+	//gtk_misc_set_alignment(GTK_MISC(label), 0, 0.5);
+	gtk_widget_show(label);
+	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 3);
+	frame = gtk_frame_new("Digital Mixer");
+	gtk_widget_show(frame);
+	gtk_box_pack_start(GTK_BOX(vbox), frame, FALSE, TRUE, 0);
+	gtk_container_set_border_width(GTK_CONTAINER(frame), 6);
+
+	/* Create controls in the digital mixer frame */
+
+	vbox = gtk_vbox_new(FALSE, 0);
+	gtk_widget_show(vbox);
+	gtk_container_add(GTK_CONTAINER(frame), vbox);	
+
+	hbox1 = gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox1);
+	gtk_box_pack_start(GTK_BOX(vbox), hbox1, FALSE, FALSE, 6);
+
+	drawing = gtk_drawing_area_new();
+	mixer_mix_drawing = drawing;
+	gtk_widget_set_name(drawing, "DigitalMixer");
+	gtk_box_pack_start(GTK_BOX(hbox1), drawing, TRUE, FALSE, 6);
+	if (tall_equal_mixer_ht > 1 ) {
+		gtk_widget_set_usize(drawing, 60, 264 + 60 * (tall_equal_mixer_ht - 1));
+	} else {
+		gtk_widget_set_usize(drawing, 60, 264);
+	}
+	gtk_signal_connect(GTK_OBJECT(drawing), "expose_event",
+			   (GtkSignalFunc)level_meters_expose_event, NULL);
+	gtk_signal_connect(GTK_OBJECT(drawing), "configure_event",
+			   (GtkSignalFunc)level_meters_configure_event, NULL);
+	gtk_widget_set_events(drawing, GDK_EXPOSURE_MASK);
+	gtk_widget_show(drawing);
+
+	hbox1 = gtk_hbox_new(TRUE, 0);
+	gtk_widget_show(hbox1);
+	gtk_box_pack_start(GTK_BOX(vbox), hbox1, TRUE, FALSE, 0);
+	gtk_container_set_border_width(GTK_CONTAINER(hbox1), 6);
+
+	label = gtk_label_new("Left");
+	gtk_misc_set_alignment(GTK_MISC(label), 0, 0.5);
+	gtk_widget_show(label);
+	gtk_box_pack_start(GTK_BOX(hbox1), label, FALSE, TRUE, 0);
+
+	label = gtk_label_new("Right");
+	gtk_misc_set_alignment(GTK_MISC(label), 1, 0.5);
+	gtk_widget_show(label);
+	gtk_box_pack_start(GTK_BOX(hbox1), label, FALSE, TRUE, 0);
+
+
+	mixer_clear_peaks_button = gtk_button_new_with_label("Reset Peaks");
+	gtk_widget_show(mixer_clear_peaks_button);
+	gtk_box_pack_start(GTK_BOX(vbox), mixer_clear_peaks_button, TRUE, FALSE, 0);
+	gtk_container_set_border_width(GTK_CONTAINER(mixer_clear_peaks_button), 4);
+	gtk_signal_connect(GTK_OBJECT(mixer_clear_peaks_button), "clicked",
+			   GTK_SIGNAL_FUNC(level_meters_reset_peaks), NULL);
+}/* End create_outer  */
+
+static void create_blank(GtkWidget *main, GtkWidget *notebook, int page)
+{
+/*	This is a little workaround for a problem with the pop-up menu.
+	For some reason the label of the last page is not accessed by the menu
+	so all it shows is 'page 7'.  Here a blank extra page is created, unseen,
+	which seems to satisfy gtk, and we see the menu last page label correct. AH 12.7.2005 */
+
+	GtkWidget *label;
+	GtkWidget *hbox;
+
+	hbox = gtk_hbox_new(FALSE, 0);
+	gtk_container_add(GTK_CONTAINER(notebook), hbox);
+
+        label = gtk_label_new("Blank");
+	gtk_notebook_set_tab_label(GTK_NOTEBOOK(notebook),
+				   gtk_notebook_get_nth_page(GTK_NOTEBOOK(notebook), page),
+				   label);
+}
+
 static void usage(void)
 {
-	fprintf(stderr, "usage: envy24control [-c card#] [-D control-name] [-o num-outputs] [-i num-inputs] [-p num-pcm-outputs] [-s num-spdif-in/outs] [-v] [-f profiles-file] [profile name|profile id] [-m channel-num]\n");
+	fprintf(stderr, "usage: envy24control [-c card#] [-D control-name] [-o num-outputs] [-i num-inputs] [-p num-pcm-outputs] [-s num-spdif-in/outs] [-v] [-f profiles-file] [profile name|profile id] [-m channel-num] [-w initial-window-width] [-t height-num]\n");
 	fprintf(stderr, "\t-c, --card\tAlsa card number to control\n");
 	fprintf(stderr, "\t-D, --device\tcontrol-name\n");
 	fprintf(stderr, "\t-o, --outputs\tLimit number of analog line outputs to display\n");
@@ -1877,11 +2037,14 @@
 	fprintf(stderr, "\t-v, --view_spdif_playback\tshows the spdif playback channels in the mixer\n");
 	fprintf(stderr, "\t-f, --profiles_file\tuse file as profiles file\n");
 	fprintf(stderr, "\t-m, --midichannel\tmidi channel number for controller control\n");
+	fprintf(stderr, "\t-w, --window_width\tSet initial window width (try 2,6 or 8; 280,626, or 968)\n");
+	fprintf(stderr, "\t-t, --tall_eq_mixer_heights\tSet taller height mixer displays (1-9)\n");
 }
 
 int main(int argc, char **argv)
 {
         GtkWidget *notebook;
+	GtkWidget *outerbox;
         char *name, tmpname[8], title[128];
 	int i, c, err;
 	snd_ctl_card_info_t *hw_info;
@@ -1893,6 +2056,12 @@
 	int input_channels_set = 0;
 	int output_channels_set = 0;
 	int pcm_output_channels_set = 0;
+	int width_val;
+	int wwidth_set =FALSE;
+	int wwidth = 796;
+	const chanwidth = 86;
+	const fixwidth = 108;
+
 	static struct option long_options[] = {
 		{"device", 1, 0, 'D'},
 		{"card", 1, 0, 'c'},
@@ -1903,7 +2072,9 @@
 		{"outputs", 1, 0, 'o'},
 		{"pcm_outputs", 1, 0, 'p'},
 		{"spdif", 1, 0, 's'},
+		{"window_width", 1, 0, 'w'},
 		{"view_spdif_playback", 0, 0, 'v'},
+		{"tall_eq_mixer_heights", 1, 0, 't'},
 		{ NULL }
 	};
 
@@ -1923,7 +2094,7 @@
 	view_spdif_playback = 0;
 	profiles_file_name = DEFAULT_PROFILERC;
 	default_profile = NULL;
-	while ((c = getopt_long(argc, argv, "D:c:f:i:m:Mo:p:s:v", long_options, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "D:c:f:i:m:Mo:p:s:w:vt:", long_options, NULL)) != -1) {
 		switch (c) {
 		case 'D':
 			name = optarg;
@@ -1986,9 +2157,23 @@
 				exit(1);
 			}
 			break;
+		case 'w':
+			width_val = atoi(optarg);
+			if ((width_val >= 1) && (width_val <= 20)) {
+				wwidth = (width_val * chanwidth + fixwidth);
+			} else {
+				wwidth = width_val;
+			}
+			wwidth_set = TRUE;
+			break;
 		case 'v':
 			view_spdif_playback = 1;
 			break;
+		case 't':
+			tall_equal_mixer_ht = atoi(optarg);
+			if ((tall_equal_mixer_ht < 0) || (tall_equal_mixer_ht >= 10))
+				tall_equal_mixer_ht = 0;
+			break;
 		default:
 			usage();
 			exit(1);
@@ -2047,23 +2232,22 @@
 		card_is_dmx6fire = TRUE;
 
 	/* Set a better default for input_channels and output_channels */
-	if(!input_channels_set) {
-		if(card_is_dmx6fire) {
+	if(!input_channels_set)
+		if(card_is_dmx6fire)
 			input_channels = 6;
-		}
-	}
 
-	if(!output_channels_set) {
-		if(card_is_dmx6fire) {
+	if(!output_channels_set)
+		if(card_is_dmx6fire)
 			output_channels = 6;
-		}
-	}
 
-	if(!pcm_output_channels_set) {
-		if(card_is_dmx6fire) {
+	if(!pcm_output_channels_set)
+		if(card_is_dmx6fire)
 			pcm_output_channels = 6; /* PCMs 7&8 can be used -set using option -p8 */
-		}
-	}
+
+	if (!wwidth_set)
+		if (card_is_dmx6fire)
+			wwidth = 626;
+
 
 	/* Initialize code */
 	config_open();
@@ -2088,20 +2272,32 @@
                            (GtkSignalFunc) gtk_main_quit, NULL);
         signal(SIGINT, (void *)gtk_main_quit);
 
+	gtk_window_set_default_size(GTK_WINDOW(window), wwidth, 300);
+
+	outerbox = gtk_hbox_new(FALSE, 3);
+	gtk_widget_show(outerbox);
+	gtk_container_add(GTK_CONTAINER(window), outerbox);
+
+	create_outer(outerbox);
+
         /* Create the notebook */
         notebook = gtk_notebook_new();
+	gtk_notebook_set_scrollable(GTK_NOTEBOOK(notebook), TRUE);
+	gtk_notebook_popup_enable(GTK_NOTEBOOK(notebook));
         gtk_widget_show(notebook);
-	gtk_container_add(GTK_CONTAINER(window), notebook);
+	gtk_container_add(GTK_CONTAINER(outerbox), notebook);
 
 	page = 0;
-	create_mixer(window, notebook, page++);
 
-	create_router(window, notebook, page++);
-	create_hardware(window, notebook, page++);
+	create_inputs_mixer(outerbox, notebook, page++);
+	create_pcms_mixer(outerbox, notebook, page++);
+	create_router(outerbox, notebook, page++);
+	create_hardware(outerbox, notebook, page++);
 	if (envy_analog_volume_available())
-		create_analog_volume(window, notebook, page++);
-	create_profiles(window, notebook, page++);
-	create_about(window, notebook, page++);
+		create_analog_volume(outerbox, notebook, page++);
+	create_profiles(outerbox, notebook, page++);
+	create_about(outerbox, notebook, page++);
+	create_blank(outerbox, notebook, page++);
 
 	npfds = snd_ctl_poll_descriptors_count(ctl);
 	if (npfds > 0) {
diff -ru Denvy24control/levelmeters.c Aenvy24control/levelmeters.c
--- Denvy24control/levelmeters.c	2004-03-05 09:10:01.000000000 +0000
+++ Aenvy24control/levelmeters.c	2005-12-16 17:29:08.000000000 +0000
@@ -1,6 +1,6 @@
 /*****************************************************************************
    levelmeters.c - Stereo level meters
-   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz>
+   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz>  AHmod 3.4 14.12.05
    
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
@@ -200,57 +200,57 @@
 	for (idx = 0; idx <= pcm_output_channels; idx++) {
 		get_levels(idx, &l1, &l2);
 		widget = idx == 0 ? mixer_mix_drawing : mixer_drawing[idx-1];
-		if (!GTK_WIDGET_VISIBLE(widget))
-			continue;
-		redraw_meters(idx, widget->allocation.width, widget->allocation.height, l1, l2);
-		gdk_draw_pixmap(widget->window,
-				widget->style->black_gc,
-				pixmap[idx],
-				0, 0,
-				0, 0,
-				widget->allocation.width, widget->allocation.height);	
+		if (GTK_WIDGET_VISIBLE(widget) && (pixmap[idx] != NULL)) {
+			redraw_meters(idx, widget->allocation.width, widget->allocation.height, l1, l2);
+			gdk_draw_pixmap(widget->window,
+					widget->style->black_gc,
+					pixmap[idx],
+					0, 0,
+					0, 0,
+					widget->allocation.width, widget->allocation.height);
+		}
 	}
 	if (view_spdif_playback) {
 		for (idx = MAX_PCM_OUTPUT_CHANNELS + 1; idx <= MAX_OUTPUT_CHANNELS + spdif_channels; idx++) {
 			get_levels(idx, &l1, &l2);
 			widget = idx == 0 ? mixer_mix_drawing : mixer_drawing[idx-1];
-			if (!GTK_WIDGET_VISIBLE(widget))
-				continue;
+			if (GTK_WIDGET_VISIBLE(widget) && (pixmap[idx] != NULL)) {
+				redraw_meters(idx, widget->allocation.width, widget->allocation.height, l1, l2);
+				gdk_draw_pixmap(widget->window,
+						widget->style->black_gc,
+						pixmap[idx],
+						0, 0,
+						0, 0,
+						widget->allocation.width, widget->allocation.height);
+			}
+		}
+	}
+	for (idx = MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + 1; idx <= input_channels + MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS; idx++) {
+		get_levels(idx, &l1, &l2);
+		widget = idx == 0 ? mixer_mix_drawing : mixer_drawing[idx-1];
+		if (GTK_WIDGET_VISIBLE(widget) && (pixmap[idx] != NULL)) {
 			redraw_meters(idx, widget->allocation.width, widget->allocation.height, l1, l2);
 			gdk_draw_pixmap(widget->window,
 					widget->style->black_gc,
 					pixmap[idx],
 					0, 0,
 					0, 0,
-					widget->allocation.width, widget->allocation.height);	
+					widget->allocation.width, widget->allocation.height);
 		}
 	}
-	for (idx = MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + 1; idx <= input_channels + MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS; idx++) {
-		get_levels(idx, &l1, &l2);
-		widget = idx == 0 ? mixer_mix_drawing : mixer_drawing[idx-1];
-		if (!GTK_WIDGET_VISIBLE(widget))
-			continue;
-		redraw_meters(idx, widget->allocation.width, widget->allocation.height, l1, l2);
-		gdk_draw_pixmap(widget->window,
-				widget->style->black_gc,
-				pixmap[idx],
-				0, 0,
-				0, 0,
-				widget->allocation.width, widget->allocation.height);	
-	}
 	for (idx = MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS + 1; \
 		    idx <= spdif_channels + MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS; idx++) {
 		get_levels(idx, &l1, &l2);
 		widget = idx == 0 ? mixer_mix_drawing : mixer_drawing[idx-1];
-		if (!GTK_WIDGET_VISIBLE(widget))
-			continue;
-		redraw_meters(idx, widget->allocation.width, widget->allocation.height, l1, l2);
-		gdk_draw_pixmap(widget->window,
-				widget->style->black_gc,
-				pixmap[idx],
-				0, 0,
-				0, 0,
-				widget->allocation.width, widget->allocation.height);	
+		if (GTK_WIDGET_VISIBLE(widget) && (pixmap[idx] != NULL)) {
+			redraw_meters(idx, widget->allocation.width, widget->allocation.height, l1, l2);
+			gdk_draw_pixmap(widget->window,
+					widget->style->black_gc,
+					pixmap[idx],
+					0, 0,
+					0, 0,
+					widget->allocation.width, widget->allocation.height);
+		}
 	}
 	return TRUE;
 }

--Boundary-00=_RRxoDV5GJlFYR9Z--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
