From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: No snd_pcm_resume_all() ?
Date: Wed, 19 Apr 2006 06:59:22 +1000
Message-ID: <1145393964.4705.76.camel@localhost.localdomain>
References: <1145321918.4705.4.camel@localhost.localdomain>
	 <s5hd5ffxc1r.wl%tiwai@suse.de> <1145382922.4116.81.camel@localhost>
	 <s5hodyyvjxr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 25FF5183
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 22:59:29 +0200 (MEST)
In-Reply-To: <s5hodyyvjxr.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-04-18 at 20:05 +0200, Takashi Iwai wrote:
> At Tue, 18 Apr 2006 19:55:22 +0200,
> Johannes Berg wrote:
> > 
> > On Tue, 2006-04-18 at 15:12 +0200, Takashi Iwai wrote:
> > 
> > > Indeed, the pcm resume was designed to be called from application to
> > > restart.  The flow is like below:
> > 
> > Why does the app even need to know?!
> 
> We cannot freeze the running user process at the very same moment the
> driver's suspend callback is called...

On ppc, I don't freeze processes at all... though from my experience,
just doing the suspend at sleep and the resume on wakeup from the driver
without freezing the app just works... the samples just stop getting
pumped for a little while. 

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
