From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: How do I perform non-DMA transfers in an interrupt handler?
Date: Fri, 21 Mar 2003 13:01:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E7AFEFE.50901@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi all,

I face the following problem: The card I'm writing a driver for (SAM9707
based) doesn't support any form of DMA transfer. It requires you to
transfer the PCM data through a 'rep outsw' like mechanism. It raises an
interrupt when it needs new data. The transfer flow is as follows:
     1) allocate buffer on card
     2) start playback
     3) card raises interrupt
     4) transfer block of data in interrupt handler
     5) wait for next interrupt -> 4

How do I implement this in ALSA? After reading the 'Writing an ALSA
driver' document a few times, I still cannot figure out how to do this.
Should I use the copy/silence callbacks? Or can I access the PCM buffer
from within the interrupt handler? I'm currently using 'concept' code
from Uros Bizjak, and the interrupt handler looks like this:

(I removed irrelevant pieces)

     substream = voice->substream;
     runtime = substream->runtime;

     hwoff = runtime->hw_ptr_interrupt;

     hwbuf = (u16 *) runtime->dma_area;
            hwbuf += (frames_to_bytes(runtime, hwoff) >> 1);

     /* word transfer count */
     wcount = snd_pcm_lib_period_bytes(substream);
     wcount >>= 1;

     /* transfer to/from sam9407 buffers */
     if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
         sam->writeData16Burst(sam, hwbuf, wcount);
     else
         sam->readData16Burst(sam, hwbuf, wcount);

     snd_sam9407_command(sam, NULL, SAM_END_XFER,
             &voice->channel, 1, NULL, 0, -1);

     /* update hardware pointer mirror */
     voice->hwptr = runtime->hw_ptr_interrupt + runtime->period_size;

     snd_pcm_period_elapsed(substream);

But I'm not sure if this is correct.

What should I use here?
Is there a card driver that I can refer to that uses the same mechanism?

Pieter




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
