From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: pointer callback in pcm
Date: Fri, 10 Mar 2006 19:51:01 +0000
Message-ID: <1142020261.9246.3.camel@localhost.localdomain>
References: <1141942882.10937.5.camel@localhost.localdomain>
	 <1141952015.13319.90.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1141952015.13319.90.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
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

On Thu, 2006-03-09 at 19:53 -0500, Lee Revell wrote:
> On Thu, 2006-03-09 at 22:21 +0000, Adrian McMenamin wrote:
> > The documentation states:
> > 
> > "This callback is called when the PCM middle layer inquires the current
> > hardware position on the buffer."
> > 
> > 
> > Does that mean the position the hardware is at (in its ring buffer in my
> > case) or does it mean the position we are at in the dma buffer.
> > 
> > ie I have a 128k DMA buffer which transfers samples into the 32k
> > hardware memory buffer. Which position am I meant to be reporting?
> > 
> 
> The DMA buffer should be the same size as the hardware buffer, so the
> positions should be the same.
> 
> The pointer callback should return the position of sample that the
> hardware is currently playing.
> 
Thanks. I am sure I am driving you round the twist now, but that (both
buffers being the same size) was a key piece of information I was
unaware of. There are several pints in it if you are ever around in
North London :)

But my basic problem remains - my buffer is 8 periods long and I get to
hear them over and over again :( - nothing new is ever fed into the DMA
buffer and so nothing new therefore ever gets fed into the hardware
buffer.

I start the process by transferring a whole eight periods worth into the
hardware buffer is that a mistake? Should I always be feeding in one
period at a time only?



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
