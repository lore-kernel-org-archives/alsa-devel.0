From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH 3/5] TerraTec DMX 6Fire USB updates
Date: Mon, 04 Apr 2011 11:49:00 +0200
Message-ID: <12f1fea5072.-2538109497311885351.4184985179110801240@zoho.com>
References: <12d995c1fa0.477955495632923443.5387390398635058860@zoho.com>
	<s5hr5c7bjmr.wl%tiwai@suse.de>
	<12da59486cd.-2882799020629445819.-7235974021966893201@zoho.com>
	<s5hmxmuiqgw.wl%tiwai@suse.de>
	<12da867d460.-8772675728917411279.-4777530225625691984@zoho.com>
	<12f0d60921e.7616534511239462585.4849758772336073987@zoho.com>
	<s5hr59mw2u5.wl%tiwai@suse.de>
	<12f1b580363.6419672029244585187.-6233154609191024090@zoho.com>
	<s5hwrjamq64.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 180E51038FD
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 11:49:01 +0200 (CEST)
In-Reply-To: <s5hwrjamq64.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Added support for sample format s32_le.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
--- a/sound/usb/6fire/pcm.c	2011-04-04 11:23:42.102833002 +0200
+++ b/sound/usb/6fire/pcm.c	2011-04-04 11:23:10.342833002 +0200
@@ -64,7 +64,7 @@
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_BATCH,
 
-	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.formats = SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
 
 	.rates = SNDRV_PCM_RATE_44100 |
 		SNDRV_PCM_RATE_48000 |
@@ -228,7 +228,7 @@
 	unsigned int total_length = 0;
 	struct pcm_runtime *rt = snd_pcm_substream_chip(sub->instance);
 	struct snd_pcm_runtime *alsa_rt = sub->instance->runtime;
-	u32 *src = (u32 *) urb->buffer;
+	u32 *src = NULL;
 	u32 *dest = (u32 *) (alsa_rt->dma_area + sub->dma_off
 			* (alsa_rt->frame_bits >> 3));
 	u32 *dest_end = (u32 *) (alsa_rt->dma_area + alsa_rt->buffer_size
@@ -244,7 +244,12 @@
 		else
 			frame_count = 0;
 
-		src = (u32 *) (urb->buffer + total_length);
+		if (alsa_rt->format == SNDRV_PCM_FORMAT_S24_LE)
+			src = (u32 *) (urb->buffer + total_length);
+		else if (alsa_rt->format == SNDRV_PCM_FORMAT_S32_LE)
+			src = (u32 *) (urb->buffer - 1 + total_length);
+		else
+			return;
 		src++; /* skip leading 4 bytes of every packet */
 		total_length += urb->packets[i].length;
 		for (frame = 0; frame < frame_count; frame++) {
@@ -274,9 +279,18 @@
 			* (alsa_rt->frame_bits >> 3));
 	u32 *src_end = (u32 *) (alsa_rt->dma_area + alsa_rt->buffer_size
 			* (alsa_rt->frame_bits >> 3));
-	u32 *dest = (u32 *) urb->buffer;
+	u32 *dest;
 	int bytes_per_frame = alsa_rt->channels << 2;
 
+	if (alsa_rt->format == SNDRV_PCM_FORMAT_S32_LE)
+		dest = (u32 *) (urb->buffer - 1);
+	else if (alsa_rt->format == SNDRV_PCM_FORMAT_S24_LE)
+		dest = (u32 *) (urb->buffer);
+	else {
+		snd_printk(KERN_ERR PREFIX "Unknown sample format.");
+		return;
+	}
+
 	for (i = 0; i < PCM_N_PACKETS_PER_URB; i++) {
 		/* at least 4 header bytes for valid packet.
 		 * after that: 32 bits per sample for analog channels */
