From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: POSIX clocks and ALSA
Date: Mon, 26 Nov 2007 09:37:08 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711260929410.7571@tm8103.perex-int.cz>
References: <474A763E.7090001@cs.helsinki.fi>
	<Pine.LNX.4.61.0711260848180.7571@tm8103.perex-int.cz>
	<474A7CE1.7080904@cs.helsinki.fi> <s5h63zpph0s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D72FD24797
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 09:37:09 +0100 (CET)
In-Reply-To: <s5h63zpph0s.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Heikki Lindholm <holindho@cs.helsinki.fi>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Nov 2007, Takashi Iwai wrote:

> At Mon, 26 Nov 2007 09:59:29 +0200,
> Heikki Lindholm wrote:
> > 
> > Jaroslav Kysela kirjoitti:
> > > On Mon, 26 Nov 2007, Heikki Lindholm wrote:
> > > 
> > >> Hello,
> > >>
> > >> Some years ago there was some talk about UST support in Linux, but the 
> > >> support never happened. With the hrtimers patch (and I'm not quite sure 
> > >> if even earlier?) CLOCK_MONOTONIC would seem like a fairly good UST time 
> > >> source. What I'd like to see, is a selectable clock for ALSA 
> > >> timestamping, e.g. something like snd_sw_params_clock(..., clockid_t 
> > >> clk). Would this seem plausible? I don't know that much about ALSA 
> > >> internals, so, no idea whether different clocks on different 
> > >> pcms/whatever would quickly turn into an unmanageable mess.
> > > 
> > > We are aware about this extension and I already proposed an 
> > > implementation. I hope to implement it soon. Timestamps are not used in 
> > > driver internally.
> > 
> > I can't seem to google up the proposal. I'd like to read it; was it on 
> > the alsa ml?
> 
> Yes, it was on alsa-devel ML.  At that time I didn't like the proposal
> much because currently there was no real user of timestamps.

I cannot find it quickly, but you may check alsa-devel archives.

> The addition of monolithc clock isn't hard, but it's an API change
> that involves with the kernel-side change.  So let's do it carefully.
> 
> But, honestly, I'm still concerned what to be done first.  Shouldn't
> we discuss about the usefulness of the timestamp at first?  That is,
> whether the current form (API, implementation) is the best or not,
> what kind of user would be, and how it's used.  So far, this feature
> is "simply there"...

The precise timestamps are necessary to keep in sync multiple timing 
sources. First example if you have multiple cards with different clocks,
a code maintaining drifts using an adaptive resampler might be created.
We need definitely one master time source. And I think that it is 
best, if this master timer source can be shared with other unix 
applications as well (video, scheduling real-time events etc.). So, 
logically, in my opinion, the best master timer source is the system 
clock.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
