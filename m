From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Questions: hw_param rules in rme9652, hdsp.c, also
 for hdspm.c ?
Date: Wed, 8 Oct 2003 21:03:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310082100050.1357@pnote.perex-int.cz>
References: <1065636181.3f8451558cf65@iem.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1065636181.3f8451558cf65@iem.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ritsch@iem.at
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 8 Oct 2003 ritsch@iem.at wrote:

> Hello !
>
> I tried to be Luke ;-), and found following rules for the hammerfall cards:
>
> (Maybe I interpret these false)
>
> A) rule_channel which set the limits to channels
>
> ->min to double speed channels and channels max to hdsp->singlespeed channels
>
> (in hdsp double speed channels is 13 and ss speed are 26,
> in hdspm they are 32 and 64)
>
> Why ? Is there a reason to let channels min not to be 1 ?

Nope. I think that hdsp cards work with all channels simultaneously,
thus you'll have to propagate all channels to the user space. It's on
applications if it does not use some of them, but being clever than the
user space code is not the right thing for ALSA drivers.

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
