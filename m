From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Build-in mixer
Date: Fri, 17 Oct 2003 09:28:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310170926350.1221@pnote.perex-int.cz>
References: <200310151240.h9FCeluU021976@oud>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310151240.h9FCeluU021976@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Dan Tihelka <dtihelka@kky.zcu.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Oct 2003, Paul Davis wrote:

> >Well, i am not author of this program actually. It is xmms plugin
> >allowing  to use ALSA for sound output (alsa-xmms-0.9). I only wanted to
> >modify it, to be able to use dmix. I see, that it is out of my abilities
> >:-(  and, so i will have to conctact the author of it and ask him to
> >correct it. It is pitty, because it will take time (if they ever do it).
> >I thought, that ALSA interface is not dependent on way, how it is opened
> >(because the same code with "hw:0:0" instead of "default" worked
> >perfectly) or did not i comprehend anything?. I would like to
> >understant, why opening "hw:0:0" works and only replacing it by
> >"default" does not. It seems to mee very dificult for developpers....
>
> it would have helped enormously if you had stated that you were
> talking about alsa-xmms up front. its a known and important piece of
> code, and one that someone here is much more likely to fix than (sorry
> to say) your own pet project.
>
> takashi or jaroslav - does using dmix involve any threads? could the
> alsa-xmms plugin be making calls to some xmms error code from a
> non-GUI thread?

The dmix plugin does not use any threads and should be thread safe.
I think that the xmms code does not conform to the ALSA API. For example,
the application MUST use snd_pcm_poll_descriptors_revents() to obtain
the real event from poll(). And so on...

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
