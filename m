From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: generic mixer control?
Date: Fri, 13 Sep 2002 17:30:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209131725230.521-100000@pnote.perex-int.cz>
References: <200209131319.g8DDJCk13884@op.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA22660
	for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2002 17:31:15 +0200
In-Reply-To: <200209131319.g8DDJCk13884@op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Sep 2002, Paul Davis wrote:

> i don't enough about ALSA's handling of consumer mixers to know if
> this is possible, but ... i was wondering if there is anyway to write
> a generic chunk of code for JACK that manipulates a consumer-oriented
> card's mixer to provide hardware mixing. the basic process would be to
> turn up the "capture gain" volume so that you get to hear whatever
> is being recorded. you might have to turn down something else as well,
> but thats probably secondary.
> 
> its not clear to me whether or not many mixers come with a single
> control that can do this, and/or whether there is any standard way to
> do this that ALSA "exports" to the world.
> 
> any comments? i'd like to provide "hardware monitoring" for users of
> consumer oriented cards to supplement the hammerfall and ice1712 stuff
> that we already have ...

Although the task is easy, the implementation is not. We definitely need 
to define some abstract controls like this in mixer and describe the 
complicated consumer mixers in configuration files like abstract PCM 
devices.

At the time, you might test if AC'97 is present (most of PCI cards) and 
write specific code for it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
