From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Wed, 01 Mar 2006 15:41:39 -0500
Message-ID: <1141245699.5860.224.camel@mindpipe>
References: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
	 <20060227172601.GA446@turing.informatik.uni-halle.de>
	 <40613.217.150.108.178.1141061722.squirrel@newgolddream.dyndns.info>
	 <20060228073049.GA4158@turing.informatik.uni-halle.de>
	 <35384.217.150.108.178.1141117853.squirrel@newgolddream.dyndns.info>
	 <20060228145541.GA20876@turing.informatik.uni-halle.de>
	 <47411.217.150.108.178.1141139656.squirrel@newgolddream.dyndns.info>
	 <20060228170824.GA24675@turing.informatik.uni-halle.de>
	 <61111.217.150.108.178.1141148175.squirrel@newgolddream.dyndns.info>
	 <1141240231.9233.11.camel@localhost.localdomain>
	 <1141241474.5860.183.camel@mindpipe>
	 <1141242058.9233.17.camel@localhost.localdomain>
	 <1141243152.5860.197.camel@mindpipe>
	 <1141244926.9233.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 49DEB1C5
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 21:41:42 +0100 (MET)
In-Reply-To: <1141244926.9233.32.camel@localhost.localdomain>
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

On Wed, 2006-03-01 at 20:28 +0000, Adrian McMenamin wrote:
> On Wed, 2006-03-01 at 14:59 -0500, Lee Revell wrote:
> > On Wed, 2006-03-01 at 19:40 +0000, Adrian McMenamin wrote:
> > > On Wed, 2006-03-01 at 14:31 -0500, Lee Revell wrote:
> > > 
> > > > > What happens next?
> > > > 
> > > > The app(s) waiting to output audio (sleeping in poll() or write()) will
> > > > be woken up and based on the value returned by the pointer callback
> > > > above, informed that there is space in the buffer and how much space
> > > > there is, and will then write the next chunk of frames, and go back to
> > > > sleep.  Then we go back to "Hardware triggers interrupt" above and the
> > > > process repeats.
> > > 
> > > But something in the alsa subsystem determines whether there is any
> > > space before waking the app, yes?
> > > 
> > 
> > Yes - the value returned by your pointer callback minus the last value
> > returned by your pointer callback determines how much space is left.  So
> > if the app is waiting to write 512 frames, the pointer was 256 at the
> > last interrupt, and the current pointer is 512, the app will not wake up
> > until the next interrupt because only 256 frames can be written.
> > 
> 
> Presumably this is on the assumption that 512 frames is a period?

In this example the period (# of frames between interrupts) is 256.  So
if the app is waiting to write 512 frames (by setting the avail_min
software parameter) it will be woken up every other interrupt.  (This
example only makes sense if there are more than 2 periods per buffer,
otherwise the app is constantly overwriting the data that the hardware
is playing).

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
