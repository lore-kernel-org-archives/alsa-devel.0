From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: double speed (ADAT), and hw params ordering
Date: Sat, 20 Jul 2002 08:57:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207200854490.809-100000@pnote.perex-int.cz>
References: <s5hlm88q9u1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA07338
	for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2002 08:58:08 +0200
In-Reply-To: <s5hlm88q9u1.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <pbd@op.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Jul 2002, Takashi Iwai wrote:

> At Thu, 18 Jul 2002 14:58:07 -0400,
> Paul Davis wrote:
> > 
> > i've been wondering what to do about setting sample rates in the
> > hammerfall and h-dsp drivers. fernando and gary from CCRMA have made
> > the excellent suggestion that rather than have the driver pretend that
> > all rates are available all the time, as it currently does, that we
> > have a control switch to go between regular rates and the "double
> > speed" or "bitsplit" rates (64kHz-96kHz) which reduce the channel
> > count.  i think this is an excellent idea. you would not be able to
> > use the switch while the device was open. when you opened it, you
> > would find (for example) a device with 14 channels (12 ADAT plus 2
> > SPDIF) at 64-96kHz or 26 channels (24 ADAT+2 SPDIF) at 32-48kHz.
>  
> i vote for this idea.

Paul, what's wrong to offer all possible configurations? Could you explain 
the problems?

> > if anyone objects to this model, please let me know. right now, its
> > more or less impossible to get access to the higher rates.
> > 
> > on a related note, although the above suggestion will fix this
> > particular problem, it seems that it might be wise to consider adding
> > a parameter order information field to the driver API, so that drivers
> > can say "you have to set param P first, then param N, then param
> > O". the default would obviously be "don't care", but for devices that
> > lose certain capabilities when certain parameters are set, it would
> > make things very much easier.
> 
> agreed that it's good to have such one.
> but how to implement this?
> from the design of hw_constraint, i don't think it's so easy...

I think that this implementation will create a big mess for the 
application developers. Also, I'm not sure, if it's really needed, because 
our refining code should already reduce the available configurations. 
Applications should use *_near() functions in order of their priority. You 
can't predict, if rate or count of channels or any other parameter is more 
important for a specific application.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
