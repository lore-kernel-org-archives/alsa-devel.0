From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Wed, 01 Mar 2006 15:31:10 -0500
Message-ID: <1141245071.5860.216.camel@mindpipe>
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
	 <1141244449.9233.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 7409E1C5
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 21:31:13 +0100 (MET)
In-Reply-To: <1141244449.9233.24.camel@localhost.localdomain>
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

On Wed, 2006-03-01 at 20:20 +0000, Adrian McMenamin wrote:
> On Wed, 2006-03-01 at 14:59 -0500, Lee Revell wrote:
> 
> > 
> > The trigger callback is only called when the PCM is stopped, started, or
> > paused.
> > 
> 
> 
> Which buffer?

The way most soundcards work is that there is a single ring buffer
shared by the software and hardware.  Once the PCM is started the
hardware will repeatedly loop over this buffer playing the samples in
it.  The buffer is normally divided in half - while your app is writing
to one half of the buffer the hardware is playing the samples in the
other half.  The hardware generates interrupts at the middle and end of
this buffer, which is where we switch - the hardware is now playing what
the software just wrote to the one half of the buffer and the software
can write into the other half that was just played by the hardware.

If your soundcard does not work this way you'll have to model it
somehow.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
