From: Daniel Ankers <dan_a@manx.net>
Subject: [patch] More Envy24Control bits
Date: Sat, 1 Nov 2003 19:26:41 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031101192641.27b5dfcd.dan_a@manx.net>
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
This patch:
 - Fixes a minor bug in the previous patch in hardware.c
 - Adds friendly names to the analog volume controls for DMX 6Fire users
 - Automatically sets the number of I/O channels for DMX 6Fire users

It is against current CVS.  As before, it has no effect for users of
other cards, and as before it might have major mistakes.

(The code was working correctly with the bug in hardware.c, but I don't
know why!)

Cheers,
Dan


Index: envy24control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/envy24control.c,v
retrieving revision 1.19
diff -u -w -r1.19 envy24control.c
--- envy24control.c	30 Oct 2003 15:09:04 -0000	1.19
+++ envy24control.c	1 Nov 2003 18:40:12 -0000
@@ -387,6 +387,16 @@
 		"H/W In 8"
 	};
 
+	if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
+	{
+		table[2] = "CD In L";
+                table[3] = "CD In R";
+                table[4] = "Line In L";
+                table[5] = "Line In R";
+                table[6] = "Phono/Mic In L";
+                table[7] = "Phono/Mic In R";
+	}
+
 	if (stream <= 8) {
 		sprintf(str, "H/W Out %i (%s)", stream, stream & 1 ? "L" :
"R");
 	} else if (stream == 9) {
@@ -1438,6 +1448,23 @@
 	GtkWidget *scrolledwindow;
 	GtkWidget *viewport;
 	int i, j;
+	static char* dmx6fire_inputs[6] = {
+		"CD In (L)",
+		"CD In (R)",
+		"Line In (L)",
+		"Line In (R)",
+		"Phono In (L)",
+		"Phono In (R)"
+	};
+	static char* dmx6fire_outputs[6] = {
+		"Front (L)",
+		"Front (R)",
+		"Rear (L)",
+		"Rear (R)",
+		"Centre",
+		"LFE"
+	};
+
 
 	scrolledwindow = gtk_scrolled_window_new(NULL, NULL);
 	gtk_widget_show(scrolledwindow);
@@ -1474,6 +1501,13 @@
 		gtk_container_add(GTK_CONTAINER(frame), vbox);
 		gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
 
+		/* Add friendly labels for DMX 6Fires */
+		if((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (i <
6)){
+			label = gtk_label_new(dmx6fire_outputs[i]);
+			gtk_widget_show(label);
+			gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, TRUE, 6);
+		}
+
 		adj = gtk_adjustment_new(0, -(envy_dac_max()), 0, 1, 16, 0);
 		av_dac_volume_adj[i] = adj;
 		vscale = gtk_vscale_new(GTK_ADJUSTMENT(adj));
@@ -1523,6 +1557,13 @@
 		gtk_container_add(GTK_CONTAINER(frame), vbox);
 		gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
 
+		/* Add friendly labels for DMX 6Fires */
+		if((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (i <
6)){
+			label = gtk_label_new(dmx6fire_inputs[i]);
+			gtk_widget_show(label);
+			gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, TRUE, 6);
+		}
+
 		adj = gtk_adjustment_new(0, -127, 0, 1, 16, 0);
 		av_adc_volume_adj[i] = adj;
 		vscale = gtk_vscale_new(GTK_ADJUSTMENT(adj));
@@ -1572,6 +1613,13 @@
 		gtk_container_add(GTK_CONTAINER(frame), vbox);
 		gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
 
+		/* Add friendly labels for DMX 6Fires */
+		if((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (i <
6)){
+			label = gtk_label_new(dmx6fire_inputs[i]);
+			gtk_widget_show(label);
+			gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, TRUE, 6);
+		}
+
 		adj = gtk_adjustment_new(0, -36, 0, 1, 16, 0);
 		av_ipga_volume_adj[i] = adj;
 		vscale = gtk_vscale_new(GTK_ADJUSTMENT(adj));
@@ -1612,6 +1660,8 @@
 	int npfds;
 	struct pollfd *pfds;
 	int page;
+	int output_channels_set = 0;
+	int input_channels_set = 0;
 	static struct option long_options[] = {
 		{"device", 1, 0, 'D'},
 		{"card", 1, 0, 'c'},
@@ -1652,12 +1702,14 @@
 				fprintf(stderr, "envy24control: must have 0-8
inputs\n");
 				exit(1);
 			}
+			input_channels_set = 1;
 			break;
 		case 'o':
 			output_channels = atoi(optarg);
 			if (output_channels < 0 || output_channels > 10) {
 				fprintf(stderr, "envy24control: must have 0-10
outputs\n");
 				exit(1);
+			output_channels_set = 1;
 			}
 			break;
 		case 's':
@@ -1695,6 +1747,19 @@
 	}
 	memcpy(&card_eeprom, snd_ctl_elem_value_get_bytes(val), 32);
 
+	/* Set a better default for input_channels and output_channels */
+	if(!input_channels_set) {
+		if(card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) {
+			input_channels = 6;
+		}
+	}
+
+	if(!output_channels_set) {
+		if(card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) {
+			output_channels = 6;
+		}
+	}
+
 	/* Initialize code */
 	level_meters_init();
 	patchbay_init();
Index: hardware.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/hardware.c,v
retrieving revision 1.11
diff -u -w -r1.11 hardware.c
--- hardware.c	30 Oct 2003 15:09:04 -0000	1.11
+++ hardware.c	1 Nov 2003 18:40:13 -0000
@@ -714,7 +714,7 @@
 
         if (!is_active(togglebutton))
                 return;
-        if (!strcmp(str, "On"))
+        if (!strcmp(str, "Phono"))
                 snd_ctl_elem_value_set_boolean(phono_input, 0, 1);
         else
                 snd_ctl_elem_value_set_boolean(phono_input, 0, 0);


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
