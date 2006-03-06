From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: kernel threads etc
Date: Mon, 06 Mar 2006 18:48:10 -0500
Message-ID: <1141688891.25487.91.camel@mindpipe>
References: <1141684061.9230.15.camel@localhost.localdomain>
	 <1141686718.25487.76.camel@mindpipe>
	 <1141687750.9230.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 5382119E
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 00:48:13 +0100 (MET)
In-Reply-To: <1141687750.9230.24.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: linux-sh <linuxsh-dev@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-03-06 at 23:29 +0000, Adrian McMenamin wrote:
> On Mon, 2006-03-06 at 18:11 -0500, Lee Revell wrote:
> > On Mon, 2006-03-06 at 22:27 +0000, Adrian McMenamin wrote:
> > > I have an interrupt handler in my sound driver that calls this:
> > 
> > You never explained why you want to create a kernel thread rather than
> > implementing copy/silence callbacks like the docs say.
> > 
> > Lee
> 
> Because what the documents actually say is: "Some chips have their own
> hardware buffers and the DMA transfer from the host memory is not
> available."
> 
> Well, DMA is very much available. Though I can see that: "Another case
> is that the chip uses a PCI memory-map region for the buffer" could be
> similar.
> 

Sorry, I guess I'm still not getting it.

You say things like this:

"I admit that my dma code as it is today won't work properly - the dma
transfer function tries to fill the whole of the ring buffer everytime
it is called. But it is only being called once - which is the real
problem! I can fix the dma issue I am sure, but it is not the blockage
at the moment.

When the pointer callback returned incorrect values the dma function did
get called more than once and the sample was all tranferred, if in a
useless way. But now it sends the correct value (and I've tested it as
such)such) it doesn't and the playback is stuck in an endless loop
merely playing the first part of the sample."

What exactly is this "DMA function" doing?  If you have to write a
function to transfer the samples from host memory to the device - how is
that DMA?

When I think of soundcard DMA I mean that you tell the card where in
host memory the buffer is, then to start the DMA, and from then on,
until you stop it, the device will automatically write audio into that
area of host memory until you tell it to stop.

Lee




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
