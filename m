From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Fri, 03 Mar 2006 03:18:36 -0500
Message-ID: <1141373916.3042.87.camel@mindpipe>
References: <47411.217.150.108.178.1141139656.squirrel@newgolddream.dyndns.info>
	 <20060228170824.GA24675@turing.informatik.uni-halle.de>
	 <61111.217.150.108.178.1141148175.squirrel@newgolddream.dyndns.info>
	 <1141240231.9233.11.camel@localhost.localdomain>
	 <1141241474.5860.183.camel@mindpipe>
	 <1141242058.9233.17.camel@localhost.localdomain>
	 <1141243152.5860.197.camel@mindpipe>
	 <1141244926.9233.32.camel@localhost.localdomain>
	 <1141245699.5860.224.camel@mindpipe>
	 <1141332564.9233.6.camel@localhost.localdomain>
	 <20060303072743.GB8569@turing.informatik.uni-halle.de>
	 <1141371753.9229.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id AD277187
	for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2006 09:18:38 +0100 (MET)
In-Reply-To: <1141371753.9229.0.camel@localhost.localdomain>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-03-03 at 07:42 +0000, Adrian McMenamin wrote:
> On Fri, 2006-03-03 at 08:27 +0100, Clemens Ladisch wrote:
> > Adrian McMenamin wrote:
> > > I think I have a good idea why my it is not working now - the DMA
> > > routine which transfers sound samples from the main CPU memory to the
> > > ring buffer of the hardware (which is effectively in a different memory
> > > space) is in a kernel thread which, in essence, never gets rescheduled -
> > > so the app thinks there is sound to be transferred but it never is -
> > > hence it gets wedged.
> > > 
> > > To fix that I need to know what the alsa subsystem calls inside the
> > > driver when it wants a DMA transfer to resume - I have to reschedule the
> > > kernel thread there.
> > 
> > ALSA doesn't call the driver.  It assumes the hardware runs by itself.
> > 
> > If your hardware doesn't issue some interrupt regularly, you have to use
> > a timer.
> > 
> It does have an interrupt - I am working on the idea of having the
> kernel thread sleep and then wake up on the interrupt
> 

Hmm, maybe the work should be done in the copy callback:

copy and silence callbacks
These callbacks are not mandatory, and can be omitted in most cases.
These callbacks are used when the hardware buffer cannot be on the
normal memory space. Some chips have their own buffer on the hardware
which is not mappable. In such a case, you have to transfer the data
manually from the memory buffer to the hardware buffer. Or, if the
buffer is non-contiguous on both physical and virtual memory spaces,
these callbacks must be defined, too. 

If these two callbacks are defined, copy and set-silence operations are
done by them. The detailed will be described in the later section Buffer
and Memory Management. 

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x639.htm#PCM-INTERFACE-OPERATORS-COPY-SILENCE

Lee






-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
