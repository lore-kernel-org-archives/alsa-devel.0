From: Anders Torger <torger@ludd.luth.se>
Subject: RME96 driver patch
Date: Sun, 5 Jan 2003 16:46:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301051646.47991.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ZTZ80RLDC6Y1LMND2CDF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA13135
	for <alsa-devel@alsa-project.org>; Sun, 5 Jan 2003 16:47:21 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, martin-langer@gmx.de, vanDongen-Gilcher <gml@xs4all.nl>
List-Id: alsa-devel@alsa-project.org


--------------Boundary-00=_ZTZ80RLDC6Y1LMND2CDF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit


Here is a patch against rme96.c

It fixes a few slight problems. A few bad things could happen when 
switching between ADAT and SPDIF and trying to run them simultaneously.

The major improvement is however how slave/master and input signals are 
handled. In the old driver, the card could not be opened if there was 
no input signal, this has been fixed. And the driver filters out the 
currently available input format in the hardware capabilities it 
reports.

For playback:
card is master: allow any rate
card is slave + no input signal: allow any rate
card is slave + input signal: allow/report only the rate provided at 
input

For capture:
no input signal: allow any rate and both ADAT/SPDIF
input signal: allow/report only the rate and format (ADAT or SPDIF).

Suggested CVS comment: "Now properly considers slave/master and input 
signal format in open and hwparams; fixed parallel ADAT/SPDIF open bug"

The rme32 driver is based on the rme96 driver, so I suppose Martin may 
be interested by this patch, but perhaps wait a while and see if 
someone complains on this patch. It works fine for me though, so far 
:-)

/Anders Torger
--------------Boundary-00=_ZTZ80RLDC6Y1LMND2CDF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rme96.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rme96.c.diff"

Index: rme96.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/rme96.c,v
retrieving revision 1.19
diff -u -r1.19 rme96.c
--- rme96.c	2 Dec 2002 16:58:04 -0000	1.19
+++ rme96.c	5 Jan 2003 15:42:19 -0000
@@ -330,6 +330,20 @@
 }
 
 static int
+snd_rme96_ratecode(int rate)
+{
+    switch (rate) {
+    case 32000: return SNDRV_PCM_RATE_32000;
+    case 44100: return SNDRV_PCM_RATE_44100;
+    case 48000: return SNDRV_PCM_RATE_48000;
+    case 64000: return SNDRV_PCM_RATE_64000;
+    case 88200: return SNDRV_PCM_RATE_88200;
+    case 96000: return SNDRV_PCM_RATE_96000;
+    }
+    return 0;
+}
+
+static int
 snd_rme96_playback_silence(snd_pcm_substream_t *substream,
 			   int channel, /* not used (interleaved data) */
 			   snd_pcm_uframes_t pos,
@@ -671,8 +685,8 @@
 	if (!(rme96->wcreg & RME96_WCR_MASTER) &&
 	    (rate = snd_rme96_capture_getrate(rme96, &dummy)) > 0)
 	{
-	    /* slave clock */
-	    return rate;
+	        /* slave clock */
+	        return rate;
 	}
 	rate = ((rme96->wcreg >> RME96_WCR_BITPOS_FREQ_0) & 1) +
 		(((rme96->wcreg >> RME96_WCR_BITPOS_FREQ_1) & 1) << 1);
@@ -974,14 +988,22 @@
 snd_rme96_playback_hw_params(snd_pcm_substream_t *substream,
 			     snd_pcm_hw_params_t *params)
 {
-	unsigned long flags;
+	unsigned long flags;        
 	rme96_t *rme96 = _snd_pcm_substream_chip(substream);
-	int err;
+	int err, rate, dummy;
 
 	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params))) < 0)
 		return err;
 	spin_lock_irqsave(&rme96->lock, flags);
-	if ((err = snd_rme96_playback_setrate(rme96, params_rate(params))) < 0) {
+	if (!(rme96->wcreg & RME96_WCR_MASTER) &&
+	    (rate = snd_rme96_capture_getrate(rme96, &dummy)) > 0)
+	{
+                /* slave clock */
+                if (params_rate(params) != rate) {
+		        spin_unlock_irqrestore(&rme96->lock, flags);
+			return -EIO;                    
+                }
+	} else if ((err = snd_rme96_playback_setrate(rme96, params_rate(params))) < 0) {
 		spin_unlock_irqrestore(&rme96->lock, flags);
 		return err;
 	}
@@ -1024,7 +1046,8 @@
 {
 	unsigned long flags;
 	rme96_t *rme96 = _snd_pcm_substream_chip(substream);
-	int err, isadat;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	int err, isadat, rate;
 	
 	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params))) < 0)
 		return err;
@@ -1040,9 +1063,6 @@
 			spin_unlock_irqrestore(&rme96->lock, flags);
 			return err;
 		}
-	} else if (params_rate(params) != snd_rme96_capture_getrate(rme96, &isadat)) {
-		spin_unlock_irqrestore(&rme96->lock, flags);
-		return -EBUSY;
 	}
 	snd_rme96_setframelog(rme96, params_channels(params), 0);
 	if (rme96->playback_periodsize != 0) {
@@ -1052,7 +1072,18 @@
 			spin_unlock_irqrestore(&rme96->lock, flags);
 			return -EBUSY;
 		}
-	}
+	} else if ((rate = snd_rme96_capture_getrate(rme96, &isadat)) > 0) {
+                if (params_rate(params) != rate) {
+			spin_unlock_irqrestore(&rme96->lock, flags);
+			return -EIO;                    
+                }
+                if ((isadat && runtime->hw.channels_min == 2) ||
+                    (!isadat && runtime->hw.channels_min == 8))
+                {
+			spin_unlock_irqrestore(&rme96->lock, flags);
+			return -EIO;
+                }
+        }
 	rme96->capture_periodsize =
 		params_period_size(params) << rme96->capture_frlog;
 	snd_rme96_set_period_properties(rme96, rme96->capture_periodsize);
@@ -1138,7 +1169,7 @@
 	
 	if (rme96->rcreg & RME96_RCR_IRQ) {
 		/* playback */
-		snd_pcm_period_elapsed(rme96->playback_substream);
+                snd_pcm_period_elapsed(rme96->playback_substream);
 		writel(0, rme96->iobase + RME96_IO_CONFIRM_PLAY_IRQ);
 	}
 	if (rme96->rcreg & RME96_RCR_IRQ_2) {
@@ -1162,12 +1193,17 @@
 snd_rme96_playback_spdif_open(snd_pcm_substream_t *substream)
 {
 	unsigned long flags;
+        int rate, dummy;
 	rme96_t *rme96 = _snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
 	snd_pcm_set_sync(substream);
 
 	spin_lock_irqsave(&rme96->lock, flags);	
+        if (rme96->playback_substream != NULL) {
+	        spin_unlock_irqrestore(&rme96->lock, flags);
+                return -EBUSY;
+        }
 	rme96->wcreg &= ~RME96_WCR_ADAT;
 	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 	rme96->playback_substream = substream;
@@ -1175,7 +1211,15 @@
 	rme96->playback_ptr = 0;
 	spin_unlock_irqrestore(&rme96->lock, flags);
 
-	runtime->hw = snd_rme96_playback_spdif_info;	
+	runtime->hw = snd_rme96_playback_spdif_info;
+	if (!(rme96->wcreg & RME96_WCR_MASTER) &&
+	    (rate = snd_rme96_capture_getrate(rme96, &dummy)) > 0)
+	{
+                /* slave clock */
+                runtime->hw.rates = snd_rme96_ratecode(rate);
+                runtime->hw.rate_min = rate;
+                runtime->hw.rate_max = rate;
+	}        
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, RME96_BUFFER_SIZE, RME96_BUFFER_SIZE);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, &hw_constraints_period_bytes);
 
@@ -1190,28 +1234,31 @@
 snd_rme96_capture_spdif_open(snd_pcm_substream_t *substream)
 {
 	unsigned long flags;
-	int isadat;
+        int isadat, rate;
 	rme96_t *rme96 = _snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
-	rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
-	if (snd_rme96_capture_getrate(rme96, &isadat) < 0) {
-		/* no input */
-		return -EIO;
-	}
-	if (isadat) {
-		/* ADAT input */
-		return -EBUSY;
-	}
 	snd_pcm_set_sync(substream);
 
-	spin_lock_irqsave(&rme96->lock, flags);	
+	runtime->hw = snd_rme96_capture_spdif_info;
+        if ((rate = snd_rme96_capture_getrate(rme96, &isadat)) > 0) {
+                if (isadat) {
+                        return -EIO;
+                }
+                runtime->hw.rates = snd_rme96_ratecode(rate);
+                runtime->hw.rate_min = rate;
+                runtime->hw.rate_max = rate;
+        }
+        
+	spin_lock_irqsave(&rme96->lock, flags);
+        if (rme96->capture_substream != NULL) {
+	        spin_unlock_irqrestore(&rme96->lock, flags);
+                return -EBUSY;
+        }
 	rme96->capture_substream = substream;
 	rme96->capture_ptr = 0;
 	spin_unlock_irqrestore(&rme96->lock, flags);
 	
-	runtime->hw = snd_rme96_capture_spdif_info;
-	
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, RME96_BUFFER_SIZE, RME96_BUFFER_SIZE);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, &hw_constraints_period_bytes);
 
@@ -1222,12 +1269,17 @@
 snd_rme96_playback_adat_open(snd_pcm_substream_t *substream)
 {
 	unsigned long flags;
+        int rate, dummy;
 	rme96_t *rme96 = _snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
+	snd_pcm_runtime_t *runtime = substream->runtime;        
 	
 	snd_pcm_set_sync(substream);
 
 	spin_lock_irqsave(&rme96->lock, flags);	
+        if (rme96->playback_substream != NULL) {
+	        spin_unlock_irqrestore(&rme96->lock, flags);
+                return -EBUSY;
+        }
 	rme96->wcreg |= RME96_WCR_ADAT;
 	writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
 	rme96->playback_substream = substream;
@@ -1236,6 +1288,14 @@
 	spin_unlock_irqrestore(&rme96->lock, flags);
 	
 	runtime->hw = snd_rme96_playback_adat_info;
+	if (!(rme96->wcreg & RME96_WCR_MASTER) &&
+	    (rate = snd_rme96_capture_getrate(rme96, &dummy)) > 0)
+	{
+                /* slave clock */
+                runtime->hw.rates = snd_rme96_ratecode(rate);
+                runtime->hw.rate_min = rate;
+                runtime->hw.rate_max = rate;
+	}        
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, RME96_BUFFER_SIZE, RME96_BUFFER_SIZE);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, &hw_constraints_period_bytes);
 	return 0;
@@ -1245,27 +1305,31 @@
 snd_rme96_capture_adat_open(snd_pcm_substream_t *substream)
 {
 	unsigned long flags;
-	int isadat;
+        int isadat, rate;
 	rme96_t *rme96 = _snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
-	rme96->rcreg = readl(rme96->iobase + RME96_IO_CONTROL_REGISTER);
-	if (snd_rme96_capture_getrate(rme96, &isadat) < 0) {
-		/* no input */
-		return -EIO;
-	}
-	if (!isadat) {
-		/* S/PDIF input */
-		return -EBUSY;
-	}
 	snd_pcm_set_sync(substream);
 
+	runtime->hw = snd_rme96_capture_adat_info;
+        if ((rate = snd_rme96_capture_getrate(rme96, &isadat)) > 0) {
+                if (!isadat) {
+                        return -EIO;
+                }
+                runtime->hw.rates = snd_rme96_ratecode(rate);
+                runtime->hw.rate_min = rate;
+                runtime->hw.rate_max = rate;
+        }
+        
 	spin_lock_irqsave(&rme96->lock, flags);	
+        if (rme96->capture_substream != NULL) {
+	        spin_unlock_irqrestore(&rme96->lock, flags);
+                return -EBUSY;
+        }
 	rme96->capture_substream = substream;
 	rme96->capture_ptr = 0;
 	spin_unlock_irqrestore(&rme96->lock, flags);
 
-	runtime->hw = snd_rme96_capture_adat_info;
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, RME96_BUFFER_SIZE, RME96_BUFFER_SIZE);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, &hw_constraints_period_bytes);
 	return 0;
@@ -1279,6 +1343,9 @@
 	int spdif = 0;
 
 	spin_lock_irqsave(&rme96->lock, flags);	
+	if (RME96_ISPLAYING(rme96)) {
+		snd_rme96_playback_stop(rme96);
+	}
 	rme96->playback_substream = NULL;
 	rme96->playback_periodsize = 0;
 	spdif = (rme96->wcreg & RME96_WCR_ADAT) == 0;
@@ -1298,6 +1365,9 @@
 	rme96_t *rme96 = _snd_pcm_substream_chip(substream);
 	
 	spin_lock_irqsave(&rme96->lock, flags);	
+	if (RME96_ISRECORDING(rme96)) {
+		snd_rme96_capture_stop(rme96);
+	}
 	rme96->capture_substream = NULL;
 	rme96->capture_periodsize = 0;
 	spin_unlock_irqrestore(&rme96->lock, flags);

--------------Boundary-00=_ZTZ80RLDC6Y1LMND2CDF--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
