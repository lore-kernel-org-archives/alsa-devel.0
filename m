From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: your mail
Date: Sun, 21 Jul 2002 10:28:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207211024590.755-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0207201136590.8230-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA25291
	for <alsa-devel@alsa-project.org>; Sun, 21 Jul 2002 10:28:36 +0200
In-Reply-To: <Pine.LNX.4.44.0207201136590.8230-100000@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Takashi Iwai <tiwai@suse.de>, Gary Scavone <gary@ccrma.Stanford.EDU>, Paul Davis <pbd@op.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 20 Jul 2002, Fernando Pablo Lopez-Lezcano wrote:

> > > > on a related note, although the above suggestion will fix this
> > > > particular problem, it seems that it might be wise to consider adding
> > > > a parameter order information field to the driver API, so that drivers
> > > > can say "you have to set param P first, then param N, then param
> > > > O". the default would obviously be "don't care", but for devices that
> > > > lose certain capabilities when certain parameters are set, it would
> > > > make things very much easier.
> > > 
> > > agreed that it's good to have such one.
> > > but how to implement this?
> > > from the design of hw_constraint, i don't think it's so easy...
> > 
> > I think that this implementation will create a big mess for the 
> > application developers. Also, I'm not sure, if it's really needed, because 
> > our refining code should already reduce the available configurations. 
> > Applications should use *_near() functions in order of their priority. You 
> > can't predict, if rate or count of channels or any other parameter is more 
> > important for a specific application.
> 
> [not exactly an answer but more details on what is actually happening]
> 
> I think this is what is happening with the current driver (Gary, please
> correct me if I'm wrong):  The application looks at the configuration
> space and selects from it one particular sampling rate. Then it looks at
> the channel count and sees a range of channel counts (10:18 - or some
> numbers like that, I don't remember). The application chooses the minimum
> channel count and the set function fails.
> 
> IMHO at that point the configuration space should have changed the number
> of channels available to match the sampling rate selected so that the
> channel count as advertised is legal (ie: if the selected sampling rate is
> one of the "single speed" rates then the range of channels should be
> 18:18, if the sampling rate is one of the "double speed" rates then the
> range should be 10:10).
> 
> The reverse is also true, if the application first selects number of 
> channels the sampling rates should be constrained to the set of rates that 
> can be supported by that number of channels. 

You've described exactly the behaviour which should be implemented in your
paragraphs. If the current implementation is broken, then we should fix
it.

> If it is not possible to do this with the current api, then the next best
> solution I can imagine is to have a switch that changes the mode of the
> card between single and double speed (that would make the dependency
> between sample rate and number of channels dissapear).

You may look to snd_rme9652_hw_rule_channels(), 
snd_rme9652_hw_rule_channels_rate() and 
snd_rme9652_hw_rule_rate_channels() functions in rme9652.c.

These functions exactly describes the contraints for rate/channels.

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
