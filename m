From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: future ALSA development
Date: Tue, 24 Jun 2003 15:04:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306241501260.1838-100000@pnote.perex-int.cz>
References: <XFMail.20030624145235.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA29688
	for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2003 15:05:06 +0200
In-Reply-To: <XFMail.20030624145235.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Jun 2003, Giuliano Pochini wrote:

> Lisp should be fine, although it's not very user-friendly. But what the
> interpreter is supposed to do ?  Is it possible to create an ordinary
> mixer control that the hw doesn't support ?  For example: a card may not
> have an hw master volume control, but the ordinary mixer has to provide
> it. Is the lisp config file generic enough to provide a function to
> emulate the master volume control it by changing the volume controls
> of all single channels ?  It's not trivial at all to do such a thing
> with a "normal" config file, but it's possible with an interpreter. The
> question is: is it worth the effort ?  Or is it better to force all
> lowlevel drivers to provide a minimal set of ordinary controls ?

I think that it's worth to let define multiple virtual mixer devices for
multichannel cards (if required) and I can find more examples in this
area. You cannot do that in the kernel space without adding more code and
this is exactly what we do not want.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
