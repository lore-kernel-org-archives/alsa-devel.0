From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Wed, 01 Mar 2006 14:31:14 -0500
Message-ID: <1141241474.5860.183.camel@mindpipe>
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
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E326A1B9
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 20:31:17 +0100 (MET)
In-Reply-To: <1141240231.9233.11.camel@localhost.localdomain>
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

On Wed, 2006-03-01 at 19:10 +0000, Adrian McMenamin wrote:
> On Tue, 2006-02-28 at 17:36 +0000, Adrian McMenamin wrote:
> > On Tue, 28 February, 2006 5:08 pm, Clemens Ladisch wrote:
> > 
> > >
> > > Where is the source code of your driver?
> > >
> > >
> > 
> > http://newgolddream.dyndns.info/repos
> > 
> Anybody have any comments? For my own understanding is the patten this:
> 
> Hardware triggers interrupt as period boundary passed  ---->
> 
> Interrupt handler calls ALSA middle layer  ---->
> 
> ALSA middle layer calls pointer callback --->
> 
> Pointer callback returns ring buffer position
> 
> 
> What happens next?

The app(s) waiting to output audio (sleeping in poll() or write()) will
be woken up and based on the value returned by the pointer callback
above, informed that there is space in the buffer and how much space
there is, and will then write the next chunk of frames, and go back to
sleep.  Then we go back to "Hardware triggers interrupt" above and the
process repeats.

I'm not sure why your driver is locking up the system - maybe the
pointer callback indicates that there is more space in the buffer than
there is, which might wedge the app when it goes to write the next
period of audio?  But normally this would just cause corrupted sound,
not a lockup...

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
