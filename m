From: Marcus Andersson <054185595@telia.com>
Subject: Patch HDSP
Date: Mon, 11 Nov 2002 19:36:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DCFF8B0.D430FDE@telia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------CC8883657D6A63CB8AE0E928"
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
--------------CC8883657D6A63CB8AE0E928
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

this patch fixes two bugs in the RME HDSP driver.

* HDSP card works after cold reboot. Firmware load is properly finished.

* Channel mapping for Multiface works.

Marcus
--------------CC8883657D6A63CB8AE0E928
Content-Type: text/plain; charset=us-ascii;
 name="hdsp_boot2.pch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdsp_boot2.pch"

Index: alsa-kernel/pci/rme9652/hdsp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/hdsp.c,v
retrieving revision 1.12
diff -u -r1.12 hdsp.c
--- alsa-kernel/pci/rme9652/hdsp.c	10 Nov 2002 19:17:43 -0000	1.12
+++ alsa-kernel/pci/rme9652/hdsp.c	11 Nov 2002 18:29:56 -0000
@@ -2,6 +2,7 @@
  *   ALSA driver for RME Hammerfall DSP audio interface(s)
  *
  *      Copyright (c) 2002  Paul Davis
+ *                          Marcus Andersson
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -78,7 +79,7 @@
 #define DIGIFACE_SS_CHANNELS     26
 #define DIGIFACE_DS_CHANNELS     14
 #define MULTIFACE_SS_CHANNELS    18
-#define MULTIFACE_DS_CHANNELS    10
+#define MULTIFACE_DS_CHANNELS    14
 
 /* Write registers. These are defined as byte-offsets from the iobase value.
  */
@@ -681,6 +682,7 @@
 		rate = HDSP_Frequency96KHz;
 		break;
 	default:
+		spin_unlock_irq(&hdsp->lock);
 		return -EINVAL;
 	}
 
@@ -741,10 +743,12 @@
 
 		mapped_channel = hdsp->channel_map[channel];
 
+		snd_assert(mapped_channel > -1, return);
+
 		if (enable) {
-			hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY(channel,channel), UNITY_GAIN);
+			hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY(mapped_channel,mapped_channel), UNITY_GAIN);
 		} else {
-			hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY(channel,channel), MINUS_INFINITY_GAIN);
+			hdsp_write_gain (hdsp, INPUT_TO_OUTPUT_KEY(mapped_channel,mapped_channel), MINUS_INFINITY_GAIN);
 		}
 	}
 }
@@ -1599,10 +1603,18 @@
 	hdsp_t *hdsp = _snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
 	int addr;
-	int chn;
+	int channel;
+	int mapped_channel;
+
+	channel = ucontrol->id.index - 1;
+
+        snd_assert(channel >= 0 || channel < HDSP_MAX_CHANNELS, return -EINVAL);
+        
+	if ((mapped_channel = hdsp->channel_map[channel]) < 0) {
+		return -EINVAL;
+	}
 
-	chn = ucontrol->id.index - 1;
-	addr = PLAYBACK_TO_OUTPUT_KEY(chn, chn);
+	addr = PLAYBACK_TO_OUTPUT_KEY(mapped_channel, mapped_channel);
 
 	spin_lock_irqsave(&hdsp->lock, flags);
 	ucontrol->value.integer.value[0] = hdsp_read_gain (hdsp, addr);
@@ -1616,14 +1628,22 @@
 	unsigned long flags;
 	int change;
 	int addr;
-	int chn;
+	int channel;
+	int mapped_channel;
 	int gain;
 
 	if (!snd_hdsp_use_is_exclusive(hdsp))
 		return -EBUSY;
 	
-	chn = ucontrol->id.index - 1;
-	addr = PLAYBACK_TO_OUTPUT_KEY(chn, chn);
+	channel = ucontrol->id.index - 1;
+
+        snd_assert(channel >= 0 || channel < HDSP_MAX_CHANNELS, return -EINVAL);
+        
+	if ((mapped_channel = hdsp->channel_map[channel]) < 0) {
+		return -EINVAL;
+	}
+
+	addr = PLAYBACK_TO_OUTPUT_KEY(mapped_channel, mapped_channel);
 	gain = ucontrol->value.integer.value[0];
 
 
@@ -2428,15 +2448,15 @@
 				    snd_pcm_channel_info_t *info)
 {
 	hdsp_t *hdsp = _snd_pcm_substream_chip(substream);
-	int chn;
+	int mapped_channel;
 
 	snd_assert(info->channel < HDSP_MAX_CHANNELS, return -EINVAL);
 
-	if ((chn = hdsp->channel_map[info->channel]) < 0) {
+	if ((mapped_channel = hdsp->channel_map[info->channel]) < 0) {
 		return -EINVAL;
 	}
 
-	info->offset = chn * HDSP_CHANNEL_BUFFER_BYTES;
+	info->offset = mapped_channel * HDSP_CHANNEL_BUFFER_BYTES;
 	info->first = 0;
 	info->step = 32;
 	return 0;
@@ -2561,7 +2581,7 @@
 				 SNDRV_PCM_RATE_96000),
 	.rate_min =		32000,
 	.rate_max =		96000,
-	.channels_min =		10,
+	.channels_min =		14,
 	.channels_max =		HDSP_MAX_CHANNELS,
 	.buffer_bytes_max =	1024*1024,
 	.period_bytes_min =	1,
@@ -2586,7 +2606,7 @@
 				 SNDRV_PCM_RATE_96000),
 	.rate_min =		32000,
 	.rate_max =		96000,
-	.channels_min =		10,
+	.channels_min =		14,
 	.channels_max =		HDSP_MAX_CHANNELS,
 	.buffer_bytes_max =	1024*1024,
 	.period_bytes_min =	1,
@@ -2896,10 +2916,14 @@
 			}
 		}
 		
-		if (hdsp_fifo_wait (hdsp, 3, HDSP_LONG_WAIT)) {
+		if (hdsp_fifo_wait (hdsp, 0, HDSP_LONG_WAIT)) {
 			snd_printk ("timeout at end of firmware loading\n");
 			return -EIO;
 		}
+
+		hdsp_write (hdsp, HDSP_jtagReg, 0);
+		snd_printk ("finished firmware loading\n");
+		mdelay(3000);
 
 	} else {
 

--------------CC8883657D6A63CB8AE0E928--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
