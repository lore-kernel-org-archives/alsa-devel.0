From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Query devices in a non-blocking fashion
Date: Mon, 8 Dec 2003 17:57:03 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312081745340.20863@pnote.perex-int.cz>
References: <oprztqwoi4q1sf88@mail.broadpark.no>
 <200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com>
 <20031208161936.310df2cb.pochini@shiny.it> <oprzvc5mu3q1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprzvc5mu3q1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Dec 2003, Arve Knudsen wrote:

> Wether its done via the control or pcm interface, it'd be good to have a
> loose coupling between configuration and streams, so one could could access
> configuration space without locking a stream don't you think? I mean,
> with ASIO, from what I can see there is no problem obtaining info about
> devices in the system even if they might be in use. Shouldn't we at least
> aim for the same flexibility with ALSA?

I was thinking about this issue whole day and it seems to me that you need
only a list of available devices (including used ones). Ok, it can be done 
now using the control interface for hw devices, but we missing a way for 
the abstract names. Yes, there is a gap in our API and we can fix it.

The second question is, if we want to give you more information about
devices than an unique name (and perhaps description). My feeling is that
you're aware what you have in your computer (and I hope, we will develop
configuration tools which makes the configuration of alsa-lib devices more
comfortable in future). Also, alsa-lib's flexibility allows us to accept 
almost any stream with the global - system wide - optimizations on our 
side. We don't want to let probing from the application side. This way
is not very good. The application should choose (or maybe an user of 
this application should choose) the best communication (stream parameters)
used for the HAL layer (in our case alsa-lib).

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
