From: Ross Vandegrift <ross@willow.seitz.com>
Subject: [PATCH] envy24control widget limits, version 2
Date: Sun, 1 Jun 2003 22:44:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030602024454.GB15874@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

	The first version of my patch had a few glaring errors.  This
update fixes the following issues:

* HW In level meters were broken
* The last PCM Out meter was broken
* S/PDIF channels can now be controlled with -s, --spdif
* The Patchbay/Router and Analog Volume tabs now accurately reflect the
number of requested channels in all cases.

This update does not include the requested vertical layout changes.  If
I have the time, this is on my TODO list.

The patch against 0.9.3 is included below, and available from
http://poplar.seitz.com/~ross/envy24control/envy24control-control-limit-v2.diff

Testers would be greatly appreciated - especially those with cards other
than the Delta44.

-- 
Ross Vandegrift
ross@willow.seitz.com

A Pope has a Water Cannon.                               It is a Water Cannon.
He fires Holy-Water from it.                        It is a Holy-Water Cannon.
He Blesses it.                                 It is a Holy Holy-Water Cannon.
He Blesses the Hell out of it.          It is a Wholly Holy Holy-Water Cannon.
He has it pierced.                It is a Holey Wholly Holy Holy-Water Cannon.
He makes it official.       It is a Canon Holey Wholly Holy Holy-Water Cannon.
Batman and Robin arrive.                                       He shoots them.



diff -u alsa-tools-0.9.3/envy24control/envy24control.c alsa-tools-hack/envy24control/envy24control.c
--- alsa-tools-0.9.3/envy24control/envy24control.c	2003-03-25 12:32:21.000000000 -0500
+++ alsa-tools-hack/envy24control/envy24control.c	2003-06-01 22:00:32.000000000 -0400
@@ -24,6 +24,7 @@
 #define _GNU_SOURCE
 #include <getopt.h>
 
+int input_channels, output_channels, spdif_channels;
 ice1712_eeprom_t card_eeprom;
 snd_ctl_t *ctl;
 
@@ -115,6 +116,7 @@
 	GtkWidget *label;
 	GtkWidget *toggle;
 	char str[64], drawname[32];
+	static int widget_count = 0;
 
 	if (stream <= 10) {
 		sprintf(str, "PCM Out %i", stream);
@@ -329,8 +331,11 @@
 	gtk_widget_show(hbox);
 	gtk_box_pack_start(GTK_BOX(vbox), hbox, FALSE, TRUE, 0);
 
-
-	for (stream = 1; stream <= 20; stream++)
+	for(stream = 1; stream <= output_channels; stream ++)
+		create_mixer_frame(hbox, stream);
+	for(stream = 11; stream <= input_channels + 10; stream ++)
+		create_mixer_frame(hbox, stream);
+	for(stream = 19; stream <= spdif_channels + 18; stream ++)
 		create_mixer_frame(hbox, stream);
 }
 
@@ -420,7 +425,7 @@
 	gtk_box_pack_start(GTK_BOX(vbox), hseparator, FALSE, TRUE, 0);
 
 
-	for(idx = 0; idx < 10; idx++) {
+	for(idx = 2 - spdif_channels; idx < input_channels + 2; idx++) {
 		radiobutton = gtk_radio_button_new_with_label(group, table[idx]);
 		router_radio[stream-1][2+idx] = radiobutton;
 		group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
@@ -462,7 +467,11 @@
 	gtk_container_add(GTK_CONTAINER(viewport), hbox);
 
 	pos = 0;
-	for (stream = 1; stream <= 10; stream++) {
+	for (stream = 1; stream <= output_channels; stream++) {
+		if (patchbay_stream_is_active(stream))
+			create_router_frame(hbox, stream, pos++);
+	}
+	for (stream = 8; stream <= 8 + spdif_channels; stream++) {
 		if (patchbay_stream_is_active(stream))
 			create_router_frame(hbox, stream, pos++);
 	}
@@ -1360,7 +1369,12 @@
 
 static void usage(void)
 {
-	fprintf(stderr, "usage: envy24control [-c card#] [-D control-name]\n");
+	fprintf(stderr, "usage: envy24control [-c card#] [-D control-name] [-o num-outputs] [-i num-inputs]\n");
+	fprintf(stderr, "\t-c, --card\tAlsa card number to control\n");
+	fprintf(stderr, "\t-D, --device\tcontrol-name\n");
+	fprintf(stderr, "\t-o, --outputs\tLimit number of outputs to display\n");
+	fprintf(stderr, "\t-i, --input\tLimit number of inputs to display\n");
+	fprintf(stderr, "\t-s, --spdif\tLimit number of spdif outputs to display\n");
 }
 
 int main(int argc, char **argv)
@@ -1376,6 +1390,9 @@
 	static struct option long_options[] = {
 		{"device", 1, 0, 'D'},
 		{"card", 1, 0, 'c'},
+		{"inputs", 1, 0, 'i'},
+		{"outputs", 1, 0, 'o'},
+		{"spdif", 1, 0, 's'}
 	};
 
 
@@ -1386,7 +1403,10 @@
         gtk_init(&argc, &argv);
 
 	name = "hw:0";
-	while ((c = getopt_long(argc, argv, "D:c:", long_options, NULL)) != -1) {
+	input_channels = 8;
+	output_channels = 10;
+	spdif_channels = 2;
+	while ((c = getopt_long(argc, argv, "D:c:i:o:s:", long_options, NULL)) != -1) {
 		switch (c) {
 		case 'c':
 			i = atoi(optarg);
@@ -1400,6 +1420,30 @@
 		case 'D':
 			name = optarg;
 			break;
+		case 'i':
+			input_channels = atoi(optarg);
+			if (input_channels < 0 || input_channels > 8) {
+				fprintf(stderr, "envy24control: must have 0-8 inputs\n",
+					input_channels);
+				exit(1);
+			}
+			break;
+		case 'o':
+			output_channels = atoi(optarg);
+			if (output_channels < 0 || output_channels > 10) {
+				fprintf(stderr, "envy24control: must have 0-10 outputs\n",
+					output_channels);
+				exit(1);
+			}
+			break;
+		case 's':
+			spdif_channels = atoi(optarg);
+			if (spdif_channels < 0 || spdif_channels > 2) {
+				fprintf(stderr, "envy24control: must have 0-2 spdifs\n",
+					spdif_channels);
+				exit(1);
+			}
+			break;
 		default:
 			usage();
 			exit(1);
diff -u alsa-tools-0.9.3/envy24control/levelmeters.c alsa-tools-hack/envy24control/levelmeters.c
--- alsa-tools-0.9.3/envy24control/levelmeters.c	2001-06-06 09:58:01.000000000 -0400
+++ alsa-tools-hack/envy24control/levelmeters.c	2003-06-01 21:54:31.000000000 -0400
@@ -28,6 +28,8 @@
 static GdkPixmap *pixmap[21] = { NULL, };
 static snd_ctl_elem_value_t *peaks;
 
+extern int input_channels, output_channels, spdif_channels;
+
 static void update_peak_switch(void)
 {
 	int err;
@@ -195,7 +197,33 @@
 	int idx, l1, l2;
 
 	update_peak_switch();
-	for (idx = 0; idx <= 20; idx++) {
+	for (idx = 0; idx <= output_channels; idx++) {
+		get_levels(idx, &l1, &l2);
+		widget = idx == 0 ? mixer_mix_drawing : mixer_drawing[idx-1];
+		if (!GTK_WIDGET_VISIBLE(widget))
+			continue;
+		redraw_meters(idx, widget->allocation.width, widget->allocation.height, l1, l2);
+		gdk_draw_pixmap(widget->window,
+				widget->style->black_gc,
+				pixmap[idx],
+				0, 0,
+				0, 0,
+				widget->allocation.width, widget->allocation.height);	
+	}
+	for (idx = 11; idx <= input_channels + 10; idx++) {
+		get_levels(idx, &l1, &l2);
+		widget = idx == 0 ? mixer_mix_drawing : mixer_drawing[idx-1];
+		if (!GTK_WIDGET_VISIBLE(widget))
+			continue;
+		redraw_meters(idx, widget->allocation.width, widget->allocation.height, l1, l2);
+		gdk_draw_pixmap(widget->window,
+				widget->style->black_gc,
+				pixmap[idx],
+				0, 0,
+				0, 0,
+				widget->allocation.width, widget->allocation.height);	
+	}
+	for (idx = 19; idx <= spdif_channels + 18; idx++) {
 		get_levels(idx, &l1, &l2);
 		widget = idx == 0 ? mixer_mix_drawing : mixer_drawing[idx-1];
 		if (!GTK_WIDGET_VISIBLE(widget))
diff -u alsa-tools-0.9.3/envy24control/mixer.c alsa-tools-hack/envy24control/mixer.c
--- alsa-tools-0.9.3/envy24control/mixer.c	2001-06-13 14:41:38.000000000 -0400
+++ alsa-tools-hack/envy24control/mixer.c	2003-06-01 18:30:10.000000000 -0400
@@ -22,6 +22,8 @@
 #define toggle_set(widget, state) \
 	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(widget), state);
 
+extern int input_channels, output_channels, spdif_channels;
+
 static int is_active(GtkWidget *widget)
 {
 	return GTK_TOGGLE_BUTTON(widget)->active ? 1 : 0;
@@ -153,6 +155,10 @@
 {
 	int stream;
 
-	for (stream = 1; stream <= 20; stream++)
+	for (stream = 1; stream <= output_channels; stream++)
+		mixer_update_stream(stream, 1, 1);
+	for (stream = 11; stream <= input_channels + 8; stream++)
+		mixer_update_stream(stream, 1, 1);
+	for (stream = 19; stream <= spdif_channels + 18; stream++)
 		mixer_update_stream(stream, 1, 1);
 }
diff -u alsa-tools-0.9.3/envy24control/patchbay.c alsa-tools-hack/envy24control/patchbay.c
--- alsa-tools-0.9.3/envy24control/patchbay.c	2001-06-13 14:41:38.000000000 -0400
+++ alsa-tools-hack/envy24control/patchbay.c	2003-06-01 21:57:09.000000000 -0400
@@ -26,6 +26,7 @@
 	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(widget), state);
 
 static int stream_active[10];
+extern int output_channels, input_channels, spdif_channels;
 
 static int is_active(GtkWidget *widget)
 {
@@ -69,7 +70,7 @@
 {
 	int stream, tidx;
 
-	for (stream = 1; stream <= 10; stream++) {
+	for (stream = 1; stream <= output_channels; stream++) {
 		if (stream_active[stream - 1]) {
 			tidx = get_toggle_index(stream);
 			toggle_set(router_radio[stream - 1][tidx], TRUE);
@@ -135,7 +136,8 @@
 	snd_ctl_elem_value_alloca(&val);
 	snd_ctl_elem_value_set_interface(val, SND_CTL_ELEM_IFACE_MIXER);
 	snd_ctl_elem_value_set_name(val, ANALOG_PLAYBACK_ROUTE_NAME);
-	for (i = 0; i < 8; i++) {
+	memset (stream_active, 0, 10 * sizeof(int));
+	for (i = 0; i < output_channels; i++) {
 		snd_ctl_elem_value_set_numid(val, 0);
 		snd_ctl_elem_value_set_index(val, i);
 		if (snd_ctl_elem_read(ctl, val) < 0)
@@ -144,7 +146,7 @@
 		stream_active[i] = 1;
 	}
 	snd_ctl_elem_value_set_name(val, SPDIF_PLAYBACK_ROUTE_NAME);
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < spdif_channels; i++) {
 		snd_ctl_elem_value_set_numid(val, 0);
 		snd_ctl_elem_value_set_index(val, i);
  		if (snd_ctl_elem_read(ctl, val) < 0)
diff -u alsa-tools-0.9.3/envy24control/volume.c alsa-tools-hack/envy24control/volume.c
--- alsa-tools-0.9.3/envy24control/volume.c	2002-12-07 04:44:27.000000000 -0500
+++ alsa-tools-hack/envy24control/volume.c	2003-06-01 22:06:45.000000000 -0400
@@ -41,6 +41,7 @@
 static int adc_sense_items;
 static char *dac_sense_name[4];
 static char *adc_sense_name[4];
+extern int input_channels, output_channels;
 
 int envy_dac_volumes(void)
 {
@@ -310,7 +311,11 @@
 			break;
 		dac_max = snd_ctl_elem_info_get_max(info);
 	}
-	dac_volumes = i;
+	if (i < output_channels - 1)
+		dac_volumes = i;
+	else
+		dac_volumes = output_channels;
+
 	snd_ctl_elem_info_set_name(info, DAC_SENSE_NAME);
 	for (i = 0; i < dac_volumes; i++) {
 		snd_ctl_elem_info_set_numid(info, 0);
@@ -338,7 +343,10 @@
 		if (snd_ctl_elem_info(ctl, info) < 0)
 			break;
 	}
-	adc_volumes = i;
+	if (i < input_channels - 1)
+		adc_volumes = i;
+	else
+		adc_volumes = input_channels;
 	snd_ctl_elem_info_set_name(info, ADC_SENSE_NAME);
 	for (i = 0; i < adc_volumes; i++) {
 		snd_ctl_elem_info_set_numid(info, 0);
@@ -366,7 +374,10 @@
 		if (snd_ctl_elem_info(ctl, info) < 0)
 			break;
 	}
-	ipga_volumes = i;
+	if (i < input_channels - 1)
+		ipga_volumes = i;
+	else
+		ipga_volumes = input_channels;
 }
 
 void analog_volume_postinit(void)


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
