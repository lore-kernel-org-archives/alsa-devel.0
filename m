From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: backwards incompatible ALSA api change?
Date: Wed, 11 Sep 2002 10:59:36 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209111759.KAA18952@cmn29.stanford.edu>
References: <Pine.LNX.4.44.0209101958360.29024-100000@cmn37.stanford.edu>
	<s5hy9a9oro6.wl@alsa2.suse.de>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy9a9oro6.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, perex@suse.cz, Jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > [sent also to alsa-dev - maybe I missed an announcement about this?]
> >
> > The jack (Jack Audio Connection Kit, cvs from around the beginning of
> > September) code no longer compiles with the most recent alsa cvs:
> >
> > There has been a backwards incompatible alsa api change. This is recent, I
> > guess, it compiles with cvs of 20020820.180035 (USA Pacific time). I know
> > there MUST a perfectly good reason for a backwards incompatible api change
> > at this point (some new extended format structure?), but may I say,
> > respectfully, something?
> >
> > ARGHHHHHHHHHH!!!!!
>
> ouch, i found that Jaroslav changed the functions above yesterday on
> cvs.
>
> the old one:
> int snd_pcm_hw_params_get_format(const snd_pcm_hw_params_t *params);
>
> the new one:
> int snd_pcm_hw_params_get_format(const snd_pcm_hw_params_t *params,
> snd_pcm_format_t *val);
>
> same are for subformat and access.
>
> i understand the reason why it was changed.  the new one looks more
> consistent.  but snd_pcm_format_t is enum, so it should be identical
> with int at any rate.
> (possibly c++ may complain about the difference between them, though.)
>
> i don't think it's a good idea to change such a basic api function at
> this time.  the old one works fine, and we'll have never negative
> values for format, etc.  this change will give more pain than gain.
>
> Jaroslav, could you consider to get them back to the old style?

Please please PLEASE?

If the change is not reverted I will personally have to patch
it back (what a pain!) to the way it was if I want to keep
trying cvs (<*> see below for more on why). The very recent
and ongoing changes happening in the very important usb audio
driver is an example of why using cvs (at least for me) is not
really a luxury.

Is there any internal side effect to reverting to the old
format with a patch?

If the API change is desirable and _has_ to be made there
should be an announcement (to alsa-dev which is where I assume
is where all developers of alsa applications are subscribed
to), and the library version should be increased so that an
application compiled with the old version will not just
segfault when run under the new drivers (maybe 0.9.1?,
0.9.0.1?).

> > To the alsa gurus: could a message be sent to alsa-dev when there are
> > backwards incompatible changes in the API please? It'd be good to know, I
> > think (at least _I_ would like to know). Please?
>
> usually such a change appears on alsa cvs annoucement, but this
> did't by unknown reason...

I am not subscribed to the cvs announcement list. At this
point in time I would say this an API change that will affect
all programs out there that use alsa should be prominently
sent to alsa-dev. Very prominently. The sooner developers know
what's coming up in the next release the better.

-- Fernando

<*> why would I have to patch things back....

If I want to try the new features or bugs of cvs alsa I would
have to either patch all the software I'm mantaining here at
ccrma, or be patient and wait for the developers of programs
to patch them to the new api.

At this point the list of packaged software that links against
libasound.so.2 includes from 15 to 20 (depending on how you
count) packages.

So, if a new feature in alsa cvs is very desirable I would
have to recompile all the applications and maybe change most
of them myself (if they use the affected functions).

That is not a HUGE undertaking but it is a BIG pain.

But the situation is a little different now, the work I do
mantaining ccrma is now reflected in the Planet CCRMA pages,
where these packages are being used by people outside ccrma.
If I want to upgrade the alsa driver at some point to a newer
cvs version (so that, for example, usb audio works better), I
would have to upgrade all packages and force a big upgrade on
all users.

I guess that is why I should not be even touching cvs :-) ;-) :-)


-------------------------------------------------------
In remembrance
www.osdn.com/911/
