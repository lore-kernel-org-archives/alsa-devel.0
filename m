From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: buffers, periods, cycles.. oh my!
Date: Sun, 29 Aug 2004 12:48:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408291648.i7TGmvjM015281@localhost.localdomain>
References: <41311E7B.4020608@davyandbeth.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 28 Aug 2004 19:08:27 CDT."
             <41311E7B.4020608@davyandbeth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Davy Durham <pubaddr@davyandbeth.com>
Cc: alsa-devel@lists.sourceforge.net, mjander@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Ok, so periods are different than buffers.
>
>I can set the period size and the number of periods.   And then separate 
>from that seems to be setting a buffer size/time.
>
>A sound card has to read/write to some area of memory for data 
>transfer.  What's a buffer and what's a period?

just about every single contemporary audio interface defines a
"hardware buffer". this consists of memory owned either by the audio
interface or the host; in either case, the audio interface can
read/write the memory directly (although there are a few devices that
always require assistance from the host CPU to move data to/from this
memory).

there will be 1 hardware buffer for each direction (playback or
capture); depending on the audio interface architecture, there may be
1 buffer per direction per channel (non-interleaved mode) or 1 buffer
per direction for all channels (interleaved mode).

the hardware buffer has a maximum size, and a size currently in
use. so for example, a specific piece of hardware may be able to use a
buffer up to 64kB, but given the current settings, uses only 4kB. read
on to see why.

whatever the effective buffer size is, the hardware will use that
space as a circular buffer, read and writing data to the buffer and
wrapping around whenever it reaches the end.

obviously, the hardware keeps its own record of where in the buffer(s)
it is reading and/or writing data. at various positions within the
buffer, the hardware will generate an interrupt to tell the CPU that
data and/or space is available. the obvious location for such
interrupts is at the wrap around point.

however, this is not necessarily the most useful configuration, and
most audio interfaces can be told to generate an interrupt at other
intervals as the hardware moves through the buffer. this subdivides
the hardware buffer into a series of "periods", punctuated by an
interrupt:


   |-------------- maximum possible buffer size --------------------|
   |----------- current buffer size -----------|
   |           |                |              |
   intr       intr              intr           intr

(note that the "intr" at the start/end of the buffer are equivalent to
each other - its really an interrupt at the wrap point)

so, in the above diagram, the hardware buffer is divided into 3
periods; as the hardware "pointer" crosses each divide, the CPU is
interrupted, and the CPU can read/write data into the buffer
before/after the hardware pointer, as appropriate.

in the above example, the interrupts are evenly spaced, typically
using a power-of-2 number of audio samples, and thus the total buffer
size is nperiods * period size. the general relationship is:

     buffer_size = nperiods * period_size;

with all the permutations that suggests.

you can measure the sizes of buffers and periods in samples, bytes or
units of time. the conversion factors between them depends on the
sample bit width and the sample rate.

--p


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
