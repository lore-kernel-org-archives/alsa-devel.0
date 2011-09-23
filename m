From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: snd-aloop: make
	preallocated	buffer	size	configurable
Date: Fri, 23 Sep 2011 16:03:31 -0500
Message-ID: <1316811812.2191.6.camel@pbossart-Dell-N7010>
References: <1316545332-2229-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<s5hzkhygkpe.wl%tiwai@suse.de> <s5hpqiugdu2.wl%tiwai@suse.de>
	<s5h7h51hpb9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-YV2hEu3nbZMr0Eenxj3g"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id F3F1D244A0
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 23:04:01 +0200 (CEST)
In-Reply-To: <s5h7h51hpb9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-YV2hEu3nbZMr0Eenxj3g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


> Well, if it's only about snd-aloop, another option would be to use
> vmalloc'ed buffer for aloop.  Since it's no hardware buffer, it's
> more system-friendly, and you don't need a pre-allocation.
> Again, an untested patch is below.

I wasn't sure why physically-contiguous memory would be required, just
reduced it, but it makes sense to remove it altogether.

I used a double loopback, one in alsa and one in pulseaudio. Works fine.
$ pactl load-module module-loopback source=alsa_input.1.analog-stereo
sink=alsa_output.pci-0000_00_1b.0.analog-stereo
$ aplay -Dhw:1,1 viol-1mn.wav 


For some reason I couldn't apply the patch as is, here's what I used
Thanks!
-Pierre

--=-YV2hEu3nbZMr0Eenxj3g
Content-Disposition: attachment; filename="aloop.patch"
Content-Type: text/x-patch; name="aloop.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index a0da775..4e40a40 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -575,7 +575,8 @@ static void loopback_runtime_free(struct snd_pcm_runtime *runtime)
 static int loopback_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params)
 {
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(params));
 }
 
 static int loopback_hw_free(struct snd_pcm_substream *substream)
@@ -587,7 +588,7 @@ static int loopback_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&dpcm->loopback->cable_lock);
 	cable->valid &= ~(1 << substream->stream);
 	mutex_unlock(&dpcm->loopback->cable_lock);
-	return snd_pcm_lib_free_pages(substream);
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
 
 static unsigned int get_cable_index(struct snd_pcm_substream *substream)
@@ -740,6 +741,8 @@ static struct snd_pcm_ops loopback_playback_ops = {
 	.prepare =	loopback_prepare,
 	.trigger =	loopback_trigger,
 	.pointer =	loopback_pointer,
+	.page =         snd_pcm_lib_get_vmalloc_page,
+	.mmap =         snd_pcm_lib_mmap_vmalloc
 };
 
 static struct snd_pcm_ops loopback_capture_ops = {
@@ -751,6 +754,8 @@ static struct snd_pcm_ops loopback_capture_ops = {
 	.prepare =	loopback_prepare,
 	.trigger =	loopback_trigger,
 	.pointer =	loopback_pointer,
+	.page =         snd_pcm_lib_get_vmalloc_page,
+	.mmap =         snd_pcm_lib_mmap_vmalloc
 };
 
 static int __devinit loopback_pcm_new(struct loopback *loopback,
@@ -772,9 +777,6 @@ static int __devinit loopback_pcm_new(struct loopback *loopback,
 
 	loopback->pcm[device] = pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-			snd_dma_continuous_data(GFP_KERNEL),
-			0, 2 * 1024 * 1024);
 	return 0;
 }
 

--=-YV2hEu3nbZMr0Eenxj3g
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-YV2hEu3nbZMr0Eenxj3g--
