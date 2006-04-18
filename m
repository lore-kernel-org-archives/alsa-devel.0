From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: No snd_pcm_resume_all() ?
Date: Tue, 18 Apr 2006 21:27:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0604182117441.9432@tm8103.perex-int.cz>
References: <1145321918.4705.4.camel@localhost.localdomain> <s5hd5ffxc1r.wl%tiwai@suse.de>
 <1145382922.4116.81.camel@localhost> <s5hodyyvjxr.wl%tiwai@suse.de>
 <1145383590.4116.83.camel@localhost> <s5hmzeivjom.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4C225183
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 21:27:46 +0200 (MEST)
In-Reply-To: <s5hmzeivjom.wl%tiwai@suse.de>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Apr 2006, Takashi Iwai wrote:

> At Tue, 18 Apr 2006 20:06:30 +0200,
> Johannes Berg wrote:
> > 
> > On Tue, 2006-04-18 at 20:05 +0200, Takashi Iwai wrote:
> > 
> > > We cannot freeze the running user process at the very same moment the
> > > driver's suspend callback is called...
> > 
> > Yeah but we can freeze the pcm before the app, so for the app it's just
> > as though there was a small pause/hiccup/whatever
> 
> That's the point.  The resume is handled just like another type of
> xrun, which requires a recover.  So, the app needs to know what is
> going on.

Also note that resume() is not supported with all hardware. Some hardware 
requires full prepare() / write() cycles and in this case only application 
can hadle this situation correctly. Also, some real-time applications 
might use this information for the time-dependent recovery (in some 
situations the resume has no sense).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
