From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: "Unexpected hw_pointer value - wrong interrupt
Date: Thu, 15 Jul 2004 12:41:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040715124123.pochini@shiny.it>
References: <1089744973.20381.53.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1089744973.20381.53.camel@mindpipe>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 13-Jul-2004 Lee Revell wrote:

>> > Jul 12 17:31:43 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:199:
>> > Unexpected hw_pointer value [1] (stream = 0, delta: -16, max jitter = 32): wrong interrupt acknowledge?
>>
>> The message appears when an unexpected DMA pointer is read in the
>> interrupt handler.  Either the handling of irq was delayed more than
>> the buffer size, an irq is issued at the wrong timing, or the DMA
>> pointer reigster is somehow screwed up.
>>
>> Since you're using quite small buffer, I guess the former case.
>>
>
> I thought this was what an XRUN was, when the handling of the irq is
> delayed more than the buffer size.  Sometimes these messages are
> associated with XRUNs, sometimes not.
>
> Is this a kernel issue, ALSA midlevel issue, or driver issue?

It is associated with an xrun when it is the cause of the xrun,
most likely, and it happens more frequently if you're using a
short buffer formed by two periods only.

A lot of things can cause it. The most common are: Some code path
in the kernel keeps interrupts disabled too long or the hardware
does not send the IRQ quickly enough or the dma counter is not up
to date when the driver reads it.

For example my driver had that problem until I figured out that
the IRQ is delivered only at addresses aligned to the lenght of
32 frames. I fixed it placing a _constaint_step() on the period
size and on the buffer size.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
