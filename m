From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Query devices in a non-blocking fashion
Date: Sun, 7 Dec 2003 21:05:56 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312072104490.20863@pnote.perex-int.cz>
References: <200312071956.hB7Juq18004807@oud.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312071956.hB7Juq18004807@oud.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Arve Knudsen <aknuds-1@broadpark.no>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 7 Dec 2003, Paul Davis wrote:

> >We all think in the same way, but there's no simple solution for this
> >problem. I prefer to have such configuration information in an user-space 
> >database accessed via an alsa-lib API. It's nothing for the kernel space.
> 
> i'm not sure i agree with that. a user-space config DB could be used
> to describe the possibilities. but it doesn't address the approach i
> outlined where a program can present the *current* state of the
> system as configured using the control API.

Why not? We can have a dynamic database where are also described the 
rules.

					Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
