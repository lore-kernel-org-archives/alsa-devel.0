From: Thomas Charbonnel <thomas@undata.org>
Subject: hdsp update
Date: Sun, 23 Nov 2003 18:21:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FC0EC7D.1010701@undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080508090301010708030604"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, torger@ludd.luth.se
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080508090301010708030604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The attach patch fixes problems with speed modes for H9632 cards (many
thanks to Pentti Ala-Vannesluoma for testing the driver and helping
finding bugs), and the AutoSync mode issue (for all cards) reported by
Anders Torger at the end of september.
A new version of hdspmixer is also available here :
http://www.undata.org/~thomas/
It is mostly a bugfix release for H9632 users.
There is also a new version of hdspconf, but it only adds a .desktop
file and a nice icon (to bring it to par with the new hdspmixer), so
Takashi, feel free not to commit this one if you don't have much time :)

Thomas


--------------080508090301010708030604
Content-Type: text/plain;
 name="hdsp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdsp.patch"

--- hdsp.c.cvs	2003-11-07 14:49:56.000000000 +0100
+++ hdsp.c	2003-11-21 17:15:18.000000000 +0100
@@ -1109,16 +1109,17 @@
 		rate_bits = HDSP_Frequency176_4KHz;
 		break;
 	case 192000:
-		if (current_rate != 192000) {
+		if (current_rate < 128000) {
 			reject_if_open = 1;
 		}
 		rate_bits = HDSP_Frequency192KHz;
+		break;
 	default:
 		return -EINVAL;
 	}
 
 	if (reject_if_open && (hdsp->capture_pid >= 0 || hdsp->playback_pid >= 0)) {
-		snd_printk ("cannot change between single- and double-speed mode (capture PID = %d, playback PID = %d)\n",
+		snd_printk ("cannot change speed mode (capture PID = %d, playback PID = %d)\n",
 			    hdsp->capture_pid,
 			    hdsp->playback_pid);
 		return -EBUSY;
@@ -2102,9 +2103,11 @@
 	switch (mode) {
 	case HDSP_CLOCK_SOURCE_AUTOSYNC:
 		if (hdsp_external_sample_rate(hdsp) != 0) {
-		    hdsp->control_register &= ~HDSP_ClockModeMaster;		
-		    hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
-		    return 0;
+		    if (!hdsp_set_rate(hdsp, hdsp_external_sample_rate(hdsp), 1)) {
+			hdsp->control_register &= ~HDSP_ClockModeMaster;		
+			hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
+			return 0;
+		    }
 		}
 		return -1;
 	case HDSP_CLOCK_SOURCE_INTERNAL_32KHZ:
@@ -4189,30 +4192,36 @@
 static int snd_hdsp_hw_rule_in_channels(snd_pcm_hw_params_t *params,
 					snd_pcm_hw_rule_t *rule)
 {
-	unsigned int list[2];
+	unsigned int list[3];
 	hdsp_t *hdsp = rule->private;
 	snd_interval_t *c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 	if (hdsp->io_type == H9632) {
 		list[0] = hdsp->qs_in_channels;
+		list[1] = hdsp->ds_in_channels;
+		list[2] = hdsp->ss_in_channels;
+		return snd_interval_list(c, 3, list, 0);
 	} else {
 		list[0] = hdsp->ds_in_channels;
+		list[1] = hdsp->ss_in_channels;
 	}
-	list[1] = hdsp->ss_in_channels;
 	return snd_interval_list(c, 2, list, 0);
 }
 
 static int snd_hdsp_hw_rule_out_channels(snd_pcm_hw_params_t *params,
 					snd_pcm_hw_rule_t *rule)
 {
-	unsigned int list[2];
+	unsigned int list[3];
 	hdsp_t *hdsp = rule->private;
 	snd_interval_t *c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 	if (hdsp->io_type == H9632) {
 		list[0] = hdsp->qs_out_channels;
+		list[1] = hdsp->ds_out_channels;
+		list[2] = hdsp->ss_out_channels;
+		return snd_interval_list(c, 3, list, 0);
 	} else {
 		list[0] = hdsp->ds_out_channels;
+		list[1] = hdsp->ss_out_channels;
 	}
-	list[1] = hdsp->ss_out_channels;
 	return snd_interval_list(c, 2, list, 0);
 }
 
@@ -4229,7 +4238,7 @@
 			.integer = 1,
 		};
 		return snd_interval_refine(c, &t);	
-	} else if (r->min > 48000) {
+	} else if (r->min > 48000 && r->max <= 96000) {
 		snd_interval_t t = {
 			.min = hdsp->ds_in_channels,
 			.max = hdsp->ds_in_channels,
@@ -4260,7 +4269,7 @@
 			.integer = 1,
 		};
 		return snd_interval_refine(c, &t);	
-	} else if (r->min > 48000) {
+	} else if (r->min > 48000 && r->max <= 96000) {
 		snd_interval_t t = {
 			.min = hdsp->ds_out_channels,
 			.max = hdsp->ds_out_channels,


--------------080508090301010708030604--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
