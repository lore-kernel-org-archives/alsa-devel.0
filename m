From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: future ALSA development
Date: Tue, 24 Jun 2003 20:28:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306241956240.1838-100000@pnote.perex-int.cz>
References: <s5hptl3mmd9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA01921
	for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2003 20:36:09 +0200
In-Reply-To: <s5hptl3mmd9.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Joern Nettingsmeier <nettings@folkwang-hochschule.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Jun 2003, Takashi Iwai wrote:

> At Tue, 24 Jun 2003 08:16:18 -0400,
> Paul Davis wrote:
> > 
> > >It is something similar like "HTML" and "Java script". The first one is 
> > >good to describe the static part of web pages, but if you want something 
> > >dynamic, you have to use another embeded language.
> > 
> > or use a real language for the whole thing. this is not the web. there
> > is no reason to use a few lines of static container code (e.g. HTML)
> > to wrap a real programming language (e.g. Java). 
> 
> i agree with Paul.
> of course, it's a pain that all configuration syntax is changed.
> but for me, it looks far more consistent to describe the whole thing
> with the same syntax.
>
> well, you might consider the compatibility issue.  yes, that's another
> big thing to discuss...

I will try to evaluate the lisp possibilities in this area. I also think 
that the old and new configuration might co-exist for awhile. Especially, 
the new extensions (like mixer configuration) might use the new 
configuration syntax.

> i believe, if we change the configuration syntax, it would be better
> to branch the development tree (or jump the version number).
> the current system works well already in many fields, so it's nice to
> keep the stable series.

We can do it when we need to break the compatibility behaviour.

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
