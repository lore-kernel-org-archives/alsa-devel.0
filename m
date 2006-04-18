From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: No snd_pcm_resume_all() ?
Date: Tue, 18 Apr 2006 12:12:47 +1000
Message-ID: <1145326367.4705.37.camel@localhost.localdomain>
References: <1145321918.4705.4.camel@localhost.localdomain>
	 <1145323208.16138.119.camel@mindpipe>
	 <1145323654.4705.31.camel@localhost.localdomain>
	 <1145324168.16138.126.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 12426171
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 04:12:51 +0200 (MEST)
In-Reply-To: <1145324168.16138.126.camel@mindpipe>
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

On Mon, 2006-04-17 at 21:36 -0400, Lee Revell wrote:
> On Tue, 2006-04-18 at 11:27 +1000, Benjamin Herrenschmidt wrote:
> > How are apps supposed to know about system suspend/resume ? There is
> > no proper way to do so that works accross architectures and
> > suspend/resume methods so far ... I yet have to see a single audio app
> > that knows about it ... (tried various KDE based things like Amarok,
> > mpg123, xine, ... ) 
> 
> They don't specifically have to know about suspend and resume - from the
> application point of view it just looks like an underrun - poll() or
> write() will return an error code so the app checks the state with
> snd_pcm_state() and recovers if it is SND_PCM_STATE_XRUN or
> SND_PCM_STATE_SUSPENDED.
> 
> Are any of these native ALSA apps, or do they all go through artsd which
> uses the OSS emulation layer?
> 
> Does it work OK with aplay?

I'm not sure what they use at this point, I'll check later. I think I
didn't enabled artsd and amarok is using xine engine so it's probably
using alsa directly though.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
