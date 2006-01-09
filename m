From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Envy24control peak metering
Date: Mon, 9 Jan 2006 11:41:39 +0000
Message-ID: <200601091141.39338.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zvkwDxJWbTxmOTH"
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
To: alsa-devel@lists.sourceforge.net
Cc: Dirk Jagdmann <doj@cubic.org>, Doug McLain <doug@nostar.net>, John Rigg <j@sound-man.co.uk>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_zvkwDxJWbTxmOTH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have put together this patch to add peak metering bars on envy24control 
(e24c-1.0.10-AHmod4.1.patch).  At present, this posting is so others can try 
it out, report back, comment, etc.  I have cc'd a few known envy24 users.

Individually selectable rider and clip indicators are provided, with option of 
timed auto-reset.  At any time all can be reset using the (already provided) 
'Reset Peaks' button.  The selection controls are on a new page 'Extras' as 
unfortunately they don't relate to any of the existing pages.

The patch should apply successfully to CVS, but earlier versions may need the 
AHmod3.6d.patch I posted applied first so the line references are reasonably 
close (not for any functional reasons) or patch line nos changing by hand to 
suit.

Let me know how you get on and comments.


Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_zvkwDxJWbTxmOTH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="e24c-1.0.10-AHmod4.1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="e24c-1.0.10-AHmod4.1.patch"

diff -ru Denvy24control/envy24control.c Aenvy24control/envy24control.c
=2D-- Denvy24control/envy24control.c	2006-01-07 00:21:19.000000000 +0000
+++ Aenvy24control/envy24control.c	2006-01-08 22:45:40.000000000 +0000
@@ -1,6 +1,6 @@
 /*************************************************************************=
****
    envy24control.c - Env24 chipset (ICE1712) control utility
=2D   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz>
+   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz> **AHmod 4.1 3.1.06

    (2003/03/22) Changed to hbox/vbox layout.
    Copyright (C) 2003 by S=C3=B8ren Wedel Nielsen
@@ -74,6 +74,13 @@
 GtkObject *hw_volume_change_adj;
 GtkWidget *hw_volume_change_spin;

+GtkWidget *clip_peaks_check;
+GtkWidget *auto_reset_clips_check;
+GtkWidget *riding_peaks_check;
+GtkWidget *auto_reset_riders_check;
+GtkObject *sw_peaks_reset_time_adj;
+//GtkWidget *sw_peaks_reset_time_spin;
+
 GtkWidget *hw_spdif_profi_nonaudio_radio;
 GtkWidget *hw_spdif_profi_audio_radio;
=20
@@ -210,7 +217,7 @@
 	gtk_signal_connect(GTK_OBJECT(drawing), "configure_event",
 			   GTK_SIGNAL_FUNC(level_meters_configure_event), NULL);
 	gtk_widget_set_events(drawing, GDK_EXPOSURE_MASK);
=2D	gtk_widget_set_usize(drawing, 36, (60 * tall_equal_mixer_ht + 204));
+	gtk_widget_set_usize(drawing, 36, (60 * tall_equal_mixer_ht + 202));
 	gtk_box_pack_start(GTK_BOX(vbox1), drawing, FALSE, FALSE, 1);
=20
 	label =3D gtk_label_new("");
@@ -737,8 +744,105 @@
 	gtk_spin_button_set_numeric(GTK_SPIN_BUTTON(spinbutton), TRUE);
 	gtk_signal_connect(GTK_OBJECT(spinbutton_adj), "value_changed",
 			   GTK_SIGNAL_FUNC(volume_change_rate_adj), NULL);
=2D=09
+
 }
+static void create_peak_bars(GtkWidget *box)
+{
+	GtkWidget *frame;
+	GtkWidget *vbox;
+	GtkWidget *vbox1;
+	GtkWidget *hbox;
+	GtkWidget *check;
+	GtkWidget *label;
+	GtkObject *spinbutton_adj;
+	GtkWidget *spinbutton;
+
+
+	frame =3D gtk_frame_new("Peak Bars");
+	gtk_widget_show(frame);
+	gtk_box_pack_start(GTK_BOX(box), frame, FALSE, FALSE, 0);
+
+	vbox =3D gtk_vbox_new(FALSE, 0);
+	gtk_widget_show(vbox);
+	gtk_container_add(GTK_CONTAINER(frame), vbox);
+	gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+
+	frame =3D gtk_frame_new("Clip Bar 98%");
+        gtk_widget_show(frame);
+	gtk_box_pack_start(GTK_BOX(vbox), frame, FALSE, FALSE, 0);
+
+	vbox1 =3D gtk_vbox_new(FALSE, 0);
+	gtk_widget_show(vbox1);
+	gtk_container_add(GTK_CONTAINER(frame), vbox1);
+//	gtk_container_set_border_width(GTK_CONTAINER(vbox1), 0);
+
+	check =3D gtk_check_button_new_with_label("Active");
+	clip_peaks_check =3D check;
+	gtk_widget_show(check);
+	gtk_box_pack_start(GTK_BOX(vbox1), check, FALSE, FALSE, 0);
+	gtk_signal_connect(GTK_OBJECT(check), "toggled",
+			  (GtkSignalFunc)peak_bars_toggled,
+			  (gpointer)"clip_peaks");
+
+	check =3D gtk_check_button_new_with_label("Auto Reset");
+	auto_reset_clips_check =3D check;
+	gtk_widget_show(check);
+	gtk_box_pack_start(GTK_BOX(vbox1), check, FALSE, FALSE, 0);
+	gtk_signal_connect(GTK_OBJECT(check), "toggled",
+			  (GtkSignalFunc)peak_bars_toggled,
+			  (gpointer)"auto_reset_clip");
+
+	frame =3D gtk_frame_new("Riding Peaks");
+        gtk_widget_show(frame);
+	gtk_box_pack_start(GTK_BOX(vbox), frame, FALSE, FALSE, 6);
+
+	vbox1 =3D gtk_vbox_new(FALSE, 0);
+	gtk_widget_show(vbox1);
+	gtk_container_add(GTK_CONTAINER(frame), vbox1);
+
+	check =3D gtk_check_button_new_with_label("Active");
+	riding_peaks_check =3D check;
+	gtk_widget_show(check);
+	gtk_box_pack_start(GTK_BOX(vbox1), check, FALSE, FALSE, 0);
+	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(check),TRUE);
+	gtk_signal_connect(GTK_OBJECT(check), "toggled",
+			  (GtkSignalFunc)peak_bars_toggled,
+			  (gpointer)"riding_peaks");
+
+	check =3D gtk_check_button_new_with_label("Auto Reset");
+	auto_reset_riders_check =3D check;
+	gtk_widget_show(check);
+	gtk_box_pack_start(GTK_BOX(vbox1), check, FALSE, FALSE, 0);
+	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(check),TRUE);
+	gtk_signal_connect(GTK_OBJECT(check), "toggled",
+			  (GtkSignalFunc)peak_bars_toggled,
+			  (gpointer)"auto_reset_riders");
+
+	frame =3D gtk_frame_new("Reset Time");
+        gtk_widget_show(frame);
+	gtk_box_pack_start(GTK_BOX(vbox), frame, FALSE, FALSE, 0);
+
+	hbox =3D gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox);
+	gtk_container_add(GTK_CONTAINER(frame), hbox);
+	gtk_container_set_border_width(GTK_CONTAINER(hbox), 6);
+
+	label =3D gtk_label_new("Setting");
+	gtk_widget_show(label);
+	gtk_box_pack_start(GTK_BOX(hbox), label, TRUE, FALSE, 0);
+	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
+
+	spinbutton_adj =3D gtk_adjustment_new(5, 0, 9, 1, 1, 1);
+	sw_peaks_reset_time_adj =3D spinbutton_adj;
+	spinbutton =3D gtk_spin_button_new(GTK_ADJUSTMENT(spinbutton_adj), 1, 0);
+	gtk_widget_show(spinbutton);
+	gtk_box_pack_start(GTK_BOX(hbox), spinbutton, TRUE, FALSE, 0);
+	gtk_spin_button_set_numeric(GTK_SPIN_BUTTON(spinbutton), TRUE);
+	gtk_signal_connect(GTK_OBJECT(spinbutton_adj), "value_changed",
+			   GTK_SIGNAL_FUNC(peaks_reset_time_adj), NULL);
+
+}
+
=20
 static void create_spdif_output_settings_profi_data(GtkWidget *box)
 {
@@ -1381,9 +1485,53 @@
 	create_input_interface(hbox2);
 	create_phono_input(hbox2);
 	create_spdif_input_select(hbox2);
+//	vbox2 =3D gtk_vbox_new(FALSE, 0);
+//	gtk_widget_show(vbox2);
+//	gtk_box_pack_start(GTK_BOX(hbox), vbox2, FALSE, FALSE, 6);
+
+//	create_peak_bars(vbox2);
 	create_spdif_output_settings(hbox);
 }
=20
+static void create_extras(GtkWidget *main, GtkWidget *notebook, int page)
+{
+	GtkWidget *label;
+	GtkWidget *vbox;
+	GtkWidget *hbox;
+	GtkWidget *scrolledwindow;
+	GtkWidget *viewport;
+
+	hbox =3D gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox);
+	gtk_container_add(GTK_CONTAINER(notebook), hbox);
+
+        label =3D gtk_label_new("Extras");
+        gtk_widget_show(label);
+	gtk_notebook_set_tab_label(GTK_NOTEBOOK(notebook),
+				   gtk_notebook_get_nth_page(GTK_NOTEBOOK(notebook), page),
+				   label);
+
+//	/* build scrolling area */                         /* Leave in for late=
r */
+//	scrolledwindow =3D gtk_scrolled_window_new(NULL, NULL);
+//	gtk_widget_show(scrolledwindow);
+//	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
+//	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow),
+//					GTK_POLICY_AUTOMATIC, GTK_POLICY_NEVER);
+
+//	viewport =3D gtk_viewport_new(NULL, NULL);
+//	gtk_widget_show(viewport);
+//	gtk_container_add(GTK_CONTAINER(scrolledwindow), viewport);
+
+
+	vbox =3D gtk_vbox_new(FALSE, 0);
+	gtk_widget_show(vbox);
+	gtk_box_pack_start(GTK_BOX(hbox), vbox, FALSE, FALSE, 6);
+//	gtk_container_add(GTK_CONTAINER(hbox), vbox);
+//	gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+
+	create_peak_bars(vbox);
+}
+
 static void create_about(GtkWidget *main, GtkWidget *notebook, int page)
 {
 	GtkWidget *label;
@@ -1426,7 +1574,7 @@
 	gtk_box_pack_start(GTK_BOX(vbox), label, TRUE, TRUE, 6);
=20
 	/* create first line */
=2D	label =3D gtk_label_new("Envy24 Control Utility " VERSION);
+	label =3D gtk_label_new("Envy24 Control Utility APH MOD 4.1-3.1.06 v" VER=
SION);
         gtk_widget_show(label);
 	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, TRUE, 6);
=20
@@ -1966,9 +2114,9 @@
 	gtk_widget_set_name(drawing, "DigitalMixer");
 	gtk_box_pack_start(GTK_BOX(hbox1), drawing, TRUE, FALSE, 6);
 	if (tall_equal_mixer_ht > 1 ) {
=2D		gtk_widget_set_usize(drawing, 60, 264 + 60 * (tall_equal_mixer_ht - 1)=
);
+		gtk_widget_set_usize(drawing, 60, 262 + 60 * (tall_equal_mixer_ht - 1));
 	} else {
=2D		gtk_widget_set_usize(drawing, 60, 264);
+		gtk_widget_set_usize(drawing, 60, 262);
 	}
 	gtk_signal_connect(GTK_OBJECT(drawing), "expose_event",
 			   (GtkSignalFunc)level_meters_expose_event, NULL);
@@ -2290,6 +2438,7 @@
 	create_hardware(outerbox, notebook, page++);
 	if (envy_analog_volume_available())
 		create_analog_volume(outerbox, notebook, page++);
+	create_extras(outerbox, notebook, page++);
 	create_profiles(outerbox, notebook, page++);
 	create_about(outerbox, notebook, page++);
 	create_blank(outerbox, notebook, page++);
diff -ru Denvy24control/envy24control.h Aenvy24control/envy24control.h
=2D-- Denvy24control/envy24control.h	2006-01-07 00:21:19.000000000 +0000
+++ Aenvy24control/envy24control.h	2006-01-08 22:34:47.000000000 +0000
@@ -1,4 +1,4 @@
=2D#include <stdio.h>
+#include <stdio.h>       /*  AHmod 4.1 3.1.06   */
 #include <stdlib.h>
 #include <string.h>
 #include <signal.h>
@@ -163,6 +163,8 @@
 gint level_meters_configure_event(GtkWidget *widget, GdkEventConfigure *ev=
ent);
 gint level_meters_expose_event(GtkWidget *widget, GdkEventExpose *event);
 gint level_meters_timeout_callback(gpointer data);
+void peak_bars_toggled(GtkWidget *togglebutton, gpointer data);
+void peaks_reset_time_adj(GtkAdjustment *adj, gpointer data);
 void level_meters_reset_peaks(GtkButton *button, gpointer data);
 void level_meters_init(void);
 void level_meters_postinit(void);
diff -ru Denvy24control/levelmeters.c Aenvy24control/levelmeters.c
=2D-- Denvy24control/levelmeters.c	2006-01-04 17:12:56.000000000 +0000
+++ Aenvy24control/levelmeters.c	2006-01-08 22:39:16.000000000 +0000
@@ -1,6 +1,6 @@
 /*************************************************************************=
****
    levelmeters.c - Stereo level meters
=2D   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz>
+   Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz>  AHmod 4.1 3.1.06
   =20
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
@@ -30,6 +30,11 @@
=20
 extern int input_channels, output_channels, pcm_output_channels, spdif_cha=
nnels, view_spdif_playback;
=20
+	int peaks_store[2][22] =3D {0};  /* Holds info for clip & riding peaks in=
dicators */
+	int count_time[2][22] =3D {0};   /* Holds reset time counts for peaks ind=
icators  */
+	int peaks_setup[4] =3D {0,0,1,1}; /* Correspond to the 4 peak bar check b=
uttons */
+	int time_count_val =3D 49;  /* Approx 2 secs reset -varied by spinbutton =
 */
+
 static void update_peak_switch(void)
 {
 	int err;
@@ -38,6 +43,11 @@
 		g_print("Unable to read peaks: %s\n", snd_strerror(err));
 }
=20
+static int is_active(GtkWidget *widget)
+{
+	return GTK_TOGGLE_BUTTON(widget)->active ? 1 : 0;
+}
+
 static void get_levels(int idx, int *l1, int *l2)
 {
 	*l1 =3D *l2 =3D 0;
@@ -87,9 +97,10 @@
 	int green_segments =3D (segments / 4) * 3;
 	int red_segments =3D 2;
 	int orange_segments =3D segments - green_segments - red_segments;
=2D	int seg;
+	int seg, peak;
 	int segs_on1 =3D ((segments * level1) + 128) / 255;
 	int segs_on2 =3D ((segments * level2) + 128) / 255;
+	const short int clip_level =3D 250;
=20
 	// g_print("segs_on1 =3D %i (%i), segs_on2 =3D %i (%i)\n", segs_on1, leve=
l1, segs_on2, level2);
 	for (seg =3D 0; seg < green_segments; seg++) {
@@ -146,6 +157,73 @@
 		segs_on1--;
 		segs_on2--;
 	}
+
+	if (peaks_setup[2]) { /* Draw rising peak segments */
+		peak =3D peaks_store[1][idx];
+		seg =3D ((segments * peak) + 128) / 255;
+		if (peak > level1) {
+			if (seg >=3D 1) {
+				gdk_draw_rectangle(pixmap[idx],
+						   penOrangeLight[idx],
+						   TRUE,
+						   6 , 3 + ((segments - seg ) * 4),
+						   (segment_width / 2),
+						   3);
+			}
+		} else {
+			peaks_store[1][idx] =3D level1;
+			count_time[1][idx] =3D 0;
+		}
+		if (stereo) { /* Draw right channel of Dig mixer, use [21] */
+			peak =3D peaks_store[1][21];
+			seg =3D ((segments * peak) + 128) / 255;
+			if (peak > level2) {
+				if (seg >=3D 1) {
+					gdk_draw_rectangle(pixmap[idx],
+							   penOrangeLight[idx],
+							   TRUE,
+							   2 + (width / 2),
+							   3 + ((segments - seg ) * 4),
+							   (segment_width / 2),
+							   3);
+				}
+			} else {
+				peaks_store[1][21] =3D level2;
+				count_time[1][21] =3D 0;
+			}
+		}
+	}
+
+	if (peaks_setup[0]) { /* Draw clip peak segments */
+		if (level1 >=3D clip_level) {
+			peaks_store[0][idx] =3D 1;
+			count_time[0][idx] =3D 0;
+		} else {
+			if (peaks_store[0][idx] > 0)  /* Previous peak */
+				gdk_draw_rectangle(pixmap[idx],
+						   penRedLight[idx],
+						   TRUE,
+						   6 + (segment_width / 2), 3,
+						   (segment_width / 2),
+						   3);
+		}
+
+		if (stereo) { /* Draw right channel of Dig mixer, use [21] */
+			if (level2 >=3D clip_level) {
+				peaks_store[0][21] =3D 1;
+				count_time[0][21] =3D 0;
+			} else {
+				if (peaks_store[0][21] > 0)  /* Previous peak */
+					gdk_draw_rectangle(pixmap[idx],
+							   penRedLight[idx],
+							   TRUE,
+							   2 + (width / 2) + (segment_width / 2), 3,
+							   (segment_width / 2),
+							   3);
+			}
+		}
+	}
+
 }
=20
 gint level_meters_configure_event(GtkWidget *widget, GdkEventConfigure *ev=
ent)
@@ -163,7 +241,7 @@
 	penOrangeShadow[idx] =3D get_pen(idx, 0xddff, 0x55ff, 0);
 	penOrangeLight[idx] =3D get_pen(idx, 0xffff, 0x99ff, 0);
 	penRedShadow[idx] =3D get_pen(idx, 0xaaff, 0, 0);
=2D	penRedLight[idx] =3D get_pen(idx, 0xffff, 0, 0);
+	penRedLight[idx] =3D get_pen(idx, 0xffff, 0x2fff, 0x2fff);
 	gdk_draw_rectangle(pixmap[idx],
 			   widget->style->black_gc,
 			   TRUE,
@@ -252,11 +330,83 @@
 					widget->allocation.width, widget->allocation.height);
 		}
 	}
+
+	for (idx =3D 0; idx<=3D 21; idx++) { /* Auto-reset the peak bars */
+		if (peaks_setup[1]) { /* Clip bars */
+			count_time[0][idx]++;
+//			g_print("A/R clips");
+			if (count_time[0][idx] > time_count_val*2) {
+				peaks_store[0][idx] =3D 0;
+				count_time[0][idx] =3D 0;
+			}
+		}
+		if (peaks_setup[3]) { /* Riding peaks */
+			count_time[1][idx]++;
+//			g_print("ST %i",slow_time);
+			if (count_time[1][idx] > time_count_val) {
+				peaks_store[1][idx] =3D 0;
+				count_time[1][idx] =3D 0;
+			}
+		}
+	}
 	return TRUE;
 }
=20
+void peak_bars_toggled(GtkWidget *togglebutton, gpointer data)
+{
+	char *what =3D (char *) data;
+
+	if (!strcmp(what, "clip_peaks")) {
+		if (is_active(togglebutton))
+			peaks_setup[0] =3D 1;
+		else
+			peaks_setup[0] =3D 0;
+	} else if (!strcmp(what, "auto_reset_clip")) {
+		if (is_active(togglebutton))
+			peaks_setup[1] =3D 1;
+		else
+			peaks_setup[1] =3D 0;
+	} else if (!strcmp(what, "riding_peaks")) {
+		if (is_active(togglebutton))
+			peaks_setup[2] =3D 1;
+		else
+			peaks_setup[2] =3D 0;
+	} else if (!strcmp(what, "auto_reset_riders")) {
+		if (is_active(togglebutton))
+			peaks_setup[3] =3D 1;
+		else
+			peaks_setup[3] =3D 0;
+	} else {
+		g_print("peak_bars_toggled: %s ???\n", what);
+	}
+
+}
+
+void peaks_reset_time_adj(GtkAdjustment *adj, gpointer data)
+{
+	int val, idx;
+
+	val =3D adj->value;
+	time_count_val =3D 9;
+	for (idx =3D 0; idx < val; idx++)
+		time_count_val =3D time_count_val * 1.442; /* Create a time count in a n=
on-linear series, approx 2^n */
+//	g_print(" Val %i", val);
+//	g_print(" Time count val %i.", time_count_val);
+}
+
+
+
 void level_meters_reset_peaks(GtkButton *button, gpointer data)
 {
+	int idx;
+
+	for (idx =3D 0; idx <=3D 21; idx++) {
+		peaks_store[0][idx] =3D 0;
+		peaks_store[1][idx] =3D 0;
+		count_time[0][idx] =3D 0;
+		count_time[1][idx] =3D 0;
+	}
+//	g_print("Reset");
 }
=20
 void level_meters_init(void)

--Boundary-00=_zvkwDxJWbTxmOTH--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
