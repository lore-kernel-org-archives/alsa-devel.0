From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Build-in mixer
Date: Fri, 17 Oct 2003 09:31:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310170930500.1221@pnote.perex-int.cz>
References: <3F8D3936.2080106@kky.zcu.cz> <200310151240.h9FCeluU021976@oud>
 <s5hy8vminw2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8vminw2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Dan Tihelka <dtihelka@kky.zcu.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Oct 2003, Takashi Iwai wrote:

> At Wed, 15 Oct 2003 08:40:47 -0400,
> Paul Davis wrote:
> >
> > >Well, i am not author of this program actually. It is xmms plugin
> > >allowing  to use ALSA for sound output (alsa-xmms-0.9). I only wanted to
> > >modify it, to be able to use dmix. I see, that it is out of my abilities
> > >:-(  and, so i will have to conctact the author of it and ask him to
> > >correct it. It is pitty, because it will take time (if they ever do it).
> > >I thought, that ALSA interface is not dependent on way, how it is opened
> > >(because the same code with "hw:0:0" instead of "default" worked
> > >perfectly) or did not i comprehend anything?. I would like to
> > >understant, why opening "hw:0:0" works and only replacing it by
> > >"default" does not. It seems to mee very dificult for developpers....
> >
> > it would have helped enormously if you had stated that you were
> > talking about alsa-xmms up front. its a known and important piece of
> > code, and one that someone here is much more likely to fix than (sorry
> > to say) your own pet project.
> >
> > takashi or jaroslav - does using dmix involve any threads? could the
> > alsa-xmms plugin be making calls to some xmms error code from a
> > non-GUI thread?
>
> it's not related with threads, but it invokes a fork for a server
> process (a main control only, doesn't do mixing stuffs).
> it looks like there is something wrong with this together with xmms.
> i've seen that Xlib got a spurious async.
> magically enough, the attached patch seems to fix.
>
> Jaroslav, what is the reason of the second fork?  to daemonize?

Yes, we need completely to detach from parent.

> hmm, i still got many underruns.  something broken atm...

I will look on this. Sorry, I was not available for two days.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
