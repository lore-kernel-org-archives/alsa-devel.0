From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: simple mixer API?
Date: Wed, 8 Oct 2003 13:06:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310081305540.1357@pnote.perex-int.cz>
References: <Pine.OSF.4.58.0310072352100.255766@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.OSF.4.58.0310072352100.255766@kosh.hut.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 8 Oct 2003, Tommi Sakari Uimonen wrote:

> Hi. If I remember correct, a while ago there were some discussion about a
> simple mixer API for ALSA. What is the current status of this?
>
> With simple mixer API I mean some basic mixer commands that all audio
> cards would perform, like volume up/down, mute, maybe others?
>
> Maybe these simple commands could be 'mapped' to driver specific commands
> in some config file. And it would be up to the user/administrator to
> configure how these simple commands will be handled.
>
> Eg. 'vol up' = 'amixer [command to rise volume]'

I'm slowly working on this, but we will use build-in lisp processor for
hardware description.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
