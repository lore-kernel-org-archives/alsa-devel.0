From: Paul Davis <pbd@op.net>
Subject: patches for hammerfall-dsp
Date: Thu, 18 Jul 2002 13:52:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207181752.g6IHqCj01075@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA11353
	for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2002 19:50:24 +0200
Received: from unknown (HELO op.net) ([209.92.228.223]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 18 Jul 2002 17:50:17 -0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


 * remove some printk's
 * fix rate rules so that OSS emulation works correctly

Index: hdsp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme9652/hdsp.c,v
retrieving revision 1.8
diff -u -u -r1.8 hdsp.c
--- hdsp.c	14 Jul 2002 21:30:57 -0000	1.8
+++ hdsp.c	18 Jul 2002 17:48:35 -0000
@@ -482,7 +482,6 @@
 	if (hdsp_fifo_wait(hdsp, 127, HDSP_LONG_WAIT)) {
 		return -1;
 	}
-	
 	hdsp_write (hdsp, HDSP_fifoData, ad);
 	hdsp->mixer_matrix[addr] = data;
 
@@ -854,10 +853,7 @@
 		}
 
 		if (clear_timer && hmidi->istimer && --hmidi->istimer <= 0) {
-			printk ("removing timer because there is nothing to do\n");
-			if (del_timer(&hmidi->timer)) {
-				printk ("not removed\n");
-			}
+			del_timer(&hmidi->timer);
 		} 
 	}
 
@@ -956,16 +952,12 @@
 			hmidi->timer.function = snd_hdsp_midi_output_timer;
 			hmidi->timer.data = (unsigned long) hmidi;
 			hmidi->timer.expires = 1 + jiffies;
-			printk ("add timer from output trigger\n");
 			add_timer(&hmidi->timer);
 			hmidi->istimer++;
 		}
 	} else {
 		if (hmidi->istimer && --hmidi->istimer <= 0) {
-			printk ("remove timer in trigger off\n");
-			if (del_timer (&hmidi->timer)) {
-				printk ("not removed\n");
-			}
+			del_timer (&hmidi->timer);
 		}
 	}
 	spin_unlock_irqrestore (&hmidi->lock, flags);
@@ -2560,7 +2552,7 @@
 				 SNDRV_PCM_INFO_SYNC_START |
 				 SNDRV_PCM_INFO_DOUBLE),
 	formats:		SNDRV_PCM_FMTBIT_S32_LE,
-	rates:			(SNDRV_PCM_RATE_32000 | 
+	rates:			(SNDRV_PCM_RATE_32000 |
 				 SNDRV_PCM_RATE_44100 | 
 				 SNDRV_PCM_RATE_48000 | 
 				 SNDRV_PCM_RATE_64000 | 
@@ -2635,7 +2627,7 @@
 			integer: 1,
 		};
 		return snd_interval_refine(c, &t);
-	} else if (r->max < 88200) {
+	} else if (r->max < 64000) {
 		snd_interval_t t = {
 			min: hdsp->ss_channels,
 			max: hdsp->ss_channels,
@@ -2654,14 +2646,14 @@
 	snd_interval_t *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	if (c->min >= hdsp->ss_channels) {
 		snd_interval_t t = {
-			min: 44100,
+			min: 32000,
 			max: 48000,
 			integer: 1,
 		};
 		return snd_interval_refine(r, &t);
 	} else if (c->max <= hdsp->ds_channels) {
 		snd_interval_t t = {
-			min: 88200,
+			min: 64000,
 			max: 96000,
 			integer: 1,
 		};


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
