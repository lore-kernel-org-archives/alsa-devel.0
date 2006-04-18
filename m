From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: No snd_pcm_resume_all() ?
Date: Mon, 17 Apr 2006 21:20:07 -0400
Message-ID: <1145323208.16138.119.camel@mindpipe>
References: <1145321918.4705.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 63A8C157
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 03:20:20 +0200 (MEST)
In-Reply-To: <1145321918.4705.4.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-04-18 at 10:58 +1000, Benjamin Herrenschmidt wrote:
> It appears that Alsa expects the streams to be resumed via some
> userland
> initiated ioctl, which for some reason is never called on my machine.
> What is the rationale there ? it's userland that is expected to
> save/restore hardware state ? That doesn't really match the linux PM
> model at this point and it seems that Alsa userland isn't notified of
> suspend/resume at least on powermacs. 

The app is expected to handle this by resetting the stream, the same way
you would handle an xrun.

What sound app(s) are you testing with?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
