From: Charles Eidsness <charles.eidsness@rogers.com>
Subject: Re: Problems Writing a Driver for an AMD Au1000 MIPS
 Processor
Date: Tue, 08 Jun 2004 14:09:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C600C4.5000004@rogers.com>
References: <40C4A94D.3070100@rogers.com> <s5hbrju2g0v.wl@alsa2.suse.de>
Reply-To: charles.eidsness@rogers.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrju2g0v.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks! That fixed the problem. :)

I have a follow-up question. The playback now works using OSS emulation 
but whenever I try to run playback using a native ALSA application I get 
an error, for instance when I try to run speaker-test I get:

Playback open error: Invalid argument

I have the following sound devices:

crw-r--r--    1 0        0         14,   0 Jun  4  2004 mixer
crw-r--r--    1 0        0         14,   3 Jun  4  2004 dsp
crw-r--r--    1 0        0        116,   0 Jun  7  2004 snd/controlC0
crw-r--r--    1 0        0        116,   4 Jun  7  2004 snd/hwC0D0
crw-r--r--    1 0        0        116,  24 Jun  7  2004 snd/pcmC0D0c
crw-r--r--    1 0        0        116,  16 Jun  7  2004 snd/pcmC0D0p
crw-r--r--    1 0        0        116,  33 Jun  7  2004 snd/timer

Am I missing something?

Thanks again,
Charles


Takashi Iwai wrote:
> At Mon, 07 Jun 2004 13:43:41 -0400,
> Charles Eidsness wrote:
> 
>>I've been trying to write an ALSA driver for the AC97 port on an
>>embedded AMD au1000 MIPS processor but am having some difficulties. The
>>processor's DMA controller has two buffers which automatically toggle
>>back and forth once the buffer is full. My problem is that when I
>>playback a wave file (just using cat xxx > /dev/dsp) it sounds choppy if
>>I run the spin_unlock_irqrestore on every interrupt, it's only playing
>>back half the data. But if I run the spin_unlock_irqrestore function on
>>every-other interrupt and have only two periods it sounds fine. I'm
>>guessing I'm handling the streaming interface with the ALSA API incorrectly.
> 
> 
> just taking a quick look, at least i found that the pointer callback
> returns the wrong value. 
> 
> static snd_pcm_uframes_t
> snd_au1000_pointer(snd_pcm_substream_t * substream)
> {
>      audio_stream_t *stream = substream->private_data;
>      snd_pcm_runtime_t *runtime = substream->runtime;
>      unsigned long location, flags;
>      spin_lock_irqsave(&stream->dma_lock, flags);
>      location = get_dma_residue(stream->dma);
>      spin_unlock_irqrestore(&stream->dma_lock, flags);
>      location = stream->dma_size - location;
>      return bytes_to_frames(runtime,location);
> }
> 
> this returns the point in the current period.  the pointer callback
> must return the current position in the whole DMA buffer.
> 
> thus, you'll need to track the current DMA position (remembering
> e.g. stream->cur_period), and increment it in interrupt. 
> Then adds this offset in the above pointer callback.
> 
> 
> Takashi
> 



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
