From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: future ALSA development
Date: Mon, 23 Jun 2003 14:01:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306231338350.1838-100000@pnote.perex-int.cz>
References: <s5hsmq12ggf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA09268
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2003 14:01:39 +0200
In-Reply-To: <s5hsmq12ggf.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Jun 2003, Takashi Iwai wrote:

> At Sun, 22 Jun 2003 21:10:31 +0200 (CEST),
> Jaroslav wrote:
> > 
> > Hello all,
> > 
> > 	here are my next goals for the ALSA library development (short 
> > term). I invite all developers to comment these directions.
> > 
> > * create ordinary pcm & mixer interfaces
> >   - proposed headers are in current CVS
> >     - alsa-lib/include/pcm_ordinary.h
> >     - alsa-lib/include/mixer_ordinary.h
> 
> i know the name conflictions of the word "simple" but i feel this
> naming not so intuitive...  it's just my tastes, though.
> 
> a native english person might have a better idea?

Well, I do not mind to change the base name again. It was only quick fix.

> >   - intended applications are
> >     - simple playback & recorders
> >     - DVD players
> >     - VoIP (and other audio conferencing) applications
> >     - very simple mixer applications
> 
> nice!
> 
> do you think it's easy to bind to other languages, too?
> i've thought of C++ wrapper for the current alsa-lib, but it's way
> complicated because of its opaque struct style.

The new API is designed to keep it very simple. I think that the porting
to another language will be very simple, too.

> > * investigate a lisp integration to the current configuration syntax
> >   - we need to describe the relations between high level abstract
> >     layer (ordinary mixer) and current universal controls (very lowlevel);
> >     it seems that the simple configuration is not able to describe
> >     these (in most cases) very complicated paths
> 
> yep.
> 
> >   - note that describing of these relations might be used also for
> >     another mixer interfaces (simple mixer for example)
> >   - I don't rely on lisp, but what another interpreter with function
> >     definition has only 22kB binary (slisp-1.2 - i686)?
> 
> surely it's nice but i don't think it's good to introduce more
> complexity into the asoundrc syntax.  or, if you mean an external

We need to introduce the configuration extensions. At this stage,
I want to investigate, if the runtime configuration modification (runtime 
functions) might be converted to lisp rather than doing more or less ugly 
hacks in our configuration syntax parsers.

> database for describing the mixer configuration, it would be the
> outside of the (old) simple-mixer API, IMO.
> 
> in that case, anyway, we can drop simple-mixer API and replace with
> the new one.  the strategy used in the simple-mixer API can be
> integrated into the new (ordinary) mixer API.

I think that the ordinary mixer API and simple mixer API does not have 
much common parts for complicated hardware. The ordinary mixer API is very 
highlevel and tied up to specified playback / capture streams, but the 
simple mixer API is still only a translation between universal controls
and mixer applications. I think that both should be configurable, but the 
question is how much of these configurations can be shared. I would keep 
the configurations separate.

> about lisp: i don't have objections.  i like lisp, too :)
> the parser can be quite small, so if we build the parser in alsa-lib,
> it's a good choice.
> 
> other people might propose XML.  then it becomes to a question whether
> alsa-lib should rely on other libs...

I think that XML is too overkill for our purposes.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
