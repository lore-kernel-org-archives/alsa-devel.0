From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: No snd_pcm_resume_all() ?
Date: Tue, 18 Apr 2006 12:13:41 +1000
Message-ID: <1145326421.4705.39.camel@localhost.localdomain>
References: <1145321918.4705.4.camel@localhost.localdomain>
	 <1145323208.16138.119.camel@mindpipe>
	 <1145323654.4705.31.camel@localhost.localdomain>
	 <1145324168.16138.126.camel@mindpipe> <1145324740.16138.129.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 543BF171
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 04:13:46 +0200 (MEST)
In-Reply-To: <1145324740.16138.129.camel@mindpipe>
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

On Mon, 2006-04-17 at 21:45 -0400, Lee Revell wrote:
> On Mon, 2006-04-17 at 21:36 -0400, Lee Revell wrote:
> > Are any of these native ALSA apps, or do they all go through artsd
> > which
> > uses the OSS emulation layer?
> > 
> > Does it work OK with aplay?
> > 
> 
> Argh, actually it looks like aplay doesn't even handle this (and I was
> wrong - apps do have to know about suspend they just don't have to do
> anything special to handle it).
> 
> I don't know why snd_pcm_resume_all() can't be added.

Ok, well, you have the patch, here's a signed-off for it too: :)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
