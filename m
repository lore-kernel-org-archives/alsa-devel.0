From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Query devices in a non-blocking fashion
Date: Sun, 7 Dec 2003 21:00:13 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312072056170.20863@pnote.perex-int.cz>
References: <200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com>
 <oprztsi6z7q1sf88@mail.broadpark.no> <Pine.LNX.4.58.0312072033450.20863@pnote.perex-int.cz>
 <oprzttgbyxq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprzttgbyxq1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 7 Dec 2003, Arve Knudsen wrote:

> > We all think in the same way, but there's no simple solution for this
> > problem. I prefer to have such configuration information in an user-space
> > database accessed via an alsa-lib API. It's nothing for the kernel space.
> 
> I dunno, I think Paul's thoughts sound sensible. Its not solved in a simple
> manner, but it was obviously solved somehow with other driver 
> architectures.

With very little success when a complicated hardware is in the machine.

> Will this database cope with runtime variables, such as the number of
> channels with RME Hammerfall though (dependent on samplerate)?

It depends on our goals and what we expect from this information. Can you 
describe your requirement (for what reason, you need this information?).

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
