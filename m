From: Davy Durham <pubaddr@davyandbeth.com>
Subject: Re: buffers, periods, cycles.. oh my!
Date: Mon, 30 Aug 2004 16:53:48 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4133A1EC.8000501@davyandbeth.com>
References: <200408291648.i7TGmvjM015281@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408291648.i7TGmvjM015281@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org

Ok, thanks guys.  [Paul and Manuel]  This pretty much clears it up.  I 
knew most of that.  I was one of the few that paid out the butt and got 
the sound blaster development kit WAY back when, and I got to have all 
the fun of programming DMA and directly handling interrupts in DOS. [I 
even discovered that I could do full-duplex on the SB16 as long as the 
recording was 8bit and playback 16bit, or vice-versa.. because the bits 
on the interrupt flags made the reason for the interrupt 
distinguishable.. that was one happy late middle of the night when it 
actually worked and my voice ECHOED echoed echhoed ... :)  ]

The key here to my understanding was that a period is a part of the 
larger buffer construct.  I was thinking that, but nothing in the docs 
indicated it for sure.

For my needs (I'm developing a native ALSA implementation for ReZound), 
I want a small playback buffer time.  I want the GUI's play position to 
closely corrispond to the audio being heard. 

But I want a large capture buffer time when doing recording because I'm 
streaming the data directly to disk thru my own file I/O layer [which 
maps a linear logical space into a fragmented physical space].

Manuel's explanation sounded as if buffer times are very dependant on 
hardware specifics.  Just to get Paul's take.. Does it depend on the 
hardware as to what I can set the buffer time for recording?  Is this 
buffering layer not something that ALSA is implementing where buffers of 
whatever size are being handled by software.  Now, periods on the other 
hand (I would guess) probably are hardware specific because they relate 
directly to interrupt triggers caused by the hardware.  Am I probably 
safest going with a power of 2 for a period size, and safest going with 
an integral multiple of the period size for the buffer size?

I've got playback pretty much how I want it.  But for my capture code, I 
would prefer to have maybe a second or so of buffer time if it becomes 
necessary [streaming to disk and all].  I'm willing to go with the 
nearest power of 2 if necessary of course.  Is this possible given any 
hardware, or will I need to buffer captured data myself to be on the 
safe side?

Thanks again,
  Davy



Paul Davis wrote:

>>Ok, so periods are different than buffers.
>>
>>I can set the period size and the number of periods.   And then separate 
>>    
>>
>>from that seems to be setting a buffer size/time.
>  
>
>>A sound card has to read/write to some area of memory for data 
>>transfer.  What's a buffer and what's a period?
>>    
>>
>
>just about every single contemporary audio interface defines a
>"hardware buffer". this consists of memory owned either by the audio
>interface or the host; in either case, the audio interface can
>read/write the memory directly (although there are a few devices that
>always require assistance from the host CPU to move data to/from this
>memory).
>
>there will be 1 hardware buffer for each direction (playback or
>capture); depending on the audio interface architecture, there may be
>1 buffer per direction per channel (non-interleaved mode) or 1 buffer
>per direction for all channels (interleaved mode).
>
>the hardware buffer has a maximum size, and a size currently in
>use. so for example, a specific piece of hardware may be able to use a
>buffer up to 64kB, but given the current settings, uses only 4kB. read
>on to see why.
>
>whatever the effective buffer size is, the hardware will use that
>space as a circular buffer, read and writing data to the buffer and
>wrapping around whenever it reaches the end.
>
>obviously, the hardware keeps its own record of where in the buffer(s)
>it is reading and/or writing data. at various positions within the
>buffer, the hardware will generate an interrupt to tell the CPU that
>data and/or space is available. the obvious location for such
>interrupts is at the wrap around point.
>
>however, this is not necessarily the most useful configuration, and
>most audio interfaces can be told to generate an interrupt at other
>intervals as the hardware moves through the buffer. this subdivides
>the hardware buffer into a series of "periods", punctuated by an
>interrupt:
>
>
>   |-------------- maximum possible buffer size --------------------|
>   |----------- current buffer size -----------|
>   |           |                |              |
>   intr       intr              intr           intr
>
>(note that the "intr" at the start/end of the buffer are equivalent to
>each other - its really an interrupt at the wrap point)
>
>so, in the above diagram, the hardware buffer is divided into 3
>periods; as the hardware "pointer" crosses each divide, the CPU is
>interrupted, and the CPU can read/write data into the buffer
>before/after the hardware pointer, as appropriate.
>
>in the above example, the interrupts are evenly spaced, typically
>using a power-of-2 number of audio samples, and thus the total buffer
>size is nperiods * period size. the general relationship is:
>
>     buffer_size = nperiods * period_size;
>
>with all the permutations that suggests.
>
>you can measure the sizes of buffers and periods in samples, bytes or
>units of time. the conversion factors between them depends on the
>sample bit width and the sample rate.
>
>--p
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
