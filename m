From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: backwards incompatible ALSA api change?
Date: Wed, 11 Sep 2002 13:36:36 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209112036.NAA19154@cmn29.stanford.edu>
References: <Pine.LNX.4.33.0209112221180.607-100000@pnote.perex-int.cz>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209112221180.607-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Takashi Iwai <tiwai@suse.de>, "Jackit-devel@lists.sourceforge.net" <Jackit-devel@lists.sourceforge.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > Correct me if I'm wrong but bumping the library version number
> > from .so.2 to .so.3 with api changes would also enable orderly
> > migration _if_ the interface between the library and the
> > drivers does not change. I would be able to have both a .so.2
> > and a .so.3 in the system, so that old, not yet converted
> > programs would work fine and new programs using the .so.3
> > library would also work. Eventually, when all programs are
> > updated and recompiled to use .so.3, the .so.2 could be just
> > erased and would be history. Am I dreaming?
>
> Nope. I'll do that (it's already on my HDD), but I'll have to change more
> snd_pcm_hw_params_* functions to unify the access and let recognize
> the error code to applications.

Great, thanks a lot. It'd be helpful if you could you post a
small message to alsa-dev when you are done with that change
in cvs. Then I can try to get a build that has the "backwards
compatibility" old library and start migrating applications as
they become "aware" of the new library.

-- Fernando


-------------------------------------------------------
In remembrance
www.osdn.com/911/
