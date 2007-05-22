From: Jasiu <kiputnik@gmail.com>
Subject: Re: Broken JACK plugin in alsa-plugins and a way to
	fix it.
Date: Tue, 22 May 2007 14:27:18 +0200
Message-ID: <f13492b00705220527m296904apd6431b056ad407f7@mail.gmail.com>
References: <f13492b00705190644s51a0cc99g95e676257a4e9044@mail.gmail.com>
	<f13492b00705190754x6ddae848j8ef07382ac49a544@mail.gmail.com>
	<s5hlkfip4gl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E95C24451
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2007 14:27:21 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so2233930nzf
	for <alsa-devel@alsa-project.org>; Tue, 22 May 2007 05:27:20 -0700 (PDT)
In-Reply-To: <s5hlkfip4gl.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Unfortunately, mpg321 doesn't exhibit similar problem. I've also
tested aplay changing various options (mmap, nonblocking, period,
buffer, etc.) to no avail. Whatever I feed to the plugin works ok,
except mplayer. If I'm not mistaken WINE did the same thing as mplayer
when I checked some time ago - I'm not sure if it still does, but not
much has changed probably. It could be as well bug in these
applications, but other plugins work ok with them so jack one should
do the same, I quess.

Yes, I'm aware of mplayer's subpar code quality. I've looked there a
few times - it isn't the most bizzare code I've ever seen, but it's
certainly not pretty. =)

Thanks for the reply.

On 5/21/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 19 May 2007 15:44:45 +0200,
> Jasiu wrote:
> >
> > Hi.
> >
> > I want to note that JACK plugin in alsa-plugins in broken. (At least
> > on my two systems.) It just plays for a few seconds and then stops
> > hanging the application that was sending data to it. When it hangs
> > jackd spits out this:
> >
> > subgraph starting at alsa-jack.jackP.3635.0 timed out
> > (subgraph_wait_fd=7, status = 0, state = Running)
> >
> > What I want to note is that there is a fix to that and I would like it
> > to be included in the tree. I'm not sure if it doesn't break anything
> > else, but it works for me ok.
> >
> > Open pcm_jack.c and on the line 146 you'll find:
> >
> > write(jack->fd, buf, 1); /* for polling */
> >
> > Deleting this seems to get rid of the problem.
> > So please if you can patch this out. (I didn't make a patch myself
> > since this is so tiny fix that it isn't really worth.)
>
> It's always worth to make a patch.
> A patch contains some contexts around the changed line, so it's more
> robust than giving just a line number.
>
>
> At Sat, 19 May 2007 16:54:45 +0200,
> Jasiu wrote:
> >
> > Sorry, it seems that while that fixed the problem for some apps
> > (notably mplayer) it broke a few others. (amarok, artsd) So please
> > just ignore my remake about the fix for now. It would be nice if
> > someone could explain to me why that bug happens, because currently
> > I'm more and more confused about that.
>
> Possibly a difference of running mode, mmap or not?
> Or, it might requires some special period or buffer sizes.
>
> Since mplayer uses libao, some other apps like ogg123 or mpg321 should
> face the same problem.  Could you check it?  If yes, it's much easier
> than debugging with mplayer.  The source code of mplayer is... well,
> you can judget after seeing it by yourself :)
>
>
> Takashi
>
