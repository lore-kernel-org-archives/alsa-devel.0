From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 10/14] ALSA: pcm: Simplify
	snd_pcm_playback_silence()
Date: Fri, 26 May 2017 22:21:54 +0900
Message-ID: <b88e1428-561b-f1ff-9fb8-ca2ca504ee6f@sakamocchi.jp>
References: <20170525191735.13787-1-tiwai@suse.de>
 <20170525191735.13787-11-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id CA6092674DB
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 15:21:58 +0200 (CEST)
In-Reply-To: <20170525191735.13787-11-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On May 26 2017 04:17, Takashi Iwai wrote:
> Use the existing silence helper codes for simplification.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_lib.c | 40 +++++++++++++---------------------------
>   1 file changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index c24a78e39b88..094447ae8486 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -42,6 +42,9 @@
>   #define trace_hw_ptr_error(substream, reason)
>   #endif
>   
> +static int fill_silence(struct snd_pcm_substream *substream, int channel,
> +			unsigned long hwoff, void *buf, unsigned long bytes);
> +
>   /*
>    * fill ring buffer with silence
>    * runtime->silence_start: starting pointer to silence area
> @@ -55,8 +58,7 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
>   {
>   	struct snd_pcm_runtime *runtime = substream->runtime;
>   	snd_pcm_uframes_t frames, ofs, transfer;
> -	char *hwbuf;
> -	int err;
> +	int c;
>   
>   	if (runtime->silence_size < runtime->boundary) {
>   		snd_pcm_sframes_t noise_dist, n;
> @@ -111,33 +113,17 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
>   		transfer = ofs + frames > runtime->buffer_size ? runtime->buffer_size - ofs : frames;
>   		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
>   		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
> -			if (substream->ops->fill_silence) {
> -				err = substream->ops->fill_silence(substream, 0,
> -								   frames_to_bytes(runtime, ofs),
> -								   frames_to_bytes(runtime, transfer));
> -				snd_BUG_ON(err < 0);
> -			} else {
> -				hwbuf = runtime->dma_area + frames_to_bytes(runtime, ofs);
> -				snd_pcm_format_set_silence(runtime->format, hwbuf, transfer * runtime->channels);
> -			}
> +			fill_silence(substream, 0,
> +				     frames_to_bytes(runtime, ofs), NULL,
> +				     frames_to_bytes(runtime, transfer));
>   		} else {
> -			unsigned int c;
> -			unsigned int channels = runtime->channels;
> -			if (substream->ops->fill_silence) {
> -				for (c = 0; c < channels; ++c) {
> -					err = substream->ops->fill_silence(substream, c,
> -									   samples_to_bytes(runtime, ofs),
> -									   samples_to_bytes(runtime, transfer));
> -					snd_BUG_ON(err < 0);
> -				}
> -			} else {
> -				size_t dma_csize = runtime->dma_bytes / channels;
> -				for (c = 0; c < channels; ++c) {
> -					hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, ofs);
> -					snd_pcm_format_set_silence(runtime->format, hwbuf, transfer);
> -				}
> -			}
> +			int byte_ofs = samples_to_bytes(runtime, ofs);
> +			int byte_xfer = samples_to_bytes(runtime, transfer);
> +			for (c = 0; c < runtime->channels; ++c)
> +				fill_silence(substream, c, byte_ofs, NULL,
> +					     byte_xfer);
>   		}
> +
>   		runtime->silence_filled += transfer;
>   		frames -= transfer;
>   		ofs = 0;

A part of the content inner the while loop can be replaced with added 
'writer' functions. And the purpose of this patchset is a kind of 
refactoring, however this drops snd_BUG_ON(). It should be remained. 
Below patch can be squashed to your patch for the points.

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 094447ae8486..7758bffdc4e2 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -42,9 +42,27 @@
  #define trace_hw_ptr_error(substream, reason)
  #endif

+typedef int (*pcm_transfer_f)(struct snd_pcm_substream *substream,
+			      int channel, unsigned long hwoff,
+			      void *buf, unsigned long bytes);
+
+typedef int (*pcm_copy_f)(struct snd_pcm_substream *, 
snd_pcm_uframes_t, void *,
+			  snd_pcm_uframes_t, snd_pcm_uframes_t, pcm_transfer_f);
+
  static int fill_silence(struct snd_pcm_substream *substream, int channel,
  			unsigned long hwoff, void *buf, unsigned long bytes);

+static int interleaved_copy(struct snd_pcm_substream *substream,
+			    snd_pcm_uframes_t hwoff, void *data,
+			    snd_pcm_uframes_t off,
+			    snd_pcm_uframes_t frames,
+			    pcm_transfer_f transfer);
+static int noninterleaved_copy(struct snd_pcm_substream *substream,
+			       snd_pcm_uframes_t hwoff, void *data,
+			       snd_pcm_uframes_t off,
+			       snd_pcm_uframes_t frames,
+			       pcm_transfer_f transfer);
+
  /*
   * fill ring buffer with silence
   * runtime->silence_start: starting pointer to silence area
@@ -58,7 +76,8 @@ void snd_pcm_playback_silence(struct snd_pcm_substream 
*substream, snd_pcm_ufram
  {
  	struct snd_pcm_runtime *runtime = substream->runtime;
  	snd_pcm_uframes_t frames, ofs, transfer;
-	int c;
+	pcm_copy_f copy;
+	int err;

  	if (runtime->silence_size < runtime->boundary) {
  		snd_pcm_sframes_t noise_dist, n;
@@ -109,20 +128,18 @@ void snd_pcm_playback_silence(struct 
snd_pcm_substream *substream, snd_pcm_ufram
  	if (frames == 0)
  		return;
  	ofs = runtime->silence_start % runtime->buffer_size;
+
+	if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
+	    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED)
+		copy = interleaved_copy;
+	else
+		copy = noninterleaved_copy;
+
  	while (frames > 0) {
  		transfer = ofs + frames > runtime->buffer_size ? 
runtime->buffer_size - ofs : frames;
-		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
-		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
-			fill_silence(substream, 0,
-				     frames_to_bytes(runtime, ofs), NULL,
-				     frames_to_bytes(runtime, transfer));
-		} else {
-			int byte_ofs = samples_to_bytes(runtime, ofs);
-			int byte_xfer = samples_to_bytes(runtime, transfer);
-			for (c = 0; c < runtime->channels; ++c)
-				fill_silence(substream, c, byte_ofs, NULL,
-					     byte_xfer);
-		}
+		err = copy(substream, ofs, (void *)NULL, 0, transfer,
+			   fill_silence);
+		snd_BUG_ON(err < 0);

  		runtime->silence_filled += transfer;
  		frames -= transfer;
@@ -1977,13 +1994,6 @@ static int wait_for_avail(struct 
snd_pcm_substream *substream,
  	return err;
  }
  	
-typedef int (*pcm_transfer_f)(struct snd_pcm_substream *substream,
-			      int channel, unsigned long hwoff,
-			      void *buf, unsigned long bytes);
-
-typedef int (*pcm_copy_f)(struct snd_pcm_substream *, 
snd_pcm_uframes_t, void *,
-			  snd_pcm_uframes_t, snd_pcm_uframes_t, pcm_transfer_f);
-
  /* calculate the target DMA-buffer position to be written/read */
  static void *get_dma_ptr(struct snd_pcm_runtime *runtime,
  			   int channel, unsigned long hwoff)


Regards

Takashi Sakamoto
