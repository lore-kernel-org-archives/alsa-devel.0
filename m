From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Envy24control -DMX6fire specifics
Date: Wed, 7 Dec 2005 12:08:14 +0000
Message-ID: <200512071208.14218.gineera@aspect135.co.uk>
References: <200512051152.03090.gineera@aspect135.co.uk> <s5hslt7l0dh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uCtlDcbXQzXCaIO"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hslt7l0dh.wl%tiwai@suse.de>
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


--Boundary-00=_uCtlDcbXQzXCaIO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 05 December 2005 21:06, you wrote:

> > Also, envy24control contains a lot of
> > 'if(card_eeprom.subvendor=ICE1712_SUBDEVICE_DMX6FIRE)'.  Originally I
> > replaced these with a boolean (card_is_dmx6fire) variable for ease of
> > reading but reverted for this patch.  It is a matter of alsa style and
> > preference. Should I prepare a patch to do this or leave the explicit
> > eeprom test?
>
> I don't care much, but checking eeprom at each place looks ideend
> ugly.
>

I prepared this patch for my use anyway, so with one hack I can pretend my 
card is not dmx6fire, for development, so offer it here.

Summary: Tidy up DMX6fire eeprom checks

Multiple instances of DMX6FIRE eeprom checks in envy24control replaced with a 
variable.

Signed-off-by:  Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_uCtlDcbXQzXCaIO
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="e24c-1.0.10-AHmod2.7d.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e24c-1.0.10-AHmod2.7d.patch"

diff -ru Denvy24control/envy24control.c Aenvy24control/envy24control.c
--- Denvy24control/envy24control.c	2005-12-06 10:49:17.000000000 +0000
+++ Aenvy24control/envy24control.c	2005-12-06 15:00:17.000000000 +0000
@@ -27,6 +27,7 @@
 #include <getopt.h>
 
 int input_channels, output_channels, pcm_output_channels, spdif_channels, view_spdif_playback, card_number;
+int card_is_dmx6fire = FALSE;
 char *profiles_file_name, *default_profile;
 
 ice1712_eeprom_t card_eeprom;
@@ -147,22 +148,15 @@
 		sprintf(str, "PCM Out %i", stream);
 	} else if (stream <= (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS)) {
 		sprintf(str, "S/PDIF Out %s", stream & 1 ? "L": "R");
-	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 11)) {
-		sprintf(str, "CD In L");
-	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 12)) {
-		sprintf(str, "CD In R");
-	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 13)) {
-		sprintf(str, "Line In L");
-	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 14)) {
-		sprintf(str, "Line In R");
-	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 15)) {
-		sprintf(str, "Phono/Mic L");
-	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 16)) {
-		sprintf(str, "Phono/Mic R");
-	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 19)) {
-		sprintf(str, "Digital In L");
-	} else if ((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (stream == 20)) {
-		sprintf(str, "Digital In R");
+	} else if (card_is_dmx6fire) {
+		if (stream == 11) sprintf(str, "CD In L");
+		if (stream == 12) sprintf(str, "CD In R");
+		if (stream == 13) sprintf(str, "Line In L");
+		if (stream == 14) sprintf(str, "Line In R");
+		if (stream == 15) sprintf(str, "Phono/Mic L");
+		if (stream == 16) sprintf(str, "Phono/Mic R");
+		if (stream == 19) sprintf(str, "Digital In L");
+		if (stream == 20) sprintf(str, "Digital In R");
 	} else if (stream <= (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS)) {
 		sprintf(str, "H/W In %i", stream - (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS));
 	} else if (stream <= (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS + MAX_SPDIF_CHANNELS)) {
@@ -418,7 +412,7 @@
 		"H/W In 8"
 	};
 
-	if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
+	if (card_is_dmx6fire)
 	{
                 table[0] = "Digital In L";
                 table[1] = "Digital In R";
@@ -433,13 +427,13 @@
 	if (stream <= MAX_OUTPUT_CHANNELS) {
 		sprintf(str, "H/W Out %i (%s)", stream, stream & 1 ? "L" : "R");
 	} else if (stream == (MAX_OUTPUT_CHANNELS + 1)) {
-		if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) {
+		if (card_is_dmx6fire) {
 				strcpy(str, "Digital Out (L)");
 			} else {
 				strcpy(str, "S/PDIF Out (L)");
 				}
 	} else if (stream == (MAX_OUTPUT_CHANNELS + 2)) {
-		if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) {
+		if (card_is_dmx6fire) {
 				strcpy(str, "Digital Out (R)");
 			} else {
 				strcpy(str, "S/PDIF Out (R)");
@@ -1176,7 +1170,7 @@
 	GSList *group = NULL;
 	int hide = 1;
 
-	if((card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTADIO2496) || (card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE))
+	if((card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTADIO2496) || (card_is_dmx6fire))
 		hide = 0;
 
 	frame = gtk_frame_new("Digital Input");
@@ -1210,7 +1204,7 @@
         radiobutton = gtk_radio_button_new_with_label(group, "Internal CD");
         hw_spdif_switch_off_radio = radiobutton;
         group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));
-	if(card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
+	if(card_is_dmx6fire)
 	        gtk_widget_show(radiobutton);
         gtk_box_pack_start(GTK_BOX(vbox), radiobutton, FALSE, FALSE, 0);
         gtk_signal_connect(GTK_OBJECT(radiobutton), "toggled",
@@ -1230,7 +1224,7 @@
         GSList *group = NULL;
         int hide = 1;
 
-        if( card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
+        if(card_is_dmx6fire)
                 hide = 0;
 
         frame = gtk_frame_new("Phono Input Switch");
@@ -1273,7 +1267,7 @@
         GSList *group = NULL;
         int hide = 1;
 
-        if( card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
+        if (card_is_dmx6fire)
                 hide = 0;
 
         frame = gtk_frame_new("Line In Selector");
@@ -1473,7 +1467,7 @@
 		gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
 
 		/* Add friendly labels for DMX 6Fires */
-		if((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (i < 6)){
+		if((card_is_dmx6fire) && (i < 6)){
 			label = gtk_label_new(dmx6fire_outputs[i]);
 			gtk_widget_show(label);
 			gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, TRUE, 6);
@@ -1529,7 +1523,7 @@
 		gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
 
 		/* Add friendly labels for DMX 6Fires */
-		if((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (i < 6)){
+		if((card_is_dmx6fire) && (i < 6)){
 			label = gtk_label_new(dmx6fire_inputs[i]);
 			gtk_widget_show(label);
 			gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, TRUE, 6);
@@ -1585,7 +1579,7 @@
 		gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
 
 		/* Add friendly labels for DMX 6Fires */
-		if((card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) && (i < 6)){
+		if((card_is_dmx6fire) && (i < 6)){
 			label = gtk_label_new(dmx6fire_inputs[i]);
 			gtk_widget_show(label);
 			gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, TRUE, 6);
@@ -2046,21 +2040,24 @@
 	}
 	memcpy(&card_eeprom, snd_ctl_elem_value_get_bytes(val), 32);
 
+	if(card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE)
+		card_is_dmx6fire = TRUE;
+
 	/* Set a better default for input_channels and output_channels */
 	if(!input_channels_set) {
-		if(card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) {
+		if(card_is_dmx6fire) {
 			input_channels = 6;
 		}
 	}
 
 	if(!output_channels_set) {
-		if(card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) {
+		if(card_is_dmx6fire) {
 			output_channels = 6;
 		}
 	}
 
 	if(!pcm_output_channels_set) {
-		if(card_eeprom.subvendor == ICE1712_SUBDEVICE_DMX6FIRE) {
+		if(card_is_dmx6fire) {
 			pcm_output_channels = 6; /* PCMs 7&8 can be used -set using option -p8 */
 		}
 	}

--Boundary-00=_uCtlDcbXQzXCaIO--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
