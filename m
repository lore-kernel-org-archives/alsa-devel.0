From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: FIxed alsa-tools' envy24control missing peak level
	meters and "Reset Peaks"
Date: Tue, 13 Jul 2010 10:47:01 +0100
Message-ID: <201007131047.01361.gineera@aspect135.co.uk>
References: <AANLkTimVnkZjBLxxhx4I8OtFiu9oOH0cPpX4V9wNimIa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VYDPM8KxGJsFdIU"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net
	[62.24.128.239]) by alsa0.perex.cz (Postfix) with ESMTP id 27896243F1
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 11:47:09 +0200 (CEST)
In-Reply-To: <AANLkTimVnkZjBLxxhx4I8OtFiu9oOH0cPpX4V9wNimIa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Niels Mayer <nielsmayer@gmail.com>, alsa-devel@alsa-project.org, Linux Audio Developers <linux-audio-dev@lists.linuxaudio.org>
Cc: PlanetCCRMA mailinglist <planetccrma@ccrma.stanford.edu>, fedora-music-list <fedora-music-list@redhat.com>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_VYDPM8KxGJsFdIU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Neils,

On Monday 12 July 2010 23:41, Niels Mayer wrote:
> I've been long annoyed by alsa-tools' envy24control (*) lack of
> peak-level indication in it's metering, and the non-implementation of
> its "Reset Peaks" button:
> https://bugzilla.redhat.com/show_bug.cgi?id=602903
>
> I've fixed that annoyance. Now, a small white line appears above the
> highest level on each meter, and can be reset via "Reset Peaks"
> button.
>
> Original source:
> http://git.alsa-project.org/?p=alsa-tools.git;a=blob_plain;f=envy24control/
>levelmeters.c;hb=HEAD Patch:
> http://nielsmayer.com/npm/602903.patch

I wish I had been aware of your interest in this - in 2006-08 I coded rising 
peak and clip indicators for envy24 control, and have my versions patched.  
Unfortunately, I never got to a final re-work to submit; it has been on that 
'todo' list.  I was responsible for patches that introduced the present 
layout of envy24control, incl 'tall_eq_mixer_heights' etc.

Right now I am in the middle of other things, but I have quickly attached my 
existing patch, as you might like to try it.  I suspect many of the cc's on 
this mail will bounce (not-subscribed) so perhaps you could re-post it there.  
No guarantees though with current ALSA - I haven't updated since 1.0.18, and 
most boxes here use 1.0.12.  But I feel sure you will be able to get the 
patch to apply.  Come back with any issues.

<snip>

> Next steps:
>
> (1) Think about building-in meter ballistics from Fons Adriaensen's
> jkmeter (
> http://www.kokkinizita.net/linuxaudio/downloads/jkmeter-0.4.0.tar.bz2 ).
> Which helps implent Bob Katz' "K System" (
> http://www.digido.com/level-practices-part-2-includes-the-k-system.html
> ). Although it probably most makes sense to implement such metering on
> the main "digital mixer" meter of envy24control, if it's not too
> inefficient, I'd want it available on all meters, despite the warning
> from Fons ( http://old.nabble.com/First-release-of-jkmeter-td18798950.html
> ).
>
> > This is the type of meter you want for live recording,
> > mixing and mastering. It probably makes no sense to
> > use it on all tracks of a DAW, where keeping digital
> > level within limits is the main purpose of metering.

With the attached patch, all channels have rising peaks that reset at regular 
intervals, or hold (have a play with values in 'Extras').  The marker is 
half-width only.  No meter ballistics, though!

> (2) Fix https://bugzilla.redhat.com/show_bug.cgi?id=602900 which
> causes 'envy24control' to crash when given "-D" argument.
> and behave incorrectly when given a correct non-numeric name for an
> audio device: e.g.
>
> >> envy24control  --card M66
> >> invalid card type (driver is USB-Audio)
> >> envy24control --card M66 --device M66
> >> Segmentation fault (core dumped)
>
> (3) Apply more reasonable defaults and automatically size to correct
>
> dimensions. I use, for example:
> >> envy24control --card 2 --outputs 4 --input 4 --pcm_output 8
> >> --view_spdif_playback --midichannel 1 --midienhanced --window_width 1275
> >> --tall_eq_mixer_heights 1 &

Bear in mind that different hardware uses this, with different graphic 
environments; what seems the obvious ideal to you may not be so for others.  
Ultimately that is the job of command line arguments, as you do now.

I use this with DMX6fire and Hoontech DSP2000.

> (4) Add midi output, in addition to midi input, which would monitor
> the hardware peak metering from the ice1712
> ("amixer -c M66 cget iface=PCM,name='Multi Track Peak',numid=45")
> and output a MIDI note-on on the corresponding MIDI channel whenever a
> specified threshold value was exceeded. This could be used to
> implement "automatic gain control" in association with the
> midi-controllable ADC gain provided by envy24control.

Regards

Alan

--Boundary-00=_VYDPM8KxGJsFdIU
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="e24c-AHrisingpeakclip-v1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e24c-AHrisingpeakclip-v1.patch"

diff -ru envy24control/envy24control.c Aenvy24control/envy24control.c
--- envy24control/envy24control.c	2006-08-22 19:25:52.000000000 +0100
+++ Aenvy24control/envy24control.c	2008-07-28 23:07:28.000000000 +0100
@@ -1,5 +1,5 @@
 /*****************************************************************************
-   envy24control.c - Env24 chipset (ICE1712) control utility
+   envy24control.c - Env24 chipset (ICE1712) control utility **AH Peaks/clips mod v1 3.1.06
    Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz>
 
    (2003/03/22) Changed to hbox/vbox layout.
@@ -74,6 +74,12 @@
 GtkObject *hw_volume_change_adj;
 GtkWidget *hw_volume_change_spin;
 
+GtkWidget *clip_peaks_check;
+GtkWidget *auto_reset_clips_check;
+GtkWidget *riding_peaks_check;
+GtkWidget *auto_reset_riders_check;
+GtkObject *sw_peaks_reset_time_adj;
+
 GtkWidget *hw_spdif_profi_nonaudio_radio;
 GtkWidget *hw_spdif_profi_audio_radio;
 
@@ -210,7 +216,7 @@
 	gtk_signal_connect(GTK_OBJECT(drawing), "configure_event",
 			   GTK_SIGNAL_FUNC(level_meters_configure_event), NULL);
 	gtk_widget_set_events(drawing, GDK_EXPOSURE_MASK);
-	gtk_widget_set_usize(drawing, 36, (60 * tall_equal_mixer_ht + 204));
+	gtk_widget_set_usize(drawing, 36, (60 * tall_equal_mixer_ht + 202));
 	gtk_box_pack_start(GTK_BOX(vbox1), drawing, FALSE, FALSE, 1);
 
 	label = gtk_label_new("");
@@ -733,9 +739,106 @@
 	gtk_spin_button_set_numeric(GTK_SPIN_BUTTON(spinbutton), TRUE);
 	gtk_signal_connect(GTK_OBJECT(spinbutton_adj), "value_changed",
 			   GTK_SIGNAL_FUNC(volume_change_rate_adj), NULL);
-	
+
+}
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
+	frame = gtk_frame_new("Peak Bars");
+	gtk_widget_show(frame);
+	gtk_box_pack_start(GTK_BOX(box), frame, FALSE, FALSE, 0);
+
+	vbox = gtk_vbox_new(FALSE, 0);
+	gtk_widget_show(vbox);
+	gtk_container_add(GTK_CONTAINER(frame), vbox);
+	gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+
+	frame = gtk_frame_new("Clip Bar 98%");
+        gtk_widget_show(frame);
+	gtk_box_pack_start(GTK_BOX(vbox), frame, FALSE, FALSE, 0);
+
+	vbox1 = gtk_vbox_new(FALSE, 0);
+	gtk_widget_show(vbox1);
+	gtk_container_add(GTK_CONTAINER(frame), vbox1);
+//	gtk_container_set_border_width(GTK_CONTAINER(vbox1), 0);
+
+	check = gtk_check_button_new_with_label("Active");
+	clip_peaks_check = check;
+	gtk_widget_show(check);
+	gtk_box_pack_start(GTK_BOX(vbox1), check, FALSE, FALSE, 0);
+	gtk_signal_connect(GTK_OBJECT(check), "toggled",
+			  (GtkSignalFunc)peak_bars_toggled,
+			  (gpointer)"clip_peaks");
+
+	check = gtk_check_button_new_with_label("Auto Reset");
+	auto_reset_clips_check = check;
+	gtk_widget_show(check);
+	gtk_box_pack_start(GTK_BOX(vbox1), check, FALSE, FALSE, 0);
+	gtk_signal_connect(GTK_OBJECT(check), "toggled",
+			  (GtkSignalFunc)peak_bars_toggled,
+			  (gpointer)"auto_reset_clip");
+
+	frame = gtk_frame_new("Riding Peaks");
+        gtk_widget_show(frame);
+	gtk_box_pack_start(GTK_BOX(vbox), frame, FALSE, FALSE, 6);
+
+	vbox1 = gtk_vbox_new(FALSE, 0);
+	gtk_widget_show(vbox1);
+	gtk_container_add(GTK_CONTAINER(frame), vbox1);
+
+	check = gtk_check_button_new_with_label("Active");
+	riding_peaks_check = check;
+	gtk_widget_show(check);
+	gtk_box_pack_start(GTK_BOX(vbox1), check, FALSE, FALSE, 0);
+	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(check),TRUE);
+	gtk_signal_connect(GTK_OBJECT(check), "toggled",
+			  (GtkSignalFunc)peak_bars_toggled,
+			  (gpointer)"riding_peaks");
+
+	check = gtk_check_button_new_with_label("Auto Reset");
+	auto_reset_riders_check = check;
+	gtk_widget_show(check);
+	gtk_box_pack_start(GTK_BOX(vbox1), check, FALSE, FALSE, 0);
+	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(check),TRUE);
+	gtk_signal_connect(GTK_OBJECT(check), "toggled",
+			  (GtkSignalFunc)peak_bars_toggled,
+			  (gpointer)"auto_reset_riders");
+
+	frame = gtk_frame_new("Reset Time");
+        gtk_widget_show(frame);
+	gtk_box_pack_start(GTK_BOX(vbox), frame, FALSE, FALSE, 0);
+
+	hbox = gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox);
+	gtk_container_add(GTK_CONTAINER(frame), hbox);
+	gtk_container_set_border_width(GTK_CONTAINER(hbox), 6);
+
+	label = gtk_label_new("Setting");
+	gtk_widget_show(label);
+	gtk_box_pack_start(GTK_BOX(hbox), label, TRUE, FALSE, 0);
+	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_LEFT);
+
+	spinbutton_adj = gtk_adjustment_new(5, 0, 9, 1, 1, 1);
+	sw_peaks_reset_time_adj = spinbutton_adj;
+	spinbutton = gtk_spin_button_new(GTK_ADJUSTMENT(spinbutton_adj), 1, 0);
+	gtk_widget_show(spinbutton);
+	gtk_box_pack_start(GTK_BOX(hbox), spinbutton, TRUE, FALSE, 0);
+	gtk_spin_button_set_numeric(GTK_SPIN_BUTTON(spinbutton), TRUE);
+	gtk_signal_connect(GTK_OBJECT(spinbutton_adj), "value_changed",
+			   GTK_SIGNAL_FUNC(peaks_reset_time_adj), NULL);
+
 }
 
+
 static void create_spdif_output_settings_profi_data(GtkWidget *box)
 {
 	GtkWidget *frame;
@@ -1379,6 +1482,45 @@
 	create_spdif_output_settings(hbox);
 }
 
+static void create_extras(GtkWidget *main, GtkWidget *notebook, int page)
+{
+	GtkWidget *label;
+	GtkWidget *vbox;
+	GtkWidget *hbox;
+	GtkWidget *scrolledwindow;
+	GtkWidget *viewport;
+
+	hbox = gtk_hbox_new(FALSE, 0);
+	gtk_widget_show(hbox);
+	gtk_container_add(GTK_CONTAINER(notebook), hbox);
+
+        label = gtk_label_new("Extras");
+        gtk_widget_show(label);
+	gtk_notebook_set_tab_label(GTK_NOTEBOOK(notebook),
+				   gtk_notebook_get_nth_page(GTK_NOTEBOOK(notebook), page),
+				   label);
+
+//	/* build scrolling area */                         /* Leave in for later */
+//	scrolledwindow = gtk_scrolled_window_new(NULL, NULL);
+//	gtk_widget_show(scrolledwindow);
+//	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
+//	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow),
+//					GTK_POLICY_AUTOMATIC, GTK_POLICY_NEVER);
+
+//	viewport = gtk_viewport_new(NULL, NULL);
+//	gtk_widget_show(viewport);
+//	gtk_container_add(GTK_CONTAINER(scrolledwindow), viewport);
+
+
+	vbox = gtk_vbox_new(FALSE, 0);
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
@@ -1421,7 +1563,7 @@
 	gtk_box_pack_start(GTK_BOX(vbox), label, TRUE, TRUE, 6);
 
 	/* create first line */
-	label = gtk_label_new("Envy24 Control Utility " VERSION);
+	label = gtk_label_new("Envy24 Control Utility v" VERSION "  **AH Peaks/clips mod v1-3.1.06");
         gtk_widget_show(label);
 	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, TRUE, 6);
 
@@ -1960,9 +2102,9 @@
 	gtk_widget_set_name(drawing, "DigitalMixer");
 	gtk_box_pack_start(GTK_BOX(hbox1), drawing, TRUE, FALSE, 6);
 	if (tall_equal_mixer_ht > 1 ) {
-		gtk_widget_set_usize(drawing, 60, 264 + 60 * (tall_equal_mixer_ht - 1));
+		gtk_widget_set_usize(drawing, 60, 262 + 60 * (tall_equal_mixer_ht - 1));
 	} else {
-		gtk_widget_set_usize(drawing, 60, 264);
+		gtk_widget_set_usize(drawing, 60, 262);
 	}
 	gtk_signal_connect(GTK_OBJECT(drawing), "expose_event",
 			   (GtkSignalFunc)level_meters_expose_event, NULL);
@@ -2285,6 +2427,7 @@
 	create_hardware(outerbox, notebook, page++);
 	if (envy_analog_volume_available())
 		create_analog_volume(outerbox, notebook, page++);
+	create_extras(outerbox, notebook, page++);
 	create_profiles(outerbox, notebook, page++);
 	create_about(outerbox, notebook, page++);
 	create_blank(outerbox, notebook, page++);
Only in Aenvy24control: envy24control.c.orig
diff -ru envy24control/envy24control.h Aenvy24control/envy24control.h
--- envy24control/envy24control.h	2006-08-22 19:25:52.000000000 +0100
+++ Aenvy24control/envy24control.h	2008-07-28 22:52:14.000000000 +0100
@@ -1,4 +1,4 @@
-#include <stdio.h>
+#include <stdio.h>       /*  AH Peaks/clips mod v1 3.1.06   */
 #include <stdlib.h>
 #include <string.h>
 #include <signal.h>
@@ -166,6 +166,8 @@
 gint level_meters_configure_event(GtkWidget *widget, GdkEventConfigure *event);
 gint level_meters_expose_event(GtkWidget *widget, GdkEventExpose *event);
 gint level_meters_timeout_callback(gpointer data);
+void peak_bars_toggled(GtkWidget *togglebutton, gpointer data);
+void peaks_reset_time_adj(GtkAdjustment *adj, gpointer data);
 void level_meters_reset_peaks(GtkButton *button, gpointer data);
 void level_meters_init(void);
 void level_meters_postinit(void);
Only in Aenvy24control: envy24control.h.orig
Only in Aenvy24control: envy24control.o
Only in Aenvy24control: envy24control-orig.c
Only in Aenvy24control: envy24control-orig.h
Only in Aenvy24control: hardware.o
diff -ru envy24control/levelmeters.c Aenvy24control/levelmeters.c
--- envy24control/levelmeters.c	2006-08-22 19:25:52.000000000 +0100
+++ Aenvy24control/levelmeters.c	2008-07-28 23:32:34.000000000 +0100
@@ -1,5 +1,5 @@
 /*****************************************************************************
-   levelmeters.c - Stereo level meters
+   levelmeters.c - Stereo level meters     **AH Peaks/clips mod v1 3.1.06
    Copyright (C) 2000 by Jaroslav Kysela <perex@suse.cz>
    
    This program is free software; you can redistribute it and/or
@@ -30,6 +30,11 @@
 
 extern int input_channels, output_channels, pcm_output_channels, spdif_channels, view_spdif_playback;
 
+	int peaks_store[2][22] = {0};  /* Holds info for clip & riding peaks indicators */
+	int count_time[2][22] = {0};   /* Holds reset time counts for peaks indicators  */
+	int peaks_setup[4] = {0,0,1,1}; /* Correspond to the 4 peak bar check buttons */
+	int time_count_val = 49;  /* Approx 2 secs reset -varied by spinbutton  */
+
 static void update_peak_switch(void)
 {
 	int err;
@@ -38,6 +43,11 @@
 		g_print("Unable to read peaks: %s\n", snd_strerror(err));
 }
 
+static int is_active(GtkWidget *widget)
+{
+	return GTK_TOGGLE_BUTTON(widget)->active ? 1 : 0;
+}
+
 static void get_levels(int idx, int *l1, int *l2)
 {
 	*l1 = *l2 = 0;
@@ -87,9 +97,10 @@
 	int green_segments = (segments / 4) * 3;
 	int red_segments = 2;
 	int orange_segments = segments - green_segments - red_segments;
-	int seg;
+	int seg, peak;
 	int segs_on1 = ((segments * level1) + 128) / 255;
 	int segs_on2 = ((segments * level2) + 128) / 255;
+	const short int clip_level = 250;
 
 	// g_print("segs_on1 = %i (%i), segs_on2 = %i (%i)\n", segs_on1, level1, segs_on2, level2);
 	for (seg = 0; seg < green_segments; seg++) {
@@ -146,6 +157,73 @@
 		segs_on1--;
 		segs_on2--;
 	}
+
+	if (peaks_setup[2]) { /* Draw rising peak segments */
+		peak = peaks_store[1][idx];
+		seg = ((segments * peak) + 128) / 255;
+		if (peak > level1) {
+			if (seg >= 1) {
+				gdk_draw_rectangle(pixmap[idx],
+						   penOrangeLight[idx],
+						   TRUE,
+						   6 , 3 + ((segments - seg ) * 4),
+						   (segment_width / 2),
+						   3);
+			}
+		} else {
+			peaks_store[1][idx] = level1;
+			count_time[1][idx] = 0;
+		}
+		if (stereo) { /* Draw right channel of Dig mixer, use [21] */
+			peak = peaks_store[1][21];
+			seg = ((segments * peak) + 128) / 255;
+			if (peak > level2) {
+				if (seg >= 1) {
+					gdk_draw_rectangle(pixmap[idx],
+							   penOrangeLight[idx],
+							   TRUE,
+							   2 + (width / 2),
+							   3 + ((segments - seg ) * 4),
+							   (segment_width / 2),
+							   3);
+				}
+			} else {
+				peaks_store[1][21] = level2;
+				count_time[1][21] = 0;
+			}
+		}
+	}
+
+	if (peaks_setup[0]) { /* Draw clip peak segments */
+		if (level1 >= clip_level) {
+			peaks_store[0][idx] = 1;
+			count_time[0][idx] = 0;
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
+			if (level2 >= clip_level) {
+				peaks_store[0][21] = 1;
+				count_time[0][21] = 0;
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
 
 gint level_meters_configure_event(GtkWidget *widget, GdkEventConfigure *event)
@@ -163,7 +241,7 @@
 	penOrangeShadow[idx] = get_pen(idx, 0xddff, 0x55ff, 0);
 	penOrangeLight[idx] = get_pen(idx, 0xffff, 0x99ff, 0);
 	penRedShadow[idx] = get_pen(idx, 0xaaff, 0, 0);
-	penRedLight[idx] = get_pen(idx, 0xffff, 0, 0);
+	penRedLight[idx] = get_pen(idx, 0xffff, 0x2fff, 0x2fff);
 	gdk_draw_rectangle(pixmap[idx],
 			   widget->style->black_gc,
 			   TRUE,
@@ -252,11 +330,83 @@
 					widget->allocation.width, widget->allocation.height);
 		}
 	}
+
+	for (idx = 0; idx<= 21; idx++) { /* Auto-reset the peak bars */
+		if (peaks_setup[1]) { /* Clip bars */
+			count_time[0][idx]++;
+//			g_print("A/R clips");
+			if (count_time[0][idx] > time_count_val*2) {
+				peaks_store[0][idx] = 0;
+				count_time[0][idx] = 0;
+			}
+		}
+		if (peaks_setup[3]) { /* Riding peaks */
+			count_time[1][idx]++;
+//			g_print("ST %i",slow_time);
+			if (count_time[1][idx] > time_count_val) {
+				peaks_store[1][idx] = 0;
+				count_time[1][idx] = 0;
+			}
+		}
+	}
 	return TRUE;
 }
 
+void peak_bars_toggled(GtkWidget *togglebutton, gpointer data)
+{
+	char *what = (char *) data;
+
+	if (!strcmp(what, "clip_peaks")) {
+		if (is_active(togglebutton))
+			peaks_setup[0] = 1;
+		else
+			peaks_setup[0] = 0;
+	} else if (!strcmp(what, "auto_reset_clip")) {
+		if (is_active(togglebutton))
+			peaks_setup[1] = 1;
+		else
+			peaks_setup[1] = 0;
+	} else if (!strcmp(what, "riding_peaks")) {
+		if (is_active(togglebutton))
+			peaks_setup[2] = 1;
+		else
+			peaks_setup[2] = 0;
+	} else if (!strcmp(what, "auto_reset_riders")) {
+		if (is_active(togglebutton))
+			peaks_setup[3] = 1;
+		else
+			peaks_setup[3] = 0;
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
+	val = adj->value;
+	time_count_val = 9;
+	for (idx = 0; idx < val; idx++)
+		time_count_val = time_count_val * 1.442; /* Create a time count in a non-linear series, approx 2^n */
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
+	for (idx = 0; idx <= 21; idx++) {
+		peaks_store[0][idx] = 0;
+		peaks_store[1][idx] = 0;
+		count_time[0][idx] = 0;
+		count_time[1][idx] = 0;
+	}
+//	g_print("Reset");
 }
 
 void level_meters_init(void)

--Boundary-00=_VYDPM8KxGJsFdIU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_VYDPM8KxGJsFdIU--
