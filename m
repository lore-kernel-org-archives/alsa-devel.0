From: Thomas Charbonnel <thomas@undata.org>
Subject: hdsp9632 mixer fix + gcc 2.9x compile fix
Date: Thu, 06 Nov 2003 13:37:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAA408F.50201@undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050802010408090907080005"
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

This is a multi-part message in MIME format.
--------------050802010408090907080005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The attached patch fixes matrix mixer and metering problems spotted by 
Pentti Ala-Vannesluoma for H9632 cards and gcc 2.9x compile errors 
reported by Martin Langer.

Thomas

--------------050802010408090907080005
Content-Type: text/plain;
 name="hdsp9632.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdsp9632.patch"

--- hdsp.c.cvs	2003-11-01 09:06:45.000000000 +0100
+++ hdsp.c	2003-11-06 13:06:28.000000000 +0100
@@ -454,6 +454,7 @@
 	unsigned short	      state;		     /* stores state bits */
 	u32		      firmware_cache[24413]; /* this helps recover from accidental iobox power failure */
 	size_t                period_bytes; 	     /* guess what this is */
+	unsigned char	      max_channels;
 	unsigned char	      qs_in_channels;	     /* quad speed mode for H9632 */
 	unsigned char         ds_in_channels;
 	unsigned char         ss_in_channels;	    /* different for multiface/digiface */
@@ -1169,11 +1170,11 @@
 		/* set thru for all channels */
 
 		if (enable) {
-			for (i = 0; i < HDSP_MAX_CHANNELS; i++) {
+			for (i = 0; i < hdsp->max_channels; i++) {
 				hdsp_write_gain (hdsp, hdsp_input_to_output_key(hdsp,i,i), UNITY_GAIN);
 			}
 		} else {
-			for (i = 0; i < HDSP_MAX_CHANNELS; i++) {
+			for (i = 0; i < hdsp->max_channels; i++) {
 				hdsp_write_gain (hdsp, hdsp_input_to_output_key(hdsp,i,i), MINUS_INFINITY_GAIN);
 			}
 		}
@@ -1181,7 +1182,7 @@
 	} else {
 		int mapped_channel;
 
-		snd_assert(channel < HDSP_MAX_CHANNELS, return);
+		snd_assert(channel < hdsp->max_channels, return);
 
 		mapped_channel = hdsp->channel_map[channel];
 
@@ -2902,9 +2903,9 @@
 
 	source = ucontrol->value.integer.value[0];
 	destination = ucontrol->value.integer.value[1];
-
-	if (source > 25) {
-		addr = hdsp_playback_to_output_key(hdsp,source-26,destination);
+	
+	if (source >= hdsp->max_channels) {
+		addr = hdsp_playback_to_output_key(hdsp,source-hdsp->max_channels,destination);
 	} else {
 		addr = hdsp_input_to_output_key(hdsp,source, destination);
 	}
@@ -2931,8 +2932,8 @@
 	source = ucontrol->value.integer.value[0];
 	destination = ucontrol->value.integer.value[1];
 
-	if (source > 25) {
-		addr = hdsp_playback_to_output_key(hdsp,source-26, destination);
+	if (source >= hdsp->max_channels) {
+		addr = hdsp_playback_to_output_key(hdsp,source-hdsp->max_channels, destination);
 	} else {
 		addr = hdsp_input_to_output_key(hdsp,source, destination);
 	}
@@ -3177,7 +3178,7 @@
 
 int snd_hdsp_create_controls(snd_card_t *card, hdsp_t *hdsp)
 {
-	unsigned int idx, limit;
+	unsigned int idx;
 	int err;
 	snd_kcontrol_t *kctl;
 
@@ -3676,12 +3677,13 @@
 		   odd numbered channels to right, even to left.
 		*/
 		if (hdsp->io_type == H9632) {
-			lineouts_base = 14;
+			/* this is the phones/analog output */
+			lineouts_base = 10;
 		} else {
 			lineouts_base = 26;
 		}
 		
-		for (i = 0; i < HDSP_MAX_CHANNELS; i++) {
+		for (i = 0; i < hdsp->max_channels; i++) {
 			if (i & 1) { 
 				if (hdsp_write_gain (hdsp, hdsp_input_to_output_key (hdsp, i, lineouts_base), UNITY_GAIN) ||
 				    hdsp_write_gain (hdsp, hdsp_playback_to_output_key (hdsp, i, lineouts_base), UNITY_GAIN)) {
@@ -3793,7 +3795,7 @@
 {
 	int mapped_channel;
 
-        snd_assert(channel >= 0 || channel < HDSP_MAX_CHANNELS, return NULL);
+        snd_assert(channel >= 0 || channel < hdsp->max_channels, return NULL);
         
 	if ((mapped_channel = hdsp->channel_map[channel]) < 0) {
 		return NULL;
@@ -3963,7 +3965,7 @@
 	hdsp_t *hdsp = _snd_pcm_substream_chip(substream);
 	int mapped_channel;
 
-	snd_assert(info->channel < HDSP_MAX_CHANNELS, return -EINVAL);
+	snd_assert(info->channel < hdsp->max_channels, return -EINVAL);
 
 	if ((mapped_channel = hdsp->channel_map[info->channel]) < 0) {
 		return -EINVAL;
@@ -4487,8 +4489,8 @@
 
 static int snd_hdsp_hwdep_dummy_op(snd_hwdep_t *hw, struct file *file)
 {
-    /* we have nothing to initialize but the call is required */
-    return 0;
+	/* we have nothing to initialize but the call is required */
+	return 0;
 }
 
 
@@ -4545,10 +4547,11 @@
 		}
 		if (hdsp->io_type == H9632) {
 			int j;
+			hdsp_9632_meters_t *m;
 			int doublespeed = 0;
 			if (hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DoubleSpeedStatus)
 				doublespeed = 1;
-			hdsp_9632_meters_t *m = (hdsp_9632_meters_t *)hdsp->iobase+HDSP_9632_metersBase;
+			m = (hdsp_9632_meters_t *)(hdsp->iobase+HDSP_9632_metersBase);
 			peak_rms = (hdsp_peak_rms_t *)arg;
 			for (i = 0, j = 0; i < 16; ++i, ++j) {
 				if (copy_to_user((void *)peak_rms->input_peaks+i*4, &(m->input_peak[j]), 4) != 0)
@@ -4814,7 +4817,7 @@
 		return -EIO;
 	}
 	
-	for (i = 0; i < HDSP_MAX_CHANNELS; ++i) {
+	for (i = 0; i < hdsp->max_channels; ++i) {
 		hdsp_write (hdsp, HDSP_inputEnable + (4 * i), 1);
 		hdsp_write (hdsp, HDSP_outputEnable + (4 * i), 1);
 	}
@@ -4841,8 +4844,9 @@
 	
 	case H9632:
 		status = hdsp_read(hdsp, HDSP_statusRegister);
-		aebi_channels = (status & HDSP_AEBI) ? 4 : 0;
-		aebo_channels = (status & HDSP_AEBO) ? 4 : 0;
+		/* HDSP_AEBx bits are low when AEB are connected */
+		aebi_channels = (status & HDSP_AEBI) ? 0 : 4;
+		aebo_channels = (status & HDSP_AEBO) ? 0 : 4;
 		hdsp->card_name = "RME Hammerfall HDSP 9632";
 		hdsp->ss_in_channels = H9632_SS_CHANNELS+aebi_channels;
 		hdsp->ds_in_channels = H9632_DS_CHANNELS+aebi_channels;
@@ -4929,7 +4933,6 @@
 {
 	struct pci_dev *pci = hdsp->pci;
 	int err;
-	int i;
 	int is_9652 = 0;
 	int is_9632 = 0;
 
@@ -4948,6 +4951,7 @@
 	hdsp->control_register = 0;
 	hdsp->control2_register = 0;
 	hdsp->io_type = Undefined;
+	hdsp->max_channels = 26;
 
 	hdsp->card = card;
 	
@@ -4974,6 +4978,7 @@
 		break;
 	case 0x96:
 		hdsp->card_name = "RME HDSP 9632";
+		hdsp->max_channels = 16;
 		is_9632 = 1;
 		break;
 	default:

--------------050802010408090907080005--




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
