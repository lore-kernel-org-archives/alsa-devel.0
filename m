From: Raymond <rayau@netvigator.com>
Subject: Re: alsa dma transfer
Date: Wed, 29 Jun 2005 20:33:22 +0800
Message-ID: <42C29512.7020205@netvigator.com>
References: <9AEDBAA573BBD346BCF9637D80097D911DCCE9@greysvr02.GreyInnovation.com> <s5hd5q57bv5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5q57bv5.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Wed, 29 Jun 2005 16:35:21 +1000,
> Tehn-Yit Chin wrote:
> 
>>From what I can tell, runtime->dma_start is a virtual memory buffer that
>>has the audio data, and the amount of data to transfer is in
>>frames_to_bytes(runtime, runtime->period_size). Is this right?
> 
> 
> runtime->dma_area is the virtual address and runtime->dma_addr is the
> physical (more exactly bus) address.  They are set up either via
> snd_pcm_lib_malloc_pages() or manually by yourself in hwparams
> callback.  In the former case, you'll need the buffer pre-allocation
> beforehand at the creation of PCM instance.
> 
> 

When implementing wavetable synth in au88x0, how to setup DMA in order
to play those pre-loaded sound font samples (loaded to snd_util_memhdr_t
using hwdep) through PCM (hw:0) ?

The device hw:0 allow sending 16 mono PCM samples ( change pitch by SRC 
and panning by hardware mixer, no reverb and chrous effect) to AC97 codec

How to ensure each sound font samples loaded in memory aligned at 4K
boundary ?




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
