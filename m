From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PATCH: snd_pcm_playback_silence
Date: Fri, 12 Apr 2002 09:06:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0204120904100.581-100000@pnote.perex-int.cz>
References: <200204111513.g3BFDsK4093415@smtpzilla1.xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200204111513.g3BFDsK4093415@smtpzilla1.xs4all.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Sander van Leeuwen <sandervl@xs4all.nl>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Apr 2002, Sander van Leeuwen wrote:

> Hi,
> 
> I'm currently porting ALSA to OS/2 and have encountered a bug in
> snd_pcm_playback_silence (core\pcm_lib.c)
> While playing an 8 bits stereo 44.1khz wave file the system
> would trap when stopping the stream. The cause was heap
> corruption caused by this function. There is no check to
> see if the offset + amount of frames to silence is larger
> than the buffer size.
> The patch below fixes this.
> 
> Sander
> 
> 
> 
> --- E:\Development\ALSA.Linux\alsa-kernel\core\pcm_lib.c	Wed Apr 10 21:55:18 2002
> +++ E:\Development\ALSA.OS2\GPL\alsa\core\pcm_lib.c	Thu Apr 11 17:01:38 2002
> @@ -60,6 +56,12 @@
>  	ofs = runtime->silenced_start % runtime->buffer_size + runtime->silenced_size;
>  	if (ofs >= runtime->buffer_size)
>  		ofs -= runtime->buffer_size;
> +#ifdef TARGET_OS2
> +        if (ofs + frames > runtime->buffer_size) {
> +                frames = runtime->buffer_size - ofs;
> +        }
> +#endif
>  	if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
>  	    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
>  		if (substream->ops->silence) {

Above patch is not perfect, but thank you for pointing to this problem. 
I've applied this fix to CVS:

Index: pcm_lib.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/pcm_lib.c,v
retrieving revision 1.9
diff -u -r1.9 pcm_lib.c
--- pcm_lib.c	9 Apr 2002 06:53:35 -0000	1.9
+++ pcm_lib.c	12 Apr 2002 07:04:47 -0000
@@ -34,7 +34,7 @@
 void snd_pcm_playback_silence(snd_pcm_substream_t *substream)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	snd_pcm_uframes_t frames, ofs;
+	snd_pcm_uframes_t frames, ofs, transfer;
 	snd_pcm_sframes_t noise_dist;
 	if (runtime->silenced_start != runtime->control->appl_ptr) {
 		snd_pcm_sframes_t n = runtime->control->appl_ptr - runtime->silenced_start;
@@ -60,32 +60,36 @@
 	ofs = runtime->silenced_start % runtime->buffer_size + runtime->silenced_size;
 	if (ofs >= runtime->buffer_size)
 		ofs -= runtime->buffer_size;
-	if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
-	    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
-		if (substream->ops->silence) {
-			int err;
-			err = substream->ops->silence(substream, -1, ofs, frames);
-			snd_assert(err >= 0, );
-		} else {
-			char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, ofs);
-			snd_pcm_format_set_silence(runtime->format, hwbuf, frames * runtime->channels);
-		}
-	} else {
-		unsigned int c;
-		unsigned int channels = runtime->channels;
-		if (substream->ops->silence) {
-			for (c = 0; c < channels; ++c) {
+	while (frames > 0) {
+		transfer = ofs + frames > runtime->buffer_size ? runtime->buffer_size - ofs : frames;
+		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
+		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
+			if (substream->ops->silence) {
 				int err;
-				err = substream->ops->silence(substream, c, ofs, frames);
+				err = substream->ops->silence(substream, -1, ofs, transfer);
 				snd_assert(err >= 0, );
+			} else {
+				char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, ofs);
+				snd_pcm_format_set_silence(runtime->format, hwbuf, transfer * runtime->channels);
 			}
 		} else {
-			size_t dma_csize = runtime->dma_bytes / channels;
-			for (c = 0; c < channels; ++c) {
-				char *hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, ofs);
-				snd_pcm_format_set_silence(runtime->format, hwbuf, frames);
+			unsigned int c;
+			unsigned int channels = runtime->channels;
+			if (substream->ops->silence) {
+				for (c = 0; c < channels; ++c) {
+					int err;
+					err = substream->ops->silence(substream, c, ofs, transfer);
+					snd_assert(err >= 0, );
+				}
+			} else {
+				size_t dma_csize = runtime->dma_bytes / channels;
+				for (c = 0; c < channels; ++c) {
+					char *hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, ofs);
+					snd_pcm_format_set_silence(runtime->format, hwbuf, transfer);
+				}
 			}
 		}
+		frames -= transfer;
 	}
 	runtime->silenced_size += frames;
 }


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
