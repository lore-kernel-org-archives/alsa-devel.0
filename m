From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: future ALSA development
Date: Tue, 24 Jun 2003 08:16:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306241209.OAA28971@alsa.alsa-project.org>
References: <Pine.LNX.4.44.0306241352410.1838-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail09.voicenet.com (mail09.voicenet.com [207.103.0.43])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id OAA28971
	for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2003 14:09:38 +0200
In-reply-to: Your message of "Tue, 24 Jun 2003 13:56:48 +0200."
             <Pine.LNX.4.44.0306241352410.1838-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Joern Nettingsmeier <nettings@folkwang-hochschule.de>, Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>There are two differences between lisp and alsa configuration language.
>Lisp is standard dynamic language but the ALSA configuration is static
>(if you ommit the runtime evaluation hacks added to enhance functinality).

but the runtime evaluation hacks are precisely what give rise to the
problems. you and abramo may have conceived of it as a static language
in the first place, but it clearly has, along with just about every other
"small language", mutated into something else. the story of PHP is one
of the more recent illustrations of this.

>It is something similar like "HTML" and "Java script". The first one is 
>good to describe the static part of web pages, but if you want something 
>dynamic, you have to use another embeded language.

or use a real language for the whole thing. this is not the web. there
is no reason to use a few lines of static container code (e.g. HTML)
to wrap a real programming language (e.g. Java). 




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
