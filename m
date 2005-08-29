From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: writing an alsa driver for an MPEG decoder chip
Date: Mon, 29 Aug 2005 01:04:18 +0100
Message-ID: <43125102.5020101@superbug.co.uk>
References: <20050828144637.GA4452@home> <431233D5.4020502@superbug.co.uk> <20050828223555.GA16031@home> <43124005.4030709@superbug.co.uk> <20050828233639.GB16031@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050828233639.GB16031@home>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicolas Boullis <nboullis@debian.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nicolas Boullis wrote:
> After sending my previous message, I figured out that with a smaller 
> period_bytes_max, I can play some sound with xine. It looks like you got 
> a point. Thanks! :-)
> 
> Anyway, explanations and suggestions for improvement are still very 
> welcome... ;-)

Well, get it working first, then improve it. For example, all the 
"magic" stuff is unneeded now.

> 
> On Sun, Aug 28, 2005 at 11:51:49PM +0100, James Courtier-Dutton wrote:
> 
>>Your FIFO looks to me to be a scatter gather array with each entry 
>>pointing to a buffer in memory.
> 
> 
> You're perfectly right. Is there a better way to handle scatter-gather 
> arrays within the ALSA framework?

The Linux kernel has it's own scatter gather framework, but I can't 
remember off hand how best to use it.

> 
> 
> 
>>You say that it is circular, which sort of contradicts the FIFO name for 
>>it, so which is it, A FIFO or a circular buffer?
> 
> 
> It is a FIFO implemented in a circular buffer: there is this circular 
> buffer and two pointers that point to the head and tail of the FIFO 
> within this buffer (look for MA_PCIRdPtr and MA_PCIWrPtr in my code).
>

Is the number of entries in the scatter-gather list a fixed size? If so, 
how big is it? If the number of entries in the scatter-gather list can 
be varied each time you open the device, then set the "periods_min/max 
to the range of values it can take. Most sound cards generally do 
between 2 and 8 periods.

> 
> 
>>ALSA has the following terms, periods and frames.
>>A frame equivalent to having one sample for every channel. E.g. stereo 
>>16bit PCM would have a frame size of 4 bytes, but a 5.1 16bit PCM would 
>>have a frame size of 12 bytes.
> 
> 
> And the em8300 chip only handles 2-channel 16-bit big-endian streams, 
> which means 4 bytes per sample.
> 
> 
> 
>>A period is the time between interrupts for the sound card, and this 
>>normally is closely linked to a fixed number of frames per period.
>>
>>Now, I will explain what periods are.
>>One period in alsa is the amount of sound samples
> 
> 
> between 2 interrupts?

Yes.

> 
> 
> 
>>A buffer is simply the total of period_size * periods.
>>
>>How is the 3 byte FIFO struction layed out? 2 bytes offset, 1 byte size?
> 
> 
> Almost: these are 2-byte words rather than bytes. Hence, there is:
>    - 1 2-byte word for the upper 16 bits of physical address to data 
>      block
>    - 1 2-byte word for the lower 16 bits of physical address to data 
>      block
>    - 1 2-byte word for the size (in bytes) of the data block
> 

You would generally pre allocate all the DMA memory use for sound in the
snd_em8300_create() function.

One would then fill the scatter-gather list with pointers to the DMA 
memory in the snd_em8300_pcm_prepare() function.

One would also try to do the fewest number of read/write to IO memory in 
the em8300_alsa_audio_interrupt() function. I.e. remove the 
read_ucregister(MA_PCISize) calls etc, and cache their values in the 
em8300_alsa_t structure.
You might want to write to the MA_PCISize register if you want the 
application to be able to select a different number of periods. It would 
be set in the prepare() function.


> 
> Thanks for your help,
> 
> Nicolas Boullis
> 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
