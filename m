From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [PATCH] Kernel crash
Date: Wed, 22 Sep 2004 16:12:56 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040922161256.pochini@shiny.it>
References: <s5hbrfyzkdx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrfyzkdx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


On 22-Sep-2004 Takashi Iwai wrote:

> OTOH, when you link streams but feed/read data separately for each
> stream, the clock difference doesn't matter.  Each stream may have
> even different periods, buffer sizes, whatever.
>
> So, in the first case, handling xrun/drain/drop in sync of all linked
> streams makes sense.  But what about the second case...?

It makes sense if the streams were started syncronously and the clock
is the same, but there isn't a way to know that right now. It would
also require driver support.


> Well, the link can be removed dynamically.  So, in theory, we can
> propose like the following:
>
> - Start, drain, drop and xrun of linked streams are operated to all
>   streams by a single call.  Especially, drain assures that the all
>   streams get sync'ed.
>
> - When one wants to operate drain and drop separately, explicitly
>   unlink streams after the sync'ed start.

It's ok IMHO.



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
