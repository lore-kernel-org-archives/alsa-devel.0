From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: buffers, periods, cycles.. oh my!
Date: Sun, 29 Aug 2004 12:50:32 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1093798231.2100.47.camel@localhost>
References: <41301C40.10609@davyandbeth.com>
	 <1093718182.2150.26.camel@localhost>  <41311E7B.4020608@davyandbeth.com>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41311E7B.4020608@davyandbeth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Davy Durham <pubaddr@davyandbeth.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, 2004-08-28 at 20:08, Davy Durham wrote:
> I just wish this stuff was documented somewhere...
> 
> Ok, so periods are different than buffers.

Yes. With buffer in ALSA semantic, its the entire memory area where
audio data is being buffered for DMA a transfer. A period is a subbuffer
(a smaller chunk) inside of this buffer. 
Why use subdivisions of the buffer (why use periods) ?
- As soon as a DMA transfer has been started, we can't touch the buffer
anymore. Using periods for various smaller DMA transfer, we know which
portion of the buffer is the one that can't be touched, so we can still
work on the others for processing, data copy, application interaction
etc.
- A single DMA transfer can't be any longer than 4KiB (i386), due to
nonlinear physical to logical memory address mappings. Using periods,
the entire buffer can be larger than 4KiB, by concatenating many
periods. We need to program each DMA tranfer for each period, thought.
- Setting up a DMA transaction on a soundcard takes some time, so if we
use one single chunk for DMA, while we are programming a new DMA
transfer, we would get a underrun. Even if the card has a fifo, it won't
last long enough. If we use several subbuffers, DMA transfer can be
programmed ahead of time, while another DMA transfer is still running.

Some remarks:
- Depending on the hardware capabilities of a particular soundcard:
buffer size == period count * period size
is NOT necessarily true. Because not all periods are necessarily the
same size. Usually the last one will be the odd sized period to fit into
the buffer. Many soundcards need this relation to be true, and ALSA
ensures that such restrictions are met.
The following expresion would be correct in any case:
buffer_size == sum(period_size[i], 1, period_count)

Just as a comment, some soundcards emulate more periods than they really
support in hardware. This needs a little bit more computations at the
interrupt handler, but it still allows the usage of bigger buffers. 

> I can set the period size and the number of periods.   And then separate 
> from that seems to be setting a buffer size/time.

ALSA provides different ways for selecting a specific period
count/period size/buffer size combination. They depend on each other.
If you really only care about how much time the buffer lasts (max time
you have to deliver new data), then just use a time based buffer setup.
In that case, you probably don care about how many periods and their
size.
You have to take into account that:
- The applicaction asks for some parameters. Unspecified parameters are
choosen by ALSA.
- The soundcard imposes some restrictions. These can be simple size
restriction, upto very complex ones (only allowing certain set of
values).
- The ALSA lib has to find an intersection between the app requirements
and the soundcard. If it does not find it, well, maybe Takashi or
Jaroslav can explain better than I what happens :). Somehow ALSA deals
with that, not necesarily in a successful manner.

>From that facts, i would say that giving some playroom to ALSA for
parameter choice, is desirable, so a parameter set that meets the
hardware restrictions can be easily found. If the application needs more
tighter control about buffer setup, then it should take care about what
parameters are actually being used afterwards.

> A sound card has to read/write to some area of memory for data 
> transfer.  What's a buffer and what's a period?

A period is a piece of the buffer. For each PCM device you have only one
buffer, divided into periods.

Hope that helps. 

Best Regards

Manuel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
