From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem with multiopen on SB Audigy 2
Date: Thu, 9 Oct 2003 15:13:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310091510460.1357@pnote.perex-int.cz>
References: <3F82F126.4000800@superbug.demon.co.uk> <s5h4qylkmbk.wl@alsa2.suse.de>
 <3F833B40.9070009@superbug.demon.co.uk> <Pine.LNX.4.53.0310081307320.1357@pnote.perex-int.cz>
 <s5hekxnalsl.wl@alsa2.suse.de> <Pine.LNX.4.53.0310081545030.1357@pnote.perex-int.cz>
 <s5hbrsrakps.wl@alsa2.suse.de> <Pine.LNX.4.53.0310081619270.1357@pnote.perex-int.cz>
 <s5h8ynvaj51.wl@alsa2.suse.de> <Pine.LNX.4.53.0310081643030.1357@pnote.perex-int.cz>
 <s5h7k3fai5d.wl@alsa2.suse.de> <Pine.LNX.4.53.0310081741500.1357@pnote.perex-int.cz>
 <s5h3ce3afhi.wl@alsa2.suse.de> <Pine.LNX.4.53.0310081819520.1357@pnote.perex-int.cz>
 <3F84B662.4080502@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F84B662.4080502@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Oct 2003, James Courtier-Dutton wrote:

> Jaroslav Kysela wrote:
> >>
> >>the template i meant above is the basic designs of control naming, and
> >>i don't mean that this is the kernel issue.  (well, in the case of
> >>"master" volume, we cannot handle it simply by abstraction but need a
> >>new control, though.)
> >>
> >>i believe it's just a question which is easier to implement.
> >>i agree that almost all cases can be solved by a higher abstraction,
> >>and i prefer that, too.
> >
> >
> > Yes, I think that we might use the kernel to create the "user defined"
> > controls which can be created from the user space. In this case, we can
> > nicely do all kinds of abstractions in the user space.
> >
> > 						Jaroslav
> >
>
> I agree, that the less work done in kernel space the better.
> I also think it is a good idea to have user space creating virtual
> controls (abstractions), but of course, the values/state given to these
> virtual controls has to be stored somewhere, and kernel space will
> probably have to store them, otherwise their state will not survive
> across application stop/start.

Yes, that's my idea, too.

> How would one start supporting some of the multichannel features
> availiable on some cards. E.g. surround sound 7.1 (8 channels)
>
> I think we should take the names for the speakers from the AC3 or DTS
> specifications.
> AC3 names: -
> Left
> Center
> Right
> Left Surround
> Right Surround
> Low Frequency Effects.
>
> DTS names: -
> Left
> Center Left
> Center
> Center Right
> Right
> Surround Left1
> Surround Right1
> Surround Left2
> Surround Right2
> Rear Left
> Rear Center
> Rear Right
> Overhead
> Low Frequency Effects.
>
> We would also need to add: -
> Headphones
>
> So, I conclude from this, that maybe we should add to the config files a
> way for the user to say what is plugged into what, and name it themselves.

Yes, that's true especially for the multichannel cards being used for
the hifi consumer audio.

I agree that we have gaps in these areas.

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
