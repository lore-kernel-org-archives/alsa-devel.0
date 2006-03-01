From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Wed, 01 Mar 2006 19:40:58 +0000
Message-ID: <1141242058.9233.17.camel@localhost.localdomain>
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
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id D47EE1B9
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 20:41:00 +0100 (MET)
In-Reply-To: <1141241474.5860.183.camel@mindpipe>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-01 at 14:31 -0500, Lee Revell wrote:

> > What happens next?
> 
> The app(s) waiting to output audio (sleeping in poll() or write()) will
> be woken up and based on the value returned by the pointer callback
> above, informed that there is space in the buffer and how much space
> there is, and will then write the next chunk of frames, and go back to
> sleep.  Then we go back to "Hardware triggers interrupt" above and the
> process repeats.

But something in the alsa subsystem determines whether there is any
space before waking the app, yes?

and when the app is woken alsa calls the trigger callback?



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
