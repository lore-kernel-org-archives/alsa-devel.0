From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Sat, 21 Sep 2002 07:41:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209210734320.503-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0209201437300.12518-100000@vaino.wakkanet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0209201437300.12518-100000@vaino.wakkanet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Sep 2002, Kai Vehmanen wrote:

> On Fri, 20 Sep 2002, Takashi Iwai wrote:
> 
> >> 	your almost all negative messages persuaded me to wait awhile with 
> >> new function prototypes. Here is the result:
> > thanks for quick reaction.
> > the new library works fine with the old applications.
> 
> Btw; with ld from binutils-2.9.5.0.22-6 (rh62) I get the
> following error when linking libasound:
> 
> /usr/bin/ld: .libs/libasound.so.2.0.0: undefined versioned symbol name snd_pcm_hw_params_get_rate_min@ALSA_0.9.0rc4
> /usr/bin/ld: failed to set dynamic section sizes: Bad value collect2: ld returned 1 exit status
> 
> And this with a fresh CVS-update of alsa-lib. Might
> be a clear ld bug. 

What's result of this command?
	nm alsa/lib/src/pcm.lo | grep snd_pcm_hw_params_get_rate_min

> >>   (not available for default linking); these new functions are explicitly
> >>   available when ALSA_PCM_NEW_HW_PARAMS_API is defined before inclusion of
> > will this condition be removed in the future release as default?
> > we can put ALSA_PCM_OLD_HW_PARAM_API for the backward compatibility
> > later, instead.
> 
> It's too bad there isn't better language-level support for versioned
> interfaces. You can do all kinds of things with the preprocessor and
> linker, but this really should be something all developers are all aware
> of and know how to use.
> 
> The basic scenario is:
> 
> 1. library implements a set of interfaces (v1, v2, ...) 
> 2. application using the library uses one of the
>    interface versions (and note, it's important that 
>    application code always explicitly defines what
>    interface is wants to use)
> 
> Age of each interface should span multiple major releases of the library,
> but not nocessarily more than that (maintaining (especially testing!) more
> than two or three different versions in the same physical package starts
> to be a mess).

I agree, but the current change is really mostly cosmetic. The enhancement 
is the returned error value and unified casting for passed/retured values.
The library code works internally already with new functions, so the 
overhead is minimal (only add conversion functions for older API).
I already noted, if API behaviour changes, then it's major change and 
we'll increase the major library number, but it's definitely a thing for 
1.0 development tree.

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
