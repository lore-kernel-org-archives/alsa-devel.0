From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: writing an alsa driver for an MPEG decoder chip
Date: Sun, 28 Aug 2005 23:51:49 +0100
Message-ID: <43124005.4030709@superbug.co.uk>
References: <20050828144637.GA4452@home> <431233D5.4020502@superbug.co.uk> <20050828223555.GA16031@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050828223555.GA16031@home>
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
> Hi,
> 
> On Sun, Aug 28, 2005 at 10:59:49PM +0100, James Courtier-Dutton wrote:
> 
>>I looked at the code. The period and buffer size selection looks a bit 
>>wrong. Can you explain to me what the actual buffer contraints are for 
>>the em8300 card? It looks to me that the only current contraint is 
>>number of periods. This seems to me to be rather a strange contrain to have.
> 
> 
> First of all, thanks for your answer.
> Unfortunately, I have to admit that I'm not sure I have undestood what 
> periods really are.
> 
> The em8300 chip uses a small on-chip circular buffer (whose size is 
> given by the read_ucregister(MA_PCISize) call) as a FIFO. This FIFO is 
> fed with structs that contain both a pointer to some sound data in main 
> memory and size of this buffer. The structs have a size of 3, which 
> means the cicrular buffer has a size of read_ucregister(MA_PCISize)/3 
> elements.
> 
> A fifo engine takes all elements in the fifo in order. For each element, 
> the DMA engine gets the sound data from main memory, and the sound is 
> played. Sometimes, the chip raises an interruption when the DMA engine 
> as finished reading a buffer. (That's generally once every two buffers, 
> but it happens that 2 consecutive buffers both lead to an interruption. 
> I never understood how that works...)
> 
> Hence, I thought I should set up read_ucregister(MA_PCISize)/3 static 
> buffers of random (well, <65536 bytes) size, and let each buffer 
> correspond to 1 period.
> 
> Do you think this is broken and this could explain why most applications 
> fail to get any sound, while xmms succeeds?
> 
> 
> Thanks for your help,
> 
> Nicolas Boullis
> 

Your FIFO looks to me to be a scatter gather array with each entry 
pointing to a buffer in memory.
You say that it is circular, which sort of contradicts the FIFO name for 
it, so which is it, A FIFO or a circular buffer?

ALSA has the following terms, periods and frames.
A frame equivalent to having one sample for every channel. E.g. stereo 
16bit PCM would have a frame size of 4 bytes, but a 5.1 16bit PCM would 
have a frame size of 12 bytes.

A period is the time between interrupts for the sound card, and this 
normally is closely linked to a fixed number of frames per period.

Now, I will explain what periods are.
One period in alsa is the amount of sound samples

A buffer is simply the total of period_size * periods.

How is the 3 byte FIFO struction layed out? 2 bytes offset, 1 byte size?

James


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
