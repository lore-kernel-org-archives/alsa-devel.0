From: Pierre-Laurent CHAMBERT <pilo.c@wanadoo.fr>
Subject: rme32 and playback offset in ADAT mode (problem with jack)
Date: Wed, 16 Feb 2005 21:28:57 +0100
Message-ID: <200502162128.57698.pilo.c@wanadoo.fr>
Reply-To: pilo.c@wanadoo.fr
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!
I'm still working on rme32 driver, as I am also building an ADAT convertor 
(now working) I can finish the driver to make it work well now.

So the problem is that when working in adat mode, I need to setup an offset to 
the playback pointer (8 bytes in 16bits mode and 24 in 32bits mode).
WIthout this offset, the first and second channel of the converter actually 
the sound send by jack on output 7 & 8.

So I try to add this offset... but I'm lost...

there are a few different place where I think I need to handle this :

static inline unsigned int snd_rme32_playback_ptr(rme32_t * rme32)
{
 return ((readl(rme32->iobase + RME32_IO_GET_POS) &  
RME32_RCR_AUDIO_ADDR_MASK)) >> rme32->playback_frlog;
}

I try first to add it here... change nothing...

so next :
static snd_pcm_uframes_t
snd_rme32_playback_pointer(snd_pcm_substream_t * substream)
{
	rme32_t *rme32 = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;
	snd_pcm_sframes_t diff;
	size_t bytes;

	snd_pcm_uframes_t offset=0;

	if((rme32->wcreg & RME32_WCR_ADAT)) { /* and interleaved */
	  if(rme32->wcreg & RME32_WCR_MODE24) offset = 24;
	  else offset = 8;
	}

	if (runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
		diff = runtime->control->appl_ptr - rme32->playback_last_appl_ptr;
		rme32->playback_last_appl_ptr = runtime->control->appl_ptr;

		if (diff != 0 && diff < -(snd_pcm_sframes_t) (runtime->boundary >> 1)) {
			diff += runtime->boundary;
		}

		bytes = diff << rme32->playback_frlog;

		/* if the card reach the top of buffer */
		if (bytes > RME32_BUFFER_SIZE - (rme32->playback_ptr + offset)) {
		  /* fill the buffer to the end */
		  memcpy_toio((void *)(rme32->iobase + RME32_IO_DATA_BUFFER + 
rme32->playback_ptr + offset),
				    runtime->dma_area + rme32->playback_ptr,
				    RME32_BUFFER_SIZE - rme32->playback_ptr - offset);

			bytes -= RME32_BUFFER_SIZE - rme32->playback_ptr - offset;

			if (bytes > RME32_BUFFER_SIZE) {
				bytes = RME32_BUFFER_SIZE;
			}

			memcpy_toio((void *)(rme32->iobase + RME32_IO_DATA_BUFFER),
				    runtime->dma_area, bytes);
			rme32->playback_ptr = bytes-offset;
		} else if (bytes != 0) {
			memcpy_toio((void *)(rme32->iobase + RME32_IO_DATA_BUFFER + 
rme32->playback_ptr + offset),
				    runtime->dma_area + rme32->playback_ptr, bytes);
			rme32->playback_ptr += bytes;
		}
	}
	return snd_rme32_playback_ptr(rme32);
}

as you can see I already add offset in memcpy here, and it works. But there 
are "clicks" in sound, and if instead of sending sound to output 1&2 I switch 
to 7&8 I can here those "clicks", so I think sound copied without the 
offset... 

I try to change 
static int snd_rme32_playback_copy(snd_pcm_substream_t * substream, int 
channel,	/* not used (interleaved data) */
				   snd_pcm_uframes_t pos,
				   void *src, snd_pcm_uframes_t count)
{

	snd_pcm_uframes_t offset=0;

	if((rme32->wcreg & RME32_WCR_ADAT)) { /* and interleaved */
	  if(rme32->wcreg & RME32_WCR_MODE24) offset = 24;
	  else offset = 8;
	}

	rme32_t *rme32 = snd_pcm_substream_chip(substream);
	count <<= rme32->playback_frlog;
	pos <<= rme32->playback_frlog;
	if (copy_from_user_toio(rme32->iobase + RME32_IO_DATA_BUFFER + pos + offset, 
src, count))
		return -EFAULT;
	return 0;
}

but it changes nothing....


so what is the way to do this? (I only tested it with jack).

thank you!!

Pilo





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
