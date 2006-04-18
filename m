From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: No snd_pcm_resume_all() ?
Date: Tue, 18 Apr 2006 11:27:34 +1000
Message-ID: <1145323654.4705.31.camel@localhost.localdomain>
References: <1145321918.4705.4.camel@localhost.localdomain>
	 <1145323208.16138.119.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A8E8D1A9
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 03:27:38 +0200 (MEST)
In-Reply-To: <1145323208.16138.119.camel@mindpipe>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-04-17 at 21:20 -0400, Lee Revell wrote:
> On Tue, 2006-04-18 at 10:58 +1000, Benjamin Herrenschmidt wrote:
> > It appears that Alsa expects the streams to be resumed via some
> > userland
> > initiated ioctl, which for some reason is never called on my machine.
> > What is the rationale there ? it's userland that is expected to
> > save/restore hardware state ? That doesn't really match the linux PM
> > model at this point and it seems that Alsa userland isn't notified of
> > suspend/resume at least on powermacs. 
> 
> The app is expected to handle this by resetting the stream, the same way
> you would handle an xrun.
> 
> What sound app(s) are you testing with?

How are apps supposed to know about system suspend/resume ? There is no
proper way to do so that works accross architectures and suspend/resume
methods so far ... I yet have to see a single audio app that knows about
it ... (tried various KDE based things like Amarok, mpg123, xine, ... )

Is there any reason why the driver couldn't resume the playback itself ?
That is, is there any reason why the patch I proposed couldn't go in for
drivers to resume automatically ?

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
