From: Thomas Charbonnel <thomas@undata.org>
Subject: hdsp firmware loading fix + 9632 cosmetic fix
Date: Fri, 07 Nov 2003 15:10:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FABA7F0.9080701@undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090105010803040800030103"
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
--------------090105010803040800030103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The attached patch at last fixes the long lasting firmware loading error 
after boot, and includes a small cosmetic fix for H9632 cards (fixes 
SPDIF external rate reporting in /proc/asound/cardX/hdsp and amixer 
outputs).
It should be applied on top of the last patch I sent to the list.

Thomas

--------------090105010803040800030103
Content-Type: text/plain;
 name="firmware_loading.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="firmware_loading.patch"

--- hdsp.c.cvs	2003-11-06 13:06:28.000000000 +0100
+++ hdsp.c	2003-11-07 14:49:56.000000000 +0100
@@ -694,6 +694,13 @@
 				return -EIO;
 			}
 		}
+
+		if ((1000 / HZ) < 3000) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout((3000 * HZ + 999) / 1000);
+		} else {
+			mdelay(3000);
+		}
 		
 		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
 			snd_printk ("timeout at end of firmware loading\n");
@@ -708,12 +715,6 @@
 		hdsp_write (hdsp, HDSP_control2Reg, hdsp->control2_register);
 		snd_printk ("finished firmware loading\n");
 		
-		if ((1000 / HZ) < 3000) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout((3000 * HZ + 999) / 1000);
-		} else {
-			mdelay(3000);
-		}
 	}
 	if (hdsp->state & HDSP_InitializationComplete) {
 		snd_printk("firmware loaded from cache, restoring defaults\n");
@@ -1882,10 +1883,12 @@
 
 static int snd_hdsp_info_spdif_sample_rate(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
-	static char *texts[] = {"32000", "44100", "48000", "64000", "88200", "96000", "None"};
+	static char *texts[] = {"32000", "44100", "48000", "64000", "88200", "96000", "None", "128000", "176400", "192000"};
+	hdsp_t *hdsp = _snd_kcontrol_chip(kcontrol);
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = 7 ;
+	uinfo->value.enumerated.items = (hdsp->io_type == H9632) ? 10 : 7;
 	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
@@ -1915,6 +1918,15 @@
 	case 96000:
 		ucontrol->value.enumerated.item[0] = 5;
 		break;
+	case 128000:
+		ucontrol->value.enumerated.item[0] = 7;
+		break;
+	case 176400:
+		ucontrol->value.enumerated.item[0] = 8;
+		break;
+	case 192000:
+		ucontrol->value.enumerated.item[0] = 9;
+		break;
 	default:
 		ucontrol->value.enumerated.item[0] = 6;		
 	}
@@ -3534,7 +3546,7 @@
 			tmp = "-12 dB";
 			break;
 		}
-		snd_iprintf(buffer, "Phone Gain : %s\n", tmp);
+		snd_iprintf(buffer, "Phones Gain : %s\n", tmp);
 
 		snd_iprintf(buffer, "XLR Breakout Cable : %s\n", hdsp_xlr_breakout_cable(hdsp) ? "yes" : "no");	
 		

--------------090105010803040800030103--




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
