From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Only one element for multichannel mixer controls
 please!
Date: Mon, 27 Oct 2008 11:12:59 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0810271102100.12044@tm8103.perex-int.cz>
References: <20081024234932.GA17812@tango.0pointer.de>
	<s5hiqrezbyr.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0810270923280.12044@tm8103.perex-int.cz>
	<s5hr662qu9n.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0810271017350.12044@tm8103.perex-int.cz>
	<s5hod16qsjn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id ED2D7246D7
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 11:12:59 +0100 (CET)
In-Reply-To: <s5hod16qsjn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Oct 2008, Takashi Iwai wrote:

> At Mon, 27 Oct 2008 10:20:48 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > On Mon, 27 Oct 2008, Takashi Iwai wrote:
> > 
> > > IMHO, a big part of the problem is its overly complex layers and
> > 
> > I agree. Some layers should be merged and simplified.
> > 
> > > old-style mixer API (in addition to complete lack of documentation).
> > 
> > I don't understand what you mean old-style API. API inside alsa-lib or 
> > smixer API for applications? If it's the second case, what you imagine as 
> > right mixer API for apps?
> 
> In my mind, mostly about the external API:
> - what if an element has 2 switches but 4 volumes?

Do we need to handle such situation? If we start to describe the exact 
routes we end in more deep hell. I would propose to leave mapping 1:1 and 
join requests for 2 switches together (with eventual value change event 
returned back to app). Eventually, we can return a volume/switch map to 
application which controls are joined.

> - are common, playback and capture exclusive?

It's just about to add one function returning this information.

> - exclusive switch is often messy; whether it's a radio button or a list,
>   it's a question of UI, not about API - a list is more appropriate

We need to add this to documentation.

> - why attach/deteach/load ops needed in addition to open/close?
> - why hctl?
> - what is mixer class and why necessary?
> - why both snd_mixer_elem and snd_mixer_selem exist?

It's exactly what I meant by simplification and merging. Anyway, all 
mentioned things are mostly cosmetic. They imply no dramatic changes for 
applications.

> But, about internal API, too:
> - the abstraction concept is nowhere documented
> - the internal API is nowhere documented
> - simple_none.c is still buggy (the common elements aren't handled
>   properly any existing mixer apps including alsamixer)
>
> > > The plugin solution doesn't work well because you are tring to graft
> > > orange and apple.
> > 
> > Please, explain.
> 
> Well, in your scenario, each driver writer is supposed to create a new
> C smixer plugin.  But, providing both is a hard work because they are
> really two different things.  In the current situation without any
> good information how and what to do, grafting two different things
> doesn't work well.
> 
> The plugin framework is pretty simple.  But, this means that you owe
> so many things (almost everything) in the plugin itself.  That's why
> no one can start on it.  At least, we need good examples codes and a
> good helper library for that.

I agree, it's time to create a helper library and some documentation (or 
better documented code example).

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
