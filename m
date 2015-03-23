From: Joe Perches <joe@perches.com>
Subject: [trivial PATCH] sound: Deparenthesize negative error returns
Date: Mon, 23 Mar 2015 12:44:49 -0700
Message-ID: <1427139889.16851.35.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Make the returns a bit more kernel standard style.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/isa/wavefront/wavefront_fx.c    |  6 +++---
 sound/isa/wavefront/wavefront_synth.c | 26 +++++++++++++-------------
 sound/oss/dev_table.c                 |  6 +++---
 sound/oss/v_midi.c                    |  4 ++--
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_fx.c b/sound/isa/wavefront/wavefront_fx.c
index b5a1970..0608a5a 100644
--- a/sound/isa/wavefront/wavefront_fx.c
+++ b/sound/isa/wavefront/wavefront_fx.c
@@ -79,13 +79,13 @@ wavefront_fx_memset (snd_wavefront_t *dev,
 	if (page < 0 || page > 7) {
 		snd_printk ("FX memset: "
 			"page must be >= 0 and <= 7\n");
-		return -(EINVAL);
+		return -EINVAL;
 	}
 
 	if (addr < 0 || addr > 0x7f) {
 		snd_printk ("FX memset: "
 			"addr must be >= 0 and <= 7f\n");
-		return -(EINVAL);
+		return -EINVAL;
 	}
 
 	if (cnt == 1) {
@@ -118,7 +118,7 @@ wavefront_fx_memset (snd_wavefront_t *dev,
 			snd_printk ("FX memset "
 				    "(0x%x, 0x%x, 0x%lx, %d) incomplete\n",
 				    page, addr, (unsigned long) data, cnt);
-			return -(EIO);
+			return -EIO;
 		}
 	}
 
diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index 33f5ec1..69f76ff 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -793,7 +793,7 @@ wavefront_send_patch (snd_wavefront_t *dev, wavefront_patch_info *header)
     
 	if (snd_wavefront_cmd (dev, WFC_DOWNLOAD_PATCH, NULL, buf)) {
 		snd_printk ("download patch failed\n");
-		return -(EIO);
+		return -EIO;
 	}
 
 	return (0);
@@ -831,7 +831,7 @@ wavefront_send_program (snd_wavefront_t *dev, wavefront_patch_info *header)
     
 	if (snd_wavefront_cmd (dev, WFC_DOWNLOAD_PROGRAM, NULL, buf)) {
 		snd_printk ("download patch failed\n");	
-		return -(EIO);
+		return -EIO;
 	}
 
 	return (0);
@@ -952,7 +952,7 @@ wavefront_send_sample (snd_wavefront_t *dev,
 	if (skip > 0 && header->hdr.s.SampleResolution != LINEAR_16BIT) {
 		snd_printk ("channel selection only "
 			    "possible on 16-bit samples");
-		return -(EINVAL);
+		return -EINVAL;
 	}
 
 	switch (skip) {
@@ -1049,7 +1049,7 @@ wavefront_send_sample (snd_wavefront_t *dev,
 			   NULL, sample_hdr)) {
 		snd_printk ("sample %sdownload refused.\n",
 			    header->size ? "" : "header ");
-		return -(EIO);
+		return -EIO;
 	}
 
 	if (header->size == 0) {
@@ -1075,7 +1075,7 @@ wavefront_send_sample (snd_wavefront_t *dev,
 		if (snd_wavefront_cmd (dev, WFC_DOWNLOAD_BLOCK, NULL, NULL)) {
 			snd_printk ("download block "
 				    "request refused.\n");
-			return -(EIO);
+			return -EIO;
 		}
 
 		for (i = 0; i < blocksize; i++) {
@@ -1135,12 +1135,12 @@ wavefront_send_sample (snd_wavefront_t *dev,
 			if (dma_ack == -1) {
 				snd_printk ("upload sample "
 					    "DMA ack timeout\n");
-				return -(EIO);
+				return -EIO;
 			} else {
 				snd_printk ("upload sample "
 					    "DMA ack error 0x%x\n",
 					    dma_ack);
-				return -(EIO);
+				return -EIO;
 			}
 		}
 	}
@@ -1181,7 +1181,7 @@ wavefront_send_alias (snd_wavefront_t *dev, wavefront_patch_info *header)
 
 	if (snd_wavefront_cmd (dev, WFC_DOWNLOAD_SAMPLE_ALIAS, NULL, alias_hdr)) {
 		snd_printk ("download alias failed.\n");
-		return -(EIO);
+		return -EIO;
 	}
 
 	dev->sample_status[header->number] = (WF_SLOT_FILLED|WF_ST_ALIAS);
@@ -1232,7 +1232,7 @@ wavefront_send_multisample (snd_wavefront_t *dev, wavefront_patch_info *header)
 			   msample_hdr)) {
 		snd_printk ("download of multisample failed.\n");
 		kfree(msample_hdr);
-		return -(EIO);
+		return -EIO;
 	}
 
 	dev->sample_status[header->number] = (WF_SLOT_FILLED|WF_ST_MULTISAMPLE);
@@ -1254,7 +1254,7 @@ wavefront_fetch_multisample (snd_wavefront_t *dev,
     
 	if (snd_wavefront_cmd (dev, WFC_UPLOAD_MULTISAMPLE, log_ns, number)) {
 		snd_printk ("upload multisample failed.\n");
-		return -(EIO);
+		return -EIO;
 	}
     
 	DPRINT (WF_DEBUG_DATA, "msample %d has %d samples\n",
@@ -1273,14 +1273,14 @@ wavefront_fetch_multisample (snd_wavefront_t *dev,
 		if ((val = wavefront_read (dev)) == -1) {
 			snd_printk ("upload multisample failed "
 				    "during sample loop.\n");
-			return -(EIO);
+			return -EIO;
 		}
 		d[0] = val;
 
 		if ((val = wavefront_read (dev)) == -1) {
 			snd_printk ("upload multisample failed "
 				    "during sample loop.\n");
-			return -(EIO);
+			return -EIO;
 		}
 		d[1] = val;
 	
@@ -1315,7 +1315,7 @@ wavefront_send_drum (snd_wavefront_t *dev, wavefront_patch_info *header)
 
 	if (snd_wavefront_cmd (dev, WFC_DOWNLOAD_EDRUM_PROGRAM, NULL, drumbuf)) {
 		snd_printk ("download drum failed.\n");
-		return -(EIO);
+		return -EIO;
 	}
 
 	return (0);
diff --git a/sound/oss/dev_table.c b/sound/oss/dev_table.c
index d8cf3e5..6dad515 100644
--- a/sound/oss/dev_table.c
+++ b/sound/oss/dev_table.c
@@ -58,13 +58,13 @@ int sound_install_audiodrv(int vers, char *name, struct audio_driver *driver,
 
 	if (vers != AUDIO_DRIVER_VERSION || driver_size > sizeof(struct audio_driver)) {
 		printk(KERN_ERR "Sound: Incompatible audio driver for %s\n", name);
-		return -(EINVAL);
+		return -EINVAL;
 	}
 	num = sound_alloc_audiodev();
 
 	if (num == -1) {
 		printk(KERN_ERR "sound: Too many audio drivers\n");
-		return -(EBUSY);
+		return -EBUSY;
 	}
 	d = (struct audio_driver *) (sound_mem_blocks[sound_nblocks] = vmalloc(sizeof(struct audio_driver)));
 	sound_nblocks++;
@@ -79,7 +79,7 @@ int sound_install_audiodrv(int vers, char *name, struct audio_driver *driver,
 	if (d == NULL || op == NULL) {
 		printk(KERN_ERR "Sound: Can't allocate driver for (%s)\n", name);
 		sound_unload_audiodev(num);
-		return -(ENOMEM);
+		return -ENOMEM;
 	}
 	init_waitqueue_head(&op->in_sleeper);
 	init_waitqueue_head(&op->out_sleeper);	
diff --git a/sound/oss/v_midi.c b/sound/oss/v_midi.c
index f0b4151..fc0ba27 100644
--- a/sound/oss/v_midi.c
+++ b/sound/oss/v_midi.c
@@ -49,13 +49,13 @@ static int v_midi_open (int dev, int mode,
 	unsigned long flags;
 
 	if (devc == NULL)
-		return -(ENXIO);
+		return -ENXIO;
 
 	spin_lock_irqsave(&devc->lock,flags);
 	if (devc->opened)
 	{
 		spin_unlock_irqrestore(&devc->lock,flags);
-		return -(EBUSY);
+		return -EBUSY;
 	}
 	devc->opened = 1;
 	spin_unlock_irqrestore(&devc->lock,flags);
